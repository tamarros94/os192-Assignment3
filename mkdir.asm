
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bf 01 00 00 00       	mov    $0x1,%edi
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d 76 00             	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 00 03 00 00       	call   33a <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 82 02 00 00       	call   2d2 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 07 0a 00 00       	push   $0xa07
  58:	6a 02                	push   $0x2
  5a:	e8 d1 03 00 00       	call   430 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 f0 09 00 00       	push   $0x9f0
  6b:	6a 02                	push   $0x2
  6d:	e8 be 03 00 00       	call   430 <printf>
    exit();
  72:	e8 5b 02 00 00       	call   2d2 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1c                	jne    e0 <strcmp+0x30>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	83 c1 01             	add    $0x1,%ecx
  d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  dc:	84 c0                	test   %al,%al
  de:	74 10                	je     f0 <strcmp+0x40>
  e0:	38 d8                	cmp    %bl,%al
  e2:	74 ec                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e4:	29 d8                	sub    %ebx,%eax
}
  e6:	5b                   	pop    %ebx
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d9                	mov    %ebx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 196:	31 f6                	xor    %esi,%esi
 198:	89 f3                	mov    %esi,%ebx
{
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1a0:	eb 2f                	jmp    1d1 <gets+0x41>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	6a 01                	push   $0x1
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 32 01 00 00       	call   2ea <read>
    if(cc < 1)
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	85 c0                	test   %eax,%eax
 1bd:	7e 1c                	jle    1db <gets+0x4b>
      break;
    buf[i++] = c;
 1bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c3:	83 c7 01             	add    $0x1,%edi
 1c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1c9:	3c 0a                	cmp    $0xa,%al
 1cb:	74 23                	je     1f0 <gets+0x60>
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 1f                	je     1f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1d1:	83 c3 01             	add    $0x1,%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	89 fe                	mov    %edi,%esi
 1d9:	7c cd                	jl     1a8 <gets+0x18>
 1db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e6:	5b                   	pop    %ebx
 1e7:	5e                   	pop    %esi
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	8b 75 08             	mov    0x8(%ebp),%esi
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 de                	add    %ebx,%esi
 1f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 200:	5b                   	pop    %ebx
 201:	5e                   	pop    %esi
 202:	5f                   	pop    %edi
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	pushl  0x8(%ebp)
 21d:	e8 f0 00 00 00       	call   312 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	pushl  0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f3 00 00 00       	call   32a <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 b9 00 00 00       	call   2fa <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 1f                	ja     295 <atoi+0x35>
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 280:	8d 04 80             	lea    (%eax,%eax,4),%eax
 283:	83 c1 01             	add    $0x1,%ecx
 286:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 28a:	0f be 11             	movsbl (%ecx),%edx
 28d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 db                	test   %ebx,%ebx
 2b0:	7e 14                	jle    2c6 <memmove+0x26>
 2b2:	31 d2                	xor    %edx,%edx
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2c2:	39 d3                	cmp    %edx,%ebx
 2c4:	75 f2                	jne    2b8 <memmove+0x18>
  return vdst;
}
 2c6:	5b                   	pop    %ebx
 2c7:	5e                   	pop    %esi
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    

000002ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ca:	b8 01 00 00 00       	mov    $0x1,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <exit>:
SYSCALL(exit)
 2d2:	b8 02 00 00 00       	mov    $0x2,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <wait>:
SYSCALL(wait)
 2da:	b8 03 00 00 00       	mov    $0x3,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <pipe>:
SYSCALL(pipe)
 2e2:	b8 04 00 00 00       	mov    $0x4,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <read>:
SYSCALL(read)
 2ea:	b8 05 00 00 00       	mov    $0x5,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <write>:
SYSCALL(write)
 2f2:	b8 10 00 00 00       	mov    $0x10,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <close>:
SYSCALL(close)
 2fa:	b8 15 00 00 00       	mov    $0x15,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kill>:
SYSCALL(kill)
 302:	b8 06 00 00 00       	mov    $0x6,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exec>:
SYSCALL(exec)
 30a:	b8 07 00 00 00       	mov    $0x7,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <open>:
SYSCALL(open)
 312:	b8 0f 00 00 00       	mov    $0xf,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mknod>:
SYSCALL(mknod)
 31a:	b8 11 00 00 00       	mov    $0x11,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <unlink>:
SYSCALL(unlink)
 322:	b8 12 00 00 00       	mov    $0x12,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <fstat>:
SYSCALL(fstat)
 32a:	b8 08 00 00 00       	mov    $0x8,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <link>:
SYSCALL(link)
 332:	b8 13 00 00 00       	mov    $0x13,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <mkdir>:
SYSCALL(mkdir)
 33a:	b8 14 00 00 00       	mov    $0x14,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <chdir>:
SYSCALL(chdir)
 342:	b8 09 00 00 00       	mov    $0x9,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <dup>:
SYSCALL(dup)
 34a:	b8 0a 00 00 00       	mov    $0xa,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <getpid>:
SYSCALL(getpid)
 352:	b8 0b 00 00 00       	mov    $0xb,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <sbrk>:
SYSCALL(sbrk)
 35a:	b8 0c 00 00 00       	mov    $0xc,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sleep>:
SYSCALL(sleep)
 362:	b8 0d 00 00 00       	mov    $0xd,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <uptime>:
SYSCALL(uptime)
 36a:	b8 0e 00 00 00       	mov    $0xe,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <get_flags>:
SYSCALL(get_flags)
 372:	b8 17 00 00 00       	mov    $0x17,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <set_flag>:
SYSCALL(set_flag)
 37a:	b8 18 00 00 00       	mov    $0x18,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <update_protected_pages>:
SYSCALL(update_protected_pages)
 382:	b8 19 00 00 00       	mov    $0x19,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 399:	85 d2                	test   %edx,%edx
{
 39b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 39e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3a0:	79 76                	jns    418 <printint+0x88>
 3a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3a6:	74 70                	je     418 <printint+0x88>
    x = -xx;
 3a8:	f7 d8                	neg    %eax
    neg = 1;
 3aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3b1:	31 f6                	xor    %esi,%esi
 3b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3b6:	eb 0a                	jmp    3c2 <printint+0x32>
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	89 fe                	mov    %edi,%esi
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	8d 7e 01             	lea    0x1(%esi),%edi
 3c7:	f7 f1                	div    %ecx
 3c9:	0f b6 92 2c 0a 00 00 	movzbl 0xa2c(%edx),%edx
  }while((x /= base) != 0);
 3d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3d5:	75 e9                	jne    3c0 <printint+0x30>
  if(neg)
 3d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3da:	85 c0                	test   %eax,%eax
 3dc:	74 08                	je     3e6 <printint+0x56>
    buf[i++] = '-';
 3de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3e3:	8d 7e 02             	lea    0x2(%esi),%edi
 3e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3f3:	83 ec 04             	sub    $0x4,%esp
 3f6:	83 ee 01             	sub    $0x1,%esi
 3f9:	6a 01                	push   $0x1
 3fb:	53                   	push   %ebx
 3fc:	57                   	push   %edi
 3fd:	88 45 d7             	mov    %al,-0x29(%ebp)
 400:	e8 ed fe ff ff       	call   2f2 <write>

  while(--i >= 0)
 405:	83 c4 10             	add    $0x10,%esp
 408:	39 de                	cmp    %ebx,%esi
 40a:	75 e4                	jne    3f0 <printint+0x60>
    putc(fd, buf[i]);
}
 40c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40f:	5b                   	pop    %ebx
 410:	5e                   	pop    %esi
 411:	5f                   	pop    %edi
 412:	5d                   	pop    %ebp
 413:	c3                   	ret    
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 418:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 41f:	eb 90                	jmp    3b1 <printint+0x21>
 421:	eb 0d                	jmp    430 <printf>
 423:	90                   	nop
 424:	90                   	nop
 425:	90                   	nop
 426:	90                   	nop
 427:	90                   	nop
 428:	90                   	nop
 429:	90                   	nop
 42a:	90                   	nop
 42b:	90                   	nop
 42c:	90                   	nop
 42d:	90                   	nop
 42e:	90                   	nop
 42f:	90                   	nop

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
 43c:	0f b6 1e             	movzbl (%esi),%ebx
 43f:	84 db                	test   %bl,%bl
 441:	0f 84 b3 00 00 00    	je     4fa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 447:	8d 45 10             	lea    0x10(%ebp),%eax
 44a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 44d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 44f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 452:	eb 2f                	jmp    483 <printf+0x53>
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 458:	83 f8 25             	cmp    $0x25,%eax
 45b:	0f 84 a7 00 00 00    	je     508 <printf+0xd8>
  write(fd, &c, 1);
 461:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 464:	83 ec 04             	sub    $0x4,%esp
 467:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 46a:	6a 01                	push   $0x1
 46c:	50                   	push   %eax
 46d:	ff 75 08             	pushl  0x8(%ebp)
 470:	e8 7d fe ff ff       	call   2f2 <write>
 475:	83 c4 10             	add    $0x10,%esp
 478:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 47b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 47f:	84 db                	test   %bl,%bl
 481:	74 77                	je     4fa <printf+0xca>
    if(state == 0){
 483:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 485:	0f be cb             	movsbl %bl,%ecx
 488:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 48b:	74 cb                	je     458 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 48d:	83 ff 25             	cmp    $0x25,%edi
 490:	75 e6                	jne    478 <printf+0x48>
      if(c == 'd'){
 492:	83 f8 64             	cmp    $0x64,%eax
 495:	0f 84 05 01 00 00    	je     5a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 49b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4a1:	83 f9 70             	cmp    $0x70,%ecx
 4a4:	74 72                	je     518 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4a6:	83 f8 73             	cmp    $0x73,%eax
 4a9:	0f 84 99 00 00 00    	je     548 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4af:	83 f8 63             	cmp    $0x63,%eax
 4b2:	0f 84 08 01 00 00    	je     5c0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4b8:	83 f8 25             	cmp    $0x25,%eax
 4bb:	0f 84 ef 00 00 00    	je     5b0 <printf+0x180>
  write(fd, &c, 1);
 4c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c4:	83 ec 04             	sub    $0x4,%esp
 4c7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4cb:	6a 01                	push   $0x1
 4cd:	50                   	push   %eax
 4ce:	ff 75 08             	pushl  0x8(%ebp)
 4d1:	e8 1c fe ff ff       	call   2f2 <write>
 4d6:	83 c4 0c             	add    $0xc,%esp
 4d9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4dc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4df:	6a 01                	push   $0x1
 4e1:	50                   	push   %eax
 4e2:	ff 75 08             	pushl  0x8(%ebp)
 4e5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4ea:	e8 03 fe ff ff       	call   2f2 <write>
  for(i = 0; fmt[i]; i++){
 4ef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 4f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4f6:	84 db                	test   %bl,%bl
 4f8:	75 89                	jne    483 <printf+0x53>
    }
  }
}
 4fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4fd:	5b                   	pop    %ebx
 4fe:	5e                   	pop    %esi
 4ff:	5f                   	pop    %edi
 500:	5d                   	pop    %ebp
 501:	c3                   	ret    
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 508:	bf 25 00 00 00       	mov    $0x25,%edi
 50d:	e9 66 ff ff ff       	jmp    478 <printf+0x48>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 518:	83 ec 0c             	sub    $0xc,%esp
 51b:	b9 10 00 00 00       	mov    $0x10,%ecx
 520:	6a 00                	push   $0x0
 522:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	8b 17                	mov    (%edi),%edx
 52a:	e8 61 fe ff ff       	call   390 <printint>
        ap++;
 52f:	89 f8                	mov    %edi,%eax
 531:	83 c4 10             	add    $0x10,%esp
      state = 0;
 534:	31 ff                	xor    %edi,%edi
        ap++;
 536:	83 c0 04             	add    $0x4,%eax
 539:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 53c:	e9 37 ff ff ff       	jmp    478 <printf+0x48>
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 54b:	8b 08                	mov    (%eax),%ecx
        ap++;
 54d:	83 c0 04             	add    $0x4,%eax
 550:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 553:	85 c9                	test   %ecx,%ecx
 555:	0f 84 8e 00 00 00    	je     5e9 <printf+0x1b9>
        while(*s != 0){
 55b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 55e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 560:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 562:	84 c0                	test   %al,%al
 564:	0f 84 0e ff ff ff    	je     478 <printf+0x48>
 56a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 56d:	89 de                	mov    %ebx,%esi
 56f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 572:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 575:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 578:	83 ec 04             	sub    $0x4,%esp
          s++;
 57b:	83 c6 01             	add    $0x1,%esi
 57e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 581:	6a 01                	push   $0x1
 583:	57                   	push   %edi
 584:	53                   	push   %ebx
 585:	e8 68 fd ff ff       	call   2f2 <write>
        while(*s != 0){
 58a:	0f b6 06             	movzbl (%esi),%eax
 58d:	83 c4 10             	add    $0x10,%esp
 590:	84 c0                	test   %al,%al
 592:	75 e4                	jne    578 <printf+0x148>
 594:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 597:	31 ff                	xor    %edi,%edi
 599:	e9 da fe ff ff       	jmp    478 <printf+0x48>
 59e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5a8:	6a 01                	push   $0x1
 5aa:	e9 73 ff ff ff       	jmp    522 <printf+0xf2>
 5af:	90                   	nop
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5b9:	6a 01                	push   $0x1
 5bb:	e9 21 ff ff ff       	jmp    4e1 <printf+0xb1>
        putc(fd, *ap);
 5c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5c6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5c8:	6a 01                	push   $0x1
        ap++;
 5ca:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5cd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5d3:	50                   	push   %eax
 5d4:	ff 75 08             	pushl  0x8(%ebp)
 5d7:	e8 16 fd ff ff       	call   2f2 <write>
        ap++;
 5dc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5e2:	31 ff                	xor    %edi,%edi
 5e4:	e9 8f fe ff ff       	jmp    478 <printf+0x48>
          s = "(null)";
 5e9:	bb 23 0a 00 00       	mov    $0xa23,%ebx
        while(*s != 0){
 5ee:	b8 28 00 00 00       	mov    $0x28,%eax
 5f3:	e9 72 ff ff ff       	jmp    56a <printf+0x13a>
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <free>:

static Header base;
static Header *freep;

void
free(void *ap) {
 600:	55                   	push   %ebp
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 3c 0e 00 00       	mov    0xe3c,%eax
free(void *ap) {
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = (Header *) ap - 1;
 60e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 618:	39 c8                	cmp    %ecx,%eax
 61a:	8b 10                	mov    (%eax),%edx
 61c:	73 32                	jae    650 <free+0x50>
 61e:	39 d1                	cmp    %edx,%ecx
 620:	72 04                	jb     626 <free+0x26>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 622:	39 d0                	cmp    %edx,%eax
 624:	72 32                	jb     658 <free+0x58>
            break;
    if (bp + bp->s.size == p->s.ptr) {
 626:	8b 73 fc             	mov    -0x4(%ebx),%esi
 629:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 62c:	39 fa                	cmp    %edi,%edx
 62e:	74 30                	je     660 <free+0x60>
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
 630:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 633:	8b 50 04             	mov    0x4(%eax),%edx
 636:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 639:	39 f1                	cmp    %esi,%ecx
 63b:	74 3a                	je     677 <free+0x77>
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
 63d:	89 08                	mov    %ecx,(%eax)
    freep = p;
 63f:	a3 3c 0e 00 00       	mov    %eax,0xe3c
}
 644:	5b                   	pop    %ebx
 645:	5e                   	pop    %esi
 646:	5f                   	pop    %edi
 647:	5d                   	pop    %ebp
 648:	c3                   	ret    
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 650:	39 d0                	cmp    %edx,%eax
 652:	72 04                	jb     658 <free+0x58>
 654:	39 d1                	cmp    %edx,%ecx
 656:	72 ce                	jb     626 <free+0x26>
free(void *ap) {
 658:	89 d0                	mov    %edx,%eax
 65a:	eb bc                	jmp    618 <free+0x18>
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->s.size += p->s.ptr->s.size;
 660:	03 72 04             	add    0x4(%edx),%esi
 663:	89 73 fc             	mov    %esi,-0x4(%ebx)
        bp->s.ptr = p->s.ptr->s.ptr;
 666:	8b 10                	mov    (%eax),%edx
 668:	8b 12                	mov    (%edx),%edx
 66a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 66d:	8b 50 04             	mov    0x4(%eax),%edx
 670:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 673:	39 f1                	cmp    %esi,%ecx
 675:	75 c6                	jne    63d <free+0x3d>
        p->s.size += bp->s.size;
 677:	03 53 fc             	add    -0x4(%ebx),%edx
    freep = p;
 67a:	a3 3c 0e 00 00       	mov    %eax,0xe3c
        p->s.size += bp->s.size;
 67f:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
 682:	8b 53 f8             	mov    -0x8(%ebx),%edx
 685:	89 10                	mov    %edx,(%eax)
}
 687:	5b                   	pop    %ebx
 688:	5e                   	pop    %esi
 689:	5f                   	pop    %edi
 68a:	5d                   	pop    %ebp
 68b:	c3                   	ret    
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <morecore>:

static Header*
morecore(uint nu, int pmalloced)
{
 690:	55                   	push   %ebp
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
 691:	3d ff 0f 00 00       	cmp    $0xfff,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	56                   	push   %esi
 699:	53                   	push   %ebx
 69a:	89 c3                	mov    %eax,%ebx
    if(nu < 4096 && !pmalloced)
 69c:	77 52                	ja     6f0 <morecore+0x60>
 69e:	83 e2 01             	and    $0x1,%edx
 6a1:	75 4d                	jne    6f0 <morecore+0x60>
 6a3:	be 00 80 00 00       	mov    $0x8000,%esi
        nu = 4096;
 6a8:	bb 00 10 00 00       	mov    $0x1000,%ebx
    printf(1 , "enter morecore %d\n", nu);
 6ad:	83 ec 04             	sub    $0x4,%esp
 6b0:	53                   	push   %ebx
 6b1:	68 3d 0a 00 00       	push   $0xa3d
 6b6:	6a 01                	push   $0x1
 6b8:	e8 73 fd ff ff       	call   430 <printf>
    p = sbrk(nu * sizeof(Header));
 6bd:	89 34 24             	mov    %esi,(%esp)
 6c0:	e8 95 fc ff ff       	call   35a <sbrk>
    if(p == (char*)-1)
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	83 f8 ff             	cmp    $0xffffffff,%eax
 6cb:	74 33                	je     700 <morecore+0x70>
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
 6cd:	89 58 04             	mov    %ebx,0x4(%eax)
    free((void*)(hp + 1));
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	83 c0 08             	add    $0x8,%eax
 6d6:	50                   	push   %eax
 6d7:	e8 24 ff ff ff       	call   600 <free>
    return freep;
 6dc:	a1 3c 0e 00 00       	mov    0xe3c,%eax
 6e1:	83 c4 10             	add    $0x10,%esp
}
 6e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6f0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6f7:	eb b4                	jmp    6ad <morecore+0x1d>
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return 0;
 700:	31 c0                	xor    %eax,%eax
 702:	eb e0                	jmp    6e4 <morecore+0x54>
 704:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 70a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000710 <malloc>:

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 10             	sub    $0x10,%esp
 719:	8b 75 08             	mov    0x8(%ebp),%esi
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
 71c:	56                   	push   %esi
 71d:	68 50 0a 00 00       	push   $0xa50
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	83 c6 07             	add    $0x7,%esi
    printf(1, "nbytes:%d\n",nbytes);
 725:	6a 01                	push   $0x1
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 727:	c1 ee 03             	shr    $0x3,%esi
 72a:	83 c6 01             	add    $0x1,%esi
    printf(1, "nbytes:%d\n",nbytes);
 72d:	e8 fe fc ff ff       	call   430 <printf>
    if((prevp = freep) == 0){
 732:	8b 3d 3c 0e 00 00    	mov    0xe3c,%edi
 738:	83 c4 10             	add    $0x10,%esp
 73b:	85 ff                	test   %edi,%edi
 73d:	0f 84 d5 00 00 00    	je     818 <malloc+0x108>
 743:	8b 1f                	mov    (%edi),%ebx
 745:	8b 53 04             	mov    0x4(%ebx),%edx
 748:	eb 0f                	jmp    759 <malloc+0x49>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 750:	8b 03                	mov    (%ebx),%eax
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
 752:	89 df                	mov    %ebx,%edi
 754:	8b 50 04             	mov    0x4(%eax),%edx
 757:	89 c3                	mov    %eax,%ebx
 759:	83 ec 04             	sub    $0x4,%esp
 75c:	52                   	push   %edx
 75d:	68 6f 0a 00 00       	push   $0xa6f
 762:	6a 01                	push   $0x1
 764:	e8 c7 fc ff ff       	call   430 <printf>
        if(p->s.size >= nunits){
 769:	8b 43 04             	mov    0x4(%ebx),%eax
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	39 f0                	cmp    %esi,%eax
 771:	73 3d                	jae    7b0 <malloc+0xa0>
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
 773:	39 1d 3c 0e 00 00    	cmp    %ebx,0xe3c
 779:	75 d5                	jne    750 <malloc+0x40>
            printf(1, "calling morecore: 0x%x\n", p);
 77b:	83 ec 04             	sub    $0x4,%esp
 77e:	53                   	push   %ebx
 77f:	68 d3 0a 00 00       	push   $0xad3
 784:	6a 01                	push   $0x1
 786:	e8 a5 fc ff ff       	call   430 <printf>
            if((p = morecore(nunits,0)) == 0)
 78b:	31 d2                	xor    %edx,%edx
 78d:	89 f0                	mov    %esi,%eax
 78f:	e8 fc fe ff ff       	call   690 <morecore>
 794:	83 c4 10             	add    $0x10,%esp
 797:	85 c0                	test   %eax,%eax
 799:	89 c3                	mov    %eax,%ebx
 79b:	75 b3                	jne    750 <malloc+0x40>
                return 0;
    }}
}
 79d:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return 0;
 7a0:	31 c0                	xor    %eax,%eax
}
 7a2:	5b                   	pop    %ebx
 7a3:	5e                   	pop    %esi
 7a4:	5f                   	pop    %edi
 7a5:	5d                   	pop    %ebp
 7a6:	c3                   	ret    
 7a7:	89 f6                	mov    %esi,%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->s.size == nunits){
 7b0:	74 46                	je     7f8 <malloc+0xe8>
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
 7b2:	56                   	push   %esi
 7b3:	50                   	push   %eax
 7b4:	68 a6 0a 00 00       	push   $0xaa6
 7b9:	6a 01                	push   $0x1
 7bb:	e8 70 fc ff ff       	call   430 <printf>
                p->s.size -= nunits;
 7c0:	8b 43 04             	mov    0x4(%ebx),%eax
                p->s.size = nunits;
 7c3:	83 c4 10             	add    $0x10,%esp
                p->s.size -= nunits;
 7c6:	29 f0                	sub    %esi,%eax
 7c8:	89 43 04             	mov    %eax,0x4(%ebx)
                p += p->s.size;
 7cb:	8d 1c c3             	lea    (%ebx,%eax,8),%ebx
                p->s.size = nunits;
 7ce:	89 73 04             	mov    %esi,0x4(%ebx)
            printf(1,"returning p+1\n");
 7d1:	83 ec 08             	sub    $0x8,%esp
 7d4:	68 c4 0a 00 00       	push   $0xac4
 7d9:	6a 01                	push   $0x1
 7db:	e8 50 fc ff ff       	call   430 <printf>
            freep = prevp;
 7e0:	89 3d 3c 0e 00 00    	mov    %edi,0xe3c
            return (void*)(p + 1);
 7e6:	83 c4 10             	add    $0x10,%esp
}
 7e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return (void*)(p + 1);
 7ec:	8d 43 08             	lea    0x8(%ebx),%eax
}
 7ef:	5b                   	pop    %ebx
 7f0:	5e                   	pop    %esi
 7f1:	5f                   	pop    %edi
 7f2:	5d                   	pop    %ebp
 7f3:	c3                   	ret    
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"p->s.size == nunits == %d\n",nunits);
 7f8:	83 ec 04             	sub    $0x4,%esp
 7fb:	56                   	push   %esi
 7fc:	68 8b 0a 00 00       	push   $0xa8b
 801:	6a 01                	push   $0x1
 803:	e8 28 fc ff ff       	call   430 <printf>
                prevp->s.ptr = p->s.ptr;}
 808:	8b 03                	mov    (%ebx),%eax
 80a:	83 c4 10             	add    $0x10,%esp
 80d:	89 07                	mov    %eax,(%edi)
 80f:	eb c0                	jmp    7d1 <malloc+0xc1>
 811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"prevp = freep == 0\n");
 818:	83 ec 08             	sub    $0x8,%esp
        base.s.size = 0;
 81b:	bb 40 0e 00 00       	mov    $0xe40,%ebx
        printf(1,"prevp = freep == 0\n");
 820:	68 5b 0a 00 00       	push   $0xa5b
 825:	6a 01                	push   $0x1
        base.s.ptr = freep = prevp = &base;
 827:	89 df                	mov    %ebx,%edi
        printf(1,"prevp = freep == 0\n");
 829:	e8 02 fc ff ff       	call   430 <printf>
        base.s.ptr = freep = prevp = &base;
 82e:	c7 05 3c 0e 00 00 40 	movl   $0xe40,0xe3c
 835:	0e 00 00 
 838:	c7 05 40 0e 00 00 40 	movl   $0xe40,0xe40
 83f:	0e 00 00 
        base.s.size = 0;
 842:	83 c4 10             	add    $0x10,%esp
 845:	c7 05 44 0e 00 00 00 	movl   $0x0,0xe44
 84c:	00 00 00 
 84f:	31 d2                	xor    %edx,%edx
 851:	e9 03 ff ff ff       	jmp    759 <malloc+0x49>
 856:	8d 76 00             	lea    0x0(%esi),%esi
 859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000860 <pmalloc>:
void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
 860:	8b 0d 3c 0e 00 00    	mov    0xe3c,%ecx
pmalloc(void) {
 866:	55                   	push   %ebp
 867:	89 e5                	mov    %esp,%ebp
 869:	56                   	push   %esi
 86a:	53                   	push   %ebx
    if ((prevp = freep) == 0) {
 86b:	85 c9                	test   %ecx,%ecx
 86d:	0f 84 95 00 00 00    	je     908 <pmalloc+0xa8>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 873:	8b 19                	mov    (%ecx),%ebx
        if (p->s.size >= ((4096 / 8)*2)) {
 875:	8b 53 04             	mov    0x4(%ebx),%edx
 878:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 87e:	76 1d                	jbe    89d <pmalloc+0x3d>
 880:	eb 3f                	jmp    8c1 <pmalloc+0x61>
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 888:	8b 03                	mov    (%ebx),%eax
        if (p->s.size >= ((4096 / 8)*2)) {
 88a:	8b 50 04             	mov    0x4(%eax),%edx
 88d:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 893:	77 30                	ja     8c5 <pmalloc+0x65>
 895:	8b 0d 3c 0e 00 00    	mov    0xe3c,%ecx
 89b:	89 c3                	mov    %eax,%ebx


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
 89d:	39 cb                	cmp    %ecx,%ebx
 89f:	75 e7                	jne    888 <pmalloc+0x28>
                if ((p = morecore(nunits, 1)) == 0) {
 8a1:	ba 01 00 00 00       	mov    $0x1,%edx
 8a6:	b8 00 02 00 00       	mov    $0x200,%eax
 8ab:	e8 e0 fd ff ff       	call   690 <morecore>
 8b0:	85 c0                	test   %eax,%eax
 8b2:	89 c3                	mov    %eax,%ebx
 8b4:	75 d2                	jne    888 <pmalloc+0x28>
                    return 0;
                }
            }
        }
}
 8b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
                    return 0;
 8b9:	31 f6                	xor    %esi,%esi
}
 8bb:	89 f0                	mov    %esi,%eax
 8bd:	5b                   	pop    %ebx
 8be:	5e                   	pop    %esi
 8bf:	5d                   	pop    %ebp
 8c0:	c3                   	ret    
        if (p->s.size >= ((4096 / 8)*2)) {
 8c1:	89 d8                	mov    %ebx,%eax
 8c3:	89 cb                	mov    %ecx,%ebx
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8c5:	81 e2 00 fe ff ff    	and    $0xfffffe00,%edx
            set_flag((uint) (p + 1), PTE_1, 1);
 8cb:	83 ec 04             	sub    $0x4,%esp
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8ce:	81 ea 01 02 00 00    	sub    $0x201,%edx
            p += p->s.size;
 8d4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8d7:	89 50 04             	mov    %edx,0x4(%eax)
            set_flag((uint) (p + 1), PTE_1, 1);
 8da:	83 c6 08             	add    $0x8,%esi
            p->s.size = nunits;
 8dd:	c7 46 fc 00 02 00 00 	movl   $0x200,-0x4(%esi)
            set_flag((uint) (p + 1), PTE_1, 1);
 8e4:	6a 01                	push   $0x1
 8e6:	68 00 04 00 00       	push   $0x400
 8eb:	56                   	push   %esi
 8ec:	e8 89 fa ff ff       	call   37a <set_flag>
            freep = prevp;
 8f1:	89 1d 3c 0e 00 00    	mov    %ebx,0xe3c
            return (void *) (p + 1);
 8f7:	83 c4 10             	add    $0x10,%esp
}
 8fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8fd:	89 f0                	mov    %esi,%eax
 8ff:	5b                   	pop    %ebx
 900:	5e                   	pop    %esi
 901:	5d                   	pop    %ebp
 902:	c3                   	ret    
 903:	90                   	nop
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        base.s.size = 0;
 908:	b9 40 0e 00 00       	mov    $0xe40,%ecx
        base.s.ptr = freep = prevp = &base;
 90d:	c7 05 3c 0e 00 00 40 	movl   $0xe40,0xe3c
 914:	0e 00 00 
 917:	c7 05 40 0e 00 00 40 	movl   $0xe40,0xe40
 91e:	0e 00 00 
        base.s.size = 0;
 921:	c7 05 44 0e 00 00 00 	movl   $0x0,0xe44
 928:	00 00 00 
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 92b:	89 cb                	mov    %ecx,%ebx
 92d:	e9 6b ff ff ff       	jmp    89d <pmalloc+0x3d>
 932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000940 <protect_page>:
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	53                   	push   %ebx
 944:	83 ec 04             	sub    $0x4,%esp
 947:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((int)(ap-8) % PGSIZE != 0){
 94a:	8d 43 f8             	lea    -0x8(%ebx),%eax
 94d:	a9 ff 0f 00 00       	test   $0xfff,%eax
 952:	75 3c                	jne    990 <protect_page+0x50>
        return -1;
    }
    int flags = get_flags((uint)ap);
 954:	83 ec 0c             	sub    $0xc,%esp
 957:	53                   	push   %ebx
 958:	e8 15 fa ff ff       	call   372 <get_flags>
    if (flags & PTE_1) {
 95d:	83 c4 10             	add    $0x10,%esp
 960:	f6 c4 04             	test   $0x4,%ah
 963:	74 2b                	je     990 <protect_page+0x50>
        set_flag((uint) ap, PTE_W, 0);
 965:	83 ec 04             	sub    $0x4,%esp
 968:	6a 00                	push   $0x0
 96a:	6a 02                	push   $0x2
 96c:	53                   	push   %ebx
 96d:	e8 08 fa ff ff       	call   37a <set_flag>
        update_protected_pages(1);
 972:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 979:	e8 04 fa ff ff       	call   382 <update_protected_pages>
        return 1;
 97e:	83 c4 10             	add    $0x10,%esp
 981:	b8 01 00 00 00       	mov    $0x1,%eax

    }
    return -1;
}
 986:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 989:	c9                   	leave  
 98a:	c3                   	ret    
 98b:	90                   	nop
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 995:	eb ef                	jmp    986 <protect_page+0x46>
 997:	89 f6                	mov    %esi,%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <pfree>:



int pfree(void *ap){
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	53                   	push   %ebx
 9a4:	83 ec 10             	sub    $0x10,%esp
 9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx

    int flags = get_flags((uint) ap);
 9aa:	53                   	push   %ebx
 9ab:	e8 c2 f9 ff ff       	call   372 <get_flags>
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
 9b0:	83 c4 10             	add    $0x10,%esp
 9b3:	a8 02                	test   $0x2,%al
 9b5:	75 31                	jne    9e8 <pfree+0x48>
 9b7:	83 ec 04             	sub    $0x4,%esp
 9ba:	6a 01                	push   $0x1
 9bc:	6a 02                	push   $0x2
 9be:	53                   	push   %ebx
 9bf:	e8 b6 f9 ff ff       	call   37a <set_flag>
    else
        return -1;

    free(ap);
 9c4:	89 1c 24             	mov    %ebx,(%esp)
 9c7:	e8 34 fc ff ff       	call   600 <free>
    update_protected_pages(0);
 9cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 9d3:	e8 aa f9 ff ff       	call   382 <update_protected_pages>
    return 1;
 9d8:	83 c4 10             	add    $0x10,%esp
 9db:	b8 01 00 00 00       	mov    $0x1,%eax
 9e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9e3:	c9                   	leave  
 9e4:	c3                   	ret    
 9e5:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
 9e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9ed:	eb f1                	jmp    9e0 <pfree+0x40>
