#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"
#include "mmu.h"

// Memory allocator by Kernighan and Ritchie,
// The C programming Language, 2nd ed.  Section 8.7.

typedef long Align;

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

static Header*
morecore(uint nu, int pmalloced)
{
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
        nu = 4096;
    printf(1 , "enter morecore %d\n", nu);
    p = sbrk(nu * sizeof(Header));
    if(p == (char*)-1)
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
    free((void*)(hp + 1));
    return freep;
}

void*
malloc(uint nbytes)
{
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    if((prevp = freep) == 0){
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
        if(p->s.size >= nunits){
            if(p->s.size == nunits){
                printf(1,"p->s.size == nunits == %d\n",nunits);
                prevp->s.ptr = p->s.ptr;}
            else {
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
                p->s.size -= nunits;
                p += p->s.size;
                p->s.size = nunits;
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
            printf(1, "calling morecore: 0x%x\n", p);
            if((p = morecore(nunits,0)) == 0)
                return 0;
    }}
}

void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
        if (p->s.size >= ((4096 / 8)*2)) {

            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
            p += p->s.size;
            p->s.size = nunits;
            set_flag((uint) (p + 1), PTE_1, 1);


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
                if ((p = morecore(nunits, 1)) == 0) {
                    return 0;
                }
            }
        }
}



//int protect_page(void *ap) {
//
//    int flags = get_flags((uint) ap);
//    if ( !(flags & PTE_1)) {
//        return -1;
//    }
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
    if((int)(ap-8) % PGSIZE != 0){
        return -1;
    }
    int flags = get_flags((uint)ap);
    if (flags & PTE_1) {
        set_flag((uint) ap, PTE_W, 0);
        update_protected_pages(1);
        return 1;

    }
    return -1;
}



int pfree(void *ap){

    int flags = get_flags((uint) ap);
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
    else
        return -1;

    free(ap);
    update_protected_pages(0);
    return 1;
}