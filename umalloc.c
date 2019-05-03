#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"
#include "mmu.h"

// Memory allocator by Kernighan and Ritchie,
// The C programming Language, 2nd ed.  Section 8.7.

typedef long Align;

// Task 1

typedef struct p_node {
    struct p_node *next;
    int free;
    uint va;
} p_node;

static p_node *head = 0;

void init_list();

void *
pmalloc() {
    if (!head)
        init_list();


    struct p_node *curr = head;

    while (1) {
        // no free node found
        if (curr->next == 0 && curr->free == 0) {
            // create new node
            curr->next = (p_node *) malloc(sizeof(struct p_node));
            curr->next->va = (uint) sbrk(PGSIZE);
            break;
        } else {
            if (curr->free == 0) break;
            curr = curr->next;
        }
        curr = curr->next;
    }

    curr->free = 0;

    // TODO: set_flags

//    // try to set flags!
//    if (!set_flags(curr->va, PTE_PM & PTE_P & PTE_U & PTE_W, 0)) {
//        // If failed, mark as free and turn off PRESENT flag
//        curr->used = 0;
//        set_flags(curr->va, ~PTE_P, 1);
//        return 0;
//    }

    return (void *) curr->va;
}

int protect_page(void *ap) {
    struct p_node *curr = head;
    int found_node = 0;
    while (curr != 0) {
        if (curr->va == (uint) ap) {
            found_node = 1;
            break;
        }
        curr = curr->next;
    }
    if (!found_node) return -1;

    // if flag is set as allocated with PMALLOC, protect the page
    if ((get_flags((uint) ap) & PTE_1)) {
        return set_flags((uint) ap, ~PTE_W, 1);
    }
    return -1;
}

void init_list() {
    head = (p_node *) malloc(sizeof(struct p_node));
    head->va = (uint) sbrk(PGSIZE);
    head->free = 1;
    head->next = 0;
}

union header {
    struct {
        union header *ptr;
        uint size;
    } s;
    Align x;
};

typedef union header Header;

static Header base;
static Header *freep;

void
free(void *ap) {
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
    freep = p;
}

static Header *
morecore(uint nu) {
    char *p;
    Header *hp;

    if (nu < 4096)
        nu = 4096;
    p = sbrk(nu * sizeof(Header));
    if (p == (char *) -1)
        return 0;
    hp = (Header *) p;
    hp->s.size = nu;
    free((void *) (hp + 1));
    return freep;
}

void *
malloc(uint nbytes) {
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    if ((prevp = freep) == 0) {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
        if (p->s.size >= nunits) {
            if (p->s.size == nunits)
                prevp->s.ptr = p->s.ptr;
            else {
                p->s.size -= nunits;
                p += p->s.size;
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *) (p + 1);
        }
        if (p == freep)
            if ((p = morecore(nunits)) == 0)
                return 0;
    }
}
