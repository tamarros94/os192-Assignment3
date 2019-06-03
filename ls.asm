
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
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
  1b:	7e 24                	jle    41 <main+0x41>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 cb 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  35:	83 c4 10             	add    $0x10,%esp
  38:	39 f3                	cmp    %esi,%ebx
  3a:	75 ec                	jne    28 <main+0x28>
  exit();
  3c:	e8 41 05 00 00       	call   582 <exit>
    ls(".");
  41:	83 ec 0c             	sub    $0xc,%esp
  44:	68 e8 0c 00 00       	push   $0xce8
  49:	e8 b2 00 00 00       	call   100 <ls>
    exit();
  4e:	e8 2f 05 00 00       	call   582 <exit>
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	53                   	push   %ebx
  6c:	e8 3f 03 00 00       	call   3b0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 d8                	add    %ebx,%eax
  76:	73 0f                	jae    87 <fmtname+0x27>
  78:	eb 12                	jmp    8c <fmtname+0x2c>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	83 e8 01             	sub    $0x1,%eax
  83:	39 c3                	cmp    %eax,%ebx
  85:	77 05                	ja     8c <fmtname+0x2c>
  87:	80 38 2f             	cmpb   $0x2f,(%eax)
  8a:	75 f4                	jne    80 <fmtname+0x20>
  p++;
  8c:	8d 58 01             	lea    0x1(%eax),%ebx
  if(strlen(p) >= DIRSIZ)
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	53                   	push   %ebx
  93:	e8 18 03 00 00       	call   3b0 <strlen>
  98:	83 c4 10             	add    $0x10,%esp
  9b:	83 f8 0d             	cmp    $0xd,%eax
  9e:	77 4a                	ja     ea <fmtname+0x8a>
  memmove(buf, p, strlen(p));
  a0:	83 ec 0c             	sub    $0xc,%esp
  a3:	53                   	push   %ebx
  a4:	e8 07 03 00 00       	call   3b0 <strlen>
  a9:	83 c4 0c             	add    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	53                   	push   %ebx
  ae:	68 74 11 00 00       	push   $0x1174
  b3:	e8 98 04 00 00       	call   550 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 1c 24             	mov    %ebx,(%esp)
  bb:	e8 f0 02 00 00       	call   3b0 <strlen>
  c0:	89 1c 24             	mov    %ebx,(%esp)
  c3:	89 c6                	mov    %eax,%esi
  return buf;
  c5:	bb 74 11 00 00       	mov    $0x1174,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	e8 e1 02 00 00       	call   3b0 <strlen>
  cf:	ba 0e 00 00 00       	mov    $0xe,%edx
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	05 74 11 00 00       	add    $0x1174,%eax
  dc:	29 f2                	sub    %esi,%edx
  de:	52                   	push   %edx
  df:	6a 20                	push   $0x20
  e1:	50                   	push   %eax
  e2:	e8 f9 02 00 00       	call   3e0 <memset>
  return buf;
  e7:	83 c4 10             	add    $0x10,%esp
}
  ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ed:	89 d8                	mov    %ebx,%eax
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 ab 04 00 00       	call   5c2 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	78 52                	js     170 <ls+0x70>
  if(fstat(fd, &st) < 0){
 11e:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 124:	83 ec 08             	sub    $0x8,%esp
 127:	89 c3                	mov    %eax,%ebx
 129:	56                   	push   %esi
 12a:	50                   	push   %eax
 12b:	e8 aa 04 00 00       	call   5da <fstat>
 130:	83 c4 10             	add    $0x10,%esp
 133:	85 c0                	test   %eax,%eax
 135:	0f 88 c5 00 00 00    	js     200 <ls+0x100>
  switch(st.type){
 13b:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 142:	66 83 f8 01          	cmp    $0x1,%ax
 146:	0f 84 84 00 00 00    	je     1d0 <ls+0xd0>
 14c:	66 83 f8 02          	cmp    $0x2,%ax
 150:	74 3e                	je     190 <ls+0x90>
  close(fd);
 152:	83 ec 0c             	sub    $0xc,%esp
 155:	53                   	push   %ebx
 156:	e8 4f 04 00 00       	call   5aa <close>
 15b:	83 c4 10             	add    $0x10,%esp
}
 15e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5f                   	pop    %edi
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
 166:	8d 76 00             	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot open %s\n", path);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	57                   	push   %edi
 174:	68 a0 0c 00 00       	push   $0xca0
 179:	6a 02                	push   $0x2
 17b:	e8 60 05 00 00       	call   6e0 <printf>
    return;
 180:	83 c4 10             	add    $0x10,%esp
}
 183:	8d 65 f4             	lea    -0xc(%ebp),%esp
 186:	5b                   	pop    %ebx
 187:	5e                   	pop    %esi
 188:	5f                   	pop    %edi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 199:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 19f:	57                   	push   %edi
 1a0:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 1a6:	e8 b5 fe ff ff       	call   60 <fmtname>
 1ab:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1b1:	59                   	pop    %ecx
 1b2:	5f                   	pop    %edi
 1b3:	52                   	push   %edx
 1b4:	56                   	push   %esi
 1b5:	6a 02                	push   $0x2
 1b7:	50                   	push   %eax
 1b8:	68 c8 0c 00 00       	push   $0xcc8
 1bd:	6a 01                	push   $0x1
 1bf:	e8 1c 05 00 00       	call   6e0 <printf>
    break;
 1c4:	83 c4 20             	add    $0x20,%esp
 1c7:	eb 89                	jmp    152 <ls+0x52>
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1d0:	83 ec 0c             	sub    $0xc,%esp
 1d3:	57                   	push   %edi
 1d4:	e8 d7 01 00 00       	call   3b0 <strlen>
 1d9:	83 c0 10             	add    $0x10,%eax
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	3d 00 02 00 00       	cmp    $0x200,%eax
 1e4:	76 42                	jbe    228 <ls+0x128>
      printf(1, "ls: path too long\n");
 1e6:	83 ec 08             	sub    $0x8,%esp
 1e9:	68 d5 0c 00 00       	push   $0xcd5
 1ee:	6a 01                	push   $0x1
 1f0:	e8 eb 04 00 00       	call   6e0 <printf>
      break;
 1f5:	83 c4 10             	add    $0x10,%esp
 1f8:	e9 55 ff ff ff       	jmp    152 <ls+0x52>
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	57                   	push   %edi
 204:	68 b4 0c 00 00       	push   $0xcb4
 209:	6a 02                	push   $0x2
 20b:	e8 d0 04 00 00       	call   6e0 <printf>
    close(fd);
 210:	89 1c 24             	mov    %ebx,(%esp)
 213:	e8 92 03 00 00       	call   5aa <close>
    return;
 218:	83 c4 10             	add    $0x10,%esp
}
 21b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21e:	5b                   	pop    %ebx
 21f:	5e                   	pop    %esi
 220:	5f                   	pop    %edi
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	90                   	nop
 224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(buf, path);
 228:	83 ec 08             	sub    $0x8,%esp
 22b:	57                   	push   %edi
 22c:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 232:	57                   	push   %edi
 233:	e8 f8 00 00 00       	call   330 <strcpy>
    p = buf+strlen(buf);
 238:	89 3c 24             	mov    %edi,(%esp)
 23b:	e8 70 01 00 00       	call   3b0 <strlen>
 240:	01 f8                	add    %edi,%eax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 242:	83 c4 10             	add    $0x10,%esp
    *p++ = '/';
 245:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 248:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 24e:	c6 00 2f             	movb   $0x2f,(%eax)
 251:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 260:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 266:	83 ec 04             	sub    $0x4,%esp
 269:	6a 10                	push   $0x10
 26b:	50                   	push   %eax
 26c:	53                   	push   %ebx
 26d:	e8 28 03 00 00       	call   59a <read>
 272:	83 c4 10             	add    $0x10,%esp
 275:	83 f8 10             	cmp    $0x10,%eax
 278:	0f 85 d4 fe ff ff    	jne    152 <ls+0x52>
      if(de.inum == 0)
 27e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 285:	00 
 286:	74 d8                	je     260 <ls+0x160>
      memmove(p, de.name, DIRSIZ);
 288:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 28e:	83 ec 04             	sub    $0x4,%esp
 291:	6a 0e                	push   $0xe
 293:	50                   	push   %eax
 294:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
 29a:	e8 b1 02 00 00       	call   550 <memmove>
      p[DIRSIZ] = 0;
 29f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 2a5:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2a9:	58                   	pop    %eax
 2aa:	5a                   	pop    %edx
 2ab:	56                   	push   %esi
 2ac:	57                   	push   %edi
 2ad:	e8 0e 02 00 00       	call   4c0 <stat>
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 5f                	js     318 <ls+0x218>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2b9:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 2c0:	83 ec 0c             	sub    $0xc,%esp
 2c3:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2c9:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2cf:	57                   	push   %edi
 2d0:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 2d6:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 2dc:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 2e2:	e8 79 fd ff ff       	call   60 <fmtname>
 2e7:	5a                   	pop    %edx
 2e8:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2ee:	59                   	pop    %ecx
 2ef:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 2f5:	51                   	push   %ecx
 2f6:	52                   	push   %edx
 2f7:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 2fd:	50                   	push   %eax
 2fe:	68 c8 0c 00 00       	push   $0xcc8
 303:	6a 01                	push   $0x1
 305:	e8 d6 03 00 00       	call   6e0 <printf>
 30a:	83 c4 20             	add    $0x20,%esp
 30d:	e9 4e ff ff ff       	jmp    260 <ls+0x160>
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 318:	83 ec 04             	sub    $0x4,%esp
 31b:	57                   	push   %edi
 31c:	68 b4 0c 00 00       	push   $0xcb4
 321:	6a 01                	push   $0x1
 323:	e8 b8 03 00 00       	call   6e0 <printf>
        continue;
 328:	83 c4 10             	add    $0x10,%esp
 32b:	e9 30 ff ff ff       	jmp    260 <ls+0x160>

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	83 c1 01             	add    $0x1,%ecx
 343:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 347:	83 c2 01             	add    $0x1,%edx
 34a:	84 db                	test   %bl,%bl
 34c:	88 5a ff             	mov    %bl,-0x1(%edx)
 34f:	75 ef                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 351:	5b                   	pop    %ebx
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	0f b6 19             	movzbl (%ecx),%ebx
 370:	84 c0                	test   %al,%al
 372:	75 1c                	jne    390 <strcmp+0x30>
 374:	eb 2a                	jmp    3a0 <strcmp+0x40>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 380:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 383:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 386:	83 c1 01             	add    $0x1,%ecx
 389:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 38c:	84 c0                	test   %al,%al
 38e:	74 10                	je     3a0 <strcmp+0x40>
 390:	38 d8                	cmp    %bl,%al
 392:	74 ec                	je     380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 394:	29 d8                	sub    %ebx,%eax
}
 396:	5b                   	pop    %ebx
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strlen>:

uint
strlen(char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 39 00             	cmpb   $0x0,(%ecx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 d2                	xor    %edx,%edx
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 3d0:	31 c0                	xor    %eax,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	74 1d                	je     42e <strchr+0x2e>
    if(*s == c)
 411:	38 d3                	cmp    %dl,%bl
 413:	89 d9                	mov    %ebx,%ecx
 415:	75 0d                	jne    424 <strchr+0x24>
 417:	eb 17                	jmp    430 <strchr+0x30>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	38 ca                	cmp    %cl,%dl
 422:	74 0c                	je     430 <strchr+0x30>
  for(; *s; s++)
 424:	83 c0 01             	add    $0x1,%eax
 427:	0f b6 10             	movzbl (%eax),%edx
 42a:	84 d2                	test   %dl,%dl
 42c:	75 f2                	jne    420 <strchr+0x20>
      return (char*)s;
  return 0;
 42e:	31 c0                	xor    %eax,%eax
}
 430:	5b                   	pop    %ebx
 431:	5d                   	pop    %ebp
 432:	c3                   	ret    
 433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 446:	31 f6                	xor    %esi,%esi
 448:	89 f3                	mov    %esi,%ebx
{
 44a:	83 ec 1c             	sub    $0x1c,%esp
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 450:	eb 2f                	jmp    481 <gets+0x41>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 458:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	6a 00                	push   $0x0
 463:	e8 32 01 00 00       	call   59a <read>
    if(cc < 1)
 468:	83 c4 10             	add    $0x10,%esp
 46b:	85 c0                	test   %eax,%eax
 46d:	7e 1c                	jle    48b <gets+0x4b>
      break;
    buf[i++] = c;
 46f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 473:	83 c7 01             	add    $0x1,%edi
 476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 23                	je     4a0 <gets+0x60>
 47d:	3c 0d                	cmp    $0xd,%al
 47f:	74 1f                	je     4a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 481:	83 c3 01             	add    $0x1,%ebx
 484:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 487:	89 fe                	mov    %edi,%esi
 489:	7c cd                	jl     458 <gets+0x18>
 48b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 490:	c6 03 00             	movb   $0x0,(%ebx)
}
 493:	8d 65 f4             	lea    -0xc(%ebp),%esp
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5f                   	pop    %edi
 499:	5d                   	pop    %ebp
 49a:	c3                   	ret    
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	8b 75 08             	mov    0x8(%ebp),%esi
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 de                	add    %ebx,%esi
 4a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 4ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5f                   	pop    %edi
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <stat>:

int
stat(char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f0 00 00 00       	call   5c2 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f3 00 00 00       	call   5da <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 b9 00 00 00       	call   5aa <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
  n = 0;
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 572:	39 d3                	cmp    %edx,%ebx
 574:	75 f2                	jne    568 <memmove+0x18>
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57a:	b8 01 00 00 00       	mov    $0x1,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
 582:	b8 02 00 00 00       	mov    $0x2,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
 58a:	b8 03 00 00 00       	mov    $0x3,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
 592:	b8 04 00 00 00       	mov    $0x4,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
 59a:	b8 05 00 00 00       	mov    $0x5,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
 5a2:	b8 10 00 00 00       	mov    $0x10,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
 5aa:	b8 15 00 00 00       	mov    $0x15,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
 5b2:	b8 06 00 00 00       	mov    $0x6,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
 5ba:	b8 07 00 00 00       	mov    $0x7,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
 5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
 5ca:	b8 11 00 00 00       	mov    $0x11,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
 5d2:	b8 12 00 00 00       	mov    $0x12,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
 5da:	b8 08 00 00 00       	mov    $0x8,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
 5e2:	b8 13 00 00 00       	mov    $0x13,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
 5ea:	b8 14 00 00 00       	mov    $0x14,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
 5f2:	b8 09 00 00 00       	mov    $0x9,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
 5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
 602:	b8 0b 00 00 00       	mov    $0xb,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
 60a:	b8 0c 00 00 00       	mov    $0xc,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
 612:	b8 0d 00 00 00       	mov    $0xd,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
 61a:	b8 0e 00 00 00       	mov    $0xe,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <get_flags>:
SYSCALL(get_flags)
 622:	b8 17 00 00 00       	mov    $0x17,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <set_flag>:
SYSCALL(set_flag)
 62a:	b8 18 00 00 00       	mov    $0x18,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <update_protected_pages>:
SYSCALL(update_protected_pages)
 632:	b8 19 00 00 00       	mov    $0x19,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 649:	85 d2                	test   %edx,%edx
{
 64b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 64e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 650:	79 76                	jns    6c8 <printint+0x88>
 652:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 656:	74 70                	je     6c8 <printint+0x88>
    x = -xx;
 658:	f7 d8                	neg    %eax
    neg = 1;
 65a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 661:	31 f6                	xor    %esi,%esi
 663:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 666:	eb 0a                	jmp    672 <printint+0x32>
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 670:	89 fe                	mov    %edi,%esi
 672:	31 d2                	xor    %edx,%edx
 674:	8d 7e 01             	lea    0x1(%esi),%edi
 677:	f7 f1                	div    %ecx
 679:	0f b6 92 f4 0c 00 00 	movzbl 0xcf4(%edx),%edx
  }while((x /= base) != 0);
 680:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 682:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 685:	75 e9                	jne    670 <printint+0x30>
  if(neg)
 687:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 68a:	85 c0                	test   %eax,%eax
 68c:	74 08                	je     696 <printint+0x56>
    buf[i++] = '-';
 68e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 693:	8d 7e 02             	lea    0x2(%esi),%edi
 696:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 69a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 6a3:	83 ec 04             	sub    $0x4,%esp
 6a6:	83 ee 01             	sub    $0x1,%esi
 6a9:	6a 01                	push   $0x1
 6ab:	53                   	push   %ebx
 6ac:	57                   	push   %edi
 6ad:	88 45 d7             	mov    %al,-0x29(%ebp)
 6b0:	e8 ed fe ff ff       	call   5a2 <write>

  while(--i >= 0)
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	39 de                	cmp    %ebx,%esi
 6ba:	75 e4                	jne    6a0 <printint+0x60>
    putc(fd, buf[i]);
}
 6bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6bf:	5b                   	pop    %ebx
 6c0:	5e                   	pop    %esi
 6c1:	5f                   	pop    %edi
 6c2:	5d                   	pop    %ebp
 6c3:	c3                   	ret    
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6cf:	eb 90                	jmp    661 <printint+0x21>
 6d1:	eb 0d                	jmp    6e0 <printf>
 6d3:	90                   	nop
 6d4:	90                   	nop
 6d5:	90                   	nop
 6d6:	90                   	nop
 6d7:	90                   	nop
 6d8:	90                   	nop
 6d9:	90                   	nop
 6da:	90                   	nop
 6db:	90                   	nop
 6dc:	90                   	nop
 6dd:	90                   	nop
 6de:	90                   	nop
 6df:	90                   	nop

000006e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 6ec:	0f b6 1e             	movzbl (%esi),%ebx
 6ef:	84 db                	test   %bl,%bl
 6f1:	0f 84 b3 00 00 00    	je     7aa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 6f7:	8d 45 10             	lea    0x10(%ebp),%eax
 6fa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 6fd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 6ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 702:	eb 2f                	jmp    733 <printf+0x53>
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 708:	83 f8 25             	cmp    $0x25,%eax
 70b:	0f 84 a7 00 00 00    	je     7b8 <printf+0xd8>
  write(fd, &c, 1);
 711:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 714:	83 ec 04             	sub    $0x4,%esp
 717:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 71a:	6a 01                	push   $0x1
 71c:	50                   	push   %eax
 71d:	ff 75 08             	pushl  0x8(%ebp)
 720:	e8 7d fe ff ff       	call   5a2 <write>
 725:	83 c4 10             	add    $0x10,%esp
 728:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 72b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 72f:	84 db                	test   %bl,%bl
 731:	74 77                	je     7aa <printf+0xca>
    if(state == 0){
 733:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 735:	0f be cb             	movsbl %bl,%ecx
 738:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 73b:	74 cb                	je     708 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 73d:	83 ff 25             	cmp    $0x25,%edi
 740:	75 e6                	jne    728 <printf+0x48>
      if(c == 'd'){
 742:	83 f8 64             	cmp    $0x64,%eax
 745:	0f 84 05 01 00 00    	je     850 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 74b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 751:	83 f9 70             	cmp    $0x70,%ecx
 754:	74 72                	je     7c8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 756:	83 f8 73             	cmp    $0x73,%eax
 759:	0f 84 99 00 00 00    	je     7f8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 75f:	83 f8 63             	cmp    $0x63,%eax
 762:	0f 84 08 01 00 00    	je     870 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 768:	83 f8 25             	cmp    $0x25,%eax
 76b:	0f 84 ef 00 00 00    	je     860 <printf+0x180>
  write(fd, &c, 1);
 771:	8d 45 e7             	lea    -0x19(%ebp),%eax
 774:	83 ec 04             	sub    $0x4,%esp
 777:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 77b:	6a 01                	push   $0x1
 77d:	50                   	push   %eax
 77e:	ff 75 08             	pushl  0x8(%ebp)
 781:	e8 1c fe ff ff       	call   5a2 <write>
 786:	83 c4 0c             	add    $0xc,%esp
 789:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 78c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 78f:	6a 01                	push   $0x1
 791:	50                   	push   %eax
 792:	ff 75 08             	pushl  0x8(%ebp)
 795:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 798:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 79a:	e8 03 fe ff ff       	call   5a2 <write>
  for(i = 0; fmt[i]; i++){
 79f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 7a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 7a6:	84 db                	test   %bl,%bl
 7a8:	75 89                	jne    733 <printf+0x53>
    }
  }
}
 7aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7ad:	5b                   	pop    %ebx
 7ae:	5e                   	pop    %esi
 7af:	5f                   	pop    %edi
 7b0:	5d                   	pop    %ebp
 7b1:	c3                   	ret    
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 7b8:	bf 25 00 00 00       	mov    $0x25,%edi
 7bd:	e9 66 ff ff ff       	jmp    728 <printf+0x48>
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7c8:	83 ec 0c             	sub    $0xc,%esp
 7cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 7d0:	6a 00                	push   $0x0
 7d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 7d5:	8b 45 08             	mov    0x8(%ebp),%eax
 7d8:	8b 17                	mov    (%edi),%edx
 7da:	e8 61 fe ff ff       	call   640 <printint>
        ap++;
 7df:	89 f8                	mov    %edi,%eax
 7e1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7e4:	31 ff                	xor    %edi,%edi
        ap++;
 7e6:	83 c0 04             	add    $0x4,%eax
 7e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 7ec:	e9 37 ff ff ff       	jmp    728 <printf+0x48>
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7fb:	8b 08                	mov    (%eax),%ecx
        ap++;
 7fd:	83 c0 04             	add    $0x4,%eax
 800:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 803:	85 c9                	test   %ecx,%ecx
 805:	0f 84 8e 00 00 00    	je     899 <printf+0x1b9>
        while(*s != 0){
 80b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 80e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 810:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 812:	84 c0                	test   %al,%al
 814:	0f 84 0e ff ff ff    	je     728 <printf+0x48>
 81a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 81d:	89 de                	mov    %ebx,%esi
 81f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 822:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 825:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 828:	83 ec 04             	sub    $0x4,%esp
          s++;
 82b:	83 c6 01             	add    $0x1,%esi
 82e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 831:	6a 01                	push   $0x1
 833:	57                   	push   %edi
 834:	53                   	push   %ebx
 835:	e8 68 fd ff ff       	call   5a2 <write>
        while(*s != 0){
 83a:	0f b6 06             	movzbl (%esi),%eax
 83d:	83 c4 10             	add    $0x10,%esp
 840:	84 c0                	test   %al,%al
 842:	75 e4                	jne    828 <printf+0x148>
 844:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 847:	31 ff                	xor    %edi,%edi
 849:	e9 da fe ff ff       	jmp    728 <printf+0x48>
 84e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	b9 0a 00 00 00       	mov    $0xa,%ecx
 858:	6a 01                	push   $0x1
 85a:	e9 73 ff ff ff       	jmp    7d2 <printf+0xf2>
 85f:	90                   	nop
  write(fd, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 866:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 869:	6a 01                	push   $0x1
 86b:	e9 21 ff ff ff       	jmp    791 <printf+0xb1>
        putc(fd, *ap);
 870:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 873:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 876:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 878:	6a 01                	push   $0x1
        ap++;
 87a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 87d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 880:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 883:	50                   	push   %eax
 884:	ff 75 08             	pushl  0x8(%ebp)
 887:	e8 16 fd ff ff       	call   5a2 <write>
        ap++;
 88c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 88f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 892:	31 ff                	xor    %edi,%edi
 894:	e9 8f fe ff ff       	jmp    728 <printf+0x48>
          s = "(null)";
 899:	bb ea 0c 00 00       	mov    $0xcea,%ebx
        while(*s != 0){
 89e:	b8 28 00 00 00       	mov    $0x28,%eax
 8a3:	e9 72 ff ff ff       	jmp    81a <printf+0x13a>
 8a8:	66 90                	xchg   %ax,%ax
 8aa:	66 90                	xchg   %ax,%ax
 8ac:	66 90                	xchg   %ax,%ax
 8ae:	66 90                	xchg   %ax,%ax

000008b0 <free>:

static Header base;
static Header *freep;

void
free(void *ap) {
 8b0:	55                   	push   %ebp
    Header *bp, *p;

    bp = (Header *) ap - 1;
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	a1 84 11 00 00       	mov    0x1184,%eax
free(void *ap) {
 8b6:	89 e5                	mov    %esp,%ebp
 8b8:	57                   	push   %edi
 8b9:	56                   	push   %esi
 8ba:	53                   	push   %ebx
 8bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = (Header *) ap - 1;
 8be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c8:	39 c8                	cmp    %ecx,%eax
 8ca:	8b 10                	mov    (%eax),%edx
 8cc:	73 32                	jae    900 <free+0x50>
 8ce:	39 d1                	cmp    %edx,%ecx
 8d0:	72 04                	jb     8d6 <free+0x26>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d2:	39 d0                	cmp    %edx,%eax
 8d4:	72 32                	jb     908 <free+0x58>
            break;
    if (bp + bp->s.size == p->s.ptr) {
 8d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8dc:	39 fa                	cmp    %edi,%edx
 8de:	74 30                	je     910 <free+0x60>
        bp->s.size += p->s.ptr->s.size;
        bp->s.ptr = p->s.ptr->s.ptr;
    } else
        bp->s.ptr = p->s.ptr;
 8e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 8e3:	8b 50 04             	mov    0x4(%eax),%edx
 8e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8e9:	39 f1                	cmp    %esi,%ecx
 8eb:	74 3a                	je     927 <free+0x77>
        p->s.size += bp->s.size;
        p->s.ptr = bp->s.ptr;
    } else
        p->s.ptr = bp;
 8ed:	89 08                	mov    %ecx,(%eax)
    freep = p;
 8ef:	a3 84 11 00 00       	mov    %eax,0x1184
}
 8f4:	5b                   	pop    %ebx
 8f5:	5e                   	pop    %esi
 8f6:	5f                   	pop    %edi
 8f7:	5d                   	pop    %ebp
 8f8:	c3                   	ret    
 8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 900:	39 d0                	cmp    %edx,%eax
 902:	72 04                	jb     908 <free+0x58>
 904:	39 d1                	cmp    %edx,%ecx
 906:	72 ce                	jb     8d6 <free+0x26>
free(void *ap) {
 908:	89 d0                	mov    %edx,%eax
 90a:	eb bc                	jmp    8c8 <free+0x18>
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        bp->s.size += p->s.ptr->s.size;
 910:	03 72 04             	add    0x4(%edx),%esi
 913:	89 73 fc             	mov    %esi,-0x4(%ebx)
        bp->s.ptr = p->s.ptr->s.ptr;
 916:	8b 10                	mov    (%eax),%edx
 918:	8b 12                	mov    (%edx),%edx
 91a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    if (p + p->s.size == bp) {
 91d:	8b 50 04             	mov    0x4(%eax),%edx
 920:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 923:	39 f1                	cmp    %esi,%ecx
 925:	75 c6                	jne    8ed <free+0x3d>
        p->s.size += bp->s.size;
 927:	03 53 fc             	add    -0x4(%ebx),%edx
    freep = p;
 92a:	a3 84 11 00 00       	mov    %eax,0x1184
        p->s.size += bp->s.size;
 92f:	89 50 04             	mov    %edx,0x4(%eax)
        p->s.ptr = bp->s.ptr;
 932:	8b 53 f8             	mov    -0x8(%ebx),%edx
 935:	89 10                	mov    %edx,(%eax)
}
 937:	5b                   	pop    %ebx
 938:	5e                   	pop    %esi
 939:	5f                   	pop    %edi
 93a:	5d                   	pop    %ebp
 93b:	c3                   	ret    
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000940 <morecore>:

static Header*
morecore(uint nu, int pmalloced)
{
 940:	55                   	push   %ebp
    char *p;
    Header *hp;

    if(nu < 4096 && !pmalloced)
 941:	3d ff 0f 00 00       	cmp    $0xfff,%eax
{
 946:	89 e5                	mov    %esp,%ebp
 948:	56                   	push   %esi
 949:	53                   	push   %ebx
 94a:	89 c3                	mov    %eax,%ebx
    if(nu < 4096 && !pmalloced)
 94c:	77 52                	ja     9a0 <morecore+0x60>
 94e:	83 e2 01             	and    $0x1,%edx
 951:	75 4d                	jne    9a0 <morecore+0x60>
 953:	be 00 80 00 00       	mov    $0x8000,%esi
        nu = 4096;
 958:	bb 00 10 00 00       	mov    $0x1000,%ebx
    printf(1 , "enter morecore %d\n", nu);
 95d:	83 ec 04             	sub    $0x4,%esp
 960:	53                   	push   %ebx
 961:	68 05 0d 00 00       	push   $0xd05
 966:	6a 01                	push   $0x1
 968:	e8 73 fd ff ff       	call   6e0 <printf>
    p = sbrk(nu * sizeof(Header));
 96d:	89 34 24             	mov    %esi,(%esp)
 970:	e8 95 fc ff ff       	call   60a <sbrk>
    if(p == (char*)-1)
 975:	83 c4 10             	add    $0x10,%esp
 978:	83 f8 ff             	cmp    $0xffffffff,%eax
 97b:	74 33                	je     9b0 <morecore+0x70>
        return 0;
    hp = (Header*)p;
    hp->s.size = nu;
 97d:	89 58 04             	mov    %ebx,0x4(%eax)
    free((void*)(hp + 1));
 980:	83 ec 0c             	sub    $0xc,%esp
 983:	83 c0 08             	add    $0x8,%eax
 986:	50                   	push   %eax
 987:	e8 24 ff ff ff       	call   8b0 <free>
    return freep;
 98c:	a1 84 11 00 00       	mov    0x1184,%eax
 991:	83 c4 10             	add    $0x10,%esp
}
 994:	8d 65 f8             	lea    -0x8(%ebp),%esp
 997:	5b                   	pop    %ebx
 998:	5e                   	pop    %esi
 999:	5d                   	pop    %ebp
 99a:	c3                   	ret    
 99b:	90                   	nop
 99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9a0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9a7:	eb b4                	jmp    95d <morecore+0x1d>
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return 0;
 9b0:	31 c0                	xor    %eax,%eax
 9b2:	eb e0                	jmp    994 <morecore+0x54>
 9b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009c0 <malloc>:

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	57                   	push   %edi
 9c4:	56                   	push   %esi
 9c5:	53                   	push   %ebx
 9c6:	83 ec 10             	sub    $0x10,%esp
 9c9:	8b 75 08             	mov    0x8(%ebp),%esi
    Header *p, *prevp;
    uint nunits;
    printf(1, "nbytes:%d\n",nbytes);
 9cc:	56                   	push   %esi
 9cd:	68 18 0d 00 00       	push   $0xd18
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d2:	83 c6 07             	add    $0x7,%esi
    printf(1, "nbytes:%d\n",nbytes);
 9d5:	6a 01                	push   $0x1
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d7:	c1 ee 03             	shr    $0x3,%esi
 9da:	83 c6 01             	add    $0x1,%esi
    printf(1, "nbytes:%d\n",nbytes);
 9dd:	e8 fe fc ff ff       	call   6e0 <printf>
    if((prevp = freep) == 0){
 9e2:	8b 3d 84 11 00 00    	mov    0x1184,%edi
 9e8:	83 c4 10             	add    $0x10,%esp
 9eb:	85 ff                	test   %edi,%edi
 9ed:	0f 84 d5 00 00 00    	je     ac8 <malloc+0x108>
 9f3:	8b 1f                	mov    (%edi),%ebx
 9f5:	8b 53 04             	mov    0x4(%ebx),%edx
 9f8:	eb 0f                	jmp    a09 <malloc+0x49>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1,"prevp = freep == 0\n");
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	8b 03                	mov    (%ebx),%eax
        printf(1,"inside loop p->s.size = %d\n",p->s.size);
 a02:	89 df                	mov    %ebx,%edi
 a04:	8b 50 04             	mov    0x4(%eax),%edx
 a07:	89 c3                	mov    %eax,%ebx
 a09:	83 ec 04             	sub    $0x4,%esp
 a0c:	52                   	push   %edx
 a0d:	68 37 0d 00 00       	push   $0xd37
 a12:	6a 01                	push   $0x1
 a14:	e8 c7 fc ff ff       	call   6e0 <printf>
        if(p->s.size >= nunits){
 a19:	8b 43 04             	mov    0x4(%ebx),%eax
 a1c:	83 c4 10             	add    $0x10,%esp
 a1f:	39 f0                	cmp    %esi,%eax
 a21:	73 3d                	jae    a60 <malloc+0xa0>
            }
            printf(1,"returning p+1\n");
            freep = prevp;
            return (void*)(p + 1);
        }
        if(p == freep){
 a23:	39 1d 84 11 00 00    	cmp    %ebx,0x1184
 a29:	75 d5                	jne    a00 <malloc+0x40>
            printf(1, "calling morecore: 0x%x\n", p);
 a2b:	83 ec 04             	sub    $0x4,%esp
 a2e:	53                   	push   %ebx
 a2f:	68 9b 0d 00 00       	push   $0xd9b
 a34:	6a 01                	push   $0x1
 a36:	e8 a5 fc ff ff       	call   6e0 <printf>
            if((p = morecore(nunits,0)) == 0)
 a3b:	31 d2                	xor    %edx,%edx
 a3d:	89 f0                	mov    %esi,%eax
 a3f:	e8 fc fe ff ff       	call   940 <morecore>
 a44:	83 c4 10             	add    $0x10,%esp
 a47:	85 c0                	test   %eax,%eax
 a49:	89 c3                	mov    %eax,%ebx
 a4b:	75 b3                	jne    a00 <malloc+0x40>
                return 0;
    }}
}
 a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return 0;
 a50:	31 c0                	xor    %eax,%eax
}
 a52:	5b                   	pop    %ebx
 a53:	5e                   	pop    %esi
 a54:	5f                   	pop    %edi
 a55:	5d                   	pop    %ebp
 a56:	c3                   	ret    
 a57:	89 f6                	mov    %esi,%esi
 a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if(p->s.size == nunits){
 a60:	74 46                	je     aa8 <malloc+0xe8>
                printf(1,"p->s.size (%d) =! nunits(%d)\n",p->s.size,nunits);
 a62:	56                   	push   %esi
 a63:	50                   	push   %eax
 a64:	68 6e 0d 00 00       	push   $0xd6e
 a69:	6a 01                	push   $0x1
 a6b:	e8 70 fc ff ff       	call   6e0 <printf>
                p->s.size -= nunits;
 a70:	8b 43 04             	mov    0x4(%ebx),%eax
                p->s.size = nunits;
 a73:	83 c4 10             	add    $0x10,%esp
                p->s.size -= nunits;
 a76:	29 f0                	sub    %esi,%eax
 a78:	89 43 04             	mov    %eax,0x4(%ebx)
                p += p->s.size;
 a7b:	8d 1c c3             	lea    (%ebx,%eax,8),%ebx
                p->s.size = nunits;
 a7e:	89 73 04             	mov    %esi,0x4(%ebx)
            printf(1,"returning p+1\n");
 a81:	83 ec 08             	sub    $0x8,%esp
 a84:	68 8c 0d 00 00       	push   $0xd8c
 a89:	6a 01                	push   $0x1
 a8b:	e8 50 fc ff ff       	call   6e0 <printf>
            freep = prevp;
 a90:	89 3d 84 11 00 00    	mov    %edi,0x1184
            return (void*)(p + 1);
 a96:	83 c4 10             	add    $0x10,%esp
}
 a99:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return (void*)(p + 1);
 a9c:	8d 43 08             	lea    0x8(%ebx),%eax
}
 a9f:	5b                   	pop    %ebx
 aa0:	5e                   	pop    %esi
 aa1:	5f                   	pop    %edi
 aa2:	5d                   	pop    %ebp
 aa3:	c3                   	ret    
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(1,"p->s.size == nunits == %d\n",nunits);
 aa8:	83 ec 04             	sub    $0x4,%esp
 aab:	56                   	push   %esi
 aac:	68 53 0d 00 00       	push   $0xd53
 ab1:	6a 01                	push   $0x1
 ab3:	e8 28 fc ff ff       	call   6e0 <printf>
                prevp->s.ptr = p->s.ptr;}
 ab8:	8b 03                	mov    (%ebx),%eax
 aba:	83 c4 10             	add    $0x10,%esp
 abd:	89 07                	mov    %eax,(%edi)
 abf:	eb c0                	jmp    a81 <malloc+0xc1>
 ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1,"prevp = freep == 0\n");
 ac8:	83 ec 08             	sub    $0x8,%esp
        base.s.size = 0;
 acb:	bb 88 11 00 00       	mov    $0x1188,%ebx
        printf(1,"prevp = freep == 0\n");
 ad0:	68 23 0d 00 00       	push   $0xd23
 ad5:	6a 01                	push   $0x1
        base.s.ptr = freep = prevp = &base;
 ad7:	89 df                	mov    %ebx,%edi
        printf(1,"prevp = freep == 0\n");
 ad9:	e8 02 fc ff ff       	call   6e0 <printf>
        base.s.ptr = freep = prevp = &base;
 ade:	c7 05 84 11 00 00 88 	movl   $0x1188,0x1184
 ae5:	11 00 00 
 ae8:	c7 05 88 11 00 00 88 	movl   $0x1188,0x1188
 aef:	11 00 00 
        base.s.size = 0;
 af2:	83 c4 10             	add    $0x10,%esp
 af5:	c7 05 8c 11 00 00 00 	movl   $0x0,0x118c
 afc:	00 00 00 
 aff:	31 d2                	xor    %edx,%edx
 b01:	e9 03 ff ff ff       	jmp    a09 <malloc+0x49>
 b06:	8d 76 00             	lea    0x0(%esi),%esi
 b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b10 <pmalloc>:
void *
pmalloc(void) {
    Header *p, *prevp;
    uint nunits = 512;
    uint page_size = (4096 / 8) ;
    if ((prevp = freep) == 0) {
 b10:	8b 0d 84 11 00 00    	mov    0x1184,%ecx
pmalloc(void) {
 b16:	55                   	push   %ebp
 b17:	89 e5                	mov    %esp,%ebp
 b19:	56                   	push   %esi
 b1a:	53                   	push   %ebx
    if ((prevp = freep) == 0) {
 b1b:	85 c9                	test   %ecx,%ecx
 b1d:	0f 84 95 00 00 00    	je     bb8 <pmalloc+0xa8>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b23:	8b 19                	mov    (%ecx),%ebx
        if (p->s.size >= ((4096 / 8)*2)) {
 b25:	8b 53 04             	mov    0x4(%ebx),%edx
 b28:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 b2e:	76 1d                	jbe    b4d <pmalloc+0x3d>
 b30:	eb 3f                	jmp    b71 <pmalloc+0x61>
 b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b38:	8b 03                	mov    (%ebx),%eax
        if (p->s.size >= ((4096 / 8)*2)) {
 b3a:	8b 50 04             	mov    0x4(%eax),%edx
 b3d:	81 fa ff 03 00 00    	cmp    $0x3ff,%edx
 b43:	77 30                	ja     b75 <pmalloc+0x65>
 b45:	8b 0d 84 11 00 00    	mov    0x1184,%ecx
 b4b:	89 c3                	mov    %eax,%ebx


            freep = prevp;
            return (void *) (p + 1);
        }
            if (p == freep) {
 b4d:	39 cb                	cmp    %ecx,%ebx
 b4f:	75 e7                	jne    b38 <pmalloc+0x28>
                if ((p = morecore(nunits, 1)) == 0) {
 b51:	ba 01 00 00 00       	mov    $0x1,%edx
 b56:	b8 00 02 00 00       	mov    $0x200,%eax
 b5b:	e8 e0 fd ff ff       	call   940 <morecore>
 b60:	85 c0                	test   %eax,%eax
 b62:	89 c3                	mov    %eax,%ebx
 b64:	75 d2                	jne    b38 <pmalloc+0x28>
                    return 0;
                }
            }
        }
}
 b66:	8d 65 f8             	lea    -0x8(%ebp),%esp
                    return 0;
 b69:	31 f6                	xor    %esi,%esi
}
 b6b:	89 f0                	mov    %esi,%eax
 b6d:	5b                   	pop    %ebx
 b6e:	5e                   	pop    %esi
 b6f:	5d                   	pop    %ebp
 b70:	c3                   	ret    
        if (p->s.size >= ((4096 / 8)*2)) {
 b71:	89 d8                	mov    %ebx,%eax
 b73:	89 cb                	mov    %ecx,%ebx
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 b75:	81 e2 00 fe ff ff    	and    $0xfffffe00,%edx
            set_flag((uint) (p + 1), PTE_1, 1);
 b7b:	83 ec 04             	sub    $0x4,%esp
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 b7e:	81 ea 01 02 00 00    	sub    $0x201,%edx
            p += p->s.size;
 b84:	8d 34 d0             	lea    (%eax,%edx,8),%esi
            p->s.size =  (p->s.size / page_size -1 ) * page_size -1;
 b87:	89 50 04             	mov    %edx,0x4(%eax)
            set_flag((uint) (p + 1), PTE_1, 1);
 b8a:	83 c6 08             	add    $0x8,%esi
            p->s.size = nunits;
 b8d:	c7 46 fc 00 02 00 00 	movl   $0x200,-0x4(%esi)
            set_flag((uint) (p + 1), PTE_1, 1);
 b94:	6a 01                	push   $0x1
 b96:	68 00 04 00 00       	push   $0x400
 b9b:	56                   	push   %esi
 b9c:	e8 89 fa ff ff       	call   62a <set_flag>
            freep = prevp;
 ba1:	89 1d 84 11 00 00    	mov    %ebx,0x1184
            return (void *) (p + 1);
 ba7:	83 c4 10             	add    $0x10,%esp
}
 baa:	8d 65 f8             	lea    -0x8(%ebp),%esp
 bad:	89 f0                	mov    %esi,%eax
 baf:	5b                   	pop    %ebx
 bb0:	5e                   	pop    %esi
 bb1:	5d                   	pop    %ebp
 bb2:	c3                   	ret    
 bb3:	90                   	nop
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        base.s.size = 0;
 bb8:	b9 88 11 00 00       	mov    $0x1188,%ecx
        base.s.ptr = freep = prevp = &base;
 bbd:	c7 05 84 11 00 00 88 	movl   $0x1188,0x1184
 bc4:	11 00 00 
 bc7:	c7 05 88 11 00 00 88 	movl   $0x1188,0x1188
 bce:	11 00 00 
        base.s.size = 0;
 bd1:	c7 05 8c 11 00 00 00 	movl   $0x0,0x118c
 bd8:	00 00 00 
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 bdb:	89 cb                	mov    %ecx,%ebx
 bdd:	e9 6b ff ff ff       	jmp    b4d <pmalloc+0x3d>
 be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <protect_page>:
//    update_protected_pages(1);
//    set_flag((uint) ap, PTE_W, 0);
//    return 1;}

int
protect_page(void* ap){
 bf0:	55                   	push   %ebp
 bf1:	89 e5                	mov    %esp,%ebp
 bf3:	53                   	push   %ebx
 bf4:	83 ec 04             	sub    $0x4,%esp
 bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if((int)(ap-8) % PGSIZE != 0){
 bfa:	8d 43 f8             	lea    -0x8(%ebx),%eax
 bfd:	a9 ff 0f 00 00       	test   $0xfff,%eax
 c02:	75 3c                	jne    c40 <protect_page+0x50>
        return -1;
    }
    int flags = get_flags((uint)ap);
 c04:	83 ec 0c             	sub    $0xc,%esp
 c07:	53                   	push   %ebx
 c08:	e8 15 fa ff ff       	call   622 <get_flags>
    if (flags & PTE_1) {
 c0d:	83 c4 10             	add    $0x10,%esp
 c10:	f6 c4 04             	test   $0x4,%ah
 c13:	74 2b                	je     c40 <protect_page+0x50>
        set_flag((uint) ap, PTE_W, 0);
 c15:	83 ec 04             	sub    $0x4,%esp
 c18:	6a 00                	push   $0x0
 c1a:	6a 02                	push   $0x2
 c1c:	53                   	push   %ebx
 c1d:	e8 08 fa ff ff       	call   62a <set_flag>
        update_protected_pages(1);
 c22:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c29:	e8 04 fa ff ff       	call   632 <update_protected_pages>
        return 1;
 c2e:	83 c4 10             	add    $0x10,%esp
 c31:	b8 01 00 00 00       	mov    $0x1,%eax

    }
    return -1;
}
 c36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 c39:	c9                   	leave  
 c3a:	c3                   	ret    
 c3b:	90                   	nop
 c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
 c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c45:	eb ef                	jmp    c36 <protect_page+0x46>
 c47:	89 f6                	mov    %esi,%esi
 c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <pfree>:



int pfree(void *ap){
 c50:	55                   	push   %ebp
 c51:	89 e5                	mov    %esp,%ebp
 c53:	53                   	push   %ebx
 c54:	83 ec 10             	sub    $0x10,%esp
 c57:	8b 5d 08             	mov    0x8(%ebp),%ebx

    int flags = get_flags((uint) ap);
 c5a:	53                   	push   %ebx
 c5b:	e8 c2 f9 ff ff       	call   622 <get_flags>
    if (!(flags & PTE_W)) set_flag((uint) ap, PTE_W, 1);
 c60:	83 c4 10             	add    $0x10,%esp
 c63:	a8 02                	test   $0x2,%al
 c65:	75 31                	jne    c98 <pfree+0x48>
 c67:	83 ec 04             	sub    $0x4,%esp
 c6a:	6a 01                	push   $0x1
 c6c:	6a 02                	push   $0x2
 c6e:	53                   	push   %ebx
 c6f:	e8 b6 f9 ff ff       	call   62a <set_flag>
    else
        return -1;

    free(ap);
 c74:	89 1c 24             	mov    %ebx,(%esp)
 c77:	e8 34 fc ff ff       	call   8b0 <free>
    update_protected_pages(0);
 c7c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 c83:	e8 aa f9 ff ff       	call   632 <update_protected_pages>
    return 1;
 c88:	83 c4 10             	add    $0x10,%esp
 c8b:	b8 01 00 00 00       	mov    $0x1,%eax
 c90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 c93:	c9                   	leave  
 c94:	c3                   	ret    
 c95:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
 c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c9d:	eb f1                	jmp    c90 <pfree+0x40>
