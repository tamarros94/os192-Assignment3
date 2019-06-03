
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 2c                	jle    49 <main+0x49>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 0b 02 00 00       	call   240 <atoi>
  35:	89 04 24             	mov    %eax,(%esp)
  38:	e8 a5 02 00 00       	call   2e2 <kill>
  for(i=1; i<argc; i++)
  3d:	83 c4 10             	add    $0x10,%esp
  40:	39 f3                	cmp    %esi,%ebx
  42:	75 e4                	jne    28 <main+0x28>
  exit();
  44:	e8 69 02 00 00       	call   2b2 <exit>
    printf(2, "usage: kill pid...\n");
  49:	50                   	push   %eax
  4a:	50                   	push   %eax
  4b:	68 d0 09 00 00       	push   $0x9d0
  50:	6a 02                	push   $0x2
  52:	e8 b9 03 00 00       	call   410 <printf>
    exit();
  57:	e8 56 02 00 00       	call   2b2 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c4:	29 d8                	sub    %ebx,%eax
}
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
{
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 32 01 00 00       	call   2ca <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:

int
stat(char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 f0 00 00 00       	call   2f2 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f3 00 00 00       	call   30a <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 b9 00 00 00       	call   2da <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
  return vdst;
}
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    

000002aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2aa:	b8 01 00 00 00       	mov    $0x1,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <exit>:
SYSCALL(exit)
 2b2:	b8 02 00 00 00       	mov    $0x2,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <wait>:
SYSCALL(wait)
 2ba:	b8 03 00 00 00       	mov    $0x3,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <pipe>:
SYSCALL(pipe)
 2c2:	b8 04 00 00 00       	mov    $0x4,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <read>:
SYSCALL(read)
 2ca:	b8 05 00 00 00       	mov    $0x5,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <write>:
SYSCALL(write)
 2d2:	b8 10 00 00 00       	mov    $0x10,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <close>:
SYSCALL(close)
 2da:	b8 15 00 00 00       	mov    $0x15,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kill>:
SYSCALL(kill)
 2e2:	b8 06 00 00 00       	mov    $0x6,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <exec>:
SYSCALL(exec)
 2ea:	b8 07 00 00 00       	mov    $0x7,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <open>:
SYSCALL(open)
 2f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mknod>:
SYSCALL(mknod)
 2fa:	b8 11 00 00 00       	mov    $0x11,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <unlink>:
SYSCALL(unlink)
 302:	b8 12 00 00 00       	mov    $0x12,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <link>:
SYSCALL(link)
 312:	b8 13 00 00 00       	mov    $0x13,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mkdir>:
SYSCALL(mkdir)
 31a:	b8 14 00 00 00       	mov    $0x14,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <chdir>:
SYSCALL(chdir)
 322:	b8 09 00 00 00       	mov    $0x9,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <dup>:
SYSCALL(dup)
 32a:	b8 0a 00 00 00       	mov    $0xa,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getpid>:
SYSCALL(getpid)
 332:	b8 0b 00 00 00       	mov    $0xb,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <sbrk>:
SYSCALL(sbrk)
 33a:	b8 0c 00 00 00       	mov    $0xc,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sleep>:
SYSCALL(sleep)
 342:	b8 0d 00 00 00       	mov    $0xd,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <uptime>:
SYSCALL(uptime)
 34a:	b8 0e 00 00 00       	mov    $0xe,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <get_flags>:
SYSCALL(get_flags)
 352:	b8 17 00 00 00       	mov    $0x17,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <set_flag>:
SYSCALL(set_flag)
 35a:	b8 18 00 00 00       	mov    $0x18,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <update_protected_pages>:
SYSCALL(update_protected_pages)
 362:	b8 19 00 00 00       	mov    $0x19,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 379:	85 d2                	test   %edx,%edx
{
 37b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 37e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 380:	79 76                	jns    3f8 <printint+0x88>
 382:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 386:	74 70                	je     3f8 <printint+0x88>
    x = -xx;
 388:	f7 d8                	neg    %eax
    neg = 1;
 38a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 391:	31 f6                	xor    %esi,%esi
 393:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 396:	eb 0a                	jmp    3a2 <printint+0x32>
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	89 fe                	mov    %edi,%esi
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	8d 7e 01             	lea    0x1(%esi),%edi
 3a7:	f7 f1                	div    %ecx
 3a9:	0f b6 92 ec 09 00 00 	movzbl 0x9ec(%edx),%edx
  }while((x /= base) != 0);
 3b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3b5:	75 e9                	jne    3a0 <printint+0x30>
  if(neg)
 3b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ba:	85 c0                	test   %eax,%eax
 3bc:	74 08                	je     3c6 <printint+0x56>
    buf[i++] = '-';
 3be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3c3:	8d 7e 02             	lea    0x2(%esi),%edi
 3c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3d3:	83 ec 04             	sub    $0x4,%esp
 3d6:	83 ee 01             	sub    $0x1,%esi
 3d9:	6a 01                	push   $0x1
 3db:	53                   	push   %ebx
 3dc:	57                   	push   %edi
 3dd:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e0:	e8 ed fe ff ff       	call   2d2 <write>

  while(--i >= 0)
 3e5:	83 c4 10             	add    $0x10,%esp
 3e8:	39 de                	cmp    %ebx,%esi
 3ea:	75 e4                	jne    3d0 <printint+0x60>
    putc(fd, buf[i]);
}
 3ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ef:	5b                   	pop    %ebx
 3f0:	5e                   	pop    %esi
 3f1:	5f                   	pop    %edi
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3f8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3ff:	eb 90                	jmp    391 <printint+0x21>
 401:	eb 0d                	jmp    410 <printf>
 403:	90                   	nop
 404:	90                   	nop
 405:	90                   	nop
 406:	90                   	nop
 407:	90                   	nop
 408:	90                   	nop
 409:	90                   	nop
 40a:	90                   	nop
 40b:	90                   	nop
 40c:	90                   	nop
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
 41c:	0f b6 1e             	movzbl (%esi),%ebx
 41f:	84 db                	test   %bl,%bl
 421:	0f 84 b3 00 00 00    	je     4da <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 427:	8d 45 10             	lea    0x10(%ebp),%eax
 42a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 42d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 42f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 432:	eb 2f                	jmp    463 <printf+0x53>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	0f 84 a7 00 00 00    	je     4e8 <printf+0xd8>
  write(fd, &c, 1);
 441:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 444:	83 ec 04             	sub    $0x4,%esp
 447:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 44a:	6a 01                	push   $0x1
 44c:	50                   	push   %eax
 44d:	ff 75 08             	pushl  0x8(%ebp)
 450:	e8 7d fe ff ff       	call   2d2 <write>
 455:	83 c4 10             	add    $0x10,%esp
 458:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 45b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 45f:	84 db                	test   %bl,%bl
 461:	74 77                	je     4da <printf+0xca>
    if(state == 0){
 463:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 465:	0f be cb             	movsbl %bl,%ecx
 468:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 46b:	74 cb                	je     438 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 46d:	83 ff 25             	cmp    $0x25,%edi
 470:	75 e6                	jne    458 <printf+0x48>
      if(c == 'd'){
 472:	83 f8 64             	cmp    $0x64,%eax
 475:	0f 84 05 01 00 00    	je     580 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 47b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 481:	83 f9 70             	cmp    $0x70,%ecx
 484:	74 72                	je     4f8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 486:	83 f8 73             	cmp    $0x73,%eax
 489:	0f 84 99 00 00 00    	je     528 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48f:	83 f8 63             	cmp    $0x63,%eax
 492:	0f 84 08 01 00 00    	je     5a0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	0f 84 ef 00 00 00    	je     590 <printf+0x180>
  write(fd, &c, 1);
 4a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a4:	83 ec 04             	sub    $0x4,%esp
 4a7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ab:	6a 01                	push   $0x1
 4ad:	50                   	push   %eax
 4ae:	ff 75 08             	pushl  0x8(%ebp)
 4b1:	e8 1c fe ff ff       	call   2d2 <write>
 4b6:	83 c4 0c             	add    $0xc,%esp
 4b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4bc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4bf:	6a 01                	push   $0x1
 4c1:	50                   	push   %eax
 4c2:	ff 75 08             	pushl  0x8(%ebp)
 4c5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4ca:	e8 03 fe ff ff       	call   2d2 <write>
  for(i = 0; fmt[i]; i++){
 4cf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 4d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4d6:	84 db                	test   %bl,%bl
 4d8:	75 89                	jne    463 <printf+0x53>
    }
  }
}
 4da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dd:	5b                   	pop    %ebx
 4de:	5e                   	pop    %esi
 4df:	5f                   	pop    %edi
 4e0:	5d                   	pop    %ebp
 4e1:	c3                   	ret    
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4e8:	bf 25 00 00 00       	mov    $0x25,%edi
 4ed:	e9 66 ff ff ff       	jmp    458 <printf+0x48>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 500:	6a 00                	push   $0x0
 502:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 505:	8b 45 08             	mov    0x8(%ebp),%eax
 508:	8b 17                	mov    (%edi),%edx
 50a:	e8 61 fe ff ff       	call   370 <printint>
        ap++;
 50f:	89 f8                	mov    %edi,%eax
 511:	83 c4 10             	add    $0x10,%esp
      state = 0;
 514:	31 ff                	xor    %edi,%edi
        ap++;
 516:	83 c0 04             	add    $0x4,%eax
 519:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 51c:	e9 37 ff ff ff       	jmp    458 <printf+0x48>
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 528:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 52b:	8b 08                	mov    (%eax),%ecx
        ap++;
 52d:	83 c0 04             	add    $0x4,%eax
 530:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 533:	85 c9                	test   %ecx,%ecx
 535:	0f 84 8e 00 00 00    	je     5c9 <printf+0x1b9>
        while(*s != 0){
 53b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 53e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 540:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 542:	84 c0                	test   %al,%al
 544:	0f 84 0e ff ff ff    	je     458 <printf+0x48>
 54a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 54d:	89 de                	mov    %ebx,%esi
 54f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 552:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 555:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 558:	83 ec 04             	sub    $0x4,%esp
          s++;
 55b:	83 c6 01             	add    $0x1,%esi
 55e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 561:	6a 01                	push   $0x1
 563:	57                   	push   %edi
 564:	53                   	push   %ebx
 565:	e8 68 fd ff ff       	call   2d2 <write>
        while(*s != 0){
 56a:	0f b6 06             	movzbl (%esi),%eax
 56d:	83 c4 10             	add    $0x10,%esp
 570:	84 c0                	test   %al,%al
 572:	75 e4                	jne    558 <printf+0x148>
 574:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 577:	31 ff                	xor    %edi,%edi
 579:	e9 da fe ff ff       	jmp    458 <printf+0x48>
 57e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
 588:	6a 01                	push   $0x1
 58a:	e9 73 ff ff ff       	jmp    502 <printf+0xf2>
 58f:	90                   	nop
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 596:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 599:	6a 01                	push   $0x1
 59b:	e9 21 ff ff ff       	jmp    4c1 <printf+0xb1>
        putc(fd, *ap);
 5a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5a6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5a8:	6a 01                	push   $0x1
        ap++;
 5aa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5ad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5b3:	50                   	push   %eax
 5b4:	ff 75 08             	pushl  0x8(%ebp)
 5b7:	e8 16 fd ff ff       	call   2d2 <write>
        ap++;
 5bc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5bf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5c2:	31 ff                	xor    %edi,%edi
 5c4:	e9 8f fe ff ff       	jmp    458 <printf+0x48>
          s = "(null)";
 5c9:	bb e4 09 00 00       	mov    $0x9e4,%ebx
        while(*s != 0){
 5ce:	b8 28 00 00 00       	mov    $0x28,%eax
 5d3:	e9 72 ff ff ff       	jmp    54a <printf+0x13a>
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <free>:

static Header base;
static Header *freep;

void
free(void *ap) {
 5e0:	55                   	push   %ebp
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 f8 0d 00 00       	mov    0xdf8,%eax
free(void *ap) {
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = (Header *) ap - 1;
 5ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f8:	39 c8                	cmp    %ecx,%eax
 5fa:	8b 10                	mov    (%eax),%edx
 5fc:	73 32                	jae    630 <free+0x50>
 5fe:	39 d1                	cmp    %edx,%ecx
 600:	72 04                	jb     606 <free+0x26>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 602:	39 d0                	cmp    %edx,%eax
 604:	72 32                	jb     638 <free+0x58>
            break;
    if (bp + bp->s.size == p->s.ptr) {
 606:	8b 73 fc             	mov    -0x4(%ebx),%esi
 609:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 60c:	39 fa                	cmp    %edi,%edx
 60e:	74 30                	je     640 <free+0x60>
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
 610:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 613:	8b 50 04             	mov    0x4(%eax),%edx
 616:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 619:	39 f1                	cmp    %esi,%ecx
 61b:	74 3a                	je     657 <free+0x77>
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
 61d:	89 08                	mov    %ecx,(%eax)
    freep = p;
 61f:	a3 f8 0d 00 00       	mov    %eax,0xdf8
}
 624:	5b                   	pop    %ebx
 625:	5e                   	pop    %esi
 626:	5f                   	pop    %edi
 627:	5d                   	pop    %ebp
 628:	c3                   	ret    
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 d0                	cmp    %edx,%eax
 632:	72 04                	jb     638 <free+0x58>
 634:	39 d1                	cmp    %edx,%ecx
 636:	72 ce                	jb     606 <free+0x26>
free(void *ap) {
 638:	89 d0                	mov    %edx,%eax
 63a:	eb bc                	jmp    5f8 <free+0x18>
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->s.size += p->s.ptr->s.size;
 640:	03 72 04             	add    0x4(%edx),%esi
 643:	89 73 fc             	mov    %esi,-0x4(%ebx)
        bp->s.ptr = p->s.ptr->s.ptr;
 646:	8b 10                	mov    (%eax),%edx
 648:	8b 12                	mov    (%edx),%edx
 64a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	75 c6                	jne    61d <free+0x3d>
        p->s.size += bp->s.size;
 657:	03 53 fc             	add    -0x4(%ebx),%edx
    freep = p;
 65a:	a3 f8 0d 00 00       	mov    %eax,0xdf8
        p->s.size += bp->s.size;
 65f:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
 662:	8b 53 f8             	mov    -0x8(%ebx),%edx
 665:	89 10                	mov    %edx,(%eax)
}
 667:	5b                   	pop    %ebx
 668:	5e                   	pop    %esi
 669:	5f                   	pop    %edi
 66a:	5d                   	pop    %ebp
 66b:	c3                   	ret    
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <morecore>:

static Header*
morecore(uint nu, int pmalloced)
{
 670:	55                   	push   %ebp
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
 671:	3d ff 0f 00 00       	cmp    $0xfff,%eax
{
 676:	89 e5                	mov    %esp,%ebp
 678:	56                   	push   %esi
 679:	53                   	push   %ebx
 67a:	89 c3                	mov    %eax,%ebx
    if(nu < 4096 && !pmalloced)
 67c:	77 52                	ja     6d0 <morecore+0x60>
 67e:	83 e2 01             	and    $0x1,%edx
 681:	75 4d                	jne    6d0 <morecore+0x60>
 683:	be 00 80 00 00       	mov    $0x8000,%esi
        nu = 4096;
 688:	bb 00 10 00 00       	mov    $0x1000,%ebx
    printf(1 , "enter morecore %d\n", nu);
 68d:	83 ec 04             	sub    $0x4,%esp
 690:	53                   	push   %ebx
 691:	68 fd 09 00 00       	push   $0x9fd
 696:	6a 01                	push   $0x1
 698:	e8 73 fd ff ff       	call   410 <printf>
    p = sbrk(nu * sizeof(Header));
 69d:	89 34 24             	mov    %esi,(%esp)
 6a0:	e8 95 fc ff ff       	call   33a <sbrk>
    if(p == (char*)-1)
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ab:	74 33                	je     6e0 <morecore+0x70>
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
 6ad:	89 58 04             	mov    %ebx,0x4(%eax)
    free((void*)(hp + 1));
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	83 c0 08             	add    $0x8,%eax
 6b6:	50                   	push   %eax
 6b7:	e8 24 ff ff ff       	call   5e0 <free>
    return freep;
 6bc:	a1 f8 0d 00 00       	mov    0xdf8,%eax
 6c1:	83 c4 10             	add    $0x10,%esp
}
 6c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5d                   	pop    %ebp
 6ca:	c3                   	ret    
 6cb:	90                   	nop
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6d7:	eb b4                	jmp    68d <morecore+0x1d>
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return 0;
 6e0:	31 c0                	xor    %eax,%eax
 6e2:	eb e0                	jmp    6c4 <morecore+0x54>
 6e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006f0 <malloc>:

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 10             	sub    $0x10,%esp
 6f9:	8b 75 08             	mov    0x8(%ebp),%esi
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
 6fc:	56                   	push   %esi
 6fd:	68 10 0a 00 00       	push   $0xa10
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	83 c6 07             	add    $0x7,%esi
    printf(1, "nbytes:%d\n",nbytes);
 705:	6a 01                	push   $0x1
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 707:	c1 ee 03             	shr    $0x3,%esi
 70a:	83 c6 01             	add    $0x1,%esi
    printf(1, "nbytes:%d\n",nbytes);
 70d:	e8 fe fc ff ff       	call   410 <printf>
    if((prevp = freep) == 0){
 712:	8b 3d f8 0d 00 00    	mov    0xdf8,%edi
 718:	83 c4 10             	add    $0x10,%esp
 71b:	85 ff                	test   %edi,%edi
 71d:	0f 84 d5 00 00 00    	je     7f8 <malloc+0x108>
 723:	8b 1f                	mov    (%edi),%ebx
 725:	8b 53 04             	mov    0x4(%ebx),%edx
 728:	eb 0f                	jmp    739 <malloc+0x49>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 03                	mov    (%ebx),%eax
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
 732:	89 df                	mov    %ebx,%edi
 734:	8b 50 04             	mov    0x4(%eax),%edx
 737:	89 c3                	mov    %eax,%ebx
 739:	83 ec 04             	sub    $0x4,%esp
 73c:	52                   	push   %edx
 73d:	68 2f 0a 00 00       	push   $0xa2f
 742:	6a 01                	push   $0x1
 744:	e8 c7 fc ff ff       	call   410 <printf>
        if(p->s.size >= nunits){
 749:	8b 43 04             	mov    0x4(%ebx),%eax
 74c:	83 c4 10             	add    $0x10,%esp
 74f:	39 f0                	cmp    %esi,%eax
 751:	73 3d                	jae    790 <malloc+0xa0>
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
 753:	39 1d f8 0d 00 00    	cmp    %ebx,0xdf8
 759:	75 d5                	jne    730 <malloc+0x40>
            printf(1, "calling morecore: 0x%x\n", p);
 75b:	83 ec 04             	sub    $0x4,%esp
 75e:	53                   	push   %ebx
 75f:	68 93 0a 00 00       	push   $0xa93
 764:	6a 01                	push   $0x1
 766:	e8 a5 fc ff ff       	call   410 <printf>
            if((p = morecore(nunits,0)) == 0)
 76b:	31 d2                	xor    %edx,%edx
 76d:	89 f0                	mov    %esi,%eax
 76f:	e8 fc fe ff ff       	call   670 <morecore>
 774:	83 c4 10             	add    $0x10,%esp
 777:	85 c0                	test   %eax,%eax
 779:	89 c3                	mov    %eax,%ebx
 77b:	75 b3                	jne    730 <malloc+0x40>
                return 0;
    }}
}
 77d:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return 0;
 780:	31 c0                	xor    %eax,%eax
}
 782:	5b                   	pop    %ebx
 783:	5e                   	pop    %esi
 784:	5f                   	pop    %edi
 785:	5d                   	pop    %ebp
 786:	c3                   	ret    
 787:	89 f6                	mov    %esi,%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->s.size == nunits){
 790:	74 46                	je     7d8 <malloc+0xe8>
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
 792:	56                   	push   %esi
 793:	50                   	push   %eax
 794:	68 66 0a 00 00       	push   $0xa66
 799:	6a 01                	push   $0x1
 79b:	e8 70 fc ff ff       	call   410 <printf>
                p->s.size -= nunits;
 7a0:	8b 43 04             	mov    0x4(%ebx),%eax
                p->s.size = nunits;
 7a3:	83 c4 10             	add    $0x10,%esp
                p->s.size -= nunits;
 7a6:	29 f0                	sub    %esi,%eax
 7a8:	89 43 04             	mov    %eax,0x4(%ebx)
                p += p->s.size;
 7ab:	8d 1c c3             	lea    (%ebx,%eax,8),%ebx
                p->s.size = nunits;
 7ae:	89 73 04             	mov    %esi,0x4(%ebx)
            printf(1,"returning p+1\n");
 7b1:	83 ec 08             	sub    $0x8,%esp
 7b4:	68 84 0a 00 00       	push   $0xa84
 7b9:	6a 01                	push   $0x1
 7bb:	e8 50 fc ff ff       	call   410 <printf>
            freep = prevp;
 7c0:	89 3d f8 0d 00 00    	mov    %edi,0xdf8
            return (void*)(p + 1);
 7c6:	83 c4 10             	add    $0x10,%esp
}
 7c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return (void*)(p + 1);
 7cc:	8d 43 08             	lea    0x8(%ebx),%eax
}
 7cf:	5b                   	pop    %ebx
 7d0:	5e                   	pop    %esi
 7d1:	5f                   	pop    %edi
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret    
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"p->s.size == nunits == %d\n",nunits);
 7d8:	83 ec 04             	sub    $0x4,%esp
 7db:	56                   	push   %esi
 7dc:	68 4b 0a 00 00       	push   $0xa4b
 7e1:	6a 01                	push   $0x1
 7e3:	e8 28 fc ff ff       	call   410 <printf>
                prevp->s.ptr = p->s.ptr;}
 7e8:	8b 03                	mov    (%ebx),%eax
 7ea:	83 c4 10             	add    $0x10,%esp
 7ed:	89 07                	mov    %eax,(%edi)
 7ef:	eb c0                	jmp    7b1 <malloc+0xc1>
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"prevp = freep == 0\n");
 7f8:	83 ec 08             	sub    $0x8,%esp
        base.s.size = 0;
 7fb:	bb fc 0d 00 00       	mov    $0xdfc,%ebx
        printf(1,"prevp = freep == 0\n");
 800:	68 1b 0a 00 00       	push   $0xa1b
 805:	6a 01                	push   $0x1
        base.s.ptr = freep = prevp = &base;
 807:	89 df                	mov    %ebx,%edi
        printf(1,"prevp = freep == 0\n");
 809:	e8 02 fc ff ff       	call   410 <printf>
        base.s.ptr = freep = prevp = &base;
 80e:	c7 05 f8 0d 00 00 fc 	movl   $0xdfc,0xdf8
 815:	0d 00 00 
 818:	c7 05 fc 0d 00 00 fc 	movl   $0xdfc,0xdfc
 81f:	0d 00 00 
        base.s.size = 0;
 822:	83 c4 10             	add    $0x10,%esp
 825:	c7 05 00 0e 00 00 00 	movl   $0x0,0xe00
 82c:	00 00 00 
 82f:	31 d2                	xor    %edx,%edx
 831:	e9 03 ff ff ff       	jmp    739 <malloc+0x49>
 836:	8d 76 00             	lea    0x0(%esi),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000840 <pmalloc>:
void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
 840:	8b 0d f8 0d 00 00    	mov    0xdf8,%ecx
pmalloc(void) {
 846:	55                   	push   %ebp
 847:	89 e5                	mov    %esp,%ebp
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
    if ((prevp = freep) == 0) {
 84b:	85 c9                	test   %ecx,%ecx
 84d:	0f 84 95 00 00 00    	je     8e8 <pmalloc+0xa8>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 853:	8b 19                	mov    (%ecx),%ebx
        if (p->s.size >= ((4096 / 8)*2)) {
 855:	8b 53 04             	mov    0x4(%ebx),%edx
 858:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 85e:	76 1d                	jbe    87d <pmalloc+0x3d>
 860:	eb 3f                	jmp    8a1 <pmalloc+0x61>
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 868:	8b 03                	mov    (%ebx),%eax
        if (p->s.size >= ((4096 / 8)*2)) {
 86a:	8b 50 04             	mov    0x4(%eax),%edx
 86d:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 873:	77 30                	ja     8a5 <pmalloc+0x65>
 875:	8b 0d f8 0d 00 00    	mov    0xdf8,%ecx
 87b:	89 c3                	mov    %eax,%ebx


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
 87d:	39 cb                	cmp    %ecx,%ebx
 87f:	75 e7                	jne    868 <pmalloc+0x28>
                if ((p = morecore(nunits, 1)) == 0) {
 881:	ba 01 00 00 00       	mov    $0x1,%edx
 886:	b8 00 02 00 00       	mov    $0x200,%eax
 88b:	e8 e0 fd ff ff       	call   670 <morecore>
 890:	85 c0                	test   %eax,%eax
 892:	89 c3                	mov    %eax,%ebx
 894:	75 d2                	jne    868 <pmalloc+0x28>
                    return 0;
                }
            }
        }
}
 896:	8d 65 f8             	lea    -0x8(%ebp),%esp
                    return 0;
 899:	31 f6                	xor    %esi,%esi
}
 89b:	89 f0                	mov    %esi,%eax
 89d:	5b                   	pop    %ebx
 89e:	5e                   	pop    %esi
 89f:	5d                   	pop    %ebp
 8a0:	c3                   	ret    
        if (p->s.size >= ((4096 / 8)*2)) {
 8a1:	89 d8                	mov    %ebx,%eax
 8a3:	89 cb                	mov    %ecx,%ebx
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8a5:	81 e2 00 fe ff ff    	and    $0xfffffe00,%edx
            set_flag((uint) (p + 1), PTE_1, 1);
 8ab:	83 ec 04             	sub    $0x4,%esp
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8ae:	81 ea 01 02 00 00    	sub    $0x201,%edx
            p += p->s.size;
 8b4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 8b7:	89 50 04             	mov    %edx,0x4(%eax)
            set_flag((uint) (p + 1), PTE_1, 1);
 8ba:	83 c6 08             	add    $0x8,%esi
            p->s.size = nunits;
 8bd:	c7 46 fc 00 02 00 00 	movl   $0x200,-0x4(%esi)
            set_flag((uint) (p + 1), PTE_1, 1);
 8c4:	6a 01                	push   $0x1
 8c6:	68 00 04 00 00       	push   $0x400
 8cb:	56                   	push   %esi
 8cc:	e8 89 fa ff ff       	call   35a <set_flag>
            freep = prevp;
 8d1:	89 1d f8 0d 00 00    	mov    %ebx,0xdf8
            return (void *) (p + 1);
 8d7:	83 c4 10             	add    $0x10,%esp
}
 8da:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8dd:	89 f0                	mov    %esi,%eax
 8df:	5b                   	pop    %ebx
 8e0:	5e                   	pop    %esi
 8e1:	5d                   	pop    %ebp
 8e2:	c3                   	ret    
 8e3:	90                   	nop
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        base.s.size = 0;
 8e8:	b9 fc 0d 00 00       	mov    $0xdfc,%ecx
        base.s.ptr = freep = prevp = &base;
 8ed:	c7 05 f8 0d 00 00 fc 	movl   $0xdfc,0xdf8
 8f4:	0d 00 00 
 8f7:	c7 05 fc 0d 00 00 fc 	movl   $0xdfc,0xdfc
 8fe:	0d 00 00 
        base.s.size = 0;
 901:	c7 05 00 0e 00 00 00 	movl   $0x0,0xe00
 908:	00 00 00 
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 90b:	89 cb                	mov    %ecx,%ebx
 90d:	e9 6b ff ff ff       	jmp    87d <pmalloc+0x3d>
 912:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000920 <protect_page>:
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	53                   	push   %ebx
 924:	83 ec 04             	sub    $0x4,%esp
 927:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((int)(ap-8) % PGSIZE != 0){
 92a:	8d 43 f8             	lea    -0x8(%ebx),%eax
 92d:	a9 ff 0f 00 00       	test   $0xfff,%eax
 932:	75 3c                	jne    970 <protect_page+0x50>
        return -1;
    }
    int flags = get_flags((uint)ap);
 934:	83 ec 0c             	sub    $0xc,%esp
 937:	53                   	push   %ebx
 938:	e8 15 fa ff ff       	call   352 <get_flags>
    if (flags & PTE_1) {
 93d:	83 c4 10             	add    $0x10,%esp
 940:	f6 c4 04             	test   $0x4,%ah
 943:	74 2b                	je     970 <protect_page+0x50>
        set_flag((uint) ap, PTE_W, 0);
 945:	83 ec 04             	sub    $0x4,%esp
 948:	6a 00                	push   $0x0
 94a:	6a 02                	push   $0x2
 94c:	53                   	push   %ebx
 94d:	e8 08 fa ff ff       	call   35a <set_flag>
        update_protected_pages(1);
 952:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 959:	e8 04 fa ff ff       	call   362 <update_protected_pages>
        return 1;
 95e:	83 c4 10             	add    $0x10,%esp
 961:	b8 01 00 00 00       	mov    $0x1,%eax

    }
    return -1;
}
 966:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 969:	c9                   	leave  
 96a:	c3                   	ret    
 96b:	90                   	nop
 96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 975:	eb ef                	jmp    966 <protect_page+0x46>
 977:	89 f6                	mov    %esi,%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <pfree>:



int pfree(void *ap){
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	53                   	push   %ebx
 984:	83 ec 10             	sub    $0x10,%esp
 987:	8b 5d 08             	mov    0x8(%ebp),%ebx

    int flags = get_flags((uint) ap);
 98a:	53                   	push   %ebx
 98b:	e8 c2 f9 ff ff       	call   352 <get_flags>
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
 990:	83 c4 10             	add    $0x10,%esp
 993:	a8 02                	test   $0x2,%al
 995:	75 31                	jne    9c8 <pfree+0x48>
 997:	83 ec 04             	sub    $0x4,%esp
 99a:	6a 01                	push   $0x1
 99c:	6a 02                	push   $0x2
 99e:	53                   	push   %ebx
 99f:	e8 b6 f9 ff ff       	call   35a <set_flag>
    else
        return -1;

    free(ap);
 9a4:	89 1c 24             	mov    %ebx,(%esp)
 9a7:	e8 34 fc ff ff       	call   5e0 <free>
    update_protected_pages(0);
 9ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 9b3:	e8 aa f9 ff ff       	call   362 <update_protected_pages>
    return 1;
 9b8:	83 c4 10             	add    $0x10,%esp
 9bb:	b8 01 00 00 00       	mov    $0x1,%eax
 9c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9c3:	c9                   	leave  
 9c4:	c3                   	ret    
 9c5:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
 9c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9cd:	eb f1                	jmp    9c0 <pfree+0x40>
