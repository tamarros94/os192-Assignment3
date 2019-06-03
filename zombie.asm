
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 64 02 00 00       	call   27a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 ee 02 00 00       	call   312 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 56 02 00 00       	call   282 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	83 c1 01             	add    $0x1,%ecx
  89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x40>
  90:	38 d8                	cmp    %bl,%al
  92:	74 ec                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  94:	29 d8                	sub    %ebx,%eax
}
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  d0:	31 c0                	xor    %eax,%eax
}
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 f6                	xor    %esi,%esi
 148:	89 f3                	mov    %esi,%ebx
{
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 158:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 32 01 00 00       	call   29a <read>
    if(cc < 1)
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 181:	83 c3 01             	add    $0x1,%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	89 fe                	mov    %edi,%esi
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 190:	c6 03 00             	movb   $0x0,(%ebx)
}
 193:	8d 65 f4             	lea    -0xc(%ebp),%esp
 196:	5b                   	pop    %ebx
 197:	5e                   	pop    %esi
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 de                	add    %ebx,%esi
 1a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <stat>:

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f0 00 00 00       	call   2c2 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 f3 00 00 00       	call   2da <fstat>
  close(fd);
 1e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ea:	89 c6                	mov    %eax,%esi
  close(fd);
 1ec:	e8 b9 00 00 00       	call   2aa <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
}
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
  n = 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 d3                	cmp    %edx,%ebx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <get_flags>:
SYSCALL(get_flags)
 322:	b8 17 00 00 00       	mov    $0x17,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <set_flag>:
SYSCALL(set_flag)
 32a:	b8 18 00 00 00       	mov    $0x18,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <update_protected_pages>:
SYSCALL(update_protected_pages)
 332:	b8 19 00 00 00       	mov    $0x19,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 349:	85 d2                	test   %edx,%edx
{
 34b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 34e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 350:	79 76                	jns    3c8 <printint+0x88>
 352:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 356:	74 70                	je     3c8 <printint+0x88>
    x = -xx;
 358:	f7 d8                	neg    %eax
    neg = 1;
 35a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 361:	31 f6                	xor    %esi,%esi
 363:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 366:	eb 0a                	jmp    372 <printint+0x32>
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 370:	89 fe                	mov    %edi,%esi
 372:	31 d2                	xor    %edx,%edx
 374:	8d 7e 01             	lea    0x1(%esi),%edi
 377:	f7 f1                	div    %ecx
 379:	0f b6 92 a8 09 00 00 	movzbl 0x9a8(%edx),%edx
  }while((x /= base) != 0);
 380:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 382:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 385:	75 e9                	jne    370 <printint+0x30>
  if(neg)
 387:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 38a:	85 c0                	test   %eax,%eax
 38c:	74 08                	je     396 <printint+0x56>
    buf[i++] = '-';
 38e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 393:	8d 7e 02             	lea    0x2(%esi),%edi
 396:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 39a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3a3:	83 ec 04             	sub    $0x4,%esp
 3a6:	83 ee 01             	sub    $0x1,%esi
 3a9:	6a 01                	push   $0x1
 3ab:	53                   	push   %ebx
 3ac:	57                   	push   %edi
 3ad:	88 45 d7             	mov    %al,-0x29(%ebp)
 3b0:	e8 ed fe ff ff       	call   2a2 <write>

  while(--i >= 0)
 3b5:	83 c4 10             	add    $0x10,%esp
 3b8:	39 de                	cmp    %ebx,%esi
 3ba:	75 e4                	jne    3a0 <printint+0x60>
    putc(fd, buf[i]);
}
 3bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bf:	5b                   	pop    %ebx
 3c0:	5e                   	pop    %esi
 3c1:	5f                   	pop    %edi
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3cf:	eb 90                	jmp    361 <printint+0x21>
 3d1:	eb 0d                	jmp    3e0 <printf>
 3d3:	90                   	nop
 3d4:	90                   	nop
 3d5:	90                   	nop
 3d6:	90                   	nop
 3d7:	90                   	nop
 3d8:	90                   	nop
 3d9:	90                   	nop
 3da:	90                   	nop
 3db:	90                   	nop
 3dc:	90                   	nop
 3dd:	90                   	nop
 3de:	90                   	nop
 3df:	90                   	nop

000003e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ec:	0f b6 1e             	movzbl (%esi),%ebx
 3ef:	84 db                	test   %bl,%bl
 3f1:	0f 84 b3 00 00 00    	je     4aa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 3f7:	8d 45 10             	lea    0x10(%ebp),%eax
 3fa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 3fd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 3ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 402:	eb 2f                	jmp    433 <printf+0x53>
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 f8 25             	cmp    $0x25,%eax
 40b:	0f 84 a7 00 00 00    	je     4b8 <printf+0xd8>
  write(fd, &c, 1);
 411:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 414:	83 ec 04             	sub    $0x4,%esp
 417:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 41a:	6a 01                	push   $0x1
 41c:	50                   	push   %eax
 41d:	ff 75 08             	pushl  0x8(%ebp)
 420:	e8 7d fe ff ff       	call   2a2 <write>
 425:	83 c4 10             	add    $0x10,%esp
 428:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 42b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 42f:	84 db                	test   %bl,%bl
 431:	74 77                	je     4aa <printf+0xca>
    if(state == 0){
 433:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 435:	0f be cb             	movsbl %bl,%ecx
 438:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 43b:	74 cb                	je     408 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 43d:	83 ff 25             	cmp    $0x25,%edi
 440:	75 e6                	jne    428 <printf+0x48>
      if(c == 'd'){
 442:	83 f8 64             	cmp    $0x64,%eax
 445:	0f 84 05 01 00 00    	je     550 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 44b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 451:	83 f9 70             	cmp    $0x70,%ecx
 454:	74 72                	je     4c8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 456:	83 f8 73             	cmp    $0x73,%eax
 459:	0f 84 99 00 00 00    	je     4f8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 45f:	83 f8 63             	cmp    $0x63,%eax
 462:	0f 84 08 01 00 00    	je     570 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	0f 84 ef 00 00 00    	je     560 <printf+0x180>
  write(fd, &c, 1);
 471:	8d 45 e7             	lea    -0x19(%ebp),%eax
 474:	83 ec 04             	sub    $0x4,%esp
 477:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 47b:	6a 01                	push   $0x1
 47d:	50                   	push   %eax
 47e:	ff 75 08             	pushl  0x8(%ebp)
 481:	e8 1c fe ff ff       	call   2a2 <write>
 486:	83 c4 0c             	add    $0xc,%esp
 489:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 48c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 48f:	6a 01                	push   $0x1
 491:	50                   	push   %eax
 492:	ff 75 08             	pushl  0x8(%ebp)
 495:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 498:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 49a:	e8 03 fe ff ff       	call   2a2 <write>
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 4a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4a6:	84 db                	test   %bl,%bl
 4a8:	75 89                	jne    433 <printf+0x53>
    }
  }
}
 4aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ad:	5b                   	pop    %ebx
 4ae:	5e                   	pop    %esi
 4af:	5f                   	pop    %edi
 4b0:	5d                   	pop    %ebp
 4b1:	c3                   	ret    
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4b8:	bf 25 00 00 00       	mov    $0x25,%edi
 4bd:	e9 66 ff ff ff       	jmp    428 <printf+0x48>
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4c8:	83 ec 0c             	sub    $0xc,%esp
 4cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d0:	6a 00                	push   $0x0
 4d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4d5:	8b 45 08             	mov    0x8(%ebp),%eax
 4d8:	8b 17                	mov    (%edi),%edx
 4da:	e8 61 fe ff ff       	call   340 <printint>
        ap++;
 4df:	89 f8                	mov    %edi,%eax
 4e1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e4:	31 ff                	xor    %edi,%edi
        ap++;
 4e6:	83 c0 04             	add    $0x4,%eax
 4e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ec:	e9 37 ff ff ff       	jmp    428 <printf+0x48>
 4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 4f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4fb:	8b 08                	mov    (%eax),%ecx
        ap++;
 4fd:	83 c0 04             	add    $0x4,%eax
 500:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 503:	85 c9                	test   %ecx,%ecx
 505:	0f 84 8e 00 00 00    	je     599 <printf+0x1b9>
        while(*s != 0){
 50b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 50e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 510:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 512:	84 c0                	test   %al,%al
 514:	0f 84 0e ff ff ff    	je     428 <printf+0x48>
 51a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 51d:	89 de                	mov    %ebx,%esi
 51f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 522:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 525:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 528:	83 ec 04             	sub    $0x4,%esp
          s++;
 52b:	83 c6 01             	add    $0x1,%esi
 52e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 531:	6a 01                	push   $0x1
 533:	57                   	push   %edi
 534:	53                   	push   %ebx
 535:	e8 68 fd ff ff       	call   2a2 <write>
        while(*s != 0){
 53a:	0f b6 06             	movzbl (%esi),%eax
 53d:	83 c4 10             	add    $0x10,%esp
 540:	84 c0                	test   %al,%al
 542:	75 e4                	jne    528 <printf+0x148>
 544:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 547:	31 ff                	xor    %edi,%edi
 549:	e9 da fe ff ff       	jmp    428 <printf+0x48>
 54e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 0a 00 00 00       	mov    $0xa,%ecx
 558:	6a 01                	push   $0x1
 55a:	e9 73 ff ff ff       	jmp    4d2 <printf+0xf2>
 55f:	90                   	nop
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 566:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 569:	6a 01                	push   $0x1
 56b:	e9 21 ff ff ff       	jmp    491 <printf+0xb1>
        putc(fd, *ap);
 570:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 573:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 576:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 578:	6a 01                	push   $0x1
        ap++;
 57a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 57d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 580:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 583:	50                   	push   %eax
 584:	ff 75 08             	pushl  0x8(%ebp)
 587:	e8 16 fd ff ff       	call   2a2 <write>
        ap++;
 58c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 58f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 592:	31 ff                	xor    %edi,%edi
 594:	e9 8f fe ff ff       	jmp    428 <printf+0x48>
          s = "(null)";
 599:	bb a0 09 00 00       	mov    $0x9a0,%ebx
        while(*s != 0){
 59e:	b8 28 00 00 00       	mov    $0x28,%eax
 5a3:	e9 72 ff ff ff       	jmp    51a <printf+0x13a>
 5a8:	66 90                	xchg   %ax,%ax
 5aa:	66 90                	xchg   %ax,%ax
 5ac:	66 90                	xchg   %ax,%ax
 5ae:	66 90                	xchg   %ax,%ax

000005b0 <free>:

static Header base;
static Header *freep;

void
free(void *ap) {
 5b0:	55                   	push   %ebp
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	a1 ac 0d 00 00       	mov    0xdac,%eax
free(void *ap) {
 5b6:	89 e5                	mov    %esp,%ebp
 5b8:	57                   	push   %edi
 5b9:	56                   	push   %esi
 5ba:	53                   	push   %ebx
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = (Header *) ap - 1;
 5be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c8:	39 c8                	cmp    %ecx,%eax
 5ca:	8b 10                	mov    (%eax),%edx
 5cc:	73 32                	jae    600 <free+0x50>
 5ce:	39 d1                	cmp    %edx,%ecx
 5d0:	72 04                	jb     5d6 <free+0x26>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d2:	39 d0                	cmp    %edx,%eax
 5d4:	72 32                	jb     608 <free+0x58>
            break;
    if (bp + bp->s.size == p->s.ptr) {
 5d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5dc:	39 fa                	cmp    %edi,%edx
 5de:	74 30                	je     610 <free+0x60>
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
 5e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 5e3:	8b 50 04             	mov    0x4(%eax),%edx
 5e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e9:	39 f1                	cmp    %esi,%ecx
 5eb:	74 3a                	je     627 <free+0x77>
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
 5ed:	89 08                	mov    %ecx,(%eax)
    freep = p;
 5ef:	a3 ac 0d 00 00       	mov    %eax,0xdac
}
 5f4:	5b                   	pop    %ebx
 5f5:	5e                   	pop    %esi
 5f6:	5f                   	pop    %edi
 5f7:	5d                   	pop    %ebp
 5f8:	c3                   	ret    
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 600:	39 d0                	cmp    %edx,%eax
 602:	72 04                	jb     608 <free+0x58>
 604:	39 d1                	cmp    %edx,%ecx
 606:	72 ce                	jb     5d6 <free+0x26>
free(void *ap) {
 608:	89 d0                	mov    %edx,%eax
 60a:	eb bc                	jmp    5c8 <free+0x18>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->s.size += p->s.ptr->s.size;
 610:	03 72 04             	add    0x4(%edx),%esi
 613:	89 73 fc             	mov    %esi,-0x4(%ebx)
        bp->s.ptr = p->s.ptr->s.ptr;
 616:	8b 10                	mov    (%eax),%edx
 618:	8b 12                	mov    (%edx),%edx
 61a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 61d:	8b 50 04             	mov    0x4(%eax),%edx
 620:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 623:	39 f1                	cmp    %esi,%ecx
 625:	75 c6                	jne    5ed <free+0x3d>
        p->s.size += bp->s.size;
 627:	03 53 fc             	add    -0x4(%ebx),%edx
    freep = p;
 62a:	a3 ac 0d 00 00       	mov    %eax,0xdac
        p->s.size += bp->s.size;
 62f:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
 632:	8b 53 f8             	mov    -0x8(%ebx),%edx
 635:	89 10                	mov    %edx,(%eax)
}
 637:	5b                   	pop    %ebx
 638:	5e                   	pop    %esi
 639:	5f                   	pop    %edi
 63a:	5d                   	pop    %ebp
 63b:	c3                   	ret    
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <morecore>:

static Header*
morecore(uint nu, int pmalloced)
{
 640:	55                   	push   %ebp
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
 641:	3d ff 0f 00 00       	cmp    $0xfff,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	56                   	push   %esi
 649:	53                   	push   %ebx
 64a:	89 c3                	mov    %eax,%ebx
    if(nu < 4096 && !pmalloced)
 64c:	77 52                	ja     6a0 <morecore+0x60>
 64e:	83 e2 01             	and    $0x1,%edx
 651:	75 4d                	jne    6a0 <morecore+0x60>
 653:	be 00 80 00 00       	mov    $0x8000,%esi
        nu = 4096;
 658:	bb 00 10 00 00       	mov    $0x1000,%ebx
    printf(1 , "enter morecore %d\n", nu);
 65d:	83 ec 04             	sub    $0x4,%esp
 660:	53                   	push   %ebx
 661:	68 b9 09 00 00       	push   $0x9b9
 666:	6a 01                	push   $0x1
 668:	e8 73 fd ff ff       	call   3e0 <printf>
    p = sbrk(nu * sizeof(Header));
 66d:	89 34 24             	mov    %esi,(%esp)
 670:	e8 95 fc ff ff       	call   30a <sbrk>
    if(p == (char*)-1)
 675:	83 c4 10             	add    $0x10,%esp
 678:	83 f8 ff             	cmp    $0xffffffff,%eax
 67b:	74 33                	je     6b0 <morecore+0x70>
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
 67d:	89 58 04             	mov    %ebx,0x4(%eax)
    free((void*)(hp + 1));
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	83 c0 08             	add    $0x8,%eax
 686:	50                   	push   %eax
 687:	e8 24 ff ff ff       	call   5b0 <free>
    return freep;
 68c:	a1 ac 0d 00 00       	mov    0xdac,%eax
 691:	83 c4 10             	add    $0x10,%esp
}
 694:	8d 65 f8             	lea    -0x8(%ebp),%esp
 697:	5b                   	pop    %ebx
 698:	5e                   	pop    %esi
 699:	5d                   	pop    %ebp
 69a:	c3                   	ret    
 69b:	90                   	nop
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6a7:	eb b4                	jmp    65d <morecore+0x1d>
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return 0;
 6b0:	31 c0                	xor    %eax,%eax
 6b2:	eb e0                	jmp    694 <morecore+0x54>
 6b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006c0 <malloc>:

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 10             	sub    $0x10,%esp
 6c9:	8b 75 08             	mov    0x8(%ebp),%esi
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
 6cc:	56                   	push   %esi
 6cd:	68 cc 09 00 00       	push   $0x9cc
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	83 c6 07             	add    $0x7,%esi
    printf(1, "nbytes:%d\n",nbytes);
 6d5:	6a 01                	push   $0x1
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d7:	c1 ee 03             	shr    $0x3,%esi
 6da:	83 c6 01             	add    $0x1,%esi
    printf(1, "nbytes:%d\n",nbytes);
 6dd:	e8 fe fc ff ff       	call   3e0 <printf>
    if((prevp = freep) == 0){
 6e2:	8b 3d ac 0d 00 00    	mov    0xdac,%edi
 6e8:	83 c4 10             	add    $0x10,%esp
 6eb:	85 ff                	test   %edi,%edi
 6ed:	0f 84 d5 00 00 00    	je     7c8 <malloc+0x108>
 6f3:	8b 1f                	mov    (%edi),%ebx
 6f5:	8b 53 04             	mov    0x4(%ebx),%edx
 6f8:	eb 0f                	jmp    709 <malloc+0x49>
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 03                	mov    (%ebx),%eax
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
 702:	89 df                	mov    %ebx,%edi
 704:	8b 50 04             	mov    0x4(%eax),%edx
 707:	89 c3                	mov    %eax,%ebx
 709:	83 ec 04             	sub    $0x4,%esp
 70c:	52                   	push   %edx
 70d:	68 eb 09 00 00       	push   $0x9eb
 712:	6a 01                	push   $0x1
 714:	e8 c7 fc ff ff       	call   3e0 <printf>
        if(p->s.size >= nunits){
 719:	8b 43 04             	mov    0x4(%ebx),%eax
 71c:	83 c4 10             	add    $0x10,%esp
 71f:	39 f0                	cmp    %esi,%eax
 721:	73 3d                	jae    760 <malloc+0xa0>
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
 723:	39 1d ac 0d 00 00    	cmp    %ebx,0xdac
 729:	75 d5                	jne    700 <malloc+0x40>
            printf(1, "calling morecore: 0x%x\n", p);
 72b:	83 ec 04             	sub    $0x4,%esp
 72e:	53                   	push   %ebx
 72f:	68 4f 0a 00 00       	push   $0xa4f
 734:	6a 01                	push   $0x1
 736:	e8 a5 fc ff ff       	call   3e0 <printf>
            if((p = morecore(nunits,0)) == 0)
 73b:	31 d2                	xor    %edx,%edx
 73d:	89 f0                	mov    %esi,%eax
 73f:	e8 fc fe ff ff       	call   640 <morecore>
 744:	83 c4 10             	add    $0x10,%esp
 747:	85 c0                	test   %eax,%eax
 749:	89 c3                	mov    %eax,%ebx
 74b:	75 b3                	jne    700 <malloc+0x40>
                return 0;
    }}
}
 74d:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return 0;
 750:	31 c0                	xor    %eax,%eax
}
 752:	5b                   	pop    %ebx
 753:	5e                   	pop    %esi
 754:	5f                   	pop    %edi
 755:	5d                   	pop    %ebp
 756:	c3                   	ret    
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->s.size == nunits){
 760:	74 46                	je     7a8 <malloc+0xe8>
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
 762:	56                   	push   %esi
 763:	50                   	push   %eax
 764:	68 22 0a 00 00       	push   $0xa22
 769:	6a 01                	push   $0x1
 76b:	e8 70 fc ff ff       	call   3e0 <printf>
                p->s.size -= nunits;
 770:	8b 43 04             	mov    0x4(%ebx),%eax
                p->s.size = nunits;
 773:	83 c4 10             	add    $0x10,%esp
                p->s.size -= nunits;
 776:	29 f0                	sub    %esi,%eax
 778:	89 43 04             	mov    %eax,0x4(%ebx)
                p += p->s.size;
 77b:	8d 1c c3             	lea    (%ebx,%eax,8),%ebx
                p->s.size = nunits;
 77e:	89 73 04             	mov    %esi,0x4(%ebx)
            printf(1,"returning p+1\n");
 781:	83 ec 08             	sub    $0x8,%esp
 784:	68 40 0a 00 00       	push   $0xa40
 789:	6a 01                	push   $0x1
 78b:	e8 50 fc ff ff       	call   3e0 <printf>
            freep = prevp;
 790:	89 3d ac 0d 00 00    	mov    %edi,0xdac
            return (void*)(p + 1);
 796:	83 c4 10             	add    $0x10,%esp
}
 799:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return (void*)(p + 1);
 79c:	8d 43 08             	lea    0x8(%ebx),%eax
}
 79f:	5b                   	pop    %ebx
 7a0:	5e                   	pop    %esi
 7a1:	5f                   	pop    %edi
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret    
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"p->s.size == nunits == %d\n",nunits);
 7a8:	83 ec 04             	sub    $0x4,%esp
 7ab:	56                   	push   %esi
 7ac:	68 07 0a 00 00       	push   $0xa07
 7b1:	6a 01                	push   $0x1
 7b3:	e8 28 fc ff ff       	call   3e0 <printf>
                prevp->s.ptr = p->s.ptr;}
 7b8:	8b 03                	mov    (%ebx),%eax
 7ba:	83 c4 10             	add    $0x10,%esp
 7bd:	89 07                	mov    %eax,(%edi)
 7bf:	eb c0                	jmp    781 <malloc+0xc1>
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"prevp = freep == 0\n");
 7c8:	83 ec 08             	sub    $0x8,%esp
        base.s.size = 0;
 7cb:	bb b0 0d 00 00       	mov    $0xdb0,%ebx
        printf(1,"prevp = freep == 0\n");
 7d0:	68 d7 09 00 00       	push   $0x9d7
 7d5:	6a 01                	push   $0x1
        base.s.ptr = freep = prevp = &base;
 7d7:	89 df                	mov    %ebx,%edi
        printf(1,"prevp = freep == 0\n");
 7d9:	e8 02 fc ff ff       	call   3e0 <printf>
        base.s.ptr = freep = prevp = &base;
 7de:	c7 05 ac 0d 00 00 b0 	movl   $0xdb0,0xdac
 7e5:	0d 00 00 
 7e8:	c7 05 b0 0d 00 00 b0 	movl   $0xdb0,0xdb0
 7ef:	0d 00 00 
        base.s.size = 0;
 7f2:	83 c4 10             	add    $0x10,%esp
 7f5:	c7 05 b4 0d 00 00 00 	movl   $0x0,0xdb4
 7fc:	00 00 00 
 7ff:	31 d2                	xor    %edx,%edx
 801:	e9 03 ff ff ff       	jmp    709 <malloc+0x49>
 806:	8d 76 00             	lea    0x0(%esi),%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000810 <pmalloc>:
void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
 810:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
pmalloc(void) {
 816:	55                   	push   %ebp
 817:	89 e5                	mov    %esp,%ebp
 819:	56                   	push   %esi
 81a:	53                   	push   %ebx
    if ((prevp = freep) == 0) {
 81b:	85 c9                	test   %ecx,%ecx
 81d:	0f 84 95 00 00 00    	je     8b8 <pmalloc+0xa8>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 823:	8b 19                	mov    (%ecx),%ebx
        if (p->s.size >= ((4096 / 8)*2)) {
 825:	8b 53 04             	mov    0x4(%ebx),%edx
 828:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 82e:	76 1d                	jbe    84d <pmalloc+0x3d>
 830:	eb 3f                	jmp    871 <pmalloc+0x61>
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 838:	8b 03                	mov    (%ebx),%eax
        if (p->s.size >= ((4096 / 8)*2)) {
 83a:	8b 50 04             	mov    0x4(%eax),%edx
 83d:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 843:	77 30                	ja     875 <pmalloc+0x65>
 845:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
 84b:	89 c3                	mov    %eax,%ebx


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
 84d:	39 cb                	cmp    %ecx,%ebx
 84f:	75 e7                	jne    838 <pmalloc+0x28>
                if ((p = morecore(nunits, 1)) == 0) {
 851:	ba 01 00 00 00       	mov    $0x1,%edx
 856:	b8 00 02 00 00       	mov    $0x200,%eax
 85b:	e8 e0 fd ff ff       	call   640 <morecore>
 860:	85 c0                	test   %eax,%eax
 862:	89 c3                	mov    %eax,%ebx
 864:	75 d2                	jne    838 <pmalloc+0x28>
                    return 0;
                }
            }
        }
}
 866:	8d 65 f8             	lea    -0x8(%ebp),%esp
                    return 0;
 869:	31 f6                	xor    %esi,%esi
}
 86b:	89 f0                	mov    %esi,%eax
 86d:	5b                   	pop    %ebx
 86e:	5e                   	pop    %esi
 86f:	5d                   	pop    %ebp
 870:	c3                   	ret    
        if (p->s.size >= ((4096 / 8)*2)) {
 871:	89 d8                	mov    %ebx,%eax
 873:	89 cb                	mov    %ecx,%ebx
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 875:	81 e2 00 fe ff ff    	and    $0xfffffe00,%edx
            set_flag((uint) (p + 1), PTE_1, 1);
 87b:	83 ec 04             	sub    $0x4,%esp
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 87e:	81 ea 01 02 00 00    	sub    $0x201,%edx
            p += p->s.size;
 884:	8d 34 d0             	lea    (%eax,%edx,8),%esi
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 887:	89 50 04             	mov    %edx,0x4(%eax)
            set_flag((uint) (p + 1), PTE_1, 1);
 88a:	83 c6 08             	add    $0x8,%esi
            p->s.size = nunits;
 88d:	c7 46 fc 00 02 00 00 	movl   $0x200,-0x4(%esi)
            set_flag((uint) (p + 1), PTE_1, 1);
 894:	6a 01                	push   $0x1
 896:	68 00 04 00 00       	push   $0x400
 89b:	56                   	push   %esi
 89c:	e8 89 fa ff ff       	call   32a <set_flag>
            freep = prevp;
 8a1:	89 1d ac 0d 00 00    	mov    %ebx,0xdac
            return (void *) (p + 1);
 8a7:	83 c4 10             	add    $0x10,%esp
}
 8aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8ad:	89 f0                	mov    %esi,%eax
 8af:	5b                   	pop    %ebx
 8b0:	5e                   	pop    %esi
 8b1:	5d                   	pop    %ebp
 8b2:	c3                   	ret    
 8b3:	90                   	nop
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        base.s.size = 0;
 8b8:	b9 b0 0d 00 00       	mov    $0xdb0,%ecx
        base.s.ptr = freep = prevp = &base;
 8bd:	c7 05 ac 0d 00 00 b0 	movl   $0xdb0,0xdac
 8c4:	0d 00 00 
 8c7:	c7 05 b0 0d 00 00 b0 	movl   $0xdb0,0xdb0
 8ce:	0d 00 00 
        base.s.size = 0;
 8d1:	c7 05 b4 0d 00 00 00 	movl   $0x0,0xdb4
 8d8:	00 00 00 
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 8db:	89 cb                	mov    %ecx,%ebx
 8dd:	e9 6b ff ff ff       	jmp    84d <pmalloc+0x3d>
 8e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <protect_page>:
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	83 ec 04             	sub    $0x4,%esp
 8f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((int)(ap-8) % PGSIZE != 0){
 8fa:	8d 43 f8             	lea    -0x8(%ebx),%eax
 8fd:	a9 ff 0f 00 00       	test   $0xfff,%eax
 902:	75 3c                	jne    940 <protect_page+0x50>
        return -1;
    }
    int flags = get_flags((uint)ap);
 904:	83 ec 0c             	sub    $0xc,%esp
 907:	53                   	push   %ebx
 908:	e8 15 fa ff ff       	call   322 <get_flags>
    if (flags & PTE_1) {
 90d:	83 c4 10             	add    $0x10,%esp
 910:	f6 c4 04             	test   $0x4,%ah
 913:	74 2b                	je     940 <protect_page+0x50>
        set_flag((uint) ap, PTE_W, 0);
 915:	83 ec 04             	sub    $0x4,%esp
 918:	6a 00                	push   $0x0
 91a:	6a 02                	push   $0x2
 91c:	53                   	push   %ebx
 91d:	e8 08 fa ff ff       	call   32a <set_flag>
        update_protected_pages(1);
 922:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 929:	e8 04 fa ff ff       	call   332 <update_protected_pages>
        return 1;
 92e:	83 c4 10             	add    $0x10,%esp
 931:	b8 01 00 00 00       	mov    $0x1,%eax

    }
    return -1;
}
 936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 939:	c9                   	leave  
 93a:	c3                   	ret    
 93b:	90                   	nop
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 945:	eb ef                	jmp    936 <protect_page+0x46>
 947:	89 f6                	mov    %esi,%esi
 949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000950 <pfree>:



int pfree(void *ap){
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	53                   	push   %ebx
 954:	83 ec 10             	sub    $0x10,%esp
 957:	8b 5d 08             	mov    0x8(%ebp),%ebx

    int flags = get_flags((uint) ap);
 95a:	53                   	push   %ebx
 95b:	e8 c2 f9 ff ff       	call   322 <get_flags>
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
 960:	83 c4 10             	add    $0x10,%esp
 963:	a8 02                	test   $0x2,%al
 965:	75 31                	jne    998 <pfree+0x48>
 967:	83 ec 04             	sub    $0x4,%esp
 96a:	6a 01                	push   $0x1
 96c:	6a 02                	push   $0x2
 96e:	53                   	push   %ebx
 96f:	e8 b6 f9 ff ff       	call   32a <set_flag>
    else
        return -1;

    free(ap);
 974:	89 1c 24             	mov    %ebx,(%esp)
 977:	e8 34 fc ff ff       	call   5b0 <free>
    update_protected_pages(0);
 97c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 983:	e8 aa f9 ff ff       	call   332 <update_protected_pages>
    return 1;
 988:	83 c4 10             	add    $0x10,%esp
 98b:	b8 01 00 00 00       	mov    $0x1,%eax
 990:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 993:	c9                   	leave  
 994:	c3                   	ret    
 995:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
 998:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 99d:	eb f1                	jmp    990 <pfree+0x40>
