#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"

extern char data[];  // defined by kernel.ld
pde_t *kpgdir;  // for use in scheduler()

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void) {
    struct cpu *c;

    // Map "logical" addresses to virtual addresses using identity map.
    // Cannot share a CODE descriptor for both kernel and user
    // because it would have to have DPL_USR, but the CPU forbids
    // an interrupt from CPL=0 to DPL=3.
    c = &cpus[cpuid()];
    c->gdt[SEG_KCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, 0);
    c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
    c->gdt[SEG_UCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, DPL_USER);
    c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
    lgdt(c->gdt, sizeof(c->gdt));
}

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
    pde_t *pde;
    pte_t *pgtab;

    pde = &pgdir[PDX(va)];
    if (*pde & PTE_P) {
        pgtab = (pte_t *) P2V(PTE_ADDR(*pde));
    } else {
        if (!alloc || (pgtab = (pte_t *) kalloc()) == 0)
            return 0;
        // Make sure all those PTE_P bits are zero.
        memset(pgtab, 0, PGSIZE);
        // The permissions here are overly generous, but they can
        // be further restricted by the permissions in the page table
        // entries, if necessary.
        *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
    }
    return &pgtab[PTX(va)];
}

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm) {
    char *a, *last;
    pte_t *pte;

    a = (char *) PGROUNDDOWN((uint) va);
    last = (char *) PGROUNDDOWN(((uint) va) + size - 1);
    for (;;) {
        if ((pte = walkpgdir(pgdir, a, 1)) == 0)
            return -1;
        if (*pte & PTE_P)
            panic("remap");
        *pte = pa | perm | PTE_P;
        if (a == last)
            break;
        a += PGSIZE;
        pa += PGSIZE;
    }
    return 0;
}

// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
//
// setupkvm() and exec() set up every page table like this:
//
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.
static struct kmap {
    void *virt;
    uint phys_start;
    uint phys_end;
    int perm;
} kmap[] = {
        {(void *) KERNBASE, 0,             EXTMEM,  PTE_W}, // I/O space
        {(void *) KERNLINK, V2P(KERNLINK), V2P(data), 0},     // kern text+rodata
        {(void *) data,     V2P(data),     PHYSTOP, PTE_W}, // kern data+memory
        {(void *) DEVSPACE, DEVSPACE, 0,            PTE_W}, // more devices
};

void page_in(int u_va, int va, pde_t *pgdir) {
    struct proc *p = myproc();
    pte_t *pte = walkpgdir(pgdir, (int *) u_va, 0);
    if (!pte)
        panic("page pte is not found");
    *pte |= PTE_P | PTE_W | PTE_U;
    p->protected--;
    *pte &= ~PTE_PG;
    *pte |= va;
    lcr3(V2P(p->pgdir));
}


void page_out(uint va, pde_t *pgdir) {
    struct proc *p = myproc();
    pte_t *pte = walkpgdir(pgdir, (int *) va, 0);
    if (!pte)
        panic("pte is not found");
    *pte |= PTE_PG;
    *pte &= ~PTE_P;
    *pte &= PTE_FLAGS(*pte);
    p->protected++;
    lcr3(V2P(p->pgdir));
}

// Set up kernel part of a page table.
pde_t *
setupkvm(void) {
    pde_t *pgdir;
    struct kmap *k;

    if ((pgdir = (pde_t *) kalloc()) == 0)
        return 0;
    memset(pgdir, 0, PGSIZE);
    if (P2V(PHYSTOP) > (void *) DEVSPACE)
        panic("PHYSTOP too high");
    for (k = kmap; k < &kmap[NELEM(kmap)];
    k++)
    if (mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                 (uint) k->phys_start, k->perm) < 0) {
        freevm(pgdir);
        return 0;
    }
    return pgdir;
}

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void) {
    kpgdir = setupkvm();
    switchkvm();
}

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void) {
    lcr3(V2P(kpgdir));   // switch to the kernel page table
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p) {
    if (p == 0)
        panic("switchuvm: no process");
    if (p->kstack == 0)
        panic("switchuvm: no kstack");
    if (p->pgdir == 0)
        panic("switchuvm: no pgdir");

    pushcli();
    mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                  sizeof(mycpu()->ts) - 1, 0);
    mycpu()->gdt[SEG_TSS].s = 0;
    mycpu()->ts.ss0 = SEG_KDATA << 3;
    mycpu()->ts.esp0 = (uint) p->kstack + KSTACKSIZE;
    // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
    // forbids I/O instructions (e.g., inb and outb) from user space
    mycpu()->ts.iomb = (ushort) 0xFFFF;
    ltr(SEG_TSS << 3);
    lcr3(V2P(p->pgdir));  // switch to process's address space
    popcli();
}

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz) {
    char *mem;

    if (sz >= PGSIZE)
        panic("inituvm: more than a page");
    mem = kalloc();
    memset(mem, 0, PGSIZE);
    mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W | PTE_U);
    memmove(mem, init, sz);
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz) {
    uint i, pa, n;
    pte_t *pte;

    if ((uint) addr % PGSIZE != 0)
        panic("loaduvm: addr must be page aligned");
    for (i = 0; i < sz; i += PGSIZE) {
        if ((pte = walkpgdir(pgdir, addr + i, 0)) == 0)
            panic("loaduvm: address should exist");
        pa = PTE_ADDR(*pte);
        if (sz - i < PGSIZE)
            n = sz - i;
        else
            n = PGSIZE;
        if (readi(ip, P2V(pa), offset + i, n) != n)
            return -1;
    }
    return 0;
}


void
turn_flag(void *va, uint flag, int on) {
    struct proc *p = myproc();
    pte_t *pte = walkpgdir(p->pgdir, va, 0);
    if (pte == 0)panic("turn flag: no pte found");
    if (on)
        *pte |= flag;
    else *pte &= ~flag;
    lcr3(V2P(p->pgdir));
}

int
is_flag_on(void *va, uint flag) {
    struct proc *p = myproc();
    pte_t *pte = walkpgdir(p->pgdir, va, 0);
    if (pte == 0)panic("turn flag: no pte found");
    if ((*pte & flag) != 0) return 1;
    else return 0;
}


int get_free_ram_idx() {
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
        if (myproc()->ram_monitor[i].used == 0)
            return i;
    }
    return -1;
}

void add2ram(pde_t *pgdir, uint p_va) {
    int idx = get_free_ram_idx();
    if (idx < 0)
        return;
    myproc()->ram_monitor[idx].used = 1;
    myproc()->ram_monitor[idx].pgdir = pgdir;
    myproc()->ram_monitor[idx].p_va = p_va;
//    cprintf("add2ram: p_va = %d, idx = %d\n", myproc()->ram_monitor[idx].p_va, idx);
    myproc()->last_in_queue++;
    myproc()->ram_monitor[idx].place_in_queue = myproc()->last_in_queue;
}
int select_LIFO() {
    int ret = -1;
    int last = 0;
    struct proc *p = myproc();

    for (int idx = 0; idx < MAX_PYSC_PAGES; idx++) {
        if (p->ram_monitor[idx].place_in_queue > last && p->ram_monitor[idx].used == 1) {
            last = p->ram_monitor[idx].place_in_queue;
            ret = idx;
        }
    }
    return ret;
}

int select_SCFIFO() {
struct proc *p = myproc();
int ret;
    int first;
    pte_t *pte;
    while (1) {
        ret = -1;
        first = 0x7FFFFFFF;
        for (int idx = 0; idx < MAX_PYSC_PAGES; idx++) {
            if (p->ram_monitor[idx].place_in_queue <= first && p->ram_monitor[idx].used == 1 ) {
                ret = idx;
                first = p->ram_monitor[idx].place_in_queue;
            }
        }
        pte = walkpgdir(p->ram_monitor[ret].pgdir, (char *) p->ram_monitor[ret].p_va, 0);
        if (PTE_FLAGS(*pte) & PTE_A) {
            *pte &= ~PTE_A;
            p->last_in_queue++;
            p->ram_monitor[ret].place_in_queue = p->last_in_queue;
        } else break;
    }
    return ret;
}

int replace_page_by_policy() {
#if LIFO
    return select_LIFO();
#endif

#if SCFIFO
    return select_SCFIFO();
#endif
    panic("invalid policy!");
}

int select_NONE() {
#if NONE
    return 1;
#endif
    return 0;
}

void swap(pde_t *pgdir, uint p_va) {
    struct proc *p = myproc();
    p->pages_in_file++;
    int ram_idx = replace_page_by_policy();
//    cprintf("Swapping index:: %d\n", ram_idx);
    pte_t *pte = walkpgdir(p->ram_monitor[ram_idx].pgdir, (int *) p->ram_monitor[ram_idx].p_va, 0);
    int p_pa = PTE_ADDR(*pte);
    write2file(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir);
    kfree(P2V(p_pa));
    p->ram_monitor[ram_idx].used = 0;
    page_out(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir);
//    cprintf("swap -> add2ram\n");
    add2ram(pgdir, p_va);
}


// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
    char *mem;
    uint a;

    if (newsz >= KERNBASE)
        return 0;
    if (newsz < oldsz)
        return oldsz;
    int i = 0;
    a = PGROUNDUP(oldsz);
    for (; a < newsz; a += PGSIZE) {
        mem = kalloc();
        i++;
        if (mem == 0) {
            cprintf("allocuvm out of memory\n");
            deallocuvm(pgdir, newsz, oldsz);
            return 0;
        }
        memset(mem, 0, PGSIZE);
        mappages(pgdir, (char *) a, PGSIZE, V2P(mem), PTE_W | PTE_U);
        if (myproc()->pid > 2 && !select_NONE()) {
            if ((PGROUNDUP(oldsz)) / PGSIZE + i <= MAX_PYSC_PAGES)
                add2ram(pgdir, a);

            else swap(pgdir, a);
        }
    }
    return newsz;
}

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
    pte_t *pte;
    uint a, pa;

    if (newsz >= oldsz)
        return oldsz;

    a = PGROUNDUP(newsz);
    for (; a < oldsz; a += PGSIZE) {
        pte = walkpgdir(pgdir, (char *) a, 0);
        if (!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if ((*pte & PTE_P) != 0) {
            pa = PTE_ADDR(*pte);
            if (pa == 0) {
                panic("kfree");
            }
            char *v = P2V(pa);
            kfree(v);
            if (!select_NONE()) {
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
                    if (myproc()->ram_monitor[i].used == 1 && myproc()->ram_monitor[i].p_va == a &&
                        myproc()->ram_monitor[i].pgdir == pgdir)
                        myproc()->ram_monitor[i].used = 0;
                }
            }
            *pte = 0;
        }
    }
    return newsz;
}

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir) {
    uint i;
    if (pgdir == 0)
        panic("freevm: no pgdir");
    deallocuvm(pgdir, KERNBASE, 0);
    for (i = 0; i < NPDENTRIES; i++) {
        if (pgdir[i] & PTE_P) {
            char *v = P2V(PTE_ADDR(pgdir[i]));
            kfree(v);
        }
    }
    kfree((char *) pgdir);
}

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva) {
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
    if (pte == 0)
        panic("clearpteu");
    *pte &= ~PTE_U;
}

// Given a parent process's page table, create a copy
// of it for a child.
pde_t *
copyuvm(pde_t *pgdir, uint sz) {
    pde_t *d;
    pte_t *pte;
    uint pa, i, flags;
    char *mem;

    if ((d = setupkvm()) == 0)
        return 0;
    for (i = 0; i < sz; i += PGSIZE) {
        if ((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
            panic("copyuvm: pte should exist");
        if (!(*pte & PTE_P))
            panic("copyuvm: page not present");
        if (*pte & PTE_PG) {
            page_out(i, d);
            continue;
        }
        pa = PTE_ADDR(*pte);
        flags = PTE_FLAGS(*pte);
        if ((mem = kalloc()) == 0)
            goto bad;
        memmove(mem, (char *) P2V(pa), PGSIZE);
        if (mappages(d, (void *) i, PGSIZE, V2P(mem), flags) < 0)
            goto bad;
    }
    return d;

    bad:
    freevm(d);
    return 0;
}

//PAGEBREAK!
// Map user virtual address to kernel address.
char *
uva2ka(pde_t *pgdir, char *uva) {
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
    if ((*pte & PTE_P) == 0)
        return 0;
    if ((*pte & PTE_U) == 0)
        return 0;
    return (char *) P2V(PTE_ADDR(*pte));
}

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len) {
    char *buf, *pa0;
    uint n, va0;

    buf = (char *) p;
    while (len > 0) {
        va0 = (uint) PGROUNDDOWN(va);
        pa0 = uva2ka(pgdir, (char *) va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (va - va0);
        if (n > len)
            n = len;
        memmove(pa0 + (va - va0), buf, n);
        len -= n;
        buf += n;
        va = va0 + PGSIZE;
    }
    return 0;
}

static char buff[PGSIZE];


int page_from_disk(int va) {
    myproc()->page_fault_counter++;
    struct proc *p = myproc();
    int p_va = PGROUNDDOWN(va);
    char *np = kalloc();
    memset(np, 0, PGSIZE);
    int free_ram_idx = get_free_ram_idx();
    if (free_ram_idx >= 0) {
        page_in(p_va, V2P(np), myproc()->pgdir);
        read_page_from_disk(p, free_ram_idx, p_va, (char *) p_va);
        return 1;
    }
    p->pages_in_file++;
    int ram_idx = replace_page_by_policy();
//    cprintf("page_from_disk: ram_idx = %d\n", ram_idx);
    struct p_monitor page = p->ram_monitor[ram_idx];
    page_in(p_va, V2P(np), myproc()->pgdir);
    read_page_from_disk(p, ram_idx, p_va, buff);
    pte_t *pte = walkpgdir(page.pgdir, (int *) page.p_va, 0);
    if (!pte)
        return -1;
    int va1 = PTE_ADDR(*pte);
    memmove(np, buff, PGSIZE);
    write2file(page.p_va, page.pgdir);
    page_out(page.p_va, page.pgdir);
    char *v = P2V(va1);
    kfree(v);
    return 1;
}

void
update_protected_pages(int up) {
    if (up) myproc()->protected++;
    else myproc()->protected--;
}