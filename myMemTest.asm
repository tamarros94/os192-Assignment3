
_myMemTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return 1;
}



int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 0c             	sub    $0xc,%esp

    printf(1, "--------- START TESTING! ---------\n\n\n");
  11:	68 f4 0c 00 00       	push   $0xcf4
  16:	6a 01                	push   $0x1
  18:	e8 13 06 00 00       	call   630 <printf>
    printf(1, "policy is SCFIFO\n");
  1d:	58                   	pop    %eax
  1e:	5a                   	pop    %edx
  1f:	68 f0 0b 00 00       	push   $0xbf0
  24:	6a 01                	push   $0x1
  26:	e8 05 06 00 00       	call   630 <printf>
    print_policy();

    printf(1, "------- first_test -------\n");
  2b:	59                   	pop    %ecx
  2c:	58                   	pop    %eax
  2d:	68 31 0c 00 00       	push   $0xc31
  32:	6a 01                	push   $0x1
  34:	e8 f7 05 00 00       	call   630 <printf>
    first_test();
  39:	e8 92 00 00 00       	call   d0 <first_test>
    printf(1, "------- first_test passed-------\n\n");
  3e:	58                   	pop    %eax
  3f:	5a                   	pop    %edx
  40:	68 1c 0d 00 00       	push   $0xd1c
  45:	6a 01                	push   $0x1
  47:	e8 e4 05 00 00       	call   630 <printf>

    printf(1, "------- second_test-------\n");
  4c:	59                   	pop    %ecx
  4d:	58                   	pop    %eax
  4e:	68 4d 0c 00 00       	push   $0xc4d
  53:	6a 01                	push   $0x1
  55:	e8 d6 05 00 00       	call   630 <printf>
    second_test();
  5a:	e8 11 01 00 00       	call   170 <second_test>
    printf(1, "------- second_test passed-------\n\n");
  5f:	58                   	pop    %eax
  60:	5a                   	pop    %edx
  61:	68 40 0d 00 00       	push   $0xd40
  66:	6a 01                	push   $0x1
  68:	e8 c3 05 00 00       	call   630 <printf>

    printf(1, "------- third_test-------\n");
  6d:	59                   	pop    %ecx
  6e:	58                   	pop    %eax
  6f:	68 69 0c 00 00       	push   $0xc69
  74:	6a 01                	push   $0x1
  76:	e8 b5 05 00 00       	call   630 <printf>
    third_test();
  7b:	e8 b0 01 00 00       	call   230 <third_test>
    printf(1, "------- third_test passed-------\n\n");
  80:	58                   	pop    %eax
  81:	5a                   	pop    %edx
  82:	68 64 0d 00 00       	push   $0xd64
  87:	6a 01                	push   $0x1
  89:	e8 a2 05 00 00       	call   630 <printf>

    printf(1, "--------- DONE  TESTING! ---------\n\n");
  8e:	59                   	pop    %ecx
  8f:	58                   	pop    %eax
  90:	68 88 0d 00 00       	push   $0xd88
  95:	6a 01                	push   $0x1
  97:	e8 94 05 00 00       	call   630 <printf>

    exit();
  9c:	e8 31 04 00 00       	call   4d2 <exit>
  a1:	66 90                	xchg   %ax,%ax
  a3:	66 90                	xchg   %ax,%ax
  a5:	66 90                	xchg   %ax,%ax
  a7:	66 90                	xchg   %ax,%ax
  a9:	66 90                	xchg   %ax,%ax
  ab:	66 90                	xchg   %ax,%ax
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <print_policy>:
void print_policy(){
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	83 ec 10             	sub    $0x10,%esp
    printf(1, "policy is SCFIFO\n");
  b6:	68 f0 0b 00 00       	push   $0xbf0
  bb:	6a 01                	push   $0x1
  bd:	e8 6e 05 00 00       	call   630 <printf>
    return;
  c2:	83 c4 10             	add    $0x10,%esp
}
  c5:	c9                   	leave  
  c6:	c3                   	ret    
  c7:	89 f6                	mov    %esi,%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000d0 <first_test>:
int first_test(){
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	83 ec 10             	sub    $0x10,%esp
    int* m = malloc(4096);
  d7:	68 00 10 00 00       	push   $0x1000
  dc:	e8 2f 08 00 00       	call   910 <malloc>
    if(protect_page(m) == 0){
  e1:	89 04 24             	mov    %eax,(%esp)
    int* m = malloc(4096);
  e4:	89 c3                	mov    %eax,%ebx
    if(protect_page(m) == 0){
  e6:	e8 55 0a 00 00       	call   b40 <protect_page>
  eb:	83 c4 10             	add    $0x10,%esp
  ee:	85 c0                	test   %eax,%eax
  f0:	74 5e                	je     150 <first_test+0x80>
        free(m);
  f2:	83 ec 0c             	sub    $0xc,%esp
  f5:	53                   	push   %ebx
  f6:	e8 05 07 00 00       	call   800 <free>
  fb:	83 c4 10             	add    $0x10,%esp
    int* p = pmalloc();
  fe:	e8 5d 09 00 00       	call   a60 <pmalloc>
    if(protect_page(p) == -1){
 103:	83 ec 0c             	sub    $0xc,%esp
    int* p = pmalloc();
 106:	89 c3                	mov    %eax,%ebx
    if(protect_page(p) == -1){
 108:	50                   	push   %eax
 109:	e8 32 0a 00 00       	call   b40 <protect_page>
 10e:	83 c4 10             	add    $0x10,%esp
 111:	83 f8 ff             	cmp    $0xffffffff,%eax
 114:	74 4a                	je     160 <first_test+0x90>
        if (pfree(p) == -1) {
 116:	83 ec 0c             	sub    $0xc,%esp
        protected_pg_num++;
 119:	83 05 50 12 00 00 01 	addl   $0x1,0x1250
        if (pfree(p) == -1) {
 120:	53                   	push   %ebx
 121:	e8 7a 0a 00 00       	call   ba0 <pfree>
 126:	83 c4 10             	add    $0x10,%esp
 129:	83 f8 ff             	cmp    $0xffffffff,%eax
 12c:	74 32                	je     160 <first_test+0x90>
            protected_pg_num--;
 12e:	83 2d 50 12 00 00 01 	subl   $0x1,0x1250
    STAY
 135:	83 ec 0c             	sub    $0xc,%esp
 138:	6a 64                	push   $0x64
 13a:	e8 23 04 00 00       	call   562 <sleep>
}
 13f:	b8 01 00 00 00       	mov    $0x1,%eax
 144:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 147:	c9                   	leave  
 148:	c3                   	ret    
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pfree(m);
 150:	83 ec 0c             	sub    $0xc,%esp
 153:	53                   	push   %ebx
 154:	e8 47 0a 00 00       	call   ba0 <pfree>
 159:	83 c4 10             	add    $0x10,%esp
 15c:	eb a0                	jmp    fe <first_test+0x2e>
 15e:	66 90                	xchg   %ax,%ax
            free(p);
 160:	83 ec 0c             	sub    $0xc,%esp
 163:	53                   	push   %ebx
 164:	e8 97 06 00 00       	call   800 <free>
 169:	83 c4 10             	add    $0x10,%esp
 16c:	eb c7                	jmp    135 <first_test+0x65>
 16e:	66 90                	xchg   %ax,%ax

00000170 <second_test>:
int second_test(){
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
    for(i=0;i<ALLOC_NUM;i++){
 174:	31 db                	xor    %ebx,%ebx
int second_test(){
 176:	83 ec 4c             	sub    $0x4c,%esp
    printf(1,"malloc pages\n");
 179:	68 02 0c 00 00       	push   $0xc02
 17e:	6a 01                	push   $0x1
 180:	e8 ab 04 00 00       	call   630 <printf>
 185:	83 c4 10             	add    $0x10,%esp
 188:	90                   	nop
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pages[i] =  malloc(PGSIZE);
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	68 00 10 00 00       	push   $0x1000
 198:	e8 73 07 00 00       	call   910 <malloc>
        memset(pages[i], i, 1);
 19d:	83 c4 0c             	add    $0xc,%esp
        pages[i] =  malloc(PGSIZE);
 1a0:	89 44 9d bc          	mov    %eax,-0x44(%ebp,%ebx,4)
        memset(pages[i], i, 1);
 1a4:	6a 01                	push   $0x1
 1a6:	53                   	push   %ebx
    for(i=0;i<ALLOC_NUM;i++){
 1a7:	83 c3 01             	add    $0x1,%ebx
        memset(pages[i], i, 1);
 1aa:	50                   	push   %eax
 1ab:	e8 80 01 00 00       	call   330 <memset>
    for(i=0;i<ALLOC_NUM;i++){
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	83 fb 0f             	cmp    $0xf,%ebx
 1b6:	75 d8                	jne    190 <second_test+0x20>
    STAY
 1b8:	83 ec 0c             	sub    $0xc,%esp
 1bb:	6a 64                	push   $0x64
 1bd:	e8 a0 03 00 00       	call   562 <sleep>
    printf(1,"validate pages\n");
 1c2:	58                   	pop    %eax
 1c3:	5a                   	pop    %edx
 1c4:	68 10 0c 00 00       	push   $0xc10
 1c9:	6a 01                	push   $0x1
 1cb:	e8 60 04 00 00       	call   630 <printf>
 1d0:	83 c4 10             	add    $0x10,%esp
    for(i=0;i<ALLOC_NUM;i++){
 1d3:	31 c0                	xor    %eax,%eax
 1d5:	eb 11                	jmp    1e8 <second_test+0x78>
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 1e0:	83 c0 01             	add    $0x1,%eax
 1e3:	83 f8 0f             	cmp    $0xf,%eax
 1e6:	74 18                	je     200 <second_test+0x90>
        if(pages[i][0] != i){
 1e8:	8b 54 85 bc          	mov    -0x44(%ebp,%eax,4),%edx
 1ec:	0f be 12             	movsbl (%edx),%edx
 1ef:	39 c2                	cmp    %eax,%edx
 1f1:	74 ed                	je     1e0 <second_test+0x70>
            return -1;
 1f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave  
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    char* extra_pg = malloc(PGSIZE);
 200:	83 ec 0c             	sub    $0xc,%esp
 203:	68 00 10 00 00       	push   $0x1000
 208:	e8 03 07 00 00       	call   910 <malloc>
    memset(extra_pg,EXRA_DATA,1);
 20d:	83 c4 0c             	add    $0xc,%esp
 210:	6a 01                	push   $0x1
 212:	6a 12                	push   $0x12
 214:	50                   	push   %eax
 215:	e8 16 01 00 00       	call   330 <memset>
 21a:	83 c4 10             	add    $0x10,%esp
 21d:	b8 01 00 00 00       	mov    $0x1,%eax
}
 222:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 225:	c9                   	leave  
 226:	c3                   	ret    
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <third_test>:
int third_test(){
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	83 ec 50             	sub    $0x50,%esp
    printf(1," Execute Ctrl+P\n");
 236:	68 20 0c 00 00       	push   $0xc20
 23b:	6a 01                	push   $0x1
 23d:	e8 ee 03 00 00       	call   630 <printf>
    gets(input, 10);
 242:	58                   	pop    %eax
 243:	8d 45 c6             	lea    -0x3a(%ebp),%eax
 246:	5a                   	pop    %edx
 247:	6a 0a                	push   $0xa
 249:	50                   	push   %eax
 24a:	e8 41 01 00 00       	call   390 <gets>
    printf(1,"allocated pages: %d \npaged out num: %d \nprotected pages num: %d \npage faults num: %d \ntotal paged out num: %d \n", allocated_pg_num, pg_out_num, protected_pg_num, pgflt_num, total_pgout_num );
 24f:	83 c4 0c             	add    $0xc,%esp
 252:	6a 29                	push   $0x29
 254:	6a 1c                	push   $0x1c
 256:	ff 35 50 12 00 00    	pushl  0x1250
 25c:	6a 0d                	push   $0xd
 25e:	6a 1d                	push   $0x1d
 260:	68 84 0c 00 00       	push   $0xc84
 265:	6a 01                	push   $0x1
 267:	e8 c4 03 00 00       	call   630 <printf>
}
 26c:	b8 01 00 00 00       	mov    $0x1,%eax
 271:	c9                   	leave  
 272:	c3                   	ret    
 273:	66 90                	xchg   %ax,%ax
 275:	66 90                	xchg   %ax,%ax
 277:	66 90                	xchg   %ax,%ax
 279:	66 90                	xchg   %ax,%ax
 27b:	66 90                	xchg   %ax,%ax
 27d:	66 90                	xchg   %ax,%ax
 27f:	90                   	nop

00000280 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 28a:	89 c2                	mov    %eax,%edx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 290:	83 c1 01             	add    $0x1,%ecx
 293:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 297:	83 c2 01             	add    $0x1,%edx
 29a:	84 db                	test   %bl,%bl
 29c:	88 5a ff             	mov    %bl,-0x1(%edx)
 29f:	75 ef                	jne    290 <strcpy+0x10>
    ;
  return os;
}
 2a1:	5b                   	pop    %ebx
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2ba:	0f b6 02             	movzbl (%edx),%eax
 2bd:	0f b6 19             	movzbl (%ecx),%ebx
 2c0:	84 c0                	test   %al,%al
 2c2:	75 1c                	jne    2e0 <strcmp+0x30>
 2c4:	eb 2a                	jmp    2f0 <strcmp+0x40>
 2c6:	8d 76 00             	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2d6:	83 c1 01             	add    $0x1,%ecx
 2d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 2dc:	84 c0                	test   %al,%al
 2de:	74 10                	je     2f0 <strcmp+0x40>
 2e0:	38 d8                	cmp    %bl,%al
 2e2:	74 ec                	je     2d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 2e4:	29 d8                	sub    %ebx,%eax
}
 2e6:	5b                   	pop    %ebx
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2f2:	29 d8                	sub    %ebx,%eax
}
 2f4:	5b                   	pop    %ebx
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strlen>:

uint
strlen(char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 306:	80 39 00             	cmpb   $0x0,(%ecx)
 309:	74 15                	je     320 <strlen+0x20>
 30b:	31 d2                	xor    %edx,%edx
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	83 c2 01             	add    $0x1,%edx
 313:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 317:	89 d0                	mov    %edx,%eax
 319:	75 f5                	jne    310 <strlen+0x10>
    ;
  return n;
}
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 320:	31 c0                	xor    %eax,%eax
}
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 32a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000330 <memset>:

void*
memset(void *dst, int c, uint n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 337:	8b 4d 10             	mov    0x10(%ebp),%ecx
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 d7                	mov    %edx,%edi
 33f:	fc                   	cld    
 340:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 342:	89 d0                	mov    %edx,%eax
 344:	5f                   	pop    %edi
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <strchr>:

char*
strchr(const char *s, char c)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 35a:	0f b6 10             	movzbl (%eax),%edx
 35d:	84 d2                	test   %dl,%dl
 35f:	74 1d                	je     37e <strchr+0x2e>
    if(*s == c)
 361:	38 d3                	cmp    %dl,%bl
 363:	89 d9                	mov    %ebx,%ecx
 365:	75 0d                	jne    374 <strchr+0x24>
 367:	eb 17                	jmp    380 <strchr+0x30>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 370:	38 ca                	cmp    %cl,%dl
 372:	74 0c                	je     380 <strchr+0x30>
  for(; *s; s++)
 374:	83 c0 01             	add    $0x1,%eax
 377:	0f b6 10             	movzbl (%eax),%edx
 37a:	84 d2                	test   %dl,%dl
 37c:	75 f2                	jne    370 <strchr+0x20>
      return (char*)s;
  return 0;
 37e:	31 c0                	xor    %eax,%eax
}
 380:	5b                   	pop    %ebx
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
 383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <gets>:

char*
gets(char *buf, int max)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	31 f6                	xor    %esi,%esi
 398:	89 f3                	mov    %esi,%ebx
{
 39a:	83 ec 1c             	sub    $0x1c,%esp
 39d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 3a0:	eb 2f                	jmp    3d1 <gets+0x41>
 3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 3a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ab:	83 ec 04             	sub    $0x4,%esp
 3ae:	6a 01                	push   $0x1
 3b0:	50                   	push   %eax
 3b1:	6a 00                	push   $0x0
 3b3:	e8 32 01 00 00       	call   4ea <read>
    if(cc < 1)
 3b8:	83 c4 10             	add    $0x10,%esp
 3bb:	85 c0                	test   %eax,%eax
 3bd:	7e 1c                	jle    3db <gets+0x4b>
      break;
    buf[i++] = c;
 3bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3c3:	83 c7 01             	add    $0x1,%edi
 3c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 3c9:	3c 0a                	cmp    $0xa,%al
 3cb:	74 23                	je     3f0 <gets+0x60>
 3cd:	3c 0d                	cmp    $0xd,%al
 3cf:	74 1f                	je     3f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 3d1:	83 c3 01             	add    $0x1,%ebx
 3d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3d7:	89 fe                	mov    %edi,%esi
 3d9:	7c cd                	jl     3a8 <gets+0x18>
 3db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 3e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 3e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e6:	5b                   	pop    %ebx
 3e7:	5e                   	pop    %esi
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f0:	8b 75 08             	mov    0x8(%ebp),%esi
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	01 de                	add    %ebx,%esi
 3f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 3fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 3fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 400:	5b                   	pop    %ebx
 401:	5e                   	pop    %esi
 402:	5f                   	pop    %edi
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
 405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <stat>:

int
stat(char *n, struct stat *st)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	pushl  0x8(%ebp)
 41d:	e8 f0 00 00 00       	call   512 <open>
  if(fd < 0)
 422:	83 c4 10             	add    $0x10,%esp
 425:	85 c0                	test   %eax,%eax
 427:	78 27                	js     450 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	ff 75 0c             	pushl  0xc(%ebp)
 42f:	89 c3                	mov    %eax,%ebx
 431:	50                   	push   %eax
 432:	e8 f3 00 00 00       	call   52a <fstat>
  close(fd);
 437:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 43a:	89 c6                	mov    %eax,%esi
  close(fd);
 43c:	e8 b9 00 00 00       	call   4fa <close>
  return r;
 441:	83 c4 10             	add    $0x10,%esp
}
 444:	8d 65 f8             	lea    -0x8(%ebp),%esp
 447:	89 f0                	mov    %esi,%eax
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 450:	be ff ff ff ff       	mov    $0xffffffff,%esi
 455:	eb ed                	jmp    444 <stat+0x34>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <atoi>:

int
atoi(const char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 467:	0f be 11             	movsbl (%ecx),%edx
 46a:	8d 42 d0             	lea    -0x30(%edx),%eax
 46d:	3c 09                	cmp    $0x9,%al
  n = 0;
 46f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 474:	77 1f                	ja     495 <atoi+0x35>
 476:	8d 76 00             	lea    0x0(%esi),%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 480:	8d 04 80             	lea    (%eax,%eax,4),%eax
 483:	83 c1 01             	add    $0x1,%ecx
 486:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 48a:	0f be 11             	movsbl (%ecx),%edx
 48d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 490:	80 fb 09             	cmp    $0x9,%bl
 493:	76 eb                	jbe    480 <atoi+0x20>
  return n;
}
 495:	5b                   	pop    %ebx
 496:	5d                   	pop    %ebp
 497:	c3                   	ret    
 498:	90                   	nop
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
 4a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ae:	85 db                	test   %ebx,%ebx
 4b0:	7e 14                	jle    4c6 <memmove+0x26>
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 4c2:	39 d3                	cmp    %edx,%ebx
 4c4:	75 f2                	jne    4b8 <memmove+0x18>
  return vdst;
}
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    

000004ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ca:	b8 01 00 00 00       	mov    $0x1,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <exit>:
SYSCALL(exit)
 4d2:	b8 02 00 00 00       	mov    $0x2,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <wait>:
SYSCALL(wait)
 4da:	b8 03 00 00 00       	mov    $0x3,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <pipe>:
SYSCALL(pipe)
 4e2:	b8 04 00 00 00       	mov    $0x4,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <read>:
SYSCALL(read)
 4ea:	b8 05 00 00 00       	mov    $0x5,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <write>:
SYSCALL(write)
 4f2:	b8 10 00 00 00       	mov    $0x10,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <close>:
SYSCALL(close)
 4fa:	b8 15 00 00 00       	mov    $0x15,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kill>:
SYSCALL(kill)
 502:	b8 06 00 00 00       	mov    $0x6,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <exec>:
SYSCALL(exec)
 50a:	b8 07 00 00 00       	mov    $0x7,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <open>:
SYSCALL(open)
 512:	b8 0f 00 00 00       	mov    $0xf,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <mknod>:
SYSCALL(mknod)
 51a:	b8 11 00 00 00       	mov    $0x11,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <unlink>:
SYSCALL(unlink)
 522:	b8 12 00 00 00       	mov    $0x12,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <fstat>:
SYSCALL(fstat)
 52a:	b8 08 00 00 00       	mov    $0x8,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <link>:
SYSCALL(link)
 532:	b8 13 00 00 00       	mov    $0x13,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mkdir>:
SYSCALL(mkdir)
 53a:	b8 14 00 00 00       	mov    $0x14,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <chdir>:
SYSCALL(chdir)
 542:	b8 09 00 00 00       	mov    $0x9,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <dup>:
SYSCALL(dup)
 54a:	b8 0a 00 00 00       	mov    $0xa,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <getpid>:
SYSCALL(getpid)
 552:	b8 0b 00 00 00       	mov    $0xb,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <sbrk>:
SYSCALL(sbrk)
 55a:	b8 0c 00 00 00       	mov    $0xc,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <sleep>:
SYSCALL(sleep)
 562:	b8 0d 00 00 00       	mov    $0xd,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <uptime>:
SYSCALL(uptime)
 56a:	b8 0e 00 00 00       	mov    $0xe,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <get_flags>:
SYSCALL(get_flags)
 572:	b8 17 00 00 00       	mov    $0x17,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <set_flag>:
SYSCALL(set_flag)
 57a:	b8 18 00 00 00       	mov    $0x18,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <update_protected_pages>:
SYSCALL(update_protected_pages)
 582:	b8 19 00 00 00       	mov    $0x19,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    
 58a:	66 90                	xchg   %ax,%ax
 58c:	66 90                	xchg   %ax,%ax
 58e:	66 90                	xchg   %ax,%ax

00000590 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 599:	85 d2                	test   %edx,%edx
{
 59b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 59e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 5a0:	79 76                	jns    618 <printint+0x88>
 5a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5a6:	74 70                	je     618 <printint+0x88>
    x = -xx;
 5a8:	f7 d8                	neg    %eax
    neg = 1;
 5aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5b1:	31 f6                	xor    %esi,%esi
 5b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5b6:	eb 0a                	jmp    5c2 <printint+0x32>
 5b8:	90                   	nop
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 5c0:	89 fe                	mov    %edi,%esi
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	8d 7e 01             	lea    0x1(%esi),%edi
 5c7:	f7 f1                	div    %ecx
 5c9:	0f b6 92 b8 0d 00 00 	movzbl 0xdb8(%edx),%edx
  }while((x /= base) != 0);
 5d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 5d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 5d5:	75 e9                	jne    5c0 <printint+0x30>
  if(neg)
 5d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5da:	85 c0                	test   %eax,%eax
 5dc:	74 08                	je     5e6 <printint+0x56>
    buf[i++] = '-';
 5de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 5e3:	8d 7e 02             	lea    0x2(%esi),%edi
 5e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 5ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
 5f0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
 5f6:	83 ee 01             	sub    $0x1,%esi
 5f9:	6a 01                	push   $0x1
 5fb:	53                   	push   %ebx
 5fc:	57                   	push   %edi
 5fd:	88 45 d7             	mov    %al,-0x29(%ebp)
 600:	e8 ed fe ff ff       	call   4f2 <write>

  while(--i >= 0)
 605:	83 c4 10             	add    $0x10,%esp
 608:	39 de                	cmp    %ebx,%esi
 60a:	75 e4                	jne    5f0 <printint+0x60>
    putc(fd, buf[i]);
}
 60c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60f:	5b                   	pop    %ebx
 610:	5e                   	pop    %esi
 611:	5f                   	pop    %edi
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 618:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 61f:	eb 90                	jmp    5b1 <printint+0x21>
 621:	eb 0d                	jmp    630 <printf>
 623:	90                   	nop
 624:	90                   	nop
 625:	90                   	nop
 626:	90                   	nop
 627:	90                   	nop
 628:	90                   	nop
 629:	90                   	nop
 62a:	90                   	nop
 62b:	90                   	nop
 62c:	90                   	nop
 62d:	90                   	nop
 62e:	90                   	nop
 62f:	90                   	nop

00000630 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 639:	8b 75 0c             	mov    0xc(%ebp),%esi
 63c:	0f b6 1e             	movzbl (%esi),%ebx
 63f:	84 db                	test   %bl,%bl
 641:	0f 84 b3 00 00 00    	je     6fa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 647:	8d 45 10             	lea    0x10(%ebp),%eax
 64a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 64d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 64f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 652:	eb 2f                	jmp    683 <printf+0x53>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 658:	83 f8 25             	cmp    $0x25,%eax
 65b:	0f 84 a7 00 00 00    	je     708 <printf+0xd8>
  write(fd, &c, 1);
 661:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 664:	83 ec 04             	sub    $0x4,%esp
 667:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 66a:	6a 01                	push   $0x1
 66c:	50                   	push   %eax
 66d:	ff 75 08             	pushl  0x8(%ebp)
 670:	e8 7d fe ff ff       	call   4f2 <write>
 675:	83 c4 10             	add    $0x10,%esp
 678:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 67b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 67f:	84 db                	test   %bl,%bl
 681:	74 77                	je     6fa <printf+0xca>
    if(state == 0){
 683:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 685:	0f be cb             	movsbl %bl,%ecx
 688:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 68b:	74 cb                	je     658 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 68d:	83 ff 25             	cmp    $0x25,%edi
 690:	75 e6                	jne    678 <printf+0x48>
      if(c == 'd'){
 692:	83 f8 64             	cmp    $0x64,%eax
 695:	0f 84 05 01 00 00    	je     7a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 69b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6a1:	83 f9 70             	cmp    $0x70,%ecx
 6a4:	74 72                	je     718 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6a6:	83 f8 73             	cmp    $0x73,%eax
 6a9:	0f 84 99 00 00 00    	je     748 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6af:	83 f8 63             	cmp    $0x63,%eax
 6b2:	0f 84 08 01 00 00    	je     7c0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6b8:	83 f8 25             	cmp    $0x25,%eax
 6bb:	0f 84 ef 00 00 00    	je     7b0 <printf+0x180>
  write(fd, &c, 1);
 6c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6c4:	83 ec 04             	sub    $0x4,%esp
 6c7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6cb:	6a 01                	push   $0x1
 6cd:	50                   	push   %eax
 6ce:	ff 75 08             	pushl  0x8(%ebp)
 6d1:	e8 1c fe ff ff       	call   4f2 <write>
 6d6:	83 c4 0c             	add    $0xc,%esp
 6d9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6dc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6df:	6a 01                	push   $0x1
 6e1:	50                   	push   %eax
 6e2:	ff 75 08             	pushl  0x8(%ebp)
 6e5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6e8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6ea:	e8 03 fe ff ff       	call   4f2 <write>
  for(i = 0; fmt[i]; i++){
 6ef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 6f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6f6:	84 db                	test   %bl,%bl
 6f8:	75 89                	jne    683 <printf+0x53>
    }
  }
}
 6fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6fd:	5b                   	pop    %ebx
 6fe:	5e                   	pop    %esi
 6ff:	5f                   	pop    %edi
 700:	5d                   	pop    %ebp
 701:	c3                   	ret    
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 708:	bf 25 00 00 00       	mov    $0x25,%edi
 70d:	e9 66 ff ff ff       	jmp    678 <printf+0x48>
 712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 718:	83 ec 0c             	sub    $0xc,%esp
 71b:	b9 10 00 00 00       	mov    $0x10,%ecx
 720:	6a 00                	push   $0x0
 722:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	8b 17                	mov    (%edi),%edx
 72a:	e8 61 fe ff ff       	call   590 <printint>
        ap++;
 72f:	89 f8                	mov    %edi,%eax
 731:	83 c4 10             	add    $0x10,%esp
      state = 0;
 734:	31 ff                	xor    %edi,%edi
        ap++;
 736:	83 c0 04             	add    $0x4,%eax
 739:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 73c:	e9 37 ff ff ff       	jmp    678 <printf+0x48>
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 748:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 74b:	8b 08                	mov    (%eax),%ecx
        ap++;
 74d:	83 c0 04             	add    $0x4,%eax
 750:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 753:	85 c9                	test   %ecx,%ecx
 755:	0f 84 8e 00 00 00    	je     7e9 <printf+0x1b9>
        while(*s != 0){
 75b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 75e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 760:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 762:	84 c0                	test   %al,%al
 764:	0f 84 0e ff ff ff    	je     678 <printf+0x48>
 76a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 76d:	89 de                	mov    %ebx,%esi
 76f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 772:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 775:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 778:	83 ec 04             	sub    $0x4,%esp
          s++;
 77b:	83 c6 01             	add    $0x1,%esi
 77e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 781:	6a 01                	push   $0x1
 783:	57                   	push   %edi
 784:	53                   	push   %ebx
 785:	e8 68 fd ff ff       	call   4f2 <write>
        while(*s != 0){
 78a:	0f b6 06             	movzbl (%esi),%eax
 78d:	83 c4 10             	add    $0x10,%esp
 790:	84 c0                	test   %al,%al
 792:	75 e4                	jne    778 <printf+0x148>
 794:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 797:	31 ff                	xor    %edi,%edi
 799:	e9 da fe ff ff       	jmp    678 <printf+0x48>
 79e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7a0:	83 ec 0c             	sub    $0xc,%esp
 7a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7a8:	6a 01                	push   $0x1
 7aa:	e9 73 ff ff ff       	jmp    722 <printf+0xf2>
 7af:	90                   	nop
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
 7b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7b9:	6a 01                	push   $0x1
 7bb:	e9 21 ff ff ff       	jmp    6e1 <printf+0xb1>
        putc(fd, *ap);
 7c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 7c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7c6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 7c8:	6a 01                	push   $0x1
        ap++;
 7ca:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 7cd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7d3:	50                   	push   %eax
 7d4:	ff 75 08             	pushl  0x8(%ebp)
 7d7:	e8 16 fd ff ff       	call   4f2 <write>
        ap++;
 7dc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 7df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7e2:	31 ff                	xor    %edi,%edi
 7e4:	e9 8f fe ff ff       	jmp    678 <printf+0x48>
          s = "(null)";
 7e9:	bb b0 0d 00 00       	mov    $0xdb0,%ebx
        while(*s != 0){
 7ee:	b8 28 00 00 00       	mov    $0x28,%eax
 7f3:	e9 72 ff ff ff       	jmp    76a <printf+0x13a>
 7f8:	66 90                	xchg   %ax,%ax
 7fa:	66 90                	xchg   %ax,%ax
 7fc:	66 90                	xchg   %ax,%ax
 7fe:	66 90                	xchg   %ax,%ax

00000800 <free>:

static Header base;
static Header *freep;

void
free(void *ap) {
 800:	55                   	push   %ebp
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 801:	a1 54 12 00 00       	mov    0x1254,%eax
free(void *ap) {
 806:	89 e5                	mov    %esp,%ebp
 808:	57                   	push   %edi
 809:	56                   	push   %esi
 80a:	53                   	push   %ebx
 80b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = (Header *) ap - 1;
 80e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 818:	39 c8                	cmp    %ecx,%eax
 81a:	8b 10                	mov    (%eax),%edx
 81c:	73 32                	jae    850 <free+0x50>
 81e:	39 d1                	cmp    %edx,%ecx
 820:	72 04                	jb     826 <free+0x26>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 822:	39 d0                	cmp    %edx,%eax
 824:	72 32                	jb     858 <free+0x58>
            break;
    if (bp + bp->s.size == p->s.ptr) {
 826:	8b 73 fc             	mov    -0x4(%ebx),%esi
 829:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 82c:	39 fa                	cmp    %edi,%edx
 82e:	74 30                	je     860 <free+0x60>
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
 830:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 833:	8b 50 04             	mov    0x4(%eax),%edx
 836:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 839:	39 f1                	cmp    %esi,%ecx
 83b:	74 3a                	je     877 <free+0x77>
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
 83d:	89 08                	mov    %ecx,(%eax)
    freep = p;
 83f:	a3 54 12 00 00       	mov    %eax,0x1254
}
 844:	5b                   	pop    %ebx
 845:	5e                   	pop    %esi
 846:	5f                   	pop    %edi
 847:	5d                   	pop    %ebp
 848:	c3                   	ret    
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 850:	39 d0                	cmp    %edx,%eax
 852:	72 04                	jb     858 <free+0x58>
 854:	39 d1                	cmp    %edx,%ecx
 856:	72 ce                	jb     826 <free+0x26>
free(void *ap) {
 858:	89 d0                	mov    %edx,%eax
 85a:	eb bc                	jmp    818 <free+0x18>
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->s.size += p->s.ptr->s.size;
 860:	03 72 04             	add    0x4(%edx),%esi
 863:	89 73 fc             	mov    %esi,-0x4(%ebx)
        bp->s.ptr = p->s.ptr->s.ptr;
 866:	8b 10                	mov    (%eax),%edx
 868:	8b 12                	mov    (%edx),%edx
 86a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 86d:	8b 50 04             	mov    0x4(%eax),%edx
 870:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 873:	39 f1                	cmp    %esi,%ecx
 875:	75 c6                	jne    83d <free+0x3d>
        p->s.size += bp->s.size;
 877:	03 53 fc             	add    -0x4(%ebx),%edx
    freep = p;
 87a:	a3 54 12 00 00       	mov    %eax,0x1254
        p->s.size += bp->s.size;
 87f:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
 882:	8b 53 f8             	mov    -0x8(%ebx),%edx
 885:	89 10                	mov    %edx,(%eax)
}
 887:	5b                   	pop    %ebx
 888:	5e                   	pop    %esi
 889:	5f                   	pop    %edi
 88a:	5d                   	pop    %ebp
 88b:	c3                   	ret    
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000890 <morecore>:

static Header*
morecore(uint nu, int pmalloced)
{
 890:	55                   	push   %ebp
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
 891:	3d ff 0f 00 00       	cmp    $0xfff,%eax
{
 896:	89 e5                	mov    %esp,%ebp
 898:	56                   	push   %esi
 899:	53                   	push   %ebx
 89a:	89 c3                	mov    %eax,%ebx
    if(nu < 4096 && !pmalloced)
 89c:	77 52                	ja     8f0 <morecore+0x60>
 89e:	83 e2 01             	and    $0x1,%edx
 8a1:	75 4d                	jne    8f0 <morecore+0x60>
 8a3:	be 00 80 00 00       	mov    $0x8000,%esi
        nu = 4096;
 8a8:	bb 00 10 00 00       	mov    $0x1000,%ebx
    printf(1 , "enter morecore %d\n", nu);
 8ad:	83 ec 04             	sub    $0x4,%esp
 8b0:	53                   	push   %ebx
 8b1:	68 c9 0d 00 00       	push   $0xdc9
 8b6:	6a 01                	push   $0x1
 8b8:	e8 73 fd ff ff       	call   630 <printf>
    p = sbrk(nu * sizeof(Header));
 8bd:	89 34 24             	mov    %esi,(%esp)
 8c0:	e8 95 fc ff ff       	call   55a <sbrk>
    if(p == (char*)-1)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	83 f8 ff             	cmp    $0xffffffff,%eax
 8cb:	74 33                	je     900 <morecore+0x70>
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
 8cd:	89 58 04             	mov    %ebx,0x4(%eax)
    free((void*)(hp + 1));
 8d0:	83 ec 0c             	sub    $0xc,%esp
 8d3:	83 c0 08             	add    $0x8,%eax
 8d6:	50                   	push   %eax
 8d7:	e8 24 ff ff ff       	call   800 <free>
    return freep;
 8dc:	a1 54 12 00 00       	mov    0x1254,%eax
 8e1:	83 c4 10             	add    $0x10,%esp
}
 8e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8e7:	5b                   	pop    %ebx
 8e8:	5e                   	pop    %esi
 8e9:	5d                   	pop    %ebp
 8ea:	c3                   	ret    
 8eb:	90                   	nop
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8f0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8f7:	eb b4                	jmp    8ad <morecore+0x1d>
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return 0;
 900:	31 c0                	xor    %eax,%eax
 902:	eb e0                	jmp    8e4 <morecore+0x54>
 904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 90a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000910 <malloc>:

void*
malloc(uint nbytes)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 10             	sub    $0x10,%esp
 919:	8b 75 08             	mov    0x8(%ebp),%esi
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
 91c:	56                   	push   %esi
 91d:	68 dc 0d 00 00       	push   $0xddc
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	83 c6 07             	add    $0x7,%esi
    printf(1, "nbytes:%d\n",nbytes);
 925:	6a 01                	push   $0x1
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 927:	c1 ee 03             	shr    $0x3,%esi
 92a:	83 c6 01             	add    $0x1,%esi
    printf(1, "nbytes:%d\n",nbytes);
 92d:	e8 fe fc ff ff       	call   630 <printf>
    if((prevp = freep) == 0){
 932:	8b 3d 54 12 00 00    	mov    0x1254,%edi
 938:	83 c4 10             	add    $0x10,%esp
 93b:	85 ff                	test   %edi,%edi
 93d:	0f 84 d5 00 00 00    	je     a18 <malloc+0x108>
 943:	8b 1f                	mov    (%edi),%ebx
 945:	8b 53 04             	mov    0x4(%ebx),%edx
 948:	eb 0f                	jmp    959 <malloc+0x49>
 94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	8b 03                	mov    (%ebx),%eax
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
 952:	89 df                	mov    %ebx,%edi
 954:	8b 50 04             	mov    0x4(%eax),%edx
 957:	89 c3                	mov    %eax,%ebx
 959:	83 ec 04             	sub    $0x4,%esp
 95c:	52                   	push   %edx
 95d:	68 fb 0d 00 00       	push   $0xdfb
 962:	6a 01                	push   $0x1
 964:	e8 c7 fc ff ff       	call   630 <printf>
        if(p->s.size >= nunits){
 969:	8b 43 04             	mov    0x4(%ebx),%eax
 96c:	83 c4 10             	add    $0x10,%esp
 96f:	39 f0                	cmp    %esi,%eax
 971:	73 3d                	jae    9b0 <malloc+0xa0>
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
 973:	39 1d 54 12 00 00    	cmp    %ebx,0x1254
 979:	75 d5                	jne    950 <malloc+0x40>
            printf(1, "calling morecore: 0x%x\n", p);
 97b:	83 ec 04             	sub    $0x4,%esp
 97e:	53                   	push   %ebx
 97f:	68 5f 0e 00 00       	push   $0xe5f
 984:	6a 01                	push   $0x1
 986:	e8 a5 fc ff ff       	call   630 <printf>
            if((p = morecore(nunits,0)) == 0)
 98b:	31 d2                	xor    %edx,%edx
 98d:	89 f0                	mov    %esi,%eax
 98f:	e8 fc fe ff ff       	call   890 <morecore>
 994:	83 c4 10             	add    $0x10,%esp
 997:	85 c0                	test   %eax,%eax
 999:	89 c3                	mov    %eax,%ebx
 99b:	75 b3                	jne    950 <malloc+0x40>
                return 0;
    }}
}
 99d:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return 0;
 9a0:	31 c0                	xor    %eax,%eax
}
 9a2:	5b                   	pop    %ebx
 9a3:	5e                   	pop    %esi
 9a4:	5f                   	pop    %edi
 9a5:	5d                   	pop    %ebp
 9a6:	c3                   	ret    
 9a7:	89 f6                	mov    %esi,%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->s.size == nunits){
 9b0:	74 46                	je     9f8 <malloc+0xe8>
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
 9b2:	56                   	push   %esi
 9b3:	50                   	push   %eax
 9b4:	68 32 0e 00 00       	push   $0xe32
 9b9:	6a 01                	push   $0x1
 9bb:	e8 70 fc ff ff       	call   630 <printf>
                p->s.size -= nunits;
 9c0:	8b 43 04             	mov    0x4(%ebx),%eax
                p->s.size = nunits;
 9c3:	83 c4 10             	add    $0x10,%esp
                p->s.size -= nunits;
 9c6:	29 f0                	sub    %esi,%eax
 9c8:	89 43 04             	mov    %eax,0x4(%ebx)
                p += p->s.size;
 9cb:	8d 1c c3             	lea    (%ebx,%eax,8),%ebx
                p->s.size = nunits;
 9ce:	89 73 04             	mov    %esi,0x4(%ebx)
            printf(1,"returning p+1\n");
 9d1:	83 ec 08             	sub    $0x8,%esp
 9d4:	68 50 0e 00 00       	push   $0xe50
 9d9:	6a 01                	push   $0x1
 9db:	e8 50 fc ff ff       	call   630 <printf>
            freep = prevp;
 9e0:	89 3d 54 12 00 00    	mov    %edi,0x1254
            return (void*)(p + 1);
 9e6:	83 c4 10             	add    $0x10,%esp
}
 9e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return (void*)(p + 1);
 9ec:	8d 43 08             	lea    0x8(%ebx),%eax
}
 9ef:	5b                   	pop    %ebx
 9f0:	5e                   	pop    %esi
 9f1:	5f                   	pop    %edi
 9f2:	5d                   	pop    %ebp
 9f3:	c3                   	ret    
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"p->s.size == nunits == %d\n",nunits);
 9f8:	83 ec 04             	sub    $0x4,%esp
 9fb:	56                   	push   %esi
 9fc:	68 17 0e 00 00       	push   $0xe17
 a01:	6a 01                	push   $0x1
 a03:	e8 28 fc ff ff       	call   630 <printf>
                prevp->s.ptr = p->s.ptr;}
 a08:	8b 03                	mov    (%ebx),%eax
 a0a:	83 c4 10             	add    $0x10,%esp
 a0d:	89 07                	mov    %eax,(%edi)
 a0f:	eb c0                	jmp    9d1 <malloc+0xc1>
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"prevp = freep == 0\n");
 a18:	83 ec 08             	sub    $0x8,%esp
        base.s.size = 0;
 a1b:	bb 58 12 00 00       	mov    $0x1258,%ebx
        printf(1,"prevp = freep == 0\n");
 a20:	68 e7 0d 00 00       	push   $0xde7
 a25:	6a 01                	push   $0x1
        base.s.ptr = freep = prevp = &base;
 a27:	89 df                	mov    %ebx,%edi
        printf(1,"prevp = freep == 0\n");
 a29:	e8 02 fc ff ff       	call   630 <printf>
        base.s.ptr = freep = prevp = &base;
 a2e:	c7 05 54 12 00 00 58 	movl   $0x1258,0x1254
 a35:	12 00 00 
 a38:	c7 05 58 12 00 00 58 	movl   $0x1258,0x1258
 a3f:	12 00 00 
        base.s.size = 0;
 a42:	83 c4 10             	add    $0x10,%esp
 a45:	c7 05 5c 12 00 00 00 	movl   $0x0,0x125c
 a4c:	00 00 00 
 a4f:	31 d2                	xor    %edx,%edx
 a51:	e9 03 ff ff ff       	jmp    959 <malloc+0x49>
 a56:	8d 76 00             	lea    0x0(%esi),%esi
 a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a60 <pmalloc>:
void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
 a60:	8b 0d 54 12 00 00    	mov    0x1254,%ecx
pmalloc(void) {
 a66:	55                   	push   %ebp
 a67:	89 e5                	mov    %esp,%ebp
 a69:	56                   	push   %esi
 a6a:	53                   	push   %ebx
    if ((prevp = freep) == 0) {
 a6b:	85 c9                	test   %ecx,%ecx
 a6d:	0f 84 95 00 00 00    	je     b08 <pmalloc+0xa8>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a73:	8b 19                	mov    (%ecx),%ebx
        if (p->s.size >= ((4096 / 8)*2)) {
 a75:	8b 53 04             	mov    0x4(%ebx),%edx
 a78:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 a7e:	76 1d                	jbe    a9d <pmalloc+0x3d>
 a80:	eb 3f                	jmp    ac1 <pmalloc+0x61>
 a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a88:	8b 03                	mov    (%ebx),%eax
        if (p->s.size >= ((4096 / 8)*2)) {
 a8a:	8b 50 04             	mov    0x4(%eax),%edx
 a8d:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 a93:	77 30                	ja     ac5 <pmalloc+0x65>
 a95:	8b 0d 54 12 00 00    	mov    0x1254,%ecx
 a9b:	89 c3                	mov    %eax,%ebx


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
 a9d:	39 cb                	cmp    %ecx,%ebx
 a9f:	75 e7                	jne    a88 <pmalloc+0x28>
                if ((p = morecore(nunits, 1)) == 0) {
 aa1:	ba 01 00 00 00       	mov    $0x1,%edx
 aa6:	b8 00 02 00 00       	mov    $0x200,%eax
 aab:	e8 e0 fd ff ff       	call   890 <morecore>
 ab0:	85 c0                	test   %eax,%eax
 ab2:	89 c3                	mov    %eax,%ebx
 ab4:	75 d2                	jne    a88 <pmalloc+0x28>
                    return 0;
                }
            }
        }
}
 ab6:	8d 65 f8             	lea    -0x8(%ebp),%esp
                    return 0;
 ab9:	31 f6                	xor    %esi,%esi
}
 abb:	89 f0                	mov    %esi,%eax
 abd:	5b                   	pop    %ebx
 abe:	5e                   	pop    %esi
 abf:	5d                   	pop    %ebp
 ac0:	c3                   	ret    
        if (p->s.size >= ((4096 / 8)*2)) {
 ac1:	89 d8                	mov    %ebx,%eax
 ac3:	89 cb                	mov    %ecx,%ebx
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 ac5:	81 e2 00 fe ff ff    	and    $0xfffffe00,%edx
            set_flag((uint) (p + 1), PTE_1, 1);
 acb:	83 ec 04             	sub    $0x4,%esp
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 ace:	81 ea 01 02 00 00    	sub    $0x201,%edx
            p += p->s.size;
 ad4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 ad7:	89 50 04             	mov    %edx,0x4(%eax)
            set_flag((uint) (p + 1), PTE_1, 1);
 ada:	83 c6 08             	add    $0x8,%esi
            p->s.size = nunits;
 add:	c7 46 fc 00 02 00 00 	movl   $0x200,-0x4(%esi)
            set_flag((uint) (p + 1), PTE_1, 1);
 ae4:	6a 01                	push   $0x1
 ae6:	68 00 04 00 00       	push   $0x400
 aeb:	56                   	push   %esi
 aec:	e8 89 fa ff ff       	call   57a <set_flag>
            freep = prevp;
 af1:	89 1d 54 12 00 00    	mov    %ebx,0x1254
            return (void *) (p + 1);
 af7:	83 c4 10             	add    $0x10,%esp
}
 afa:	8d 65 f8             	lea    -0x8(%ebp),%esp
 afd:	89 f0                	mov    %esi,%eax
 aff:	5b                   	pop    %ebx
 b00:	5e                   	pop    %esi
 b01:	5d                   	pop    %ebp
 b02:	c3                   	ret    
 b03:	90                   	nop
 b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        base.s.size = 0;
 b08:	b9 58 12 00 00       	mov    $0x1258,%ecx
        base.s.ptr = freep = prevp = &base;
 b0d:	c7 05 54 12 00 00 58 	movl   $0x1258,0x1254
 b14:	12 00 00 
 b17:	c7 05 58 12 00 00 58 	movl   $0x1258,0x1258
 b1e:	12 00 00 
        base.s.size = 0;
 b21:	c7 05 5c 12 00 00 00 	movl   $0x0,0x125c
 b28:	00 00 00 
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b2b:	89 cb                	mov    %ecx,%ebx
 b2d:	e9 6b ff ff ff       	jmp    a9d <pmalloc+0x3d>
 b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <protect_page>:
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
 b40:	55                   	push   %ebp
 b41:	89 e5                	mov    %esp,%ebp
 b43:	53                   	push   %ebx
 b44:	83 ec 04             	sub    $0x4,%esp
 b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((int)(ap-8) % PGSIZE != 0){
 b4a:	8d 43 f8             	lea    -0x8(%ebx),%eax
 b4d:	a9 ff 0f 00 00       	test   $0xfff,%eax
 b52:	75 3c                	jne    b90 <protect_page+0x50>
        return -1;
    }
    int flags = get_flags((uint)ap);
 b54:	83 ec 0c             	sub    $0xc,%esp
 b57:	53                   	push   %ebx
 b58:	e8 15 fa ff ff       	call   572 <get_flags>
    if (flags & PTE_1) {
 b5d:	83 c4 10             	add    $0x10,%esp
 b60:	f6 c4 04             	test   $0x4,%ah
 b63:	74 2b                	je     b90 <protect_page+0x50>
        set_flag((uint) ap, PTE_W, 0);
 b65:	83 ec 04             	sub    $0x4,%esp
 b68:	6a 00                	push   $0x0
 b6a:	6a 02                	push   $0x2
 b6c:	53                   	push   %ebx
 b6d:	e8 08 fa ff ff       	call   57a <set_flag>
        update_protected_pages(1);
 b72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b79:	e8 04 fa ff ff       	call   582 <update_protected_pages>
        return 1;
 b7e:	83 c4 10             	add    $0x10,%esp
 b81:	b8 01 00 00 00       	mov    $0x1,%eax

    }
    return -1;
}
 b86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 b89:	c9                   	leave  
 b8a:	c3                   	ret    
 b8b:	90                   	nop
 b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b95:	eb ef                	jmp    b86 <protect_page+0x46>
 b97:	89 f6                	mov    %esi,%esi
 b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ba0 <pfree>:



int pfree(void *ap){
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	53                   	push   %ebx
 ba4:	83 ec 10             	sub    $0x10,%esp
 ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx

    int flags = get_flags((uint) ap);
 baa:	53                   	push   %ebx
 bab:	e8 c2 f9 ff ff       	call   572 <get_flags>
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
 bb0:	83 c4 10             	add    $0x10,%esp
 bb3:	a8 02                	test   $0x2,%al
 bb5:	75 31                	jne    be8 <pfree+0x48>
 bb7:	83 ec 04             	sub    $0x4,%esp
 bba:	6a 01                	push   $0x1
 bbc:	6a 02                	push   $0x2
 bbe:	53                   	push   %ebx
 bbf:	e8 b6 f9 ff ff       	call   57a <set_flag>
    else
        return -1;

    free(ap);
 bc4:	89 1c 24             	mov    %ebx,(%esp)
 bc7:	e8 34 fc ff ff       	call   800 <free>
    update_protected_pages(0);
 bcc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 bd3:	e8 aa f9 ff ff       	call   582 <update_protected_pages>
    return 1;
 bd8:	83 c4 10             	add    $0x10,%esp
 bdb:	b8 01 00 00 00       	mov    $0x1,%eax
 be0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 be3:	c9                   	leave  
 be4:	c3                   	ret    
 be5:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
 be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 bed:	eb f1                	jmp    be0 <pfree+0x40>
