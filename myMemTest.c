#include "types.h"
#include "user.h"



#define PGSIZE 4096


int protected_count = 0;
int total_available_pages = 20;
int swap_pages = 4;
int page_fault_counter = 0;
int pages_in_file = 0;





int test1() {

    int *mem = malloc(4096);

    if (protect_page(mem) == 0) {
        pfree(mem);
    } else {
        free(mem);
    }


    int *page = pmalloc();

    if (protect_page(page) == 1) {
        printf(1, "protect_page success (:\n");
        protected_count++;
        if (pfree(page) < 0) {
            printf(1, "pfree failed\n");
            free(page);
        } else {
            printf(1, "pfree success (:\n");
            protected_count--;
        }
    } else {
        free(page);
        printf(1, "protect_page fail\n");
    }

    sleep(200);
    return 1;
}


int test2() {
    char input[50];


    for (int j = 0; j < 50; ++j) {
        memset(input,0,1);
    }
    const int pages_zise = 10;
     char *pages[pages_zise];

    printf(1, "allocating pages...\n");
    for (int i = 0; i < pages_zise; i++) {
//        printf(1, "allocating page %d\n",i);
        pages[i] = malloc(PGSIZE);
        memset(pages[i], 0, 1);
    }
    printf(1, "allocating pages success (:\n");

    printf(1, "trying to access pages...\n");
    for (int i = 0; i < pages_zise; i++) {
        if (pages[i][0] != 0) {
            return -1;
        }
    }
    printf(1, "access pages success (:\n");

    sleep(200);

    char *extra_pg = malloc(PGSIZE);
    memset(extra_pg, 0, 1);

    return 1;
}


int test3() {
#ifdef NONE
    total_available_pages = 0;
    swap_pages = 0;
#endif

#ifdef LIFO
    page_fault_counter = 6;
    pages_in_file = 10;
#endif

#ifdef SCFIFO
    page_fault_counter = 6;
    pages_in_file = 10;
#endif
    char input[50];

    printf(1, "Press Ctrl+P\n");
    gets(input, 10);


    printf(1,
           "EXPECTED: total_available_pages: %d swap_pages: %d protected: %d page_fault_counter: %d pages_in_file: %d \n",
           total_available_pages, swap_pages, protected_count, page_fault_counter, pages_in_file);

    return 1;
}


int main(int argc, char *argv[]) {

    printf(1, "============= myMemTest INIT ============\n");

    printf(1, "============= test1 ===========\n");
    test1();
    printf(1, "========== test1 pass =========\n");

    printf(1, "============= test2 ===========\n");
    test2();
    printf(1, "========== test2 pass =========\n");

    printf(1, "============= test3 ===========\n");
    test3();
    printf(1, "========== test3 pass =========\n");

    printf(1, "============= myMemTest DONE ============\n");

    exit();
}