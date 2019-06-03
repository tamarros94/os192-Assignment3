
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 d5 10 80       	mov    $0x8010d5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 90 35 10 80       	mov    $0x80103590,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 d5 10 80       	mov    $0x8010d5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 80 10 80       	push   $0x801080e0
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 45 4b 00 00       	call   80104ba0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 1d 11 80 bc 	movl   $0x80111cbc,0x80111d0c
80100062:	1c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 1d 11 80 bc 	movl   $0x80111cbc,0x80111d10
8010006c:	1c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 1c 11 80       	mov    $0x80111cbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 1c 11 80 	movl   $0x80111cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 80 10 80       	push   $0x801080e7
80100097:	50                   	push   %eax
80100098:	e8 f3 49 00 00       	call   80104a90 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 1d 11 80       	mov    0x80111d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 1d 11 80    	mov    %ebx,0x80111d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 1c 11 80       	cmp    $0x80111cbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 d5 10 80       	push   $0x8010d5c0
801000e4:	e8 a7 4b 00 00       	call   80104c90 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 1d 11 80    	mov    0x80111d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 1d 11 80    	mov    0x80111d0c,%ebx
80100126:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 d5 10 80       	push   $0x8010d5c0
80100162:	e8 49 4c 00 00       	call   80104db0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 49 00 00       	call   80104ad0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 26 00 00       	call   80102790 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ee 80 10 80       	push   $0x801080ee
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 bd 49 00 00       	call   80104b70 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 c7 25 00 00       	jmp    80102790 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 ff 80 10 80       	push   $0x801080ff
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 7c 49 00 00       	call   80104b70 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 49 00 00       	call   80104b30 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 80 4a 00 00       	call   80104c90 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 1d 11 80       	mov    0x80111d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 1c 11 80 	movl   $0x80111cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 1d 11 80       	mov    0x80111d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 1d 11 80    	mov    %ebx,0x80111d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 d5 10 80 	movl   $0x8010d5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 4f 4b 00 00       	jmp    80104db0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 81 10 80       	push   $0x80108106
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 4b 15 00 00       	call   801017d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 ff 49 00 00       	call   80104c90 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002a7:	39 15 a4 1f 11 80    	cmp    %edx,0x80111fa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 a0 1f 11 80       	push   $0x80111fa0
801002c5:	e8 86 43 00 00       	call   80104650 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 40 3c 00 00       	call   80103f20 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 bc 4a 00 00       	call   80104db0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 f4 13 00 00       	call   801016f0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 1f 11 80       	mov    %eax,0x80111fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 1f 11 80 	movsbl -0x7feee0e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 5e 4a 00 00       	call   80104db0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 96 13 00 00       	call   801016f0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 1f 11 80    	mov    %edx,0x80111fa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 72 2a 00 00       	call   80102e20 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 0d 81 10 80       	push   $0x8010810d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 52 87 10 80 	movl   $0x80108752,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 e3 47 00 00       	call   80104bc0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 21 81 10 80       	push   $0x80108121
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 b1 61 00 00       	call   801065f0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 ff 60 00 00       	call   801065f0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 f3 60 00 00       	call   801065f0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 e7 60 00 00       	call   801065f0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 97 49 00 00       	call   80104ec0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 ca 48 00 00       	call   80104e10 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 25 81 10 80       	push   $0x80108125
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 50 81 10 80 	movzbl -0x7fef7eb0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 bc 11 00 00       	call   801017d0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 70 46 00 00       	call   80104c90 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 64 47 00 00       	call   80104db0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 9b 10 00 00       	call   801016f0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 8c 46 00 00       	call   80104db0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 38 81 10 80       	mov    $0x80108138,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 9b 44 00 00       	call   80104c90 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 3f 81 10 80       	push   $0x8010813f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 68 44 00 00       	call   80104c90 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
80100856:	3b 05 a4 1f 11 80    	cmp    0x80111fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 1f 11 80       	mov    %eax,0x80111fa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 23 45 00 00       	call   80104db0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 1f 11 80    	sub    0x80111fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 1f 11 80    	mov    %edx,0x80111fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 1f 11 80    	mov    %cl,-0x7feee0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 1f 11 80       	mov    0x80111fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 1f 11 80    	cmp    %eax,0x80111fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 1f 11 80       	mov    %eax,0x80111fa4
          wakeup(&input.r);
80100911:	68 a0 1f 11 80       	push   $0x80111fa0
80100916:	e8 25 3f 00 00       	call   80104840 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
8010093d:	39 05 a4 1f 11 80    	cmp    %eax,0x80111fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 1f 11 80       	mov    %eax,0x80111fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
80100964:	3b 05 a4 1f 11 80    	cmp    0x80111fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 1f 11 80 0a 	cmpb   $0xa,-0x7feee0e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 b4 3f 00 00       	jmp    80104950 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 1f 11 80 0a 	movb   $0xa,-0x7feee0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 48 81 10 80       	push   $0x80108148
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 cb 41 00 00       	call   80104ba0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 29 11 80 00 	movl   $0x80100600,0x8011296c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 29 11 80 70 	movl   $0x80100270,0x80112968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 42 1f 00 00       	call   80102940 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 ff 34 00 00       	call   80103f20 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 64 28 00 00       	call   80103290 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 19 15 00 00       	call   80101f50 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 a3 0c 00 00       	call   801016f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 72 0f 00 00       	call   801019d0 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 11 0f 00 00       	call   80101980 <iunlockput>
    end_op();
80100a6f:	e8 8c 28 00 00       	call   80103300 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 97 70 00 00       	call   80107b30 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 e1 02 00 00    	je     80100da0 <exec+0x390>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 15 6e 00 00       	call   80107910 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 d3 69 00 00       	call   80107500 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 73 0e 00 00       	call   801019d0 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 39 6f 00 00       	call   80107ab0 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 e6 0d 00 00       	call   80101980 <iunlockput>
  end_op();
80100b9a:	e8 61 27 00 00       	call   80103300 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 61 6d 00 00       	call   80107910 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 ea 6e 00 00       	call   80107ab0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 28 27 00 00       	call   80103300 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 61 81 10 80       	push   $0x80108161
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 c5 6f 00 00       	call   80107bd0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 f2 43 00 00       	call   80105030 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 df 43 00 00       	call   80105030 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 4e 71 00 00       	call   80107db0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 e4 70 00 00       	call   80107db0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	8d 47 6c             	lea    0x6c(%edi),%eax
80100d07:	50                   	push   %eax
80100d08:	e8 e3 42 00 00       	call   80104ff0 <safestrcpy>
80100d0d:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100d13:	89 fa                	mov    %edi,%edx
80100d15:	8d 87 80 00 00 00    	lea    0x80(%edi),%eax
80100d1b:	81 c2 80 01 00 00    	add    $0x180,%edx
80100d21:	83 c4 10             	add    $0x10,%esp
80100d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(curproc->ram_monitor[j].used==1)
80100d28:	83 38 01             	cmpl   $0x1,(%eax)
80100d2b:	75 03                	jne    80100d30 <exec+0x320>
            curproc->ram_monitor[j].pgdir = pgdir;
80100d2d:	89 48 04             	mov    %ecx,0x4(%eax)
80100d30:	83 c0 10             	add    $0x10,%eax
    for (int j = 0; j < MAX_PYSC_PAGES; ++j) {
80100d33:	39 d0                	cmp    %edx,%eax
80100d35:	75 f1                	jne    80100d28 <exec+0x318>
80100d37:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100d3d:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100d43:	81 c2 80 02 00 00    	add    $0x280,%edx
80100d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(curproc->swap_monitor[j].used==1)
80100d50:	83 38 01             	cmpl   $0x1,(%eax)
80100d53:	75 03                	jne    80100d58 <exec+0x348>
            curproc->swap_monitor[j].pgdir = pgdir;
80100d55:	89 48 04             	mov    %ecx,0x4(%eax)
80100d58:	83 c0 10             	add    $0x10,%eax
    for (int j = 0; j < MAX_TOTAL_PAGES-MAX_PYSC_PAGES; ++j) {
80100d5b:	39 c2                	cmp    %eax,%edx
80100d5d:	75 f1                	jne    80100d50 <exec+0x340>
  oldpgdir = curproc->pgdir;
80100d5f:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  curproc->pgdir = pgdir;
80100d65:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  switchuvm(curproc);
80100d6b:	83 ec 0c             	sub    $0xc,%esp
  oldpgdir = curproc->pgdir;
80100d6e:	8b 79 04             	mov    0x4(%ecx),%edi
  curproc->sz = sz;
80100d71:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d73:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d76:	8b 41 18             	mov    0x18(%ecx),%eax
80100d79:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d7f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d82:	8b 41 18             	mov    0x18(%ecx),%eax
80100d85:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d88:	51                   	push   %ecx
80100d89:	e8 e2 65 00 00       	call   80107370 <switchuvm>
  freevm(oldpgdir);
80100d8e:	89 3c 24             	mov    %edi,(%esp)
80100d91:	e8 1a 6d 00 00       	call   80107ab0 <freevm>
  return 0;
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	31 c0                	xor    %eax,%eax
80100d9b:	e9 dc fc ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100da0:	be 00 20 00 00       	mov    $0x2000,%esi
80100da5:	e9 e7 fd ff ff       	jmp    80100b91 <exec+0x181>
80100daa:	66 90                	xchg   %ax,%ax
80100dac:	66 90                	xchg   %ax,%ax
80100dae:	66 90                	xchg   %ax,%ax

80100db0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100db0:	55                   	push   %ebp
80100db1:	89 e5                	mov    %esp,%ebp
80100db3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100db6:	68 6d 81 10 80       	push   $0x8010816d
80100dbb:	68 c0 1f 11 80       	push   $0x80111fc0
80100dc0:	e8 db 3d 00 00       	call   80104ba0 <initlock>
}
80100dc5:	83 c4 10             	add    $0x10,%esp
80100dc8:	c9                   	leave  
80100dc9:	c3                   	ret    
80100dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100dd0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dd4:	bb f4 1f 11 80       	mov    $0x80111ff4,%ebx
{
80100dd9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100ddc:	68 c0 1f 11 80       	push   $0x80111fc0
80100de1:	e8 aa 3e 00 00       	call   80104c90 <acquire>
80100de6:	83 c4 10             	add    $0x10,%esp
80100de9:	eb 10                	jmp    80100dfb <filealloc+0x2b>
80100deb:	90                   	nop
80100dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100df0:	83 c3 18             	add    $0x18,%ebx
80100df3:	81 fb 54 29 11 80    	cmp    $0x80112954,%ebx
80100df9:	73 25                	jae    80100e20 <filealloc+0x50>
    if(f->ref == 0){
80100dfb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dfe:	85 c0                	test   %eax,%eax
80100e00:	75 ee                	jne    80100df0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e02:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e05:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e0c:	68 c0 1f 11 80       	push   $0x80111fc0
80100e11:	e8 9a 3f 00 00       	call   80104db0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e16:	89 d8                	mov    %ebx,%eax
      return f;
80100e18:	83 c4 10             	add    $0x10,%esp
}
80100e1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e1e:	c9                   	leave  
80100e1f:	c3                   	ret    
  release(&ftable.lock);
80100e20:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e23:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e25:	68 c0 1f 11 80       	push   $0x80111fc0
80100e2a:	e8 81 3f 00 00       	call   80104db0 <release>
}
80100e2f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e31:	83 c4 10             	add    $0x10,%esp
}
80100e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e37:	c9                   	leave  
80100e38:	c3                   	ret    
80100e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e40 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
80100e44:	83 ec 10             	sub    $0x10,%esp
80100e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e4a:	68 c0 1f 11 80       	push   $0x80111fc0
80100e4f:	e8 3c 3e 00 00       	call   80104c90 <acquire>
  if(f->ref < 1)
80100e54:	8b 43 04             	mov    0x4(%ebx),%eax
80100e57:	83 c4 10             	add    $0x10,%esp
80100e5a:	85 c0                	test   %eax,%eax
80100e5c:	7e 1a                	jle    80100e78 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e5e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e61:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e64:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e67:	68 c0 1f 11 80       	push   $0x80111fc0
80100e6c:	e8 3f 3f 00 00       	call   80104db0 <release>
  return f;
}
80100e71:	89 d8                	mov    %ebx,%eax
80100e73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e76:	c9                   	leave  
80100e77:	c3                   	ret    
    panic("filedup");
80100e78:	83 ec 0c             	sub    $0xc,%esp
80100e7b:	68 74 81 10 80       	push   $0x80108174
80100e80:	e8 0b f5 ff ff       	call   80100390 <panic>
80100e85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e90 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e90:	55                   	push   %ebp
80100e91:	89 e5                	mov    %esp,%ebp
80100e93:	57                   	push   %edi
80100e94:	56                   	push   %esi
80100e95:	53                   	push   %ebx
80100e96:	83 ec 28             	sub    $0x28,%esp
80100e99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e9c:	68 c0 1f 11 80       	push   $0x80111fc0
80100ea1:	e8 ea 3d 00 00       	call   80104c90 <acquire>
  if(f->ref < 1)
80100ea6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ea9:	83 c4 10             	add    $0x10,%esp
80100eac:	85 c0                	test   %eax,%eax
80100eae:	0f 8e 9b 00 00 00    	jle    80100f4f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100eb4:	83 e8 01             	sub    $0x1,%eax
80100eb7:	85 c0                	test   %eax,%eax
80100eb9:	89 43 04             	mov    %eax,0x4(%ebx)
80100ebc:	74 1a                	je     80100ed8 <fileclose+0x48>
    release(&ftable.lock);
80100ebe:	c7 45 08 c0 1f 11 80 	movl   $0x80111fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100ec5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec8:	5b                   	pop    %ebx
80100ec9:	5e                   	pop    %esi
80100eca:	5f                   	pop    %edi
80100ecb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100ecc:	e9 df 3e 00 00       	jmp    80104db0 <release>
80100ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100ed8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100edc:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100ede:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ee1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ee4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eea:	88 45 e7             	mov    %al,-0x19(%ebp)
80100eed:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ef0:	68 c0 1f 11 80       	push   $0x80111fc0
  ff = *f;
80100ef5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ef8:	e8 b3 3e 00 00       	call   80104db0 <release>
  if(ff.type == FD_PIPE)
80100efd:	83 c4 10             	add    $0x10,%esp
80100f00:	83 ff 01             	cmp    $0x1,%edi
80100f03:	74 13                	je     80100f18 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f05:	83 ff 02             	cmp    $0x2,%edi
80100f08:	74 26                	je     80100f30 <fileclose+0xa0>
}
80100f0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f0d:	5b                   	pop    %ebx
80100f0e:	5e                   	pop    %esi
80100f0f:	5f                   	pop    %edi
80100f10:	5d                   	pop    %ebp
80100f11:	c3                   	ret    
80100f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f18:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f1c:	83 ec 08             	sub    $0x8,%esp
80100f1f:	53                   	push   %ebx
80100f20:	56                   	push   %esi
80100f21:	e8 1a 2b 00 00       	call   80103a40 <pipeclose>
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	eb df                	jmp    80100f0a <fileclose+0x7a>
80100f2b:	90                   	nop
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f30:	e8 5b 23 00 00       	call   80103290 <begin_op>
    iput(ff.ip);
80100f35:	83 ec 0c             	sub    $0xc,%esp
80100f38:	ff 75 e0             	pushl  -0x20(%ebp)
80100f3b:	e8 e0 08 00 00       	call   80101820 <iput>
    end_op();
80100f40:	83 c4 10             	add    $0x10,%esp
}
80100f43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f46:	5b                   	pop    %ebx
80100f47:	5e                   	pop    %esi
80100f48:	5f                   	pop    %edi
80100f49:	5d                   	pop    %ebp
    end_op();
80100f4a:	e9 b1 23 00 00       	jmp    80103300 <end_op>
    panic("fileclose");
80100f4f:	83 ec 0c             	sub    $0xc,%esp
80100f52:	68 7c 81 10 80       	push   $0x8010817c
80100f57:	e8 34 f4 ff ff       	call   80100390 <panic>
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f60 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	53                   	push   %ebx
80100f64:	83 ec 04             	sub    $0x4,%esp
80100f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f6a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f6d:	75 31                	jne    80100fa0 <filestat+0x40>
    ilock(f->ip);
80100f6f:	83 ec 0c             	sub    $0xc,%esp
80100f72:	ff 73 10             	pushl  0x10(%ebx)
80100f75:	e8 76 07 00 00       	call   801016f0 <ilock>
    stati(f->ip, st);
80100f7a:	58                   	pop    %eax
80100f7b:	5a                   	pop    %edx
80100f7c:	ff 75 0c             	pushl  0xc(%ebp)
80100f7f:	ff 73 10             	pushl  0x10(%ebx)
80100f82:	e8 19 0a 00 00       	call   801019a0 <stati>
    iunlock(f->ip);
80100f87:	59                   	pop    %ecx
80100f88:	ff 73 10             	pushl  0x10(%ebx)
80100f8b:	e8 40 08 00 00       	call   801017d0 <iunlock>
    return 0;
80100f90:	83 c4 10             	add    $0x10,%esp
80100f93:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fa5:	eb ee                	jmp    80100f95 <filestat+0x35>
80100fa7:	89 f6                	mov    %esi,%esi
80100fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fb0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	57                   	push   %edi
80100fb4:	56                   	push   %esi
80100fb5:	53                   	push   %ebx
80100fb6:	83 ec 0c             	sub    $0xc,%esp
80100fb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fbc:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fbf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fc2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fc6:	74 60                	je     80101028 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fc8:	8b 03                	mov    (%ebx),%eax
80100fca:	83 f8 01             	cmp    $0x1,%eax
80100fcd:	74 41                	je     80101010 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fcf:	83 f8 02             	cmp    $0x2,%eax
80100fd2:	75 5b                	jne    8010102f <fileread+0x7f>
    ilock(f->ip);
80100fd4:	83 ec 0c             	sub    $0xc,%esp
80100fd7:	ff 73 10             	pushl  0x10(%ebx)
80100fda:	e8 11 07 00 00       	call   801016f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fdf:	57                   	push   %edi
80100fe0:	ff 73 14             	pushl  0x14(%ebx)
80100fe3:	56                   	push   %esi
80100fe4:	ff 73 10             	pushl  0x10(%ebx)
80100fe7:	e8 e4 09 00 00       	call   801019d0 <readi>
80100fec:	83 c4 20             	add    $0x20,%esp
80100fef:	85 c0                	test   %eax,%eax
80100ff1:	89 c6                	mov    %eax,%esi
80100ff3:	7e 03                	jle    80100ff8 <fileread+0x48>
      f->off += r;
80100ff5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100ff8:	83 ec 0c             	sub    $0xc,%esp
80100ffb:	ff 73 10             	pushl  0x10(%ebx)
80100ffe:	e8 cd 07 00 00       	call   801017d0 <iunlock>
    return r;
80101003:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101006:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101009:	89 f0                	mov    %esi,%eax
8010100b:	5b                   	pop    %ebx
8010100c:	5e                   	pop    %esi
8010100d:	5f                   	pop    %edi
8010100e:	5d                   	pop    %ebp
8010100f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101010:	8b 43 0c             	mov    0xc(%ebx),%eax
80101013:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101016:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101019:	5b                   	pop    %ebx
8010101a:	5e                   	pop    %esi
8010101b:	5f                   	pop    %edi
8010101c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010101d:	e9 ce 2b 00 00       	jmp    80103bf0 <piperead>
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101028:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010102d:	eb d7                	jmp    80101006 <fileread+0x56>
  panic("fileread");
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	68 86 81 10 80       	push   $0x80108186
80101037:	e8 54 f3 ff ff       	call   80100390 <panic>
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101040 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	57                   	push   %edi
80101044:	56                   	push   %esi
80101045:	53                   	push   %ebx
80101046:	83 ec 1c             	sub    $0x1c,%esp
80101049:	8b 75 08             	mov    0x8(%ebp),%esi
8010104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010104f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101053:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101056:	8b 45 10             	mov    0x10(%ebp),%eax
80101059:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010105c:	0f 84 aa 00 00 00    	je     8010110c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101062:	8b 06                	mov    (%esi),%eax
80101064:	83 f8 01             	cmp    $0x1,%eax
80101067:	0f 84 c3 00 00 00    	je     80101130 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010106d:	83 f8 02             	cmp    $0x2,%eax
80101070:	0f 85 d9 00 00 00    	jne    8010114f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101076:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    int i = 0;
80101079:	31 ff                	xor    %edi,%edi
    while(i < n){
8010107b:	85 c9                	test   %ecx,%ecx
8010107d:	7f 34                	jg     801010b3 <filewrite+0x73>
8010107f:	e9 9c 00 00 00       	jmp    80101120 <filewrite+0xe0>
80101084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101088:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010108b:	83 ec 0c             	sub    $0xc,%esp
8010108e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101091:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101094:	e8 37 07 00 00       	call   801017d0 <iunlock>
      end_op();
80101099:	e8 62 22 00 00       	call   80103300 <end_op>
8010109e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801010a4:	39 c3                	cmp    %eax,%ebx
801010a6:	0f 85 96 00 00 00    	jne    80101142 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801010ac:	01 df                	add    %ebx,%edi
    while(i < n){
801010ae:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010b1:	7e 6d                	jle    80101120 <filewrite+0xe0>
      int n1 = n - i;
801010b3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010b6:	b8 00 06 00 00       	mov    $0x600,%eax
801010bb:	29 fb                	sub    %edi,%ebx
801010bd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010c3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010c6:	e8 c5 21 00 00       	call   80103290 <begin_op>
      ilock(f->ip);
801010cb:	83 ec 0c             	sub    $0xc,%esp
801010ce:	ff 76 10             	pushl  0x10(%esi)
801010d1:	e8 1a 06 00 00       	call   801016f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010d9:	53                   	push   %ebx
801010da:	ff 76 14             	pushl  0x14(%esi)
801010dd:	01 f8                	add    %edi,%eax
801010df:	50                   	push   %eax
801010e0:	ff 76 10             	pushl  0x10(%esi)
801010e3:	e8 e8 09 00 00       	call   80101ad0 <writei>
801010e8:	83 c4 20             	add    $0x20,%esp
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 99                	jg     80101088 <filewrite+0x48>
      iunlock(f->ip);
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	ff 76 10             	pushl  0x10(%esi)
801010f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010f8:	e8 d3 06 00 00       	call   801017d0 <iunlock>
      end_op();
801010fd:	e8 fe 21 00 00       	call   80103300 <end_op>
      if(r < 0)
80101102:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101105:	83 c4 10             	add    $0x10,%esp
80101108:	85 c0                	test   %eax,%eax
8010110a:	74 98                	je     801010a4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
    cprintf("type:%d\n", f->type);
    panic("filewrite");
}
8010110c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010110f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101114:	89 f8                	mov    %edi,%eax
80101116:	5b                   	pop    %ebx
80101117:	5e                   	pop    %esi
80101118:	5f                   	pop    %edi
80101119:	5d                   	pop    %ebp
8010111a:	c3                   	ret    
8010111b:	90                   	nop
8010111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101120:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101123:	75 e7                	jne    8010110c <filewrite+0xcc>
}
80101125:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101128:	89 f8                	mov    %edi,%eax
8010112a:	5b                   	pop    %ebx
8010112b:	5e                   	pop    %esi
8010112c:	5f                   	pop    %edi
8010112d:	5d                   	pop    %ebp
8010112e:	c3                   	ret    
8010112f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101130:	8b 46 0c             	mov    0xc(%esi),%eax
80101133:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101136:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101139:	5b                   	pop    %ebx
8010113a:	5e                   	pop    %esi
8010113b:	5f                   	pop    %edi
8010113c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010113d:	e9 9e 29 00 00       	jmp    80103ae0 <pipewrite>
        panic("short filewrite");
80101142:	83 ec 0c             	sub    $0xc,%esp
80101145:	68 8f 81 10 80       	push   $0x8010818f
8010114a:	e8 41 f2 ff ff       	call   80100390 <panic>
    cprintf("type:%d\n", f->type);
8010114f:	52                   	push   %edx
80101150:	52                   	push   %edx
80101151:	50                   	push   %eax
80101152:	68 9f 81 10 80       	push   $0x8010819f
80101157:	e8 04 f5 ff ff       	call   80100660 <cprintf>
    panic("filewrite");
8010115c:	c7 04 24 95 81 10 80 	movl   $0x80108195,(%esp)
80101163:	e8 28 f2 ff ff       	call   80100390 <panic>
80101168:	66 90                	xchg   %ax,%ax
8010116a:	66 90                	xchg   %ax,%ax
8010116c:	66 90                	xchg   %ax,%ax
8010116e:	66 90                	xchg   %ax,%ax

80101170 <balloc>:

// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev) {
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 1c             	sub    $0x1c,%esp
    int b, bi, m;
    struct buf *bp;

    bp = 0;
    for (b = 0; b < sb.size; b += BPB) {
80101179:	8b 0d c0 29 11 80    	mov    0x801129c0,%ecx
balloc(uint dev) {
8010117f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (b = 0; b < sb.size; b += BPB) {
80101182:	85 c9                	test   %ecx,%ecx
80101184:	0f 84 87 00 00 00    	je     80101211 <balloc+0xa1>
8010118a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
        bp = bread(dev, BBLOCK(b, sb));
80101191:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101194:	83 ec 08             	sub    $0x8,%esp
80101197:	89 f0                	mov    %esi,%eax
80101199:	c1 f8 0c             	sar    $0xc,%eax
8010119c:	03 05 d8 29 11 80    	add    0x801129d8,%eax
801011a2:	50                   	push   %eax
801011a3:	ff 75 d8             	pushl  -0x28(%ebp)
801011a6:	e8 25 ef ff ff       	call   801000d0 <bread>
801011ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
801011ae:	a1 c0 29 11 80       	mov    0x801129c0,%eax
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011b9:	31 c0                	xor    %eax,%eax
801011bb:	eb 2f                	jmp    801011ec <balloc+0x7c>
801011bd:	8d 76 00             	lea    0x0(%esi),%esi
            m = 1 << (bi % 8);
801011c0:	89 c1                	mov    %eax,%ecx
            if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
801011c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            m = 1 << (bi % 8);
801011c5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011ca:	83 e1 07             	and    $0x7,%ecx
801011cd:	d3 e3                	shl    %cl,%ebx
            if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
801011cf:	89 c1                	mov    %eax,%ecx
801011d1:	c1 f9 03             	sar    $0x3,%ecx
801011d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011d9:	85 df                	test   %ebx,%edi
801011db:	89 fa                	mov    %edi,%edx
801011dd:	74 41                	je     80101220 <balloc+0xb0>
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
801011df:	83 c0 01             	add    $0x1,%eax
801011e2:	83 c6 01             	add    $0x1,%esi
801011e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011ea:	74 05                	je     801011f1 <balloc+0x81>
801011ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ef:	77 cf                	ja     801011c0 <balloc+0x50>
                brelse(bp);
                bzero(dev, b + bi);
                return b + bi;
            }
        }
        brelse(bp);
801011f1:	83 ec 0c             	sub    $0xc,%esp
801011f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801011f7:	e8 e4 ef ff ff       	call   801001e0 <brelse>
    for (b = 0; b < sb.size; b += BPB) {
801011fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101203:	83 c4 10             	add    $0x10,%esp
80101206:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101209:	39 05 c0 29 11 80    	cmp    %eax,0x801129c0
8010120f:	77 80                	ja     80101191 <balloc+0x21>
    }
    panic("balloc: out of blocks");
80101211:	83 ec 0c             	sub    $0xc,%esp
80101214:	68 a8 81 10 80       	push   $0x801081a8
80101219:	e8 72 f1 ff ff       	call   80100390 <panic>
8010121e:	66 90                	xchg   %ax,%ax
                bp->data[bi / 8] |= m;  // Mark block in use.
80101220:	8b 7d e4             	mov    -0x1c(%ebp),%edi
                log_write(bp);
80101223:	83 ec 0c             	sub    $0xc,%esp
                bp->data[bi / 8] |= m;  // Mark block in use.
80101226:	09 da                	or     %ebx,%edx
80101228:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
                log_write(bp);
8010122c:	57                   	push   %edi
8010122d:	e8 2e 22 00 00       	call   80103460 <log_write>
                brelse(bp);
80101232:	89 3c 24             	mov    %edi,(%esp)
80101235:	e8 a6 ef ff ff       	call   801001e0 <brelse>
    bp = bread(dev, bno);
8010123a:	58                   	pop    %eax
8010123b:	5a                   	pop    %edx
8010123c:	56                   	push   %esi
8010123d:	ff 75 d8             	pushl  -0x28(%ebp)
80101240:	e8 8b ee ff ff       	call   801000d0 <bread>
80101245:	89 c3                	mov    %eax,%ebx
    memset(bp->data, 0, BSIZE);
80101247:	8d 40 5c             	lea    0x5c(%eax),%eax
8010124a:	83 c4 0c             	add    $0xc,%esp
8010124d:	68 00 02 00 00       	push   $0x200
80101252:	6a 00                	push   $0x0
80101254:	50                   	push   %eax
80101255:	e8 b6 3b 00 00       	call   80104e10 <memset>
    log_write(bp);
8010125a:	89 1c 24             	mov    %ebx,(%esp)
8010125d:	e8 fe 21 00 00       	call   80103460 <log_write>
    brelse(bp);
80101262:	89 1c 24             	mov    %ebx,(%esp)
80101265:	e8 76 ef ff ff       	call   801001e0 <brelse>
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	89 f0                	mov    %esi,%eax
8010126f:	5b                   	pop    %ebx
80101270:	5e                   	pop    %esi
80101271:	5f                   	pop    %edi
80101272:	5d                   	pop    %ebp
80101273:	c3                   	ret    
80101274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010127a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101280 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode *
iget(uint dev, uint inum) {
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	89 c7                	mov    %eax,%edi
    struct inode *ip, *empty;

    acquire(&icache.lock);

    // Is the inode already cached?
    empty = 0;
80101288:	31 f6                	xor    %esi,%esi
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++) {
8010128a:	bb 14 2a 11 80       	mov    $0x80112a14,%ebx
iget(uint dev, uint inum) {
8010128f:	83 ec 28             	sub    $0x28,%esp
80101292:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    acquire(&icache.lock);
80101295:	68 e0 29 11 80       	push   $0x801129e0
8010129a:	e8 f1 39 00 00       	call   80104c90 <acquire>
8010129f:	83 c4 10             	add    $0x10,%esp
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++) {
801012a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012a5:	eb 17                	jmp    801012be <iget+0x3e>
801012a7:	89 f6                	mov    %esi,%esi
801012a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012b0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012b6:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
801012bc:	73 22                	jae    801012e0 <iget+0x60>
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
801012be:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012c1:	85 c9                	test   %ecx,%ecx
801012c3:	7e 04                	jle    801012c9 <iget+0x49>
801012c5:	39 3b                	cmp    %edi,(%ebx)
801012c7:	74 4f                	je     80101318 <iget+0x98>
            ip->ref++;
            release(&icache.lock);
            return ip;
        }
        if (empty == 0 && ip->ref == 0)    // Remember empty slot.
801012c9:	85 f6                	test   %esi,%esi
801012cb:	75 e3                	jne    801012b0 <iget+0x30>
801012cd:	85 c9                	test   %ecx,%ecx
801012cf:	0f 44 f3             	cmove  %ebx,%esi
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++) {
801012d2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012d8:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
801012de:	72 de                	jb     801012be <iget+0x3e>
            empty = ip;
    }

    // Recycle an inode cache entry.
    if (empty == 0)
801012e0:	85 f6                	test   %esi,%esi
801012e2:	74 5b                	je     8010133f <iget+0xbf>
    ip = empty;
    ip->dev = dev;
    ip->inum = inum;
    ip->ref = 1;
    ip->valid = 0;
    release(&icache.lock);
801012e4:	83 ec 0c             	sub    $0xc,%esp
    ip->dev = dev;
801012e7:	89 3e                	mov    %edi,(%esi)
    ip->inum = inum;
801012e9:	89 56 04             	mov    %edx,0x4(%esi)
    ip->ref = 1;
801012ec:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
    ip->valid = 0;
801012f3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
    release(&icache.lock);
801012fa:	68 e0 29 11 80       	push   $0x801129e0
801012ff:	e8 ac 3a 00 00       	call   80104db0 <release>

    return ip;
80101304:	83 c4 10             	add    $0x10,%esp
}
80101307:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130a:	89 f0                	mov    %esi,%eax
8010130c:	5b                   	pop    %ebx
8010130d:	5e                   	pop    %esi
8010130e:	5f                   	pop    %edi
8010130f:	5d                   	pop    %ebp
80101310:	c3                   	ret    
80101311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
80101318:	39 53 04             	cmp    %edx,0x4(%ebx)
8010131b:	75 ac                	jne    801012c9 <iget+0x49>
            release(&icache.lock);
8010131d:	83 ec 0c             	sub    $0xc,%esp
            ip->ref++;
80101320:	83 c1 01             	add    $0x1,%ecx
            return ip;
80101323:	89 de                	mov    %ebx,%esi
            release(&icache.lock);
80101325:	68 e0 29 11 80       	push   $0x801129e0
            ip->ref++;
8010132a:	89 4b 08             	mov    %ecx,0x8(%ebx)
            release(&icache.lock);
8010132d:	e8 7e 3a 00 00       	call   80104db0 <release>
            return ip;
80101332:	83 c4 10             	add    $0x10,%esp
}
80101335:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101338:	89 f0                	mov    %esi,%eax
8010133a:	5b                   	pop    %ebx
8010133b:	5e                   	pop    %esi
8010133c:	5f                   	pop    %edi
8010133d:	5d                   	pop    %ebp
8010133e:	c3                   	ret    
        panic("iget: no inodes");
8010133f:	83 ec 0c             	sub    $0xc,%esp
80101342:	68 be 81 10 80       	push   $0x801081be
80101347:	e8 44 f0 ff ff       	call   80100390 <panic>
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101350 <bmap>:
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn) {
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	89 c6                	mov    %eax,%esi
80101358:	83 ec 1c             	sub    $0x1c,%esp
    uint addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) {
8010135b:	83 fa 0b             	cmp    $0xb,%edx
8010135e:	77 18                	ja     80101378 <bmap+0x28>
80101360:	8d 3c 90             	lea    (%eax,%edx,4),%edi
        if ((addr = ip->addrs[bn]) == 0)
80101363:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101366:	85 db                	test   %ebx,%ebx
80101368:	74 76                	je     801013e0 <bmap+0x90>
        brelse(bp);
        return addr;
    }

    panic("bmap: out of range");
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	89 d8                	mov    %ebx,%eax
8010136f:	5b                   	pop    %ebx
80101370:	5e                   	pop    %esi
80101371:	5f                   	pop    %edi
80101372:	5d                   	pop    %ebp
80101373:	c3                   	ret    
80101374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bn -= NDIRECT;
80101378:	8d 5a f4             	lea    -0xc(%edx),%ebx
    if (bn < NINDIRECT) {
8010137b:	83 fb 7f             	cmp    $0x7f,%ebx
8010137e:	0f 87 90 00 00 00    	ja     80101414 <bmap+0xc4>
        if ((addr = ip->addrs[NDIRECT]) == 0)
80101384:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010138a:	8b 00                	mov    (%eax),%eax
8010138c:	85 d2                	test   %edx,%edx
8010138e:	74 70                	je     80101400 <bmap+0xb0>
        bp = bread(ip->dev, addr);
80101390:	83 ec 08             	sub    $0x8,%esp
80101393:	52                   	push   %edx
80101394:	50                   	push   %eax
80101395:	e8 36 ed ff ff       	call   801000d0 <bread>
        if ((addr = a[bn]) == 0) {
8010139a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010139e:	83 c4 10             	add    $0x10,%esp
        bp = bread(ip->dev, addr);
801013a1:	89 c7                	mov    %eax,%edi
        if ((addr = a[bn]) == 0) {
801013a3:	8b 1a                	mov    (%edx),%ebx
801013a5:	85 db                	test   %ebx,%ebx
801013a7:	75 1d                	jne    801013c6 <bmap+0x76>
            a[bn] = addr = balloc(ip->dev);
801013a9:	8b 06                	mov    (%esi),%eax
801013ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013ae:	e8 bd fd ff ff       	call   80101170 <balloc>
801013b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            log_write(bp);
801013b6:	83 ec 0c             	sub    $0xc,%esp
            a[bn] = addr = balloc(ip->dev);
801013b9:	89 c3                	mov    %eax,%ebx
801013bb:	89 02                	mov    %eax,(%edx)
            log_write(bp);
801013bd:	57                   	push   %edi
801013be:	e8 9d 20 00 00       	call   80103460 <log_write>
801013c3:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801013c6:	83 ec 0c             	sub    $0xc,%esp
801013c9:	57                   	push   %edi
801013ca:	e8 11 ee ff ff       	call   801001e0 <brelse>
801013cf:	83 c4 10             	add    $0x10,%esp
}
801013d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013d5:	89 d8                	mov    %ebx,%eax
801013d7:	5b                   	pop    %ebx
801013d8:	5e                   	pop    %esi
801013d9:	5f                   	pop    %edi
801013da:	5d                   	pop    %ebp
801013db:	c3                   	ret    
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 00                	mov    (%eax),%eax
801013e2:	e8 89 fd ff ff       	call   80101170 <balloc>
801013e7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801013ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
            ip->addrs[bn] = addr = balloc(ip->dev);
801013ed:	89 c3                	mov    %eax,%ebx
}
801013ef:	89 d8                	mov    %ebx,%eax
801013f1:	5b                   	pop    %ebx
801013f2:	5e                   	pop    %esi
801013f3:	5f                   	pop    %edi
801013f4:	5d                   	pop    %ebp
801013f5:	c3                   	ret    
801013f6:	8d 76 00             	lea    0x0(%esi),%esi
801013f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101400:	e8 6b fd ff ff       	call   80101170 <balloc>
80101405:	89 c2                	mov    %eax,%edx
80101407:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010140d:	8b 06                	mov    (%esi),%eax
8010140f:	e9 7c ff ff ff       	jmp    80101390 <bmap+0x40>
    panic("bmap: out of range");
80101414:	83 ec 0c             	sub    $0xc,%esp
80101417:	68 ce 81 10 80       	push   $0x801081ce
8010141c:	e8 6f ef ff ff       	call   80100390 <panic>
80101421:	eb 0d                	jmp    80101430 <readsb>
80101423:	90                   	nop
80101424:	90                   	nop
80101425:	90                   	nop
80101426:	90                   	nop
80101427:	90                   	nop
80101428:	90                   	nop
80101429:	90                   	nop
8010142a:	90                   	nop
8010142b:	90                   	nop
8010142c:	90                   	nop
8010142d:	90                   	nop
8010142e:	90                   	nop
8010142f:	90                   	nop

80101430 <readsb>:
readsb(int dev, struct superblock *sb) {
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	56                   	push   %esi
80101434:	53                   	push   %ebx
80101435:	8b 75 0c             	mov    0xc(%ebp),%esi
    bp = bread(dev, 1);
80101438:	83 ec 08             	sub    $0x8,%esp
8010143b:	6a 01                	push   $0x1
8010143d:	ff 75 08             	pushl  0x8(%ebp)
80101440:	e8 8b ec ff ff       	call   801000d0 <bread>
80101445:	89 c3                	mov    %eax,%ebx
    memmove(sb, bp->data, sizeof(*sb));
80101447:	8d 40 5c             	lea    0x5c(%eax),%eax
8010144a:	83 c4 0c             	add    $0xc,%esp
8010144d:	6a 1c                	push   $0x1c
8010144f:	50                   	push   %eax
80101450:	56                   	push   %esi
80101451:	e8 6a 3a 00 00       	call   80104ec0 <memmove>
    brelse(bp);
80101456:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101459:	83 c4 10             	add    $0x10,%esp
}
8010145c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145f:	5b                   	pop    %ebx
80101460:	5e                   	pop    %esi
80101461:	5d                   	pop    %ebp
    brelse(bp);
80101462:	e9 79 ed ff ff       	jmp    801001e0 <brelse>
80101467:	89 f6                	mov    %esi,%esi
80101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101470 <bfree>:
bfree(int dev, uint b) {
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	56                   	push   %esi
80101474:	53                   	push   %ebx
80101475:	89 d3                	mov    %edx,%ebx
80101477:	89 c6                	mov    %eax,%esi
    readsb(dev, &sb);
80101479:	83 ec 08             	sub    $0x8,%esp
8010147c:	68 c0 29 11 80       	push   $0x801129c0
80101481:	50                   	push   %eax
80101482:	e8 a9 ff ff ff       	call   80101430 <readsb>
    bp = bread(dev, BBLOCK(b, sb));
80101487:	58                   	pop    %eax
80101488:	5a                   	pop    %edx
80101489:	89 da                	mov    %ebx,%edx
8010148b:	c1 ea 0c             	shr    $0xc,%edx
8010148e:	03 15 d8 29 11 80    	add    0x801129d8,%edx
80101494:	52                   	push   %edx
80101495:	56                   	push   %esi
80101496:	e8 35 ec ff ff       	call   801000d0 <bread>
    m = 1 << (bi % 8);
8010149b:	89 d9                	mov    %ebx,%ecx
    if ((bp->data[bi / 8] & m) == 0)
8010149d:	c1 fb 03             	sar    $0x3,%ebx
    m = 1 << (bi % 8);
801014a0:	ba 01 00 00 00       	mov    $0x1,%edx
801014a5:	83 e1 07             	and    $0x7,%ecx
    if ((bp->data[bi / 8] & m) == 0)
801014a8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801014ae:	83 c4 10             	add    $0x10,%esp
    m = 1 << (bi % 8);
801014b1:	d3 e2                	shl    %cl,%edx
    if ((bp->data[bi / 8] & m) == 0)
801014b3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801014b8:	85 d1                	test   %edx,%ecx
801014ba:	74 25                	je     801014e1 <bfree+0x71>
    bp->data[bi / 8] &= ~m;
801014bc:	f7 d2                	not    %edx
801014be:	89 c6                	mov    %eax,%esi
    log_write(bp);
801014c0:	83 ec 0c             	sub    $0xc,%esp
    bp->data[bi / 8] &= ~m;
801014c3:	21 ca                	and    %ecx,%edx
801014c5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
    log_write(bp);
801014c9:	56                   	push   %esi
801014ca:	e8 91 1f 00 00       	call   80103460 <log_write>
    brelse(bp);
801014cf:	89 34 24             	mov    %esi,(%esp)
801014d2:	e8 09 ed ff ff       	call   801001e0 <brelse>
}
801014d7:	83 c4 10             	add    $0x10,%esp
801014da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014dd:	5b                   	pop    %ebx
801014de:	5e                   	pop    %esi
801014df:	5d                   	pop    %ebp
801014e0:	c3                   	ret    
        panic("freeing free block");
801014e1:	83 ec 0c             	sub    $0xc,%esp
801014e4:	68 e1 81 10 80       	push   $0x801081e1
801014e9:	e8 a2 ee ff ff       	call   80100390 <panic>
801014ee:	66 90                	xchg   %ax,%ax

801014f0 <iinit>:
iinit(int dev) {
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	53                   	push   %ebx
801014f4:	bb 20 2a 11 80       	mov    $0x80112a20,%ebx
801014f9:	83 ec 0c             	sub    $0xc,%esp
    initlock(&icache.lock, "icache");
801014fc:	68 f4 81 10 80       	push   $0x801081f4
80101501:	68 e0 29 11 80       	push   $0x801129e0
80101506:	e8 95 36 00 00       	call   80104ba0 <initlock>
8010150b:	83 c4 10             	add    $0x10,%esp
8010150e:	66 90                	xchg   %ax,%ax
        initsleeplock(&icache.inode[i].lock, "inode");
80101510:	83 ec 08             	sub    $0x8,%esp
80101513:	68 fb 81 10 80       	push   $0x801081fb
80101518:	53                   	push   %ebx
80101519:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010151f:	e8 6c 35 00 00       	call   80104a90 <initsleeplock>
    for (i = 0; i < NINODE; i++) {
80101524:	83 c4 10             	add    $0x10,%esp
80101527:	81 fb 40 46 11 80    	cmp    $0x80114640,%ebx
8010152d:	75 e1                	jne    80101510 <iinit+0x20>
    readsb(dev, &sb);
8010152f:	83 ec 08             	sub    $0x8,%esp
80101532:	68 c0 29 11 80       	push   $0x801129c0
80101537:	ff 75 08             	pushl  0x8(%ebp)
8010153a:	e8 f1 fe ff ff       	call   80101430 <readsb>
    cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010153f:	ff 35 d8 29 11 80    	pushl  0x801129d8
80101545:	ff 35 d4 29 11 80    	pushl  0x801129d4
8010154b:	ff 35 d0 29 11 80    	pushl  0x801129d0
80101551:	ff 35 cc 29 11 80    	pushl  0x801129cc
80101557:	ff 35 c8 29 11 80    	pushl  0x801129c8
8010155d:	ff 35 c4 29 11 80    	pushl  0x801129c4
80101563:	ff 35 c0 29 11 80    	pushl  0x801129c0
80101569:	68 bc 82 10 80       	push   $0x801082bc
8010156e:	e8 ed f0 ff ff       	call   80100660 <cprintf>
}
80101573:	83 c4 30             	add    $0x30,%esp
80101576:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101579:	c9                   	leave  
8010157a:	c3                   	ret    
8010157b:	90                   	nop
8010157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101580 <ialloc>:
ialloc(uint dev, short type) {
80101580:	55                   	push   %ebp
80101581:	89 e5                	mov    %esp,%ebp
80101583:	57                   	push   %edi
80101584:	56                   	push   %esi
80101585:	53                   	push   %ebx
80101586:	83 ec 1c             	sub    $0x1c,%esp
    for (inum = 1; inum < sb.ninodes; inum++) {
80101589:	83 3d c8 29 11 80 01 	cmpl   $0x1,0x801129c8
ialloc(uint dev, short type) {
80101590:	8b 45 0c             	mov    0xc(%ebp),%eax
80101593:	8b 75 08             	mov    0x8(%ebp),%esi
80101596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for (inum = 1; inum < sb.ninodes; inum++) {
80101599:	0f 86 91 00 00 00    	jbe    80101630 <ialloc+0xb0>
8010159f:	bb 01 00 00 00       	mov    $0x1,%ebx
801015a4:	eb 21                	jmp    801015c7 <ialloc+0x47>
801015a6:	8d 76 00             	lea    0x0(%esi),%esi
801015a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        brelse(bp);
801015b0:	83 ec 0c             	sub    $0xc,%esp
    for (inum = 1; inum < sb.ninodes; inum++) {
801015b3:	83 c3 01             	add    $0x1,%ebx
        brelse(bp);
801015b6:	57                   	push   %edi
801015b7:	e8 24 ec ff ff       	call   801001e0 <brelse>
    for (inum = 1; inum < sb.ninodes; inum++) {
801015bc:	83 c4 10             	add    $0x10,%esp
801015bf:	39 1d c8 29 11 80    	cmp    %ebx,0x801129c8
801015c5:	76 69                	jbe    80101630 <ialloc+0xb0>
        bp = bread(dev, IBLOCK(inum, sb));
801015c7:	89 d8                	mov    %ebx,%eax
801015c9:	83 ec 08             	sub    $0x8,%esp
801015cc:	c1 e8 03             	shr    $0x3,%eax
801015cf:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801015d5:	50                   	push   %eax
801015d6:	56                   	push   %esi
801015d7:	e8 f4 ea ff ff       	call   801000d0 <bread>
801015dc:	89 c7                	mov    %eax,%edi
        dip = (struct dinode *) bp->data + inum % IPB;
801015de:	89 d8                	mov    %ebx,%eax
        if (dip->type == 0) {  // a free inode
801015e0:	83 c4 10             	add    $0x10,%esp
        dip = (struct dinode *) bp->data + inum % IPB;
801015e3:	83 e0 07             	and    $0x7,%eax
801015e6:	c1 e0 06             	shl    $0x6,%eax
801015e9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
        if (dip->type == 0) {  // a free inode
801015ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015f1:	75 bd                	jne    801015b0 <ialloc+0x30>
            memset(dip, 0, sizeof(*dip));
801015f3:	83 ec 04             	sub    $0x4,%esp
801015f6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015f9:	6a 40                	push   $0x40
801015fb:	6a 00                	push   $0x0
801015fd:	51                   	push   %ecx
801015fe:	e8 0d 38 00 00       	call   80104e10 <memset>
            dip->type = type;
80101603:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101607:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010160a:	66 89 01             	mov    %ax,(%ecx)
            log_write(bp);   // mark it allocated on the disk
8010160d:	89 3c 24             	mov    %edi,(%esp)
80101610:	e8 4b 1e 00 00       	call   80103460 <log_write>
            brelse(bp);
80101615:	89 3c 24             	mov    %edi,(%esp)
80101618:	e8 c3 eb ff ff       	call   801001e0 <brelse>
            return iget(dev, inum);
8010161d:	83 c4 10             	add    $0x10,%esp
}
80101620:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return iget(dev, inum);
80101623:	89 da                	mov    %ebx,%edx
80101625:	89 f0                	mov    %esi,%eax
}
80101627:	5b                   	pop    %ebx
80101628:	5e                   	pop    %esi
80101629:	5f                   	pop    %edi
8010162a:	5d                   	pop    %ebp
            return iget(dev, inum);
8010162b:	e9 50 fc ff ff       	jmp    80101280 <iget>
    panic("ialloc: no inodes");
80101630:	83 ec 0c             	sub    $0xc,%esp
80101633:	68 01 82 10 80       	push   $0x80108201
80101638:	e8 53 ed ff ff       	call   80100390 <panic>
8010163d:	8d 76 00             	lea    0x0(%esi),%esi

80101640 <iupdate>:
iupdate(struct inode *ip) {
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	56                   	push   %esi
80101644:	53                   	push   %ebx
80101645:	8b 5d 08             	mov    0x8(%ebp),%ebx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101648:	83 ec 08             	sub    $0x8,%esp
8010164b:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010164e:	83 c3 5c             	add    $0x5c,%ebx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101651:	c1 e8 03             	shr    $0x3,%eax
80101654:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010165a:	50                   	push   %eax
8010165b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010165e:	e8 6d ea ff ff       	call   801000d0 <bread>
80101663:	89 c6                	mov    %eax,%esi
    dip = (struct dinode *) bp->data + ip->inum % IPB;
80101665:	8b 43 a8             	mov    -0x58(%ebx),%eax
    dip->type = ip->type;
80101668:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010166c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode *) bp->data + ip->inum % IPB;
8010166f:	83 e0 07             	and    $0x7,%eax
80101672:	c1 e0 06             	shl    $0x6,%eax
80101675:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    dip->type = ip->type;
80101679:	66 89 10             	mov    %dx,(%eax)
    dip->major = ip->major;
8010167c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101680:	83 c0 0c             	add    $0xc,%eax
    dip->major = ip->major;
80101683:	66 89 50 f6          	mov    %dx,-0xa(%eax)
    dip->minor = ip->minor;
80101687:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010168b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
    dip->nlink = ip->nlink;
8010168f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101693:	66 89 50 fa          	mov    %dx,-0x6(%eax)
    dip->size = ip->size;
80101697:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010169a:	89 50 fc             	mov    %edx,-0x4(%eax)
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010169d:	6a 34                	push   $0x34
8010169f:	53                   	push   %ebx
801016a0:	50                   	push   %eax
801016a1:	e8 1a 38 00 00       	call   80104ec0 <memmove>
    log_write(bp);
801016a6:	89 34 24             	mov    %esi,(%esp)
801016a9:	e8 b2 1d 00 00       	call   80103460 <log_write>
    brelse(bp);
801016ae:	89 75 08             	mov    %esi,0x8(%ebp)
801016b1:	83 c4 10             	add    $0x10,%esp
}
801016b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b7:	5b                   	pop    %ebx
801016b8:	5e                   	pop    %esi
801016b9:	5d                   	pop    %ebp
    brelse(bp);
801016ba:	e9 21 eb ff ff       	jmp    801001e0 <brelse>
801016bf:	90                   	nop

801016c0 <idup>:
idup(struct inode *ip) {
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	53                   	push   %ebx
801016c4:	83 ec 10             	sub    $0x10,%esp
801016c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&icache.lock);
801016ca:	68 e0 29 11 80       	push   $0x801129e0
801016cf:	e8 bc 35 00 00       	call   80104c90 <acquire>
    ip->ref++;
801016d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
    release(&icache.lock);
801016d8:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801016df:	e8 cc 36 00 00       	call   80104db0 <release>
}
801016e4:	89 d8                	mov    %ebx,%eax
801016e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016e9:	c9                   	leave  
801016ea:	c3                   	ret    
801016eb:	90                   	nop
801016ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016f0 <ilock>:
ilock(struct inode *ip) {
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	56                   	push   %esi
801016f4:	53                   	push   %ebx
801016f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (ip == 0 || ip->ref < 1)
801016f8:	85 db                	test   %ebx,%ebx
801016fa:	0f 84 b7 00 00 00    	je     801017b7 <ilock+0xc7>
80101700:	8b 53 08             	mov    0x8(%ebx),%edx
80101703:	85 d2                	test   %edx,%edx
80101705:	0f 8e ac 00 00 00    	jle    801017b7 <ilock+0xc7>
    acquiresleep(&ip->lock);
8010170b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010170e:	83 ec 0c             	sub    $0xc,%esp
80101711:	50                   	push   %eax
80101712:	e8 b9 33 00 00       	call   80104ad0 <acquiresleep>
    if (ip->valid == 0) {
80101717:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010171a:	83 c4 10             	add    $0x10,%esp
8010171d:	85 c0                	test   %eax,%eax
8010171f:	74 0f                	je     80101730 <ilock+0x40>
}
80101721:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101724:	5b                   	pop    %ebx
80101725:	5e                   	pop    %esi
80101726:	5d                   	pop    %ebp
80101727:	c3                   	ret    
80101728:	90                   	nop
80101729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101730:	8b 43 04             	mov    0x4(%ebx),%eax
80101733:	83 ec 08             	sub    $0x8,%esp
80101736:	c1 e8 03             	shr    $0x3,%eax
80101739:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010173f:	50                   	push   %eax
80101740:	ff 33                	pushl  (%ebx)
80101742:	e8 89 e9 ff ff       	call   801000d0 <bread>
80101747:	89 c6                	mov    %eax,%esi
        dip = (struct dinode *) bp->data + ip->inum % IPB;
80101749:	8b 43 04             	mov    0x4(%ebx),%eax
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010174c:	83 c4 0c             	add    $0xc,%esp
        dip = (struct dinode *) bp->data + ip->inum % IPB;
8010174f:	83 e0 07             	and    $0x7,%eax
80101752:	c1 e0 06             	shl    $0x6,%eax
80101755:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
        ip->type = dip->type;
80101759:	0f b7 10             	movzwl (%eax),%edx
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010175c:	83 c0 0c             	add    $0xc,%eax
        ip->type = dip->type;
8010175f:	66 89 53 50          	mov    %dx,0x50(%ebx)
        ip->major = dip->major;
80101763:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101767:	66 89 53 52          	mov    %dx,0x52(%ebx)
        ip->minor = dip->minor;
8010176b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010176f:	66 89 53 54          	mov    %dx,0x54(%ebx)
        ip->nlink = dip->nlink;
80101773:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101777:	66 89 53 56          	mov    %dx,0x56(%ebx)
        ip->size = dip->size;
8010177b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010177e:	89 53 58             	mov    %edx,0x58(%ebx)
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101781:	6a 34                	push   $0x34
80101783:	50                   	push   %eax
80101784:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101787:	50                   	push   %eax
80101788:	e8 33 37 00 00       	call   80104ec0 <memmove>
        brelse(bp);
8010178d:	89 34 24             	mov    %esi,(%esp)
80101790:	e8 4b ea ff ff       	call   801001e0 <brelse>
        if (ip->type == 0)
80101795:	83 c4 10             	add    $0x10,%esp
80101798:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
        ip->valid = 1;
8010179d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
        if (ip->type == 0)
801017a4:	0f 85 77 ff ff ff    	jne    80101721 <ilock+0x31>
            panic("ilock: no type");
801017aa:	83 ec 0c             	sub    $0xc,%esp
801017ad:	68 19 82 10 80       	push   $0x80108219
801017b2:	e8 d9 eb ff ff       	call   80100390 <panic>
        panic("ilock");
801017b7:	83 ec 0c             	sub    $0xc,%esp
801017ba:	68 13 82 10 80       	push   $0x80108213
801017bf:	e8 cc eb ff ff       	call   80100390 <panic>
801017c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017d0 <iunlock>:
iunlock(struct inode *ip) {
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	56                   	push   %esi
801017d4:	53                   	push   %ebx
801017d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017d8:	85 db                	test   %ebx,%ebx
801017da:	74 28                	je     80101804 <iunlock+0x34>
801017dc:	8d 73 0c             	lea    0xc(%ebx),%esi
801017df:	83 ec 0c             	sub    $0xc,%esp
801017e2:	56                   	push   %esi
801017e3:	e8 88 33 00 00       	call   80104b70 <holdingsleep>
801017e8:	83 c4 10             	add    $0x10,%esp
801017eb:	85 c0                	test   %eax,%eax
801017ed:	74 15                	je     80101804 <iunlock+0x34>
801017ef:	8b 43 08             	mov    0x8(%ebx),%eax
801017f2:	85 c0                	test   %eax,%eax
801017f4:	7e 0e                	jle    80101804 <iunlock+0x34>
    releasesleep(&ip->lock);
801017f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5d                   	pop    %ebp
    releasesleep(&ip->lock);
801017ff:	e9 2c 33 00 00       	jmp    80104b30 <releasesleep>
        panic("iunlock");
80101804:	83 ec 0c             	sub    $0xc,%esp
80101807:	68 28 82 10 80       	push   $0x80108228
8010180c:	e8 7f eb ff ff       	call   80100390 <panic>
80101811:	eb 0d                	jmp    80101820 <iput>
80101813:	90                   	nop
80101814:	90                   	nop
80101815:	90                   	nop
80101816:	90                   	nop
80101817:	90                   	nop
80101818:	90                   	nop
80101819:	90                   	nop
8010181a:	90                   	nop
8010181b:	90                   	nop
8010181c:	90                   	nop
8010181d:	90                   	nop
8010181e:	90                   	nop
8010181f:	90                   	nop

80101820 <iput>:
iput(struct inode *ip) {
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	57                   	push   %edi
80101824:	56                   	push   %esi
80101825:	53                   	push   %ebx
80101826:	83 ec 28             	sub    $0x28,%esp
80101829:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquiresleep(&ip->lock);
8010182c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010182f:	57                   	push   %edi
80101830:	e8 9b 32 00 00       	call   80104ad0 <acquiresleep>
    if (ip->valid && ip->nlink == 0) {
80101835:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101838:	83 c4 10             	add    $0x10,%esp
8010183b:	85 d2                	test   %edx,%edx
8010183d:	74 07                	je     80101846 <iput+0x26>
8010183f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101844:	74 32                	je     80101878 <iput+0x58>
    releasesleep(&ip->lock);
80101846:	83 ec 0c             	sub    $0xc,%esp
80101849:	57                   	push   %edi
8010184a:	e8 e1 32 00 00       	call   80104b30 <releasesleep>
    acquire(&icache.lock);
8010184f:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101856:	e8 35 34 00 00       	call   80104c90 <acquire>
    ip->ref--;
8010185b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
    release(&icache.lock);
8010185f:	83 c4 10             	add    $0x10,%esp
80101862:	c7 45 08 e0 29 11 80 	movl   $0x801129e0,0x8(%ebp)
}
80101869:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010186c:	5b                   	pop    %ebx
8010186d:	5e                   	pop    %esi
8010186e:	5f                   	pop    %edi
8010186f:	5d                   	pop    %ebp
    release(&icache.lock);
80101870:	e9 3b 35 00 00       	jmp    80104db0 <release>
80101875:	8d 76 00             	lea    0x0(%esi),%esi
        acquire(&icache.lock);
80101878:	83 ec 0c             	sub    $0xc,%esp
8010187b:	68 e0 29 11 80       	push   $0x801129e0
80101880:	e8 0b 34 00 00       	call   80104c90 <acquire>
        int r = ip->ref;
80101885:	8b 73 08             	mov    0x8(%ebx),%esi
        release(&icache.lock);
80101888:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010188f:	e8 1c 35 00 00       	call   80104db0 <release>
        if (r == 1) {
80101894:	83 c4 10             	add    $0x10,%esp
80101897:	83 fe 01             	cmp    $0x1,%esi
8010189a:	75 aa                	jne    80101846 <iput+0x26>
8010189c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018a2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018a8:	89 cf                	mov    %ecx,%edi
801018aa:	eb 0b                	jmp    801018b7 <iput+0x97>
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018b0:	83 c6 04             	add    $0x4,%esi
itrunc(struct inode *ip) {
    int i, j;
    struct buf *bp;
    uint *a;

    for (i = 0; i < NDIRECT; i++) {
801018b3:	39 fe                	cmp    %edi,%esi
801018b5:	74 19                	je     801018d0 <iput+0xb0>
        if (ip->addrs[i]) {
801018b7:	8b 16                	mov    (%esi),%edx
801018b9:	85 d2                	test   %edx,%edx
801018bb:	74 f3                	je     801018b0 <iput+0x90>
            bfree(ip->dev, ip->addrs[i]);
801018bd:	8b 03                	mov    (%ebx),%eax
801018bf:	e8 ac fb ff ff       	call   80101470 <bfree>
            ip->addrs[i] = 0;
801018c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018ca:	eb e4                	jmp    801018b0 <iput+0x90>
801018cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
    }

    if (ip->addrs[NDIRECT]) {
801018d0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018d6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018d9:	85 c0                	test   %eax,%eax
801018db:	75 33                	jne    80101910 <iput+0xf0>
        bfree(ip->dev, ip->addrs[NDIRECT]);
        ip->addrs[NDIRECT] = 0;
    }

    ip->size = 0;
    iupdate(ip);
801018dd:	83 ec 0c             	sub    $0xc,%esp
    ip->size = 0;
801018e0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
    iupdate(ip);
801018e7:	53                   	push   %ebx
801018e8:	e8 53 fd ff ff       	call   80101640 <iupdate>
            ip->type = 0;
801018ed:	31 c0                	xor    %eax,%eax
801018ef:	66 89 43 50          	mov    %ax,0x50(%ebx)
            iupdate(ip);
801018f3:	89 1c 24             	mov    %ebx,(%esp)
801018f6:	e8 45 fd ff ff       	call   80101640 <iupdate>
            ip->valid = 0;
801018fb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101902:	83 c4 10             	add    $0x10,%esp
80101905:	e9 3c ff ff ff       	jmp    80101846 <iput+0x26>
8010190a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101910:	83 ec 08             	sub    $0x8,%esp
80101913:	50                   	push   %eax
80101914:	ff 33                	pushl  (%ebx)
80101916:	e8 b5 e7 ff ff       	call   801000d0 <bread>
8010191b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101921:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101924:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        a = (uint *) bp->data;
80101927:	8d 70 5c             	lea    0x5c(%eax),%esi
8010192a:	83 c4 10             	add    $0x10,%esp
8010192d:	89 cf                	mov    %ecx,%edi
8010192f:	eb 0e                	jmp    8010193f <iput+0x11f>
80101931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101938:	83 c6 04             	add    $0x4,%esi
        for (j = 0; j < NINDIRECT; j++) {
8010193b:	39 fe                	cmp    %edi,%esi
8010193d:	74 0f                	je     8010194e <iput+0x12e>
            if (a[j])
8010193f:	8b 16                	mov    (%esi),%edx
80101941:	85 d2                	test   %edx,%edx
80101943:	74 f3                	je     80101938 <iput+0x118>
                bfree(ip->dev, a[j]);
80101945:	8b 03                	mov    (%ebx),%eax
80101947:	e8 24 fb ff ff       	call   80101470 <bfree>
8010194c:	eb ea                	jmp    80101938 <iput+0x118>
        brelse(bp);
8010194e:	83 ec 0c             	sub    $0xc,%esp
80101951:	ff 75 e4             	pushl  -0x1c(%ebp)
80101954:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101957:	e8 84 e8 ff ff       	call   801001e0 <brelse>
        bfree(ip->dev, ip->addrs[NDIRECT]);
8010195c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101962:	8b 03                	mov    (%ebx),%eax
80101964:	e8 07 fb ff ff       	call   80101470 <bfree>
        ip->addrs[NDIRECT] = 0;
80101969:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101970:	00 00 00 
80101973:	83 c4 10             	add    $0x10,%esp
80101976:	e9 62 ff ff ff       	jmp    801018dd <iput+0xbd>
8010197b:	90                   	nop
8010197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101980 <iunlockput>:
iunlockput(struct inode *ip) {
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	53                   	push   %ebx
80101984:	83 ec 10             	sub    $0x10,%esp
80101987:	8b 5d 08             	mov    0x8(%ebp),%ebx
    iunlock(ip);
8010198a:	53                   	push   %ebx
8010198b:	e8 40 fe ff ff       	call   801017d0 <iunlock>
    iput(ip);
80101990:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101993:	83 c4 10             	add    $0x10,%esp
}
80101996:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101999:	c9                   	leave  
    iput(ip);
8010199a:	e9 81 fe ff ff       	jmp    80101820 <iput>
8010199f:	90                   	nop

801019a0 <stati>:
}

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st) {
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	8b 55 08             	mov    0x8(%ebp),%edx
801019a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    st->dev = ip->dev;
801019a9:	8b 0a                	mov    (%edx),%ecx
801019ab:	89 48 04             	mov    %ecx,0x4(%eax)
    st->ino = ip->inum;
801019ae:	8b 4a 04             	mov    0x4(%edx),%ecx
801019b1:	89 48 08             	mov    %ecx,0x8(%eax)
    st->type = ip->type;
801019b4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019b8:	66 89 08             	mov    %cx,(%eax)
    st->nlink = ip->nlink;
801019bb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019bf:	66 89 48 0c          	mov    %cx,0xc(%eax)
    st->size = ip->size;
801019c3:	8b 52 58             	mov    0x58(%edx),%edx
801019c6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019c9:	5d                   	pop    %ebp
801019ca:	c3                   	ret    
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <readi>:

//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n) {
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 1c             	sub    $0x1c,%esp
801019d9:	8b 45 08             	mov    0x8(%ebp),%eax
801019dc:	8b 75 0c             	mov    0xc(%ebp),%esi
801019df:	8b 7d 14             	mov    0x14(%ebp),%edi
    uint tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
801019e2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
readi(struct inode *ip, char *dst, uint off, uint n) {
801019e7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801019ea:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019ed:	8b 75 10             	mov    0x10(%ebp),%esi
801019f0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    if (ip->type == T_DEV) {
801019f3:	0f 84 a7 00 00 00    	je     80101aa0 <readi+0xd0>
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
            return -1;
        return devsw[ip->major].read(ip, dst, n);
    }

    if (off > ip->size || off + n < off)
801019f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019fc:	8b 40 58             	mov    0x58(%eax),%eax
801019ff:	39 c6                	cmp    %eax,%esi
80101a01:	0f 87 ba 00 00 00    	ja     80101ac1 <readi+0xf1>
80101a07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a0a:	89 f9                	mov    %edi,%ecx
80101a0c:	01 f1                	add    %esi,%ecx
80101a0e:	0f 82 ad 00 00 00    	jb     80101ac1 <readi+0xf1>
        return -1;
    if (off + n > ip->size)
        n = ip->size - off;
80101a14:	89 c2                	mov    %eax,%edx
80101a16:	29 f2                	sub    %esi,%edx
80101a18:	39 c8                	cmp    %ecx,%eax
80101a1a:	0f 43 d7             	cmovae %edi,%edx

    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
80101a1d:	31 ff                	xor    %edi,%edi
80101a1f:	85 d2                	test   %edx,%edx
        n = ip->size - off;
80101a21:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
80101a24:	74 6c                	je     80101a92 <readi+0xc2>
80101a26:	8d 76 00             	lea    0x0(%esi),%esi
80101a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
80101a30:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a33:	89 f2                	mov    %esi,%edx
80101a35:	c1 ea 09             	shr    $0x9,%edx
80101a38:	89 d8                	mov    %ebx,%eax
80101a3a:	e8 11 f9 ff ff       	call   80101350 <bmap>
80101a3f:	83 ec 08             	sub    $0x8,%esp
80101a42:	50                   	push   %eax
80101a43:	ff 33                	pushl  (%ebx)
80101a45:	e8 86 e6 ff ff       	call   801000d0 <bread>
        m = min(n - tot, BSIZE - off % BSIZE);
80101a4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
80101a4d:	89 c2                	mov    %eax,%edx
        m = min(n - tot, BSIZE - off % BSIZE);
80101a4f:	89 f0                	mov    %esi,%eax
80101a51:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a56:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a5b:	83 c4 0c             	add    $0xc,%esp
80101a5e:	29 c1                	sub    %eax,%ecx
        memmove(dst, bp->data + off % BSIZE, m);
80101a60:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a64:	89 55 dc             	mov    %edx,-0x24(%ebp)
        m = min(n - tot, BSIZE - off % BSIZE);
80101a67:	29 fb                	sub    %edi,%ebx
80101a69:	39 d9                	cmp    %ebx,%ecx
80101a6b:	0f 46 d9             	cmovbe %ecx,%ebx
        memmove(dst, bp->data + off % BSIZE, m);
80101a6e:	53                   	push   %ebx
80101a6f:	50                   	push   %eax
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
80101a70:	01 df                	add    %ebx,%edi
        memmove(dst, bp->data + off % BSIZE, m);
80101a72:	ff 75 e0             	pushl  -0x20(%ebp)
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
80101a75:	01 de                	add    %ebx,%esi
        memmove(dst, bp->data + off % BSIZE, m);
80101a77:	e8 44 34 00 00       	call   80104ec0 <memmove>
        brelse(bp);
80101a7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a7f:	89 14 24             	mov    %edx,(%esp)
80101a82:	e8 59 e7 ff ff       	call   801001e0 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
80101a87:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a8a:	83 c4 10             	add    $0x10,%esp
80101a8d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a90:	77 9e                	ja     80101a30 <readi+0x60>
    }
    return n;
80101a92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a98:	5b                   	pop    %ebx
80101a99:	5e                   	pop    %esi
80101a9a:	5f                   	pop    %edi
80101a9b:	5d                   	pop    %ebp
80101a9c:	c3                   	ret    
80101a9d:	8d 76 00             	lea    0x0(%esi),%esi
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101aa0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101aa4:	66 83 f8 09          	cmp    $0x9,%ax
80101aa8:	77 17                	ja     80101ac1 <readi+0xf1>
80101aaa:	8b 04 c5 60 29 11 80 	mov    -0x7feed6a0(,%eax,8),%eax
80101ab1:	85 c0                	test   %eax,%eax
80101ab3:	74 0c                	je     80101ac1 <readi+0xf1>
        return devsw[ip->major].read(ip, dst, n);
80101ab5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101abb:	5b                   	pop    %ebx
80101abc:	5e                   	pop    %esi
80101abd:	5f                   	pop    %edi
80101abe:	5d                   	pop    %ebp
        return devsw[ip->major].read(ip, dst, n);
80101abf:	ff e0                	jmp    *%eax
            return -1;
80101ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ac6:	eb cd                	jmp    80101a95 <readi+0xc5>
80101ac8:	90                   	nop
80101ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <writei>:

// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n) {
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 1c             	sub    $0x1c,%esp
80101ad9:	8b 45 08             	mov    0x8(%ebp),%eax
80101adc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101adf:	8b 7d 14             	mov    0x14(%ebp),%edi
    uint tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
80101ae2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
writei(struct inode *ip, char *src, uint off, uint n) {
80101ae7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aed:	8b 75 10             	mov    0x10(%ebp),%esi
80101af0:	89 7d e0             	mov    %edi,-0x20(%ebp)
    if (ip->type == T_DEV) {
80101af3:	0f 84 b7 00 00 00    	je     80101bb0 <writei+0xe0>
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
            return -1;
        return devsw[ip->major].write(ip, src, n);
    }

    if (off > ip->size || off + n < off)
80101af9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101afc:	39 70 58             	cmp    %esi,0x58(%eax)
80101aff:	0f 82 eb 00 00 00    	jb     80101bf0 <writei+0x120>
80101b05:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b08:	31 d2                	xor    %edx,%edx
80101b0a:	89 f8                	mov    %edi,%eax
80101b0c:	01 f0                	add    %esi,%eax
80101b0e:	0f 92 c2             	setb   %dl
        return -1;
    if (off + n > MAXFILE * BSIZE)
80101b11:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b16:	0f 87 d4 00 00 00    	ja     80101bf0 <writei+0x120>
80101b1c:	85 d2                	test   %edx,%edx
80101b1e:	0f 85 cc 00 00 00    	jne    80101bf0 <writei+0x120>
        return -1;

    for (tot = 0; tot < n; tot += m, off += m, src += m) {
80101b24:	85 ff                	test   %edi,%edi
80101b26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b2d:	74 72                	je     80101ba1 <writei+0xd1>
80101b2f:	90                   	nop
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
80101b30:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b33:	89 f2                	mov    %esi,%edx
80101b35:	c1 ea 09             	shr    $0x9,%edx
80101b38:	89 f8                	mov    %edi,%eax
80101b3a:	e8 11 f8 ff ff       	call   80101350 <bmap>
80101b3f:	83 ec 08             	sub    $0x8,%esp
80101b42:	50                   	push   %eax
80101b43:	ff 37                	pushl  (%edi)
80101b45:	e8 86 e5 ff ff       	call   801000d0 <bread>
        m = min(n - tot, BSIZE - off % BSIZE);
80101b4a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b4d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
80101b50:	89 c7                	mov    %eax,%edi
        m = min(n - tot, BSIZE - off % BSIZE);
80101b52:	89 f0                	mov    %esi,%eax
80101b54:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b59:	83 c4 0c             	add    $0xc,%esp
80101b5c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b61:	29 c1                	sub    %eax,%ecx
        memmove(bp->data + off % BSIZE, src, m);
80101b63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
        m = min(n - tot, BSIZE - off % BSIZE);
80101b67:	39 d9                	cmp    %ebx,%ecx
80101b69:	0f 46 d9             	cmovbe %ecx,%ebx
        memmove(bp->data + off % BSIZE, src, m);
80101b6c:	53                   	push   %ebx
80101b6d:	ff 75 dc             	pushl  -0x24(%ebp)
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
80101b70:	01 de                	add    %ebx,%esi
        memmove(bp->data + off % BSIZE, src, m);
80101b72:	50                   	push   %eax
80101b73:	e8 48 33 00 00       	call   80104ec0 <memmove>
        log_write(bp);
80101b78:	89 3c 24             	mov    %edi,(%esp)
80101b7b:	e8 e0 18 00 00       	call   80103460 <log_write>
        brelse(bp);
80101b80:	89 3c 24             	mov    %edi,(%esp)
80101b83:	e8 58 e6 ff ff       	call   801001e0 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
80101b88:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b8b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b8e:	83 c4 10             	add    $0x10,%esp
80101b91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b94:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b97:	77 97                	ja     80101b30 <writei+0x60>
    }

    if (n > 0 && off > ip->size) {
80101b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b9f:	77 37                	ja     80101bd8 <writei+0x108>
        ip->size = off;
        iupdate(ip);
    }
    return n;
80101ba1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ba4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ba7:	5b                   	pop    %ebx
80101ba8:	5e                   	pop    %esi
80101ba9:	5f                   	pop    %edi
80101baa:	5d                   	pop    %ebp
80101bab:	c3                   	ret    
80101bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101bb4:	66 83 f8 09          	cmp    $0x9,%ax
80101bb8:	77 36                	ja     80101bf0 <writei+0x120>
80101bba:	8b 04 c5 64 29 11 80 	mov    -0x7feed69c(,%eax,8),%eax
80101bc1:	85 c0                	test   %eax,%eax
80101bc3:	74 2b                	je     80101bf0 <writei+0x120>
        return devsw[ip->major].write(ip, src, n);
80101bc5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bcb:	5b                   	pop    %ebx
80101bcc:	5e                   	pop    %esi
80101bcd:	5f                   	pop    %edi
80101bce:	5d                   	pop    %ebp
        return devsw[ip->major].write(ip, src, n);
80101bcf:	ff e0                	jmp    *%eax
80101bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        ip->size = off;
80101bd8:	8b 45 d8             	mov    -0x28(%ebp),%eax
        iupdate(ip);
80101bdb:	83 ec 0c             	sub    $0xc,%esp
        ip->size = off;
80101bde:	89 70 58             	mov    %esi,0x58(%eax)
        iupdate(ip);
80101be1:	50                   	push   %eax
80101be2:	e8 59 fa ff ff       	call   80101640 <iupdate>
80101be7:	83 c4 10             	add    $0x10,%esp
80101bea:	eb b5                	jmp    80101ba1 <writei+0xd1>
80101bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            return -1;
80101bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bf5:	eb ad                	jmp    80101ba4 <writei+0xd4>
80101bf7:	89 f6                	mov    %esi,%esi
80101bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c00 <namecmp>:

//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t) {
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	83 ec 0c             	sub    $0xc,%esp
    return strncmp(s, t, DIRSIZ);
80101c06:	6a 0e                	push   $0xe
80101c08:	ff 75 0c             	pushl  0xc(%ebp)
80101c0b:	ff 75 08             	pushl  0x8(%ebp)
80101c0e:	e8 1d 33 00 00       	call   80104f30 <strncmp>
}
80101c13:	c9                   	leave  
80101c14:	c3                   	ret    
80101c15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *
dirlookup(struct inode *dp, char *name, uint *poff) {
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	83 ec 1c             	sub    $0x1c,%esp
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
    uint off, inum;
    struct dirent de;

    if (dp->type != T_DIR)
80101c2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c31:	0f 85 85 00 00 00    	jne    80101cbc <dirlookup+0x9c>
        panic("dirlookup not DIR");

    for (off = 0; off < dp->size; off += sizeof(de)) {
80101c37:	8b 53 58             	mov    0x58(%ebx),%edx
80101c3a:	31 ff                	xor    %edi,%edi
80101c3c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c3f:	85 d2                	test   %edx,%edx
80101c41:	74 3e                	je     80101c81 <dirlookup+0x61>
80101c43:	90                   	nop
80101c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (readi(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
80101c48:	6a 10                	push   $0x10
80101c4a:	57                   	push   %edi
80101c4b:	56                   	push   %esi
80101c4c:	53                   	push   %ebx
80101c4d:	e8 7e fd ff ff       	call   801019d0 <readi>
80101c52:	83 c4 10             	add    $0x10,%esp
80101c55:	83 f8 10             	cmp    $0x10,%eax
80101c58:	75 55                	jne    80101caf <dirlookup+0x8f>
            panic("dirlookup read");
        if (de.inum == 0)
80101c5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c5f:	74 18                	je     80101c79 <dirlookup+0x59>
    return strncmp(s, t, DIRSIZ);
80101c61:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c64:	83 ec 04             	sub    $0x4,%esp
80101c67:	6a 0e                	push   $0xe
80101c69:	50                   	push   %eax
80101c6a:	ff 75 0c             	pushl  0xc(%ebp)
80101c6d:	e8 be 32 00 00       	call   80104f30 <strncmp>
            continue;
        if (namecmp(name, de.name) == 0) {
80101c72:	83 c4 10             	add    $0x10,%esp
80101c75:	85 c0                	test   %eax,%eax
80101c77:	74 17                	je     80101c90 <dirlookup+0x70>
    for (off = 0; off < dp->size; off += sizeof(de)) {
80101c79:	83 c7 10             	add    $0x10,%edi
80101c7c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c7f:	72 c7                	jb     80101c48 <dirlookup+0x28>
            return iget(dp->dev, inum);
        }
    }

    return 0;
}
80101c81:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80101c84:	31 c0                	xor    %eax,%eax
}
80101c86:	5b                   	pop    %ebx
80101c87:	5e                   	pop    %esi
80101c88:	5f                   	pop    %edi
80101c89:	5d                   	pop    %ebp
80101c8a:	c3                   	ret    
80101c8b:	90                   	nop
80101c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if (poff)
80101c90:	8b 45 10             	mov    0x10(%ebp),%eax
80101c93:	85 c0                	test   %eax,%eax
80101c95:	74 05                	je     80101c9c <dirlookup+0x7c>
                *poff = off;
80101c97:	8b 45 10             	mov    0x10(%ebp),%eax
80101c9a:	89 38                	mov    %edi,(%eax)
            inum = de.inum;
80101c9c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
            return iget(dp->dev, inum);
80101ca0:	8b 03                	mov    (%ebx),%eax
80101ca2:	e8 d9 f5 ff ff       	call   80101280 <iget>
}
80101ca7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101caa:	5b                   	pop    %ebx
80101cab:	5e                   	pop    %esi
80101cac:	5f                   	pop    %edi
80101cad:	5d                   	pop    %ebp
80101cae:	c3                   	ret    
            panic("dirlookup read");
80101caf:	83 ec 0c             	sub    $0xc,%esp
80101cb2:	68 42 82 10 80       	push   $0x80108242
80101cb7:	e8 d4 e6 ff ff       	call   80100390 <panic>
        panic("dirlookup not DIR");
80101cbc:	83 ec 0c             	sub    $0xc,%esp
80101cbf:	68 30 82 10 80       	push   $0x80108230
80101cc4:	e8 c7 e6 ff ff       	call   80100390 <panic>
80101cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101cd0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *
namex(char *path, int nameiparent, char *name) {
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	57                   	push   %edi
80101cd4:	56                   	push   %esi
80101cd5:	53                   	push   %ebx
80101cd6:	89 cf                	mov    %ecx,%edi
80101cd8:	89 c3                	mov    %eax,%ebx
80101cda:	83 ec 1c             	sub    $0x1c,%esp
    struct inode *ip, *next;

    if (*path == '/')
80101cdd:	80 38 2f             	cmpb   $0x2f,(%eax)
namex(char *path, int nameiparent, char *name) {
80101ce0:	89 55 e0             	mov    %edx,-0x20(%ebp)
    if (*path == '/')
80101ce3:	0f 84 67 01 00 00    	je     80101e50 <namex+0x180>
        ip = iget(ROOTDEV, ROOTINO);
    else
        ip = idup(myproc()->cwd);
80101ce9:	e8 32 22 00 00       	call   80103f20 <myproc>
    acquire(&icache.lock);
80101cee:	83 ec 0c             	sub    $0xc,%esp
        ip = idup(myproc()->cwd);
80101cf1:	8b 70 68             	mov    0x68(%eax),%esi
    acquire(&icache.lock);
80101cf4:	68 e0 29 11 80       	push   $0x801129e0
80101cf9:	e8 92 2f 00 00       	call   80104c90 <acquire>
    ip->ref++;
80101cfe:	83 46 08 01          	addl   $0x1,0x8(%esi)
    release(&icache.lock);
80101d02:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101d09:	e8 a2 30 00 00       	call   80104db0 <release>
80101d0e:	83 c4 10             	add    $0x10,%esp
80101d11:	eb 08                	jmp    80101d1b <namex+0x4b>
80101d13:	90                   	nop
80101d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        path++;
80101d18:	83 c3 01             	add    $0x1,%ebx
    while (*path == '/')
80101d1b:	0f b6 03             	movzbl (%ebx),%eax
80101d1e:	3c 2f                	cmp    $0x2f,%al
80101d20:	74 f6                	je     80101d18 <namex+0x48>
    if (*path == 0)
80101d22:	84 c0                	test   %al,%al
80101d24:	0f 84 ee 00 00 00    	je     80101e18 <namex+0x148>
    while (*path != '/' && *path != 0)
80101d2a:	0f b6 03             	movzbl (%ebx),%eax
80101d2d:	3c 2f                	cmp    $0x2f,%al
80101d2f:	0f 84 b3 00 00 00    	je     80101de8 <namex+0x118>
80101d35:	84 c0                	test   %al,%al
80101d37:	89 da                	mov    %ebx,%edx
80101d39:	75 09                	jne    80101d44 <namex+0x74>
80101d3b:	e9 a8 00 00 00       	jmp    80101de8 <namex+0x118>
80101d40:	84 c0                	test   %al,%al
80101d42:	74 0a                	je     80101d4e <namex+0x7e>
        path++;
80101d44:	83 c2 01             	add    $0x1,%edx
    while (*path != '/' && *path != 0)
80101d47:	0f b6 02             	movzbl (%edx),%eax
80101d4a:	3c 2f                	cmp    $0x2f,%al
80101d4c:	75 f2                	jne    80101d40 <namex+0x70>
80101d4e:	89 d1                	mov    %edx,%ecx
80101d50:	29 d9                	sub    %ebx,%ecx
    if (len >= DIRSIZ)
80101d52:	83 f9 0d             	cmp    $0xd,%ecx
80101d55:	0f 8e 91 00 00 00    	jle    80101dec <namex+0x11c>
        memmove(name, s, DIRSIZ);
80101d5b:	83 ec 04             	sub    $0x4,%esp
80101d5e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d61:	6a 0e                	push   $0xe
80101d63:	53                   	push   %ebx
80101d64:	57                   	push   %edi
80101d65:	e8 56 31 00 00       	call   80104ec0 <memmove>
        path++;
80101d6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        memmove(name, s, DIRSIZ);
80101d6d:	83 c4 10             	add    $0x10,%esp
        path++;
80101d70:	89 d3                	mov    %edx,%ebx
    while (*path == '/')
80101d72:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d75:	75 11                	jne    80101d88 <namex+0xb8>
80101d77:	89 f6                	mov    %esi,%esi
80101d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        path++;
80101d80:	83 c3 01             	add    $0x1,%ebx
    while (*path == '/')
80101d83:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d86:	74 f8                	je     80101d80 <namex+0xb0>

    while ((path = skipelem(path, name)) != 0) {
        ilock(ip);
80101d88:	83 ec 0c             	sub    $0xc,%esp
80101d8b:	56                   	push   %esi
80101d8c:	e8 5f f9 ff ff       	call   801016f0 <ilock>
        if (ip->type != T_DIR) {
80101d91:	83 c4 10             	add    $0x10,%esp
80101d94:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d99:	0f 85 91 00 00 00    	jne    80101e30 <namex+0x160>
            iunlockput(ip);
            return 0;
        }
        if (nameiparent && *path == '\0') {
80101d9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101da2:	85 d2                	test   %edx,%edx
80101da4:	74 09                	je     80101daf <namex+0xdf>
80101da6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101da9:	0f 84 b7 00 00 00    	je     80101e66 <namex+0x196>
            // Stop one level early.
            iunlock(ip);
            return ip;
        }
        if ((next = dirlookup(ip, name, 0)) == 0) {
80101daf:	83 ec 04             	sub    $0x4,%esp
80101db2:	6a 00                	push   $0x0
80101db4:	57                   	push   %edi
80101db5:	56                   	push   %esi
80101db6:	e8 65 fe ff ff       	call   80101c20 <dirlookup>
80101dbb:	83 c4 10             	add    $0x10,%esp
80101dbe:	85 c0                	test   %eax,%eax
80101dc0:	74 6e                	je     80101e30 <namex+0x160>
    iunlock(ip);
80101dc2:	83 ec 0c             	sub    $0xc,%esp
80101dc5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101dc8:	56                   	push   %esi
80101dc9:	e8 02 fa ff ff       	call   801017d0 <iunlock>
    iput(ip);
80101dce:	89 34 24             	mov    %esi,(%esp)
80101dd1:	e8 4a fa ff ff       	call   80101820 <iput>
80101dd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101dd9:	83 c4 10             	add    $0x10,%esp
80101ddc:	89 c6                	mov    %eax,%esi
80101dde:	e9 38 ff ff ff       	jmp    80101d1b <namex+0x4b>
80101de3:	90                   	nop
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while (*path != '/' && *path != 0)
80101de8:	89 da                	mov    %ebx,%edx
80101dea:	31 c9                	xor    %ecx,%ecx
        memmove(name, s, len);
80101dec:	83 ec 04             	sub    $0x4,%esp
80101def:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101df2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101df5:	51                   	push   %ecx
80101df6:	53                   	push   %ebx
80101df7:	57                   	push   %edi
80101df8:	e8 c3 30 00 00       	call   80104ec0 <memmove>
        name[len] = 0;
80101dfd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e00:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e03:	83 c4 10             	add    $0x10,%esp
80101e06:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e0a:	89 d3                	mov    %edx,%ebx
80101e0c:	e9 61 ff ff ff       	jmp    80101d72 <namex+0xa2>
80101e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            return 0;
        }
        iunlockput(ip);
        ip = next;
    }
    if (nameiparent) {
80101e18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e1b:	85 c0                	test   %eax,%eax
80101e1d:	75 5d                	jne    80101e7c <namex+0x1ac>
        iput(ip);
        return 0;
    }
    return ip;
}
80101e1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e22:	89 f0                	mov    %esi,%eax
80101e24:	5b                   	pop    %ebx
80101e25:	5e                   	pop    %esi
80101e26:	5f                   	pop    %edi
80101e27:	5d                   	pop    %ebp
80101e28:	c3                   	ret    
80101e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlock(ip);
80101e30:	83 ec 0c             	sub    $0xc,%esp
80101e33:	56                   	push   %esi
80101e34:	e8 97 f9 ff ff       	call   801017d0 <iunlock>
    iput(ip);
80101e39:	89 34 24             	mov    %esi,(%esp)
            return 0;
80101e3c:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e3e:	e8 dd f9 ff ff       	call   80101820 <iput>
            return 0;
80101e43:	83 c4 10             	add    $0x10,%esp
}
80101e46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e49:	89 f0                	mov    %esi,%eax
80101e4b:	5b                   	pop    %ebx
80101e4c:	5e                   	pop    %esi
80101e4d:	5f                   	pop    %edi
80101e4e:	5d                   	pop    %ebp
80101e4f:	c3                   	ret    
        ip = iget(ROOTDEV, ROOTINO);
80101e50:	ba 01 00 00 00       	mov    $0x1,%edx
80101e55:	b8 01 00 00 00       	mov    $0x1,%eax
80101e5a:	e8 21 f4 ff ff       	call   80101280 <iget>
80101e5f:	89 c6                	mov    %eax,%esi
80101e61:	e9 b5 fe ff ff       	jmp    80101d1b <namex+0x4b>
            iunlock(ip);
80101e66:	83 ec 0c             	sub    $0xc,%esp
80101e69:	56                   	push   %esi
80101e6a:	e8 61 f9 ff ff       	call   801017d0 <iunlock>
            return ip;
80101e6f:	83 c4 10             	add    $0x10,%esp
}
80101e72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e75:	89 f0                	mov    %esi,%eax
80101e77:	5b                   	pop    %ebx
80101e78:	5e                   	pop    %esi
80101e79:	5f                   	pop    %edi
80101e7a:	5d                   	pop    %ebp
80101e7b:	c3                   	ret    
        iput(ip);
80101e7c:	83 ec 0c             	sub    $0xc,%esp
80101e7f:	56                   	push   %esi
        return 0;
80101e80:	31 f6                	xor    %esi,%esi
        iput(ip);
80101e82:	e8 99 f9 ff ff       	call   80101820 <iput>
        return 0;
80101e87:	83 c4 10             	add    $0x10,%esp
80101e8a:	eb 93                	jmp    80101e1f <namex+0x14f>
80101e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e90 <dirlink>:
dirlink(struct inode *dp, char *name, uint inum) {
80101e90:	55                   	push   %ebp
80101e91:	89 e5                	mov    %esp,%ebp
80101e93:	57                   	push   %edi
80101e94:	56                   	push   %esi
80101e95:	53                   	push   %ebx
80101e96:	83 ec 20             	sub    $0x20,%esp
80101e99:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if ((ip = dirlookup(dp, name, 0)) != 0) {
80101e9c:	6a 00                	push   $0x0
80101e9e:	ff 75 0c             	pushl  0xc(%ebp)
80101ea1:	53                   	push   %ebx
80101ea2:	e8 79 fd ff ff       	call   80101c20 <dirlookup>
80101ea7:	83 c4 10             	add    $0x10,%esp
80101eaa:	85 c0                	test   %eax,%eax
80101eac:	75 67                	jne    80101f15 <dirlink+0x85>
    for (off = 0; off < dp->size; off += sizeof(de)) {
80101eae:	8b 7b 58             	mov    0x58(%ebx),%edi
80101eb1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101eb4:	85 ff                	test   %edi,%edi
80101eb6:	74 29                	je     80101ee1 <dirlink+0x51>
80101eb8:	31 ff                	xor    %edi,%edi
80101eba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ebd:	eb 09                	jmp    80101ec8 <dirlink+0x38>
80101ebf:	90                   	nop
80101ec0:	83 c7 10             	add    $0x10,%edi
80101ec3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101ec6:	73 19                	jae    80101ee1 <dirlink+0x51>
        if (readi(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
80101ec8:	6a 10                	push   $0x10
80101eca:	57                   	push   %edi
80101ecb:	56                   	push   %esi
80101ecc:	53                   	push   %ebx
80101ecd:	e8 fe fa ff ff       	call   801019d0 <readi>
80101ed2:	83 c4 10             	add    $0x10,%esp
80101ed5:	83 f8 10             	cmp    $0x10,%eax
80101ed8:	75 4e                	jne    80101f28 <dirlink+0x98>
        if (de.inum == 0)
80101eda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101edf:	75 df                	jne    80101ec0 <dirlink+0x30>
    strncpy(de.name, name, DIRSIZ);
80101ee1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ee4:	83 ec 04             	sub    $0x4,%esp
80101ee7:	6a 0e                	push   $0xe
80101ee9:	ff 75 0c             	pushl  0xc(%ebp)
80101eec:	50                   	push   %eax
80101eed:	e8 9e 30 00 00       	call   80104f90 <strncpy>
    de.inum = inum;
80101ef2:	8b 45 10             	mov    0x10(%ebp),%eax
    if (writei(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
80101ef5:	6a 10                	push   $0x10
80101ef7:	57                   	push   %edi
80101ef8:	56                   	push   %esi
80101ef9:	53                   	push   %ebx
    de.inum = inum;
80101efa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
    if (writei(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
80101efe:	e8 cd fb ff ff       	call   80101ad0 <writei>
80101f03:	83 c4 20             	add    $0x20,%esp
80101f06:	83 f8 10             	cmp    $0x10,%eax
80101f09:	75 2a                	jne    80101f35 <dirlink+0xa5>
    return 0;
80101f0b:	31 c0                	xor    %eax,%eax
}
80101f0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f10:	5b                   	pop    %ebx
80101f11:	5e                   	pop    %esi
80101f12:	5f                   	pop    %edi
80101f13:	5d                   	pop    %ebp
80101f14:	c3                   	ret    
        iput(ip);
80101f15:	83 ec 0c             	sub    $0xc,%esp
80101f18:	50                   	push   %eax
80101f19:	e8 02 f9 ff ff       	call   80101820 <iput>
        return -1;
80101f1e:	83 c4 10             	add    $0x10,%esp
80101f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f26:	eb e5                	jmp    80101f0d <dirlink+0x7d>
            panic("dirlink read");
80101f28:	83 ec 0c             	sub    $0xc,%esp
80101f2b:	68 51 82 10 80       	push   $0x80108251
80101f30:	e8 5b e4 ff ff       	call   80100390 <panic>
        panic("dirlink");
80101f35:	83 ec 0c             	sub    $0xc,%esp
80101f38:	68 5d 89 10 80       	push   $0x8010895d
80101f3d:	e8 4e e4 ff ff       	call   80100390 <panic>
80101f42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f50 <namei>:

struct inode *
namei(char *path) {
80101f50:	55                   	push   %ebp
    char name[DIRSIZ];
    return namex(path, 0, name);
80101f51:	31 d2                	xor    %edx,%edx
namei(char *path) {
80101f53:	89 e5                	mov    %esp,%ebp
80101f55:	83 ec 18             	sub    $0x18,%esp
    return namex(path, 0, name);
80101f58:	8b 45 08             	mov    0x8(%ebp),%eax
80101f5b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f5e:	e8 6d fd ff ff       	call   80101cd0 <namex>
}
80101f63:	c9                   	leave  
80101f64:	c3                   	ret    
80101f65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f70 <nameiparent>:

struct inode *
nameiparent(char *path, char *name) {
80101f70:	55                   	push   %ebp
    return namex(path, 1, name);
80101f71:	ba 01 00 00 00       	mov    $0x1,%edx
nameiparent(char *path, char *name) {
80101f76:	89 e5                	mov    %esp,%ebp
    return namex(path, 1, name);
80101f78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f7e:	5d                   	pop    %ebp
    return namex(path, 1, name);
80101f7f:	e9 4c fd ff ff       	jmp    80101cd0 <namex>
80101f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101f90 <itoa>:

#include "fcntl.h"

#define DIGITS 14

char *itoa(int i, char b[]) {
80101f90:	55                   	push   %ebp
    char const digit[] = "0123456789";
80101f91:	b8 38 39 00 00       	mov    $0x3938,%eax
char *itoa(int i, char b[]) {
80101f96:	89 e5                	mov    %esp,%ebp
80101f98:	57                   	push   %edi
80101f99:	56                   	push   %esi
80101f9a:	53                   	push   %ebx
80101f9b:	83 ec 10             	sub    $0x10,%esp
80101f9e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80101fa1:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80101fa8:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80101faf:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80101fb3:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
80101fb7:	8b 75 0c             	mov    0xc(%ebp),%esi
    char *p = b;
    if (i < 0) {
80101fba:	85 c9                	test   %ecx,%ecx
80101fbc:	79 0a                	jns    80101fc8 <itoa+0x38>
80101fbe:	89 f0                	mov    %esi,%eax
80101fc0:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
80101fc3:	f7 d9                	neg    %ecx
        *p++ = '-';
80101fc5:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
80101fc8:	89 cb                	mov    %ecx,%ebx
    do { //Move to where representation ends
        ++p;
        shifter = shifter / 10;
80101fca:	bf 67 66 66 66       	mov    $0x66666667,%edi
80101fcf:	90                   	nop
80101fd0:	89 d8                	mov    %ebx,%eax
80101fd2:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
80101fd5:	83 c6 01             	add    $0x1,%esi
        shifter = shifter / 10;
80101fd8:	f7 ef                	imul   %edi
80101fda:	c1 fa 02             	sar    $0x2,%edx
    } while (shifter);
80101fdd:	29 da                	sub    %ebx,%edx
80101fdf:	89 d3                	mov    %edx,%ebx
80101fe1:	75 ed                	jne    80101fd0 <itoa+0x40>
    *p = '\0';
80101fe3:	c6 06 00             	movb   $0x0,(%esi)
    do { //Move back, inserting digits as u go
        *--p = digit[i % 10];
80101fe6:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80101feb:	90                   	nop
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ff0:	89 c8                	mov    %ecx,%eax
80101ff2:	83 ee 01             	sub    $0x1,%esi
80101ff5:	f7 eb                	imul   %ebx
80101ff7:	89 c8                	mov    %ecx,%eax
80101ff9:	c1 f8 1f             	sar    $0x1f,%eax
80101ffc:	c1 fa 02             	sar    $0x2,%edx
80101fff:	29 c2                	sub    %eax,%edx
80102001:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102004:	01 c0                	add    %eax,%eax
80102006:	29 c1                	sub    %eax,%ecx
        i = i / 10;
    } while (i);
80102008:	85 d2                	test   %edx,%edx
        *--p = digit[i % 10];
8010200a:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i / 10;
8010200f:	89 d1                	mov    %edx,%ecx
        *--p = digit[i % 10];
80102011:	88 06                	mov    %al,(%esi)
    } while (i);
80102013:	75 db                	jne    80101ff0 <itoa+0x60>
    return b;
}
80102015:	8b 45 0c             	mov    0xc(%ebp),%eax
80102018:	83 c4 10             	add    $0x10,%esp
8010201b:	5b                   	pop    %ebx
8010201c:	5e                   	pop    %esi
8010201d:	5f                   	pop    %edi
8010201e:	5d                   	pop    %ebp
8010201f:	c3                   	ret    

80102020 <removeSwapFile>:

//remove swap file of proc p;
int
removeSwapFile(struct proc *p) {
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	57                   	push   %edi
80102024:	56                   	push   %esi
80102025:	53                   	push   %ebx
    //path of proccess
    char path[DIGITS];
    memmove(path, "/.swap", 6);
80102026:	8d 75 bc             	lea    -0x44(%ebp),%esi
removeSwapFile(struct proc *p) {
80102029:	83 ec 40             	sub    $0x40,%esp
8010202c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    memmove(path, "/.swap", 6);
8010202f:	6a 06                	push   $0x6
80102031:	68 5e 82 10 80       	push   $0x8010825e
80102036:	56                   	push   %esi
80102037:	e8 84 2e 00 00       	call   80104ec0 <memmove>
    itoa(p->pid, path + 6);
8010203c:	58                   	pop    %eax
8010203d:	8d 45 c2             	lea    -0x3e(%ebp),%eax
80102040:	5a                   	pop    %edx
80102041:	50                   	push   %eax
80102042:	ff 73 10             	pushl  0x10(%ebx)
80102045:	e8 46 ff ff ff       	call   80101f90 <itoa>
    struct inode *ip, *dp;
    struct dirent de;
    char name[DIRSIZ];
    uint off;

    if (0 == p->swapFile) {
8010204a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010204d:	83 c4 10             	add    $0x10,%esp
80102050:	85 c0                	test   %eax,%eax
80102052:	0f 84 88 01 00 00    	je     801021e0 <removeSwapFile+0x1c0>
        return -1;
    }
    fileclose(p->swapFile);
80102058:	83 ec 0c             	sub    $0xc,%esp
    return namex(path, 1, name);
8010205b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
    fileclose(p->swapFile);
8010205e:	50                   	push   %eax
8010205f:	e8 2c ee ff ff       	call   80100e90 <fileclose>

    begin_op();
80102064:	e8 27 12 00 00       	call   80103290 <begin_op>
    return namex(path, 1, name);
80102069:	89 f0                	mov    %esi,%eax
8010206b:	89 d9                	mov    %ebx,%ecx
8010206d:	ba 01 00 00 00       	mov    $0x1,%edx
80102072:	e8 59 fc ff ff       	call   80101cd0 <namex>
    if ((dp = nameiparent(path, name)) == 0) {
80102077:	83 c4 10             	add    $0x10,%esp
8010207a:	85 c0                	test   %eax,%eax
    return namex(path, 1, name);
8010207c:	89 c6                	mov    %eax,%esi
    if ((dp = nameiparent(path, name)) == 0) {
8010207e:	0f 84 66 01 00 00    	je     801021ea <removeSwapFile+0x1ca>
        end_op();
        return -1;
    }

    ilock(dp);
80102084:	83 ec 0c             	sub    $0xc,%esp
80102087:	50                   	push   %eax
80102088:	e8 63 f6 ff ff       	call   801016f0 <ilock>
    return strncmp(s, t, DIRSIZ);
8010208d:	83 c4 0c             	add    $0xc,%esp
80102090:	6a 0e                	push   $0xe
80102092:	68 66 82 10 80       	push   $0x80108266
80102097:	53                   	push   %ebx
80102098:	e8 93 2e 00 00       	call   80104f30 <strncmp>

    // Cannot unlink "." or "..".
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010209d:	83 c4 10             	add    $0x10,%esp
801020a0:	85 c0                	test   %eax,%eax
801020a2:	0f 84 f8 00 00 00    	je     801021a0 <removeSwapFile+0x180>
    return strncmp(s, t, DIRSIZ);
801020a8:	83 ec 04             	sub    $0x4,%esp
801020ab:	6a 0e                	push   $0xe
801020ad:	68 65 82 10 80       	push   $0x80108265
801020b2:	53                   	push   %ebx
801020b3:	e8 78 2e 00 00       	call   80104f30 <strncmp>
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801020b8:	83 c4 10             	add    $0x10,%esp
801020bb:	85 c0                	test   %eax,%eax
801020bd:	0f 84 dd 00 00 00    	je     801021a0 <removeSwapFile+0x180>
        goto bad;

    if ((ip = dirlookup(dp, name, &off)) == 0)
801020c3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801020c6:	83 ec 04             	sub    $0x4,%esp
801020c9:	50                   	push   %eax
801020ca:	53                   	push   %ebx
801020cb:	56                   	push   %esi
801020cc:	e8 4f fb ff ff       	call   80101c20 <dirlookup>
801020d1:	83 c4 10             	add    $0x10,%esp
801020d4:	85 c0                	test   %eax,%eax
801020d6:	89 c3                	mov    %eax,%ebx
801020d8:	0f 84 c2 00 00 00    	je     801021a0 <removeSwapFile+0x180>
        goto bad;
    ilock(ip);
801020de:	83 ec 0c             	sub    $0xc,%esp
801020e1:	50                   	push   %eax
801020e2:	e8 09 f6 ff ff       	call   801016f0 <ilock>

    if (ip->nlink < 1)
801020e7:	83 c4 10             	add    $0x10,%esp
801020ea:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801020ef:	0f 8e 11 01 00 00    	jle    80102206 <removeSwapFile+0x1e6>
        panic("unlink: nlink < 1");
    if (ip->type == T_DIR && !isdirempty(ip)) {
801020f5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801020fa:	74 74                	je     80102170 <removeSwapFile+0x150>
        iunlockput(ip);
        goto bad;
    }

    memset(&de, 0, sizeof(de));
801020fc:	8d 7d d8             	lea    -0x28(%ebp),%edi
801020ff:	83 ec 04             	sub    $0x4,%esp
80102102:	6a 10                	push   $0x10
80102104:	6a 00                	push   $0x0
80102106:	57                   	push   %edi
80102107:	e8 04 2d 00 00       	call   80104e10 <memset>
    if (writei(dp, (char *) &de, off, sizeof(de)) != sizeof(de))
8010210c:	6a 10                	push   $0x10
8010210e:	ff 75 b8             	pushl  -0x48(%ebp)
80102111:	57                   	push   %edi
80102112:	56                   	push   %esi
80102113:	e8 b8 f9 ff ff       	call   80101ad0 <writei>
80102118:	83 c4 20             	add    $0x20,%esp
8010211b:	83 f8 10             	cmp    $0x10,%eax
8010211e:	0f 85 d5 00 00 00    	jne    801021f9 <removeSwapFile+0x1d9>
        panic("unlink: writei");
    if (ip->type == T_DIR) {
80102124:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102129:	0f 84 91 00 00 00    	je     801021c0 <removeSwapFile+0x1a0>
    iunlock(ip);
8010212f:	83 ec 0c             	sub    $0xc,%esp
80102132:	56                   	push   %esi
80102133:	e8 98 f6 ff ff       	call   801017d0 <iunlock>
    iput(ip);
80102138:	89 34 24             	mov    %esi,(%esp)
8010213b:	e8 e0 f6 ff ff       	call   80101820 <iput>
        dp->nlink--;
        iupdate(dp);
    }
    iunlockput(dp);

    ip->nlink--;
80102140:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
    iupdate(ip);
80102145:	89 1c 24             	mov    %ebx,(%esp)
80102148:	e8 f3 f4 ff ff       	call   80101640 <iupdate>
    iunlock(ip);
8010214d:	89 1c 24             	mov    %ebx,(%esp)
80102150:	e8 7b f6 ff ff       	call   801017d0 <iunlock>
    iput(ip);
80102155:	89 1c 24             	mov    %ebx,(%esp)
80102158:	e8 c3 f6 ff ff       	call   80101820 <iput>
    iunlockput(ip);

    end_op();
8010215d:	e8 9e 11 00 00       	call   80103300 <end_op>

    return 0;
80102162:	83 c4 10             	add    $0x10,%esp
80102165:	31 c0                	xor    %eax,%eax
    bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102167:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010216a:	5b                   	pop    %ebx
8010216b:	5e                   	pop    %esi
8010216c:	5f                   	pop    %edi
8010216d:	5d                   	pop    %ebp
8010216e:	c3                   	ret    
8010216f:	90                   	nop
    if (ip->type == T_DIR && !isdirempty(ip)) {
80102170:	83 ec 0c             	sub    $0xc,%esp
80102173:	53                   	push   %ebx
80102174:	e8 77 34 00 00       	call   801055f0 <isdirempty>
80102179:	83 c4 10             	add    $0x10,%esp
8010217c:	85 c0                	test   %eax,%eax
8010217e:	0f 85 78 ff ff ff    	jne    801020fc <removeSwapFile+0xdc>
    iunlock(ip);
80102184:	83 ec 0c             	sub    $0xc,%esp
80102187:	53                   	push   %ebx
80102188:	e8 43 f6 ff ff       	call   801017d0 <iunlock>
    iput(ip);
8010218d:	89 1c 24             	mov    %ebx,(%esp)
80102190:	e8 8b f6 ff ff       	call   80101820 <iput>
80102195:	83 c4 10             	add    $0x10,%esp
80102198:	90                   	nop
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlock(ip);
801021a0:	83 ec 0c             	sub    $0xc,%esp
801021a3:	56                   	push   %esi
801021a4:	e8 27 f6 ff ff       	call   801017d0 <iunlock>
    iput(ip);
801021a9:	89 34 24             	mov    %esi,(%esp)
801021ac:	e8 6f f6 ff ff       	call   80101820 <iput>
    end_op();
801021b1:	e8 4a 11 00 00       	call   80103300 <end_op>
    return -1;
801021b6:	83 c4 10             	add    $0x10,%esp
801021b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021be:	eb a7                	jmp    80102167 <removeSwapFile+0x147>
        dp->nlink--;
801021c0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
        iupdate(dp);
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	56                   	push   %esi
801021c9:	e8 72 f4 ff ff       	call   80101640 <iupdate>
801021ce:	83 c4 10             	add    $0x10,%esp
801021d1:	e9 59 ff ff ff       	jmp    8010212f <removeSwapFile+0x10f>
801021d6:	8d 76 00             	lea    0x0(%esi),%esi
801021d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        return -1;
801021e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021e5:	e9 7d ff ff ff       	jmp    80102167 <removeSwapFile+0x147>
        end_op();
801021ea:	e8 11 11 00 00       	call   80103300 <end_op>
        return -1;
801021ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021f4:	e9 6e ff ff ff       	jmp    80102167 <removeSwapFile+0x147>
        panic("unlink: writei");
801021f9:	83 ec 0c             	sub    $0xc,%esp
801021fc:	68 7a 82 10 80       	push   $0x8010827a
80102201:	e8 8a e1 ff ff       	call   80100390 <panic>
        panic("unlink: nlink < 1");
80102206:	83 ec 0c             	sub    $0xc,%esp
80102209:	68 68 82 10 80       	push   $0x80108268
8010220e:	e8 7d e1 ff ff       	call   80100390 <panic>
80102213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102220 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc *p) {
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	56                   	push   %esi
80102224:	53                   	push   %ebx

    char path[DIGITS];
    memmove(path, "/.swap", 6);
80102225:	8d 75 ea             	lea    -0x16(%ebp),%esi
createSwapFile(struct proc *p) {
80102228:	83 ec 14             	sub    $0x14,%esp
8010222b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    memmove(path, "/.swap", 6);
8010222e:	6a 06                	push   $0x6
80102230:	68 5e 82 10 80       	push   $0x8010825e
80102235:	56                   	push   %esi
80102236:	e8 85 2c 00 00       	call   80104ec0 <memmove>
    itoa(p->pid, path + 6);
8010223b:	58                   	pop    %eax
8010223c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010223f:	5a                   	pop    %edx
80102240:	50                   	push   %eax
80102241:	ff 73 10             	pushl  0x10(%ebx)
80102244:	e8 47 fd ff ff       	call   80101f90 <itoa>

    begin_op();
80102249:	e8 42 10 00 00       	call   80103290 <begin_op>
    struct inode *in = create(path, T_FILE, 0, 0);
8010224e:	6a 00                	push   $0x0
80102250:	6a 00                	push   $0x0
80102252:	6a 02                	push   $0x2
80102254:	56                   	push   %esi
80102255:	e8 a6 35 00 00       	call   80105800 <create>
    iunlock(in);
8010225a:	83 c4 14             	add    $0x14,%esp
    struct inode *in = create(path, T_FILE, 0, 0);
8010225d:	89 c6                	mov    %eax,%esi
    iunlock(in);
8010225f:	50                   	push   %eax
80102260:	e8 6b f5 ff ff       	call   801017d0 <iunlock>

    p->swapFile = filealloc();
80102265:	e8 66 eb ff ff       	call   80100dd0 <filealloc>
    if (p->swapFile == 0)
8010226a:	83 c4 10             	add    $0x10,%esp
8010226d:	85 c0                	test   %eax,%eax
    p->swapFile = filealloc();
8010226f:	89 43 7c             	mov    %eax,0x7c(%ebx)
    if (p->swapFile == 0)
80102272:	74 32                	je     801022a6 <createSwapFile+0x86>
        panic("no slot for files on /store");

    p->swapFile->ip = in;
80102274:	89 70 10             	mov    %esi,0x10(%eax)
    p->swapFile->type = FD_INODE;
80102277:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010227a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
    p->swapFile->off = 0;
80102280:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102283:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    p->swapFile->readable = O_WRONLY;
8010228a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010228d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
    p->swapFile->writable = O_RDWR;
80102291:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102294:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
80102298:	e8 63 10 00 00       	call   80103300 <end_op>

    return 0;
}
8010229d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022a0:	31 c0                	xor    %eax,%eax
801022a2:	5b                   	pop    %ebx
801022a3:	5e                   	pop    %esi
801022a4:	5d                   	pop    %ebp
801022a5:	c3                   	ret    
        panic("no slot for files on /store");
801022a6:	83 ec 0c             	sub    $0xc,%esp
801022a9:	68 89 82 10 80       	push   $0x80108289
801022ae:	e8 dd e0 ff ff       	call   80100390 <panic>
801022b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022c0 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc *p, char *buffer, uint placeOnFile, uint size) {
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	8b 45 08             	mov    0x8(%ebp),%eax
    p->swapFile->off = placeOnFile;
801022c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801022c9:	8b 50 7c             	mov    0x7c(%eax),%edx
801022cc:	89 4a 14             	mov    %ecx,0x14(%edx)

    return filewrite(p->swapFile, buffer, size);
801022cf:	8b 55 14             	mov    0x14(%ebp),%edx
801022d2:	89 55 10             	mov    %edx,0x10(%ebp)
801022d5:	8b 40 7c             	mov    0x7c(%eax),%eax
801022d8:	89 45 08             	mov    %eax,0x8(%ebp)

}
801022db:	5d                   	pop    %ebp
    return filewrite(p->swapFile, buffer, size);
801022dc:	e9 5f ed ff ff       	jmp    80101040 <filewrite>
801022e1:	eb 0d                	jmp    801022f0 <readFromSwapFile>
801022e3:	90                   	nop
801022e4:	90                   	nop
801022e5:	90                   	nop
801022e6:	90                   	nop
801022e7:	90                   	nop
801022e8:	90                   	nop
801022e9:	90                   	nop
801022ea:	90                   	nop
801022eb:	90                   	nop
801022ec:	90                   	nop
801022ed:	90                   	nop
801022ee:	90                   	nop
801022ef:	90                   	nop

801022f0 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc *p, char *buffer, uint placeOnFile, uint size) {
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	8b 45 08             	mov    0x8(%ebp),%eax
    p->swapFile->off = placeOnFile;
801022f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801022f9:	8b 50 7c             	mov    0x7c(%eax),%edx
801022fc:	89 4a 14             	mov    %ecx,0x14(%edx)

    return fileread(p->swapFile, buffer, size);
801022ff:	8b 55 14             	mov    0x14(%ebp),%edx
80102302:	89 55 10             	mov    %edx,0x10(%ebp)
80102305:	8b 40 7c             	mov    0x7c(%eax),%eax
80102308:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010230b:	5d                   	pop    %ebp
    return fileread(p->swapFile, buffer, size);
8010230c:	e9 9f ec ff ff       	jmp    80100fb0 <fileread>
80102311:	eb 0d                	jmp    80102320 <copyParentSwapFile>
80102313:	90                   	nop
80102314:	90                   	nop
80102315:	90                   	nop
80102316:	90                   	nop
80102317:	90                   	nop
80102318:	90                   	nop
80102319:	90                   	nop
8010231a:	90                   	nop
8010231b:	90                   	nop
8010231c:	90                   	nop
8010231d:	90                   	nop
8010231e:	90                   	nop
8010231f:	90                   	nop

80102320 <copyParentSwapFile>:

int
copyParentSwapFile(struct proc *np) {
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	57                   	push   %edi
80102324:	56                   	push   %esi
80102325:	53                   	push   %ebx
80102326:	81 ec 18 10 00 00    	sub    $0x1018,%esp
8010232c:	8b 7d 08             	mov    0x8(%ebp),%edi
    cprintf("copyParentSwapFile...\n");
8010232f:	68 a5 82 10 80       	push   $0x801082a5
80102334:	e8 27 e3 ff ff       	call   80100660 <cprintf>
    if (myproc()->pid > 2) {
80102339:	e8 e2 1b 00 00       	call   80103f20 <myproc>
8010233e:	83 c4 10             	add    $0x10,%esp
80102341:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
80102345:	7e 7a                	jle    801023c1 <copyParentSwapFile+0xa1>
        char buff[PGSIZE];
        int swapArrSize = MAX_TOTAL_PAGES - MAX_PYSC_PAGES;
        for (int i = 0; i < swapArrSize; i++) {
80102347:	31 f6                	xor    %esi,%esi
80102349:	eb 0d                	jmp    80102358 <copyParentSwapFile+0x38>
8010234b:	90                   	nop
8010234c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102350:	83 c6 01             	add    $0x1,%esi
80102353:	83 fe 10             	cmp    $0x10,%esi
80102356:	74 78                	je     801023d0 <copyParentSwapFile+0xb0>
            if (myproc()->swap_monitor[i].used == 1) {
80102358:	e8 c3 1b 00 00       	call   80103f20 <myproc>
8010235d:	8d 4e 18             	lea    0x18(%esi),%ecx
80102360:	c1 e1 04             	shl    $0x4,%ecx
80102363:	83 3c 08 01          	cmpl   $0x1,(%eax,%ecx,1)
80102367:	75 e7                	jne    80102350 <copyParentSwapFile+0x30>
                if (readFromSwapFile(myproc(), buff, PGSIZE * i, PGSIZE) != PGSIZE)
80102369:	e8 b2 1b 00 00       	call   80103f20 <myproc>
    p->swapFile->off = placeOnFile;
8010236e:	8b 48 7c             	mov    0x7c(%eax),%ecx
    return fileread(p->swapFile, buffer, size);
80102371:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
80102377:	89 f3                	mov    %esi,%ebx
80102379:	83 ec 04             	sub    $0x4,%esp
8010237c:	c1 e3 0c             	shl    $0xc,%ebx
    p->swapFile->off = placeOnFile;
8010237f:	89 59 14             	mov    %ebx,0x14(%ecx)
    return fileread(p->swapFile, buffer, size);
80102382:	68 00 10 00 00       	push   $0x1000
80102387:	52                   	push   %edx
80102388:	ff 70 7c             	pushl  0x7c(%eax)
8010238b:	e8 20 ec ff ff       	call   80100fb0 <fileread>
                if (readFromSwapFile(myproc(), buff, PGSIZE * i, PGSIZE) != PGSIZE)
80102390:	83 c4 10             	add    $0x10,%esp
80102393:	3d 00 10 00 00       	cmp    $0x1000,%eax
80102398:	75 27                	jne    801023c1 <copyParentSwapFile+0xa1>
    p->swapFile->off = placeOnFile;
8010239a:	8b 47 7c             	mov    0x7c(%edi),%eax
    return filewrite(p->swapFile, buffer, size);
8010239d:	83 ec 04             	sub    $0x4,%esp
    p->swapFile->off = placeOnFile;
801023a0:	89 58 14             	mov    %ebx,0x14(%eax)
    return filewrite(p->swapFile, buffer, size);
801023a3:	8d 85 e8 ef ff ff    	lea    -0x1018(%ebp),%eax
801023a9:	68 00 10 00 00       	push   $0x1000
801023ae:	50                   	push   %eax
801023af:	ff 77 7c             	pushl  0x7c(%edi)
801023b2:	e8 89 ec ff ff       	call   80101040 <filewrite>
                    return -1;
                if (writeToSwapFile(np, buff, PGSIZE * i, PGSIZE) != PGSIZE)
801023b7:	83 c4 10             	add    $0x10,%esp
801023ba:	3d 00 10 00 00       	cmp    $0x1000,%eax
801023bf:	74 8f                	je     80102350 <copyParentSwapFile+0x30>

        }
        return 0;
    }
    return -1;
}
801023c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801023c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801023c9:	5b                   	pop    %ebx
801023ca:	5e                   	pop    %esi
801023cb:	5f                   	pop    %edi
801023cc:	5d                   	pop    %ebp
801023cd:	c3                   	ret    
801023ce:	66 90                	xchg   %ax,%ax
801023d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
801023d3:	31 c0                	xor    %eax,%eax
}
801023d5:	5b                   	pop    %ebx
801023d6:	5e                   	pop    %esi
801023d7:	5f                   	pop    %edi
801023d8:	5d                   	pop    %ebp
801023d9:	c3                   	ret    
801023da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023e0 <get_swap_idx>:


int get_swap_idx() {
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	53                   	push   %ebx
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; ++i) {
801023e4:	31 db                	xor    %ebx,%ebx
int get_swap_idx() {
801023e6:	83 ec 04             	sub    $0x4,%esp
801023e9:	eb 0d                	jmp    801023f8 <get_swap_idx+0x18>
801023eb:	90                   	nop
801023ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; ++i) {
801023f0:	83 c3 01             	add    $0x1,%ebx
801023f3:	83 fb 10             	cmp    $0x10,%ebx
801023f6:	74 20                	je     80102418 <get_swap_idx+0x38>
        if (myproc()->swap_monitor[i].used == 0) {
801023f8:	e8 23 1b 00 00       	call   80103f20 <myproc>
801023fd:	8d 53 18             	lea    0x18(%ebx),%edx
80102400:	c1 e2 04             	shl    $0x4,%edx
80102403:	8b 04 10             	mov    (%eax,%edx,1),%eax
80102406:	85 c0                	test   %eax,%eax
80102408:	75 e6                	jne    801023f0 <get_swap_idx+0x10>
            return i;
        }
    }
    return -1;
}
8010240a:	83 c4 04             	add    $0x4,%esp
8010240d:	89 d8                	mov    %ebx,%eax
8010240f:	5b                   	pop    %ebx
80102410:	5d                   	pop    %ebp
80102411:	c3                   	ret    
80102412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80102418:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010241d:	83 c4 04             	add    $0x4,%esp
80102420:	89 d8                	mov    %ebx,%eax
80102422:	5b                   	pop    %ebx
80102423:	5d                   	pop    %ebp
80102424:	c3                   	ret    
80102425:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <write2file>:

int write2file(int p_va, pde_t *pgdir) {
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	57                   	push   %edi
80102434:	56                   	push   %esi
80102435:	53                   	push   %ebx
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; ++i) {
80102436:	31 db                	xor    %ebx,%ebx
int write2file(int p_va, pde_t *pgdir) {
80102438:	83 ec 0c             	sub    $0xc,%esp
8010243b:	8b 75 08             	mov    0x8(%ebp),%esi
8010243e:	eb 08                	jmp    80102448 <write2file+0x18>
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; ++i) {
80102440:	83 c3 01             	add    $0x1,%ebx
80102443:	83 fb 10             	cmp    $0x10,%ebx
80102446:	74 70                	je     801024b8 <write2file+0x88>
        if (myproc()->swap_monitor[i].used == 0) {
80102448:	e8 d3 1a 00 00       	call   80103f20 <myproc>
8010244d:	8d 53 18             	lea    0x18(%ebx),%edx
80102450:	c1 e2 04             	shl    $0x4,%edx
80102453:	8b 04 10             	mov    (%eax,%edx,1),%eax
80102456:	85 c0                	test   %eax,%eax
80102458:	75 e6                	jne    80102440 <write2file+0x10>
    int swap_idx = get_swap_idx();
    if(swap_idx<0) return -1;
    struct proc *p = myproc();
8010245a:	e8 c1 1a 00 00       	call   80103f20 <myproc>
8010245f:	89 c7                	mov    %eax,%edi
    p->swapFile->off = placeOnFile;
80102461:	8b 40 7c             	mov    0x7c(%eax),%eax
    int success = writeToSwapFile(p, (char*)p_va, PGSIZE * swap_idx, PGSIZE);
80102464:	89 da                	mov    %ebx,%edx
    return filewrite(p->swapFile, buffer, size);
80102466:	83 ec 04             	sub    $0x4,%esp
    int success = writeToSwapFile(p, (char*)p_va, PGSIZE * swap_idx, PGSIZE);
80102469:	c1 e2 0c             	shl    $0xc,%edx
8010246c:	89 50 14             	mov    %edx,0x14(%eax)
    return filewrite(p->swapFile, buffer, size);
8010246f:	68 00 10 00 00       	push   $0x1000
80102474:	56                   	push   %esi
80102475:	ff 77 7c             	pushl  0x7c(%edi)
80102478:	e8 c3 eb ff ff       	call   80101040 <filewrite>
    if (success < 0) return -1;
8010247d:	83 c4 10             	add    $0x10,%esp
80102480:	85 c0                	test   %eax,%eax
80102482:	78 34                	js     801024b8 <write2file+0x88>

    p->swap_monitor[swap_idx].pgdir = pgdir;
80102484:	8b 55 0c             	mov    0xc(%ebp),%edx
80102487:	c1 e3 04             	shl    $0x4,%ebx
8010248a:	01 fb                	add    %edi,%ebx
    p->swap_monitor[swap_idx].p_va = p_va;
8010248c:	89 b3 88 01 00 00    	mov    %esi,0x188(%ebx)
//    cprintf("write2file p_va = %d, idx = %d\n",p->swap_monitor[swap_idx].p_va, swap_idx);
    p->swap_monitor[swap_idx].used = 1;
80102492:	c7 83 80 01 00 00 01 	movl   $0x1,0x180(%ebx)
80102499:	00 00 00 
    p->swap_monitor[swap_idx].pgdir = pgdir;
8010249c:	89 93 84 01 00 00    	mov    %edx,0x184(%ebx)
    p->swap_monitor[swap_idx].place_in_queue = 0;
801024a2:	c7 83 8c 01 00 00 00 	movl   $0x0,0x18c(%ebx)
801024a9:	00 00 00 

    return success;
}
801024ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024af:	5b                   	pop    %ebx
801024b0:	5e                   	pop    %esi
801024b1:	5f                   	pop    %edi
801024b2:	5d                   	pop    %ebp
801024b3:	c3                   	ret    
801024b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(swap_idx<0) return -1;
801024bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801024c0:	5b                   	pop    %ebx
801024c1:	5e                   	pop    %esi
801024c2:	5f                   	pop    %edi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <read_page_from_disk>:

int read_page_from_disk(struct proc *p, int ram_idx, int p_va, char* buff) {
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	56                   	push   %esi
801024d4:	53                   	push   %ebx
801024d5:	8b 75 08             	mov    0x8(%ebp),%esi
801024d8:	8b 55 10             	mov    0x10(%ebp),%edx
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; i++) {
801024db:	31 db                	xor    %ebx,%ebx
801024dd:	8d 86 88 01 00 00    	lea    0x188(%esi),%eax
801024e3:	eb 12                	jmp    801024f7 <read_page_from_disk+0x27>
801024e5:	8d 76 00             	lea    0x0(%esi),%esi
801024e8:	83 c3 01             	add    $0x1,%ebx
801024eb:	83 c0 10             	add    $0x10,%eax
801024ee:	83 fb 10             	cmp    $0x10,%ebx
801024f1:	0f 84 89 00 00 00    	je     80102580 <read_page_from_disk+0xb0>
        if (p->swap_monitor[i].p_va == p_va) {
801024f7:	39 10                	cmp    %edx,(%eax)
801024f9:	75 ed                	jne    801024e8 <read_page_from_disk+0x18>
    p->swapFile->off = placeOnFile;
801024fb:	8b 46 7c             	mov    0x7c(%esi),%eax
            if (readFromSwapFile(p, buff, i * PGSIZE, PGSIZE) < 0) break;
801024fe:	89 da                	mov    %ebx,%edx
    return fileread(p->swapFile, buffer, size);
80102500:	83 ec 04             	sub    $0x4,%esp
            if (readFromSwapFile(p, buff, i * PGSIZE, PGSIZE) < 0) break;
80102503:	c1 e2 0c             	shl    $0xc,%edx
80102506:	89 50 14             	mov    %edx,0x14(%eax)
    return fileread(p->swapFile, buffer, size);
80102509:	68 00 10 00 00       	push   $0x1000
8010250e:	ff 75 14             	pushl  0x14(%ebp)
80102511:	ff 76 7c             	pushl  0x7c(%esi)
80102514:	e8 97 ea ff ff       	call   80100fb0 <fileread>
            if (readFromSwapFile(p, buff, i * PGSIZE, PGSIZE) < 0) break;
80102519:	83 c4 10             	add    $0x10,%esp
8010251c:	85 c0                	test   %eax,%eax
8010251e:	78 60                	js     80102580 <read_page_from_disk+0xb0>
            p->ram_monitor[ram_idx] = p->swap_monitor[i];
80102520:	83 c3 18             	add    $0x18,%ebx
80102523:	8b 45 0c             	mov    0xc(%ebp),%eax
80102526:	c1 e3 04             	shl    $0x4,%ebx
80102529:	01 f3                	add    %esi,%ebx
8010252b:	8b 13                	mov    (%ebx),%edx
8010252d:	c1 e0 04             	shl    $0x4,%eax
80102530:	01 f0                	add    %esi,%eax
80102532:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
80102538:	8b 53 04             	mov    0x4(%ebx),%edx
8010253b:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
80102541:	8b 53 08             	mov    0x8(%ebx),%edx
80102544:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
8010254a:	8b 53 0c             	mov    0xc(%ebx),%edx
8010254d:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
            p->swap_monitor[i].used = 0;
80102553:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
            p->last_in_queue++;
80102559:	8b 8e 84 02 00 00    	mov    0x284(%esi),%ecx
8010255f:	8d 51 01             	lea    0x1(%ecx),%edx
80102562:	89 96 84 02 00 00    	mov    %edx,0x284(%esi)
            p->ram_monitor[ram_idx].place_in_queue = p->last_in_queue;
80102568:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
            return 1;
        }
    }
    return -1;
}
8010256e:	8d 65 f8             	lea    -0x8(%ebp),%esp
            return 1;
80102571:	b8 01 00 00 00       	mov    $0x1,%eax
}
80102576:	5b                   	pop    %ebx
80102577:	5e                   	pop    %esi
80102578:	5d                   	pop    %ebp
80102579:	c3                   	ret    
8010257a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102580:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80102583:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102588:	5b                   	pop    %ebx
80102589:	5e                   	pop    %esi
8010258a:	5d                   	pop    %ebp
8010258b:	c3                   	ret    
8010258c:	66 90                	xchg   %ax,%ax
8010258e:	66 90                	xchg   %ax,%ax

80102590 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	57                   	push   %edi
80102594:	56                   	push   %esi
80102595:	53                   	push   %ebx
80102596:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102599:	85 c0                	test   %eax,%eax
8010259b:	0f 84 b4 00 00 00    	je     80102655 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801025a1:	8b 58 08             	mov    0x8(%eax),%ebx
801025a4:	89 c6                	mov    %eax,%esi
801025a6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801025ac:	0f 87 96 00 00 00    	ja     80102648 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801025b7:	89 f6                	mov    %esi,%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801025c0:	89 ca                	mov    %ecx,%edx
801025c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025c3:	83 e0 c0             	and    $0xffffffc0,%eax
801025c6:	3c 40                	cmp    $0x40,%al
801025c8:	75 f6                	jne    801025c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025ca:	31 ff                	xor    %edi,%edi
801025cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801025d1:	89 f8                	mov    %edi,%eax
801025d3:	ee                   	out    %al,(%dx)
801025d4:	b8 01 00 00 00       	mov    $0x1,%eax
801025d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801025de:	ee                   	out    %al,(%dx)
801025df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801025e4:	89 d8                	mov    %ebx,%eax
801025e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801025e7:	89 d8                	mov    %ebx,%eax
801025e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025ee:	c1 f8 08             	sar    $0x8,%eax
801025f1:	ee                   	out    %al,(%dx)
801025f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025f7:	89 f8                	mov    %edi,%eax
801025f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801025fa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801025fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102603:	c1 e0 04             	shl    $0x4,%eax
80102606:	83 e0 10             	and    $0x10,%eax
80102609:	83 c8 e0             	or     $0xffffffe0,%eax
8010260c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010260d:	f6 06 04             	testb  $0x4,(%esi)
80102610:	75 16                	jne    80102628 <idestart+0x98>
80102612:	b8 20 00 00 00       	mov    $0x20,%eax
80102617:	89 ca                	mov    %ecx,%edx
80102619:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010261a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010261d:	5b                   	pop    %ebx
8010261e:	5e                   	pop    %esi
8010261f:	5f                   	pop    %edi
80102620:	5d                   	pop    %ebp
80102621:	c3                   	ret    
80102622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102628:	b8 30 00 00 00       	mov    $0x30,%eax
8010262d:	89 ca                	mov    %ecx,%edx
8010262f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102630:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102635:	83 c6 5c             	add    $0x5c,%esi
80102638:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010263d:	fc                   	cld    
8010263e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102640:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102643:	5b                   	pop    %ebx
80102644:	5e                   	pop    %esi
80102645:	5f                   	pop    %edi
80102646:	5d                   	pop    %ebp
80102647:	c3                   	ret    
    panic("incorrect blockno");
80102648:	83 ec 0c             	sub    $0xc,%esp
8010264b:	68 18 83 10 80       	push   $0x80108318
80102650:	e8 3b dd ff ff       	call   80100390 <panic>
    panic("idestart");
80102655:	83 ec 0c             	sub    $0xc,%esp
80102658:	68 0f 83 10 80       	push   $0x8010830f
8010265d:	e8 2e dd ff ff       	call   80100390 <panic>
80102662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <ideinit>:
{
80102670:	55                   	push   %ebp
80102671:	89 e5                	mov    %esp,%ebp
80102673:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102676:	68 2a 83 10 80       	push   $0x8010832a
8010267b:	68 80 b5 10 80       	push   $0x8010b580
80102680:	e8 1b 25 00 00       	call   80104ba0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102685:	58                   	pop    %eax
80102686:	a1 00 4d 11 80       	mov    0x80114d00,%eax
8010268b:	5a                   	pop    %edx
8010268c:	83 e8 01             	sub    $0x1,%eax
8010268f:	50                   	push   %eax
80102690:	6a 0e                	push   $0xe
80102692:	e8 a9 02 00 00       	call   80102940 <ioapicenable>
80102697:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010269a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010269f:	90                   	nop
801026a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801026a1:	83 e0 c0             	and    $0xffffffc0,%eax
801026a4:	3c 40                	cmp    $0x40,%al
801026a6:	75 f8                	jne    801026a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801026ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026b2:	ee                   	out    %al,(%dx)
801026b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026bd:	eb 06                	jmp    801026c5 <ideinit+0x55>
801026bf:	90                   	nop
  for(i=0; i<1000; i++){
801026c0:	83 e9 01             	sub    $0x1,%ecx
801026c3:	74 0f                	je     801026d4 <ideinit+0x64>
801026c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801026c6:	84 c0                	test   %al,%al
801026c8:	74 f6                	je     801026c0 <ideinit+0x50>
      havedisk1 = 1;
801026ca:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801026d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026de:	ee                   	out    %al,(%dx)
}
801026df:	c9                   	leave  
801026e0:	c3                   	ret    
801026e1:	eb 0d                	jmp    801026f0 <ideintr>
801026e3:	90                   	nop
801026e4:	90                   	nop
801026e5:	90                   	nop
801026e6:	90                   	nop
801026e7:	90                   	nop
801026e8:	90                   	nop
801026e9:	90                   	nop
801026ea:	90                   	nop
801026eb:	90                   	nop
801026ec:	90                   	nop
801026ed:	90                   	nop
801026ee:	90                   	nop
801026ef:	90                   	nop

801026f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	57                   	push   %edi
801026f4:	56                   	push   %esi
801026f5:	53                   	push   %ebx
801026f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026f9:	68 80 b5 10 80       	push   $0x8010b580
801026fe:	e8 8d 25 00 00       	call   80104c90 <acquire>

  if((b = idequeue) == 0){
80102703:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102709:	83 c4 10             	add    $0x10,%esp
8010270c:	85 db                	test   %ebx,%ebx
8010270e:	74 67                	je     80102777 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102710:	8b 43 58             	mov    0x58(%ebx),%eax
80102713:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102718:	8b 3b                	mov    (%ebx),%edi
8010271a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102720:	75 31                	jne    80102753 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102722:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102727:	89 f6                	mov    %esi,%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102730:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102731:	89 c6                	mov    %eax,%esi
80102733:	83 e6 c0             	and    $0xffffffc0,%esi
80102736:	89 f1                	mov    %esi,%ecx
80102738:	80 f9 40             	cmp    $0x40,%cl
8010273b:	75 f3                	jne    80102730 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010273d:	a8 21                	test   $0x21,%al
8010273f:	75 12                	jne    80102753 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102741:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102744:	b9 80 00 00 00       	mov    $0x80,%ecx
80102749:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010274e:	fc                   	cld    
8010274f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102751:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102753:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102756:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102759:	89 f9                	mov    %edi,%ecx
8010275b:	83 c9 02             	or     $0x2,%ecx
8010275e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102760:	53                   	push   %ebx
80102761:	e8 da 20 00 00       	call   80104840 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102766:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010276b:	83 c4 10             	add    $0x10,%esp
8010276e:	85 c0                	test   %eax,%eax
80102770:	74 05                	je     80102777 <ideintr+0x87>
    idestart(idequeue);
80102772:	e8 19 fe ff ff       	call   80102590 <idestart>
    release(&idelock);
80102777:	83 ec 0c             	sub    $0xc,%esp
8010277a:	68 80 b5 10 80       	push   $0x8010b580
8010277f:	e8 2c 26 00 00       	call   80104db0 <release>

  release(&idelock);
}
80102784:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102787:	5b                   	pop    %ebx
80102788:	5e                   	pop    %esi
80102789:	5f                   	pop    %edi
8010278a:	5d                   	pop    %ebp
8010278b:	c3                   	ret    
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102790 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	53                   	push   %ebx
80102794:	83 ec 10             	sub    $0x10,%esp
80102797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010279a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010279d:	50                   	push   %eax
8010279e:	e8 cd 23 00 00       	call   80104b70 <holdingsleep>
801027a3:	83 c4 10             	add    $0x10,%esp
801027a6:	85 c0                	test   %eax,%eax
801027a8:	0f 84 c6 00 00 00    	je     80102874 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027ae:	8b 03                	mov    (%ebx),%eax
801027b0:	83 e0 06             	and    $0x6,%eax
801027b3:	83 f8 02             	cmp    $0x2,%eax
801027b6:	0f 84 ab 00 00 00    	je     80102867 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801027bc:	8b 53 04             	mov    0x4(%ebx),%edx
801027bf:	85 d2                	test   %edx,%edx
801027c1:	74 0d                	je     801027d0 <iderw+0x40>
801027c3:	a1 60 b5 10 80       	mov    0x8010b560,%eax
801027c8:	85 c0                	test   %eax,%eax
801027ca:	0f 84 b1 00 00 00    	je     80102881 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027d0:	83 ec 0c             	sub    $0xc,%esp
801027d3:	68 80 b5 10 80       	push   $0x8010b580
801027d8:	e8 b3 24 00 00       	call   80104c90 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027dd:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
801027e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801027e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027ed:	85 d2                	test   %edx,%edx
801027ef:	75 09                	jne    801027fa <iderw+0x6a>
801027f1:	eb 6d                	jmp    80102860 <iderw+0xd0>
801027f3:	90                   	nop
801027f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027f8:	89 c2                	mov    %eax,%edx
801027fa:	8b 42 58             	mov    0x58(%edx),%eax
801027fd:	85 c0                	test   %eax,%eax
801027ff:	75 f7                	jne    801027f8 <iderw+0x68>
80102801:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102804:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102806:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010280c:	74 42                	je     80102850 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010280e:	8b 03                	mov    (%ebx),%eax
80102810:	83 e0 06             	and    $0x6,%eax
80102813:	83 f8 02             	cmp    $0x2,%eax
80102816:	74 23                	je     8010283b <iderw+0xab>
80102818:	90                   	nop
80102819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102820:	83 ec 08             	sub    $0x8,%esp
80102823:	68 80 b5 10 80       	push   $0x8010b580
80102828:	53                   	push   %ebx
80102829:	e8 22 1e 00 00       	call   80104650 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010282e:	8b 03                	mov    (%ebx),%eax
80102830:	83 c4 10             	add    $0x10,%esp
80102833:	83 e0 06             	and    $0x6,%eax
80102836:	83 f8 02             	cmp    $0x2,%eax
80102839:	75 e5                	jne    80102820 <iderw+0x90>
  }


  release(&idelock);
8010283b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102845:	c9                   	leave  
  release(&idelock);
80102846:	e9 65 25 00 00       	jmp    80104db0 <release>
8010284b:	90                   	nop
8010284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102850:	89 d8                	mov    %ebx,%eax
80102852:	e8 39 fd ff ff       	call   80102590 <idestart>
80102857:	eb b5                	jmp    8010280e <iderw+0x7e>
80102859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102860:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102865:	eb 9d                	jmp    80102804 <iderw+0x74>
    panic("iderw: nothing to do");
80102867:	83 ec 0c             	sub    $0xc,%esp
8010286a:	68 44 83 10 80       	push   $0x80108344
8010286f:	e8 1c db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102874:	83 ec 0c             	sub    $0xc,%esp
80102877:	68 2e 83 10 80       	push   $0x8010832e
8010287c:	e8 0f db ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102881:	83 ec 0c             	sub    $0xc,%esp
80102884:	68 59 83 10 80       	push   $0x80108359
80102889:	e8 02 db ff ff       	call   80100390 <panic>
8010288e:	66 90                	xchg   %ax,%ax

80102890 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102890:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102891:	c7 05 34 46 11 80 00 	movl   $0xfec00000,0x80114634
80102898:	00 c0 fe 
{
8010289b:	89 e5                	mov    %esp,%ebp
8010289d:	56                   	push   %esi
8010289e:	53                   	push   %ebx
  ioapic->reg = reg;
8010289f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801028a6:	00 00 00 
  return ioapic->data;
801028a9:	a1 34 46 11 80       	mov    0x80114634,%eax
801028ae:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801028b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801028b7:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801028bd:	0f b6 15 60 47 11 80 	movzbl 0x80114760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028c4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801028c7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028ca:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801028cd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801028d0:	39 c2                	cmp    %eax,%edx
801028d2:	74 16                	je     801028ea <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028d4:	83 ec 0c             	sub    $0xc,%esp
801028d7:	68 78 83 10 80       	push   $0x80108378
801028dc:	e8 7f dd ff ff       	call   80100660 <cprintf>
801028e1:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
801028e7:	83 c4 10             	add    $0x10,%esp
801028ea:	83 c3 21             	add    $0x21,%ebx
{
801028ed:	ba 10 00 00 00       	mov    $0x10,%edx
801028f2:	b8 20 00 00 00       	mov    $0x20,%eax
801028f7:	89 f6                	mov    %esi,%esi
801028f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102900:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102902:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102908:	89 c6                	mov    %eax,%esi
8010290a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102910:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102913:	89 71 10             	mov    %esi,0x10(%ecx)
80102916:	8d 72 01             	lea    0x1(%edx),%esi
80102919:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010291c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010291e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102920:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102926:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010292d:	75 d1                	jne    80102900 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010292f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102932:	5b                   	pop    %ebx
80102933:	5e                   	pop    %esi
80102934:	5d                   	pop    %ebp
80102935:	c3                   	ret    
80102936:	8d 76 00             	lea    0x0(%esi),%esi
80102939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102940 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102940:	55                   	push   %ebp
  ioapic->reg = reg;
80102941:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
{
80102947:	89 e5                	mov    %esp,%ebp
80102949:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010294c:	8d 50 20             	lea    0x20(%eax),%edx
8010294f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102953:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102955:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010295b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010295e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102961:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102964:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102966:	a1 34 46 11 80       	mov    0x80114634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010296b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010296e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102971:	5d                   	pop    %ebp
80102972:	c3                   	ret    
80102973:	66 90                	xchg   %ax,%ax
80102975:	66 90                	xchg   %ax,%ax
80102977:	66 90                	xchg   %ax,%ax
80102979:	66 90                	xchg   %ax,%ax
8010297b:	66 90                	xchg   %ax,%ax
8010297d:	66 90                	xchg   %ax,%ax
8010297f:	90                   	nop

80102980 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102980:	55                   	push   %ebp
80102981:	89 e5                	mov    %esp,%ebp
80102983:	53                   	push   %ebx
80102984:	83 ec 04             	sub    $0x4,%esp
80102987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP){
8010298a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102990:	75 70                	jne    80102a02 <kfree+0x82>
80102992:	81 fb a8 f9 11 80    	cmp    $0x8011f9a8,%ebx
80102998:	72 68                	jb     80102a02 <kfree+0x82>
8010299a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801029a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801029a5:	77 5b                	ja     80102a02 <kfree+0x82>
      panic("kfree");}

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801029a7:	83 ec 04             	sub    $0x4,%esp
801029aa:	68 00 10 00 00       	push   $0x1000
801029af:	6a 01                	push   $0x1
801029b1:	53                   	push   %ebx
801029b2:	e8 59 24 00 00       	call   80104e10 <memset>

  if(kmem.use_lock)
801029b7:	8b 15 74 46 11 80    	mov    0x80114674,%edx
801029bd:	83 c4 10             	add    $0x10,%esp
801029c0:	85 d2                	test   %edx,%edx
801029c2:	75 2c                	jne    801029f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801029c4:	a1 78 46 11 80       	mov    0x80114678,%eax
801029c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801029cb:	a1 74 46 11 80       	mov    0x80114674,%eax
  kmem.freelist = r;
801029d0:	89 1d 78 46 11 80    	mov    %ebx,0x80114678
  if(kmem.use_lock)
801029d6:	85 c0                	test   %eax,%eax
801029d8:	75 06                	jne    801029e0 <kfree+0x60>
    release(&kmem.lock);
}
801029da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029dd:	c9                   	leave  
801029de:	c3                   	ret    
801029df:	90                   	nop
    release(&kmem.lock);
801029e0:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
801029e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ea:	c9                   	leave  
    release(&kmem.lock);
801029eb:	e9 c0 23 00 00       	jmp    80104db0 <release>
    acquire(&kmem.lock);
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	68 40 46 11 80       	push   $0x80114640
801029f8:	e8 93 22 00 00       	call   80104c90 <acquire>
801029fd:	83 c4 10             	add    $0x10,%esp
80102a00:	eb c2                	jmp    801029c4 <kfree+0x44>
      panic("kfree");}
80102a02:	83 ec 0c             	sub    $0xc,%esp
80102a05:	68 aa 83 10 80       	push   $0x801083aa
80102a0a:	e8 81 d9 ff ff       	call   80100390 <panic>
80102a0f:	90                   	nop

80102a10 <freerange>:
{
80102a10:	55                   	push   %ebp
80102a11:	89 e5                	mov    %esp,%ebp
80102a13:	56                   	push   %esi
80102a14:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a15:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a18:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a1b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a21:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a27:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a2d:	39 de                	cmp    %ebx,%esi
80102a2f:	72 23                	jb     80102a54 <freerange+0x44>
80102a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a38:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a3e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a47:	50                   	push   %eax
80102a48:	e8 33 ff ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a4d:	83 c4 10             	add    $0x10,%esp
80102a50:	39 f3                	cmp    %esi,%ebx
80102a52:	76 e4                	jbe    80102a38 <freerange+0x28>
}
80102a54:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a57:	5b                   	pop    %ebx
80102a58:	5e                   	pop    %esi
80102a59:	5d                   	pop    %ebp
80102a5a:	c3                   	ret    
80102a5b:	90                   	nop
80102a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a60 <kinit1>:
{
80102a60:	55                   	push   %ebp
80102a61:	89 e5                	mov    %esp,%ebp
80102a63:	56                   	push   %esi
80102a64:	53                   	push   %ebx
80102a65:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102a68:	83 ec 08             	sub    $0x8,%esp
80102a6b:	68 b0 83 10 80       	push   $0x801083b0
80102a70:	68 40 46 11 80       	push   $0x80114640
80102a75:	e8 26 21 00 00       	call   80104ba0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a7d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a80:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102a87:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102a8a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a90:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a96:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a9c:	39 de                	cmp    %ebx,%esi
80102a9e:	72 1c                	jb     80102abc <kinit1+0x5c>
    kfree(p);
80102aa0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102aa6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aa9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102aaf:	50                   	push   %eax
80102ab0:	e8 cb fe ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ab5:	83 c4 10             	add    $0x10,%esp
80102ab8:	39 de                	cmp    %ebx,%esi
80102aba:	73 e4                	jae    80102aa0 <kinit1+0x40>
}
80102abc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102abf:	5b                   	pop    %ebx
80102ac0:	5e                   	pop    %esi
80102ac1:	5d                   	pop    %ebp
80102ac2:	c3                   	ret    
80102ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ad0 <kinit2>:
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	56                   	push   %esi
80102ad4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102ad5:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102ad8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102adb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ae1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ae7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102aed:	39 de                	cmp    %ebx,%esi
80102aef:	72 23                	jb     80102b14 <kinit2+0x44>
80102af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102af8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102afe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b01:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b07:	50                   	push   %eax
80102b08:	e8 73 fe ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b0d:	83 c4 10             	add    $0x10,%esp
80102b10:	39 de                	cmp    %ebx,%esi
80102b12:	73 e4                	jae    80102af8 <kinit2+0x28>
  kmem.use_lock = 1;
80102b14:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
80102b1b:	00 00 00 
}
80102b1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b21:	5b                   	pop    %ebx
80102b22:	5e                   	pop    %esi
80102b23:	5d                   	pop    %ebp
80102b24:	c3                   	ret    
80102b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102b30:	a1 74 46 11 80       	mov    0x80114674,%eax
80102b35:	85 c0                	test   %eax,%eax
80102b37:	75 1f                	jne    80102b58 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b39:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r)
80102b3e:	85 c0                	test   %eax,%eax
80102b40:	74 0e                	je     80102b50 <kalloc+0x20>
    kmem.freelist = r->next;
80102b42:	8b 10                	mov    (%eax),%edx
80102b44:	89 15 78 46 11 80    	mov    %edx,0x80114678
80102b4a:	c3                   	ret    
80102b4b:	90                   	nop
80102b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102b50:	f3 c3                	repz ret 
80102b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102b58:	55                   	push   %ebp
80102b59:	89 e5                	mov    %esp,%ebp
80102b5b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102b5e:	68 40 46 11 80       	push   $0x80114640
80102b63:	e8 28 21 00 00       	call   80104c90 <acquire>
  r = kmem.freelist;
80102b68:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r)
80102b6d:	83 c4 10             	add    $0x10,%esp
80102b70:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102b76:	85 c0                	test   %eax,%eax
80102b78:	74 08                	je     80102b82 <kalloc+0x52>
    kmem.freelist = r->next;
80102b7a:	8b 08                	mov    (%eax),%ecx
80102b7c:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
  if(kmem.use_lock)
80102b82:	85 d2                	test   %edx,%edx
80102b84:	74 16                	je     80102b9c <kalloc+0x6c>
    release(&kmem.lock);
80102b86:	83 ec 0c             	sub    $0xc,%esp
80102b89:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b8c:	68 40 46 11 80       	push   $0x80114640
80102b91:	e8 1a 22 00 00       	call   80104db0 <release>
  return (char*)r;
80102b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102b99:	83 c4 10             	add    $0x10,%esp
}
80102b9c:	c9                   	leave  
80102b9d:	c3                   	ret    
80102b9e:	66 90                	xchg   %ax,%ax

80102ba0 <free_pages_in_system>:

int
free_pages_in_system()
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 18             	sub    $0x18,%esp
    struct run *r;

    int pages_num = 0;
    if(kmem.use_lock)
80102ba6:	8b 0d 74 46 11 80    	mov    0x80114674,%ecx
80102bac:	85 c9                	test   %ecx,%ecx
80102bae:	75 40                	jne    80102bf0 <free_pages_in_system+0x50>
        acquire(&kmem.lock);
    r = kmem.freelist;
80102bb0:	8b 15 78 46 11 80    	mov    0x80114678,%edx
    while(r){
80102bb6:	85 d2                	test   %edx,%edx
80102bb8:	74 5e                	je     80102c18 <free_pages_in_system+0x78>
{
80102bba:	31 c0                	xor    %eax,%eax
80102bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        r = r->next;
80102bc0:	8b 12                	mov    (%edx),%edx
        pages_num++;
80102bc2:	83 c0 01             	add    $0x1,%eax
    while(r){
80102bc5:	85 d2                	test   %edx,%edx
80102bc7:	75 f7                	jne    80102bc0 <free_pages_in_system+0x20>
    }
    if(kmem.use_lock)
80102bc9:	85 c9                	test   %ecx,%ecx
80102bcb:	75 03                	jne    80102bd0 <free_pages_in_system+0x30>
        release(&kmem.lock);
    return pages_num;
}
80102bcd:	c9                   	leave  
80102bce:	c3                   	ret    
80102bcf:	90                   	nop
        release(&kmem.lock);
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102bd6:	68 40 46 11 80       	push   $0x80114640
80102bdb:	e8 d0 21 00 00       	call   80104db0 <release>
    return pages_num;
80102be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
        release(&kmem.lock);
80102be3:	83 c4 10             	add    $0x10,%esp
}
80102be6:	c9                   	leave  
80102be7:	c3                   	ret    
80102be8:	90                   	nop
80102be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        acquire(&kmem.lock);
80102bf0:	83 ec 0c             	sub    $0xc,%esp
80102bf3:	68 40 46 11 80       	push   $0x80114640
80102bf8:	e8 93 20 00 00       	call   80104c90 <acquire>
    r = kmem.freelist;
80102bfd:	8b 15 78 46 11 80    	mov    0x80114678,%edx
    while(r){
80102c03:	83 c4 10             	add    $0x10,%esp
80102c06:	8b 0d 74 46 11 80    	mov    0x80114674,%ecx
80102c0c:	85 d2                	test   %edx,%edx
80102c0e:	75 aa                	jne    80102bba <free_pages_in_system+0x1a>
    int pages_num = 0;
80102c10:	31 c0                	xor    %eax,%eax
80102c12:	eb b5                	jmp    80102bc9 <free_pages_in_system+0x29>
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c18:	31 c0                	xor    %eax,%eax
}
80102c1a:	c9                   	leave  
80102c1b:	c3                   	ret    
80102c1c:	66 90                	xchg   %ax,%ax
80102c1e:	66 90                	xchg   %ax,%ax

80102c20 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c20:	ba 64 00 00 00       	mov    $0x64,%edx
80102c25:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102c26:	a8 01                	test   $0x1,%al
80102c28:	0f 84 c2 00 00 00    	je     80102cf0 <kbdgetc+0xd0>
80102c2e:	ba 60 00 00 00       	mov    $0x60,%edx
80102c33:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102c34:	0f b6 d0             	movzbl %al,%edx
80102c37:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
80102c3d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102c43:	0f 84 7f 00 00 00    	je     80102cc8 <kbdgetc+0xa8>
{
80102c49:	55                   	push   %ebp
80102c4a:	89 e5                	mov    %esp,%ebp
80102c4c:	53                   	push   %ebx
80102c4d:	89 cb                	mov    %ecx,%ebx
80102c4f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102c52:	84 c0                	test   %al,%al
80102c54:	78 4a                	js     80102ca0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102c56:	85 db                	test   %ebx,%ebx
80102c58:	74 09                	je     80102c63 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c5a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102c5d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102c60:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102c63:	0f b6 82 e0 84 10 80 	movzbl -0x7fef7b20(%edx),%eax
80102c6a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102c6c:	0f b6 82 e0 83 10 80 	movzbl -0x7fef7c20(%edx),%eax
80102c73:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c75:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102c77:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102c7d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c80:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c83:	8b 04 85 c0 83 10 80 	mov    -0x7fef7c40(,%eax,4),%eax
80102c8a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102c8e:	74 31                	je     80102cc1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102c90:	8d 50 9f             	lea    -0x61(%eax),%edx
80102c93:	83 fa 19             	cmp    $0x19,%edx
80102c96:	77 40                	ja     80102cd8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c98:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c9b:	5b                   	pop    %ebx
80102c9c:	5d                   	pop    %ebp
80102c9d:	c3                   	ret    
80102c9e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102ca0:	83 e0 7f             	and    $0x7f,%eax
80102ca3:	85 db                	test   %ebx,%ebx
80102ca5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102ca8:	0f b6 82 e0 84 10 80 	movzbl -0x7fef7b20(%edx),%eax
80102caf:	83 c8 40             	or     $0x40,%eax
80102cb2:	0f b6 c0             	movzbl %al,%eax
80102cb5:	f7 d0                	not    %eax
80102cb7:	21 c1                	and    %eax,%ecx
    return 0;
80102cb9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102cbb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102cc1:	5b                   	pop    %ebx
80102cc2:	5d                   	pop    %ebp
80102cc3:	c3                   	ret    
80102cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102cc8:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102ccb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102ccd:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
80102cd3:	c3                   	ret    
80102cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102cd8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102cdb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102cde:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102cdf:	83 f9 1a             	cmp    $0x1a,%ecx
80102ce2:	0f 42 c2             	cmovb  %edx,%eax
}
80102ce5:	5d                   	pop    %ebp
80102ce6:	c3                   	ret    
80102ce7:	89 f6                	mov    %esi,%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102cf5:	c3                   	ret    
80102cf6:	8d 76 00             	lea    0x0(%esi),%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d00 <kbdintr>:

void
kbdintr(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102d06:	68 20 2c 10 80       	push   $0x80102c20
80102d0b:	e8 00 db ff ff       	call   80100810 <consoleintr>
}
80102d10:	83 c4 10             	add    $0x10,%esp
80102d13:	c9                   	leave  
80102d14:	c3                   	ret    
80102d15:	66 90                	xchg   %ax,%ax
80102d17:	66 90                	xchg   %ax,%ax
80102d19:	66 90                	xchg   %ax,%ax
80102d1b:	66 90                	xchg   %ax,%ax
80102d1d:	66 90                	xchg   %ax,%ax
80102d1f:	90                   	nop

80102d20 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102d20:	a1 7c 46 11 80       	mov    0x8011467c,%eax
{
80102d25:	55                   	push   %ebp
80102d26:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102d28:	85 c0                	test   %eax,%eax
80102d2a:	0f 84 c8 00 00 00    	je     80102df8 <lapicinit+0xd8>
  lapic[index] = value;
80102d30:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102d37:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d3a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d3d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102d44:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d47:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d4a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102d51:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102d54:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d57:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102d5e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102d61:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d64:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d6b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d6e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d71:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d78:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d7b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d7e:	8b 50 30             	mov    0x30(%eax),%edx
80102d81:	c1 ea 10             	shr    $0x10,%edx
80102d84:	80 fa 03             	cmp    $0x3,%dl
80102d87:	77 77                	ja     80102e00 <lapicinit+0xe0>
  lapic[index] = value;
80102d89:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d90:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d93:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d96:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d9d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102da0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102da3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102daa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102db0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102db7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dbd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102dc4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dc7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102dd1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102dd4:	8b 50 20             	mov    0x20(%eax),%edx
80102dd7:	89 f6                	mov    %esi,%esi
80102dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102de0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102de6:	80 e6 10             	and    $0x10,%dh
80102de9:	75 f5                	jne    80102de0 <lapicinit+0xc0>
  lapic[index] = value;
80102deb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102df2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102df5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102df8:	5d                   	pop    %ebp
80102df9:	c3                   	ret    
80102dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102e00:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102e07:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e0a:	8b 50 20             	mov    0x20(%eax),%edx
80102e0d:	e9 77 ff ff ff       	jmp    80102d89 <lapicinit+0x69>
80102e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e20 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102e20:	8b 15 7c 46 11 80    	mov    0x8011467c,%edx
{
80102e26:	55                   	push   %ebp
80102e27:	31 c0                	xor    %eax,%eax
80102e29:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102e2b:	85 d2                	test   %edx,%edx
80102e2d:	74 06                	je     80102e35 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102e2f:	8b 42 20             	mov    0x20(%edx),%eax
80102e32:	c1 e8 18             	shr    $0x18,%eax
}
80102e35:	5d                   	pop    %ebp
80102e36:	c3                   	ret    
80102e37:	89 f6                	mov    %esi,%esi
80102e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e40 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102e40:	a1 7c 46 11 80       	mov    0x8011467c,%eax
{
80102e45:	55                   	push   %ebp
80102e46:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102e48:	85 c0                	test   %eax,%eax
80102e4a:	74 0d                	je     80102e59 <lapiceoi+0x19>
  lapic[index] = value;
80102e4c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e53:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e56:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102e59:	5d                   	pop    %ebp
80102e5a:	c3                   	ret    
80102e5b:	90                   	nop
80102e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e60 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
}
80102e63:	5d                   	pop    %ebp
80102e64:	c3                   	ret    
80102e65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e70 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e70:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e71:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e76:	ba 70 00 00 00       	mov    $0x70,%edx
80102e7b:	89 e5                	mov    %esp,%ebp
80102e7d:	53                   	push   %ebx
80102e7e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e81:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e84:	ee                   	out    %al,(%dx)
80102e85:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e8a:	ba 71 00 00 00       	mov    $0x71,%edx
80102e8f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e90:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102e92:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e95:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e9b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e9d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102ea0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102ea3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ea5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102ea8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102eae:	a1 7c 46 11 80       	mov    0x8011467c,%eax
80102eb3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eb9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ebc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ec3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ec6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ec9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ed0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ed3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ed6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102edc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102edf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ee5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ee8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ef1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ef7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102efa:	5b                   	pop    %ebx
80102efb:	5d                   	pop    %ebp
80102efc:	c3                   	ret    
80102efd:	8d 76 00             	lea    0x0(%esi),%esi

80102f00 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102f00:	55                   	push   %ebp
80102f01:	b8 0b 00 00 00       	mov    $0xb,%eax
80102f06:	ba 70 00 00 00       	mov    $0x70,%edx
80102f0b:	89 e5                	mov    %esp,%ebp
80102f0d:	57                   	push   %edi
80102f0e:	56                   	push   %esi
80102f0f:	53                   	push   %ebx
80102f10:	83 ec 4c             	sub    $0x4c,%esp
80102f13:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f14:	ba 71 00 00 00       	mov    $0x71,%edx
80102f19:	ec                   	in     (%dx),%al
80102f1a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f1d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102f22:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102f25:	8d 76 00             	lea    0x0(%esi),%esi
80102f28:	31 c0                	xor    %eax,%eax
80102f2a:	89 da                	mov    %ebx,%edx
80102f2c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f2d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102f32:	89 ca                	mov    %ecx,%edx
80102f34:	ec                   	in     (%dx),%al
80102f35:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f38:	89 da                	mov    %ebx,%edx
80102f3a:	b8 02 00 00 00       	mov    $0x2,%eax
80102f3f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f40:	89 ca                	mov    %ecx,%edx
80102f42:	ec                   	in     (%dx),%al
80102f43:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f46:	89 da                	mov    %ebx,%edx
80102f48:	b8 04 00 00 00       	mov    $0x4,%eax
80102f4d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f4e:	89 ca                	mov    %ecx,%edx
80102f50:	ec                   	in     (%dx),%al
80102f51:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f54:	89 da                	mov    %ebx,%edx
80102f56:	b8 07 00 00 00       	mov    $0x7,%eax
80102f5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f5c:	89 ca                	mov    %ecx,%edx
80102f5e:	ec                   	in     (%dx),%al
80102f5f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f62:	89 da                	mov    %ebx,%edx
80102f64:	b8 08 00 00 00       	mov    $0x8,%eax
80102f69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f6a:	89 ca                	mov    %ecx,%edx
80102f6c:	ec                   	in     (%dx),%al
80102f6d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6f:	89 da                	mov    %ebx,%edx
80102f71:	b8 09 00 00 00       	mov    $0x9,%eax
80102f76:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f77:	89 ca                	mov    %ecx,%edx
80102f79:	ec                   	in     (%dx),%al
80102f7a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f7c:	89 da                	mov    %ebx,%edx
80102f7e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f84:	89 ca                	mov    %ecx,%edx
80102f86:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f87:	84 c0                	test   %al,%al
80102f89:	78 9d                	js     80102f28 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102f8b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f8f:	89 fa                	mov    %edi,%edx
80102f91:	0f b6 fa             	movzbl %dl,%edi
80102f94:	89 f2                	mov    %esi,%edx
80102f96:	0f b6 f2             	movzbl %dl,%esi
80102f99:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f9c:	89 da                	mov    %ebx,%edx
80102f9e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102fa1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fa4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102fa8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102fab:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102faf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102fb2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102fb6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102fb9:	31 c0                	xor    %eax,%eax
80102fbb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fbc:	89 ca                	mov    %ecx,%edx
80102fbe:	ec                   	in     (%dx),%al
80102fbf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fc2:	89 da                	mov    %ebx,%edx
80102fc4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102fc7:	b8 02 00 00 00       	mov    $0x2,%eax
80102fcc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fcd:	89 ca                	mov    %ecx,%edx
80102fcf:	ec                   	in     (%dx),%al
80102fd0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fd3:	89 da                	mov    %ebx,%edx
80102fd5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102fd8:	b8 04 00 00 00       	mov    $0x4,%eax
80102fdd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fde:	89 ca                	mov    %ecx,%edx
80102fe0:	ec                   	in     (%dx),%al
80102fe1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fe4:	89 da                	mov    %ebx,%edx
80102fe6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102fe9:	b8 07 00 00 00       	mov    $0x7,%eax
80102fee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fef:	89 ca                	mov    %ecx,%edx
80102ff1:	ec                   	in     (%dx),%al
80102ff2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ff5:	89 da                	mov    %ebx,%edx
80102ff7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102ffa:	b8 08 00 00 00       	mov    $0x8,%eax
80102fff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103000:	89 ca                	mov    %ecx,%edx
80103002:	ec                   	in     (%dx),%al
80103003:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103006:	89 da                	mov    %ebx,%edx
80103008:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010300b:	b8 09 00 00 00       	mov    $0x9,%eax
80103010:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103011:	89 ca                	mov    %ecx,%edx
80103013:	ec                   	in     (%dx),%al
80103014:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103017:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010301a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010301d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103020:	6a 18                	push   $0x18
80103022:	50                   	push   %eax
80103023:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103026:	50                   	push   %eax
80103027:	e8 34 1e 00 00       	call   80104e60 <memcmp>
8010302c:	83 c4 10             	add    $0x10,%esp
8010302f:	85 c0                	test   %eax,%eax
80103031:	0f 85 f1 fe ff ff    	jne    80102f28 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103037:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010303b:	75 78                	jne    801030b5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010303d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103040:	89 c2                	mov    %eax,%edx
80103042:	83 e0 0f             	and    $0xf,%eax
80103045:	c1 ea 04             	shr    $0x4,%edx
80103048:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010304b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010304e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103051:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103054:	89 c2                	mov    %eax,%edx
80103056:	83 e0 0f             	and    $0xf,%eax
80103059:	c1 ea 04             	shr    $0x4,%edx
8010305c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010305f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103062:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103065:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103068:	89 c2                	mov    %eax,%edx
8010306a:	83 e0 0f             	and    $0xf,%eax
8010306d:	c1 ea 04             	shr    $0x4,%edx
80103070:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103073:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103076:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103079:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010307c:	89 c2                	mov    %eax,%edx
8010307e:	83 e0 0f             	and    $0xf,%eax
80103081:	c1 ea 04             	shr    $0x4,%edx
80103084:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103087:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010308a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010308d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103090:	89 c2                	mov    %eax,%edx
80103092:	83 e0 0f             	and    $0xf,%eax
80103095:	c1 ea 04             	shr    $0x4,%edx
80103098:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010309b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801030a1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030a4:	89 c2                	mov    %eax,%edx
801030a6:	83 e0 0f             	and    $0xf,%eax
801030a9:	c1 ea 04             	shr    $0x4,%edx
801030ac:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030af:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030b2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801030b5:	8b 75 08             	mov    0x8(%ebp),%esi
801030b8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801030bb:	89 06                	mov    %eax,(%esi)
801030bd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801030c0:	89 46 04             	mov    %eax,0x4(%esi)
801030c3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801030c6:	89 46 08             	mov    %eax,0x8(%esi)
801030c9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801030cc:	89 46 0c             	mov    %eax,0xc(%esi)
801030cf:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030d2:	89 46 10             	mov    %eax,0x10(%esi)
801030d5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030d8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801030db:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801030e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030e5:	5b                   	pop    %ebx
801030e6:	5e                   	pop    %esi
801030e7:	5f                   	pop    %edi
801030e8:	5d                   	pop    %ebp
801030e9:	c3                   	ret    
801030ea:	66 90                	xchg   %ax,%ax
801030ec:	66 90                	xchg   %ax,%ax
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030f0:	8b 0d c8 46 11 80    	mov    0x801146c8,%ecx
801030f6:	85 c9                	test   %ecx,%ecx
801030f8:	0f 8e 8a 00 00 00    	jle    80103188 <install_trans+0x98>
{
801030fe:	55                   	push   %ebp
801030ff:	89 e5                	mov    %esp,%ebp
80103101:	57                   	push   %edi
80103102:	56                   	push   %esi
80103103:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80103104:	31 db                	xor    %ebx,%ebx
{
80103106:	83 ec 0c             	sub    $0xc,%esp
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103110:	a1 b4 46 11 80       	mov    0x801146b4,%eax
80103115:	83 ec 08             	sub    $0x8,%esp
80103118:	01 d8                	add    %ebx,%eax
8010311a:	83 c0 01             	add    $0x1,%eax
8010311d:	50                   	push   %eax
8010311e:	ff 35 c4 46 11 80    	pushl  0x801146c4
80103124:	e8 a7 cf ff ff       	call   801000d0 <bread>
80103129:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010312b:	58                   	pop    %eax
8010312c:	5a                   	pop    %edx
8010312d:	ff 34 9d cc 46 11 80 	pushl  -0x7feeb934(,%ebx,4)
80103134:	ff 35 c4 46 11 80    	pushl  0x801146c4
  for (tail = 0; tail < log.lh.n; tail++) {
8010313a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010313d:	e8 8e cf ff ff       	call   801000d0 <bread>
80103142:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103144:	8d 47 5c             	lea    0x5c(%edi),%eax
80103147:	83 c4 0c             	add    $0xc,%esp
8010314a:	68 00 02 00 00       	push   $0x200
8010314f:	50                   	push   %eax
80103150:	8d 46 5c             	lea    0x5c(%esi),%eax
80103153:	50                   	push   %eax
80103154:	e8 67 1d 00 00       	call   80104ec0 <memmove>
    bwrite(dbuf);  // write dst to disk
80103159:	89 34 24             	mov    %esi,(%esp)
8010315c:	e8 3f d0 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103161:	89 3c 24             	mov    %edi,(%esp)
80103164:	e8 77 d0 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103169:	89 34 24             	mov    %esi,(%esp)
8010316c:	e8 6f d0 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103171:	83 c4 10             	add    $0x10,%esp
80103174:	39 1d c8 46 11 80    	cmp    %ebx,0x801146c8
8010317a:	7f 94                	jg     80103110 <install_trans+0x20>
  }
}
8010317c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010317f:	5b                   	pop    %ebx
80103180:	5e                   	pop    %esi
80103181:	5f                   	pop    %edi
80103182:	5d                   	pop    %ebp
80103183:	c3                   	ret    
80103184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103188:	f3 c3                	repz ret 
8010318a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103190 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	56                   	push   %esi
80103194:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80103195:	83 ec 08             	sub    $0x8,%esp
80103198:	ff 35 b4 46 11 80    	pushl  0x801146b4
8010319e:	ff 35 c4 46 11 80    	pushl  0x801146c4
801031a4:	e8 27 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801031a9:	8b 1d c8 46 11 80    	mov    0x801146c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
801031af:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801031b2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
801031b4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
801031b6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031b9:	7e 16                	jle    801031d1 <write_head+0x41>
801031bb:	c1 e3 02             	shl    $0x2,%ebx
801031be:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
801031c0:	8b 8a cc 46 11 80    	mov    -0x7feeb934(%edx),%ecx
801031c6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
801031ca:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
801031cd:	39 da                	cmp    %ebx,%edx
801031cf:	75 ef                	jne    801031c0 <write_head+0x30>
  }
  bwrite(buf);
801031d1:	83 ec 0c             	sub    $0xc,%esp
801031d4:	56                   	push   %esi
801031d5:	e8 c6 cf ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801031da:	89 34 24             	mov    %esi,(%esp)
801031dd:	e8 fe cf ff ff       	call   801001e0 <brelse>
}
801031e2:	83 c4 10             	add    $0x10,%esp
801031e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031e8:	5b                   	pop    %ebx
801031e9:	5e                   	pop    %esi
801031ea:	5d                   	pop    %ebp
801031eb:	c3                   	ret    
801031ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031f0 <initlog>:
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	53                   	push   %ebx
801031f4:	83 ec 2c             	sub    $0x2c,%esp
801031f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801031fa:	68 e0 85 10 80       	push   $0x801085e0
801031ff:	68 80 46 11 80       	push   $0x80114680
80103204:	e8 97 19 00 00       	call   80104ba0 <initlock>
  readsb(dev, &sb);
80103209:	58                   	pop    %eax
8010320a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010320d:	5a                   	pop    %edx
8010320e:	50                   	push   %eax
8010320f:	53                   	push   %ebx
80103210:	e8 1b e2 ff ff       	call   80101430 <readsb>
  log.size = sb.nlog;
80103215:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103218:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010321b:	59                   	pop    %ecx
  log.dev = dev;
8010321c:	89 1d c4 46 11 80    	mov    %ebx,0x801146c4
  log.size = sb.nlog;
80103222:	89 15 b8 46 11 80    	mov    %edx,0x801146b8
  log.start = sb.logstart;
80103228:	a3 b4 46 11 80       	mov    %eax,0x801146b4
  struct buf *buf = bread(log.dev, log.start);
8010322d:	5a                   	pop    %edx
8010322e:	50                   	push   %eax
8010322f:	53                   	push   %ebx
80103230:	e8 9b ce ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103235:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80103238:	83 c4 10             	add    $0x10,%esp
8010323b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
8010323d:	89 1d c8 46 11 80    	mov    %ebx,0x801146c8
  for (i = 0; i < log.lh.n; i++) {
80103243:	7e 1c                	jle    80103261 <initlog+0x71>
80103245:	c1 e3 02             	shl    $0x2,%ebx
80103248:	31 d2                	xor    %edx,%edx
8010324a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103250:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103254:	83 c2 04             	add    $0x4,%edx
80103257:	89 8a c8 46 11 80    	mov    %ecx,-0x7feeb938(%edx)
  for (i = 0; i < log.lh.n; i++) {
8010325d:	39 d3                	cmp    %edx,%ebx
8010325f:	75 ef                	jne    80103250 <initlog+0x60>
  brelse(buf);
80103261:	83 ec 0c             	sub    $0xc,%esp
80103264:	50                   	push   %eax
80103265:	e8 76 cf ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010326a:	e8 81 fe ff ff       	call   801030f0 <install_trans>
  log.lh.n = 0;
8010326f:	c7 05 c8 46 11 80 00 	movl   $0x0,0x801146c8
80103276:	00 00 00 
  write_head(); // clear the log
80103279:	e8 12 ff ff ff       	call   80103190 <write_head>
}
8010327e:	83 c4 10             	add    $0x10,%esp
80103281:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103284:	c9                   	leave  
80103285:	c3                   	ret    
80103286:	8d 76 00             	lea    0x0(%esi),%esi
80103289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103290 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103296:	68 80 46 11 80       	push   $0x80114680
8010329b:	e8 f0 19 00 00       	call   80104c90 <acquire>
801032a0:	83 c4 10             	add    $0x10,%esp
801032a3:	eb 18                	jmp    801032bd <begin_op+0x2d>
801032a5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801032a8:	83 ec 08             	sub    $0x8,%esp
801032ab:	68 80 46 11 80       	push   $0x80114680
801032b0:	68 80 46 11 80       	push   $0x80114680
801032b5:	e8 96 13 00 00       	call   80104650 <sleep>
801032ba:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801032bd:	a1 c0 46 11 80       	mov    0x801146c0,%eax
801032c2:	85 c0                	test   %eax,%eax
801032c4:	75 e2                	jne    801032a8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801032c6:	a1 bc 46 11 80       	mov    0x801146bc,%eax
801032cb:	8b 15 c8 46 11 80    	mov    0x801146c8,%edx
801032d1:	83 c0 01             	add    $0x1,%eax
801032d4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801032d7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801032da:	83 fa 1e             	cmp    $0x1e,%edx
801032dd:	7f c9                	jg     801032a8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801032df:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801032e2:	a3 bc 46 11 80       	mov    %eax,0x801146bc
      release(&log.lock);
801032e7:	68 80 46 11 80       	push   $0x80114680
801032ec:	e8 bf 1a 00 00       	call   80104db0 <release>
      break;
    }
  }
}
801032f1:	83 c4 10             	add    $0x10,%esp
801032f4:	c9                   	leave  
801032f5:	c3                   	ret    
801032f6:	8d 76 00             	lea    0x0(%esi),%esi
801032f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103300 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	57                   	push   %edi
80103304:	56                   	push   %esi
80103305:	53                   	push   %ebx
80103306:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103309:	68 80 46 11 80       	push   $0x80114680
8010330e:	e8 7d 19 00 00       	call   80104c90 <acquire>
  log.outstanding -= 1;
80103313:	a1 bc 46 11 80       	mov    0x801146bc,%eax
  if(log.committing)
80103318:	8b 35 c0 46 11 80    	mov    0x801146c0,%esi
8010331e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103321:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103324:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103326:	89 1d bc 46 11 80    	mov    %ebx,0x801146bc
  if(log.committing)
8010332c:	0f 85 1a 01 00 00    	jne    8010344c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103332:	85 db                	test   %ebx,%ebx
80103334:	0f 85 ee 00 00 00    	jne    80103428 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010333a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010333d:	c7 05 c0 46 11 80 01 	movl   $0x1,0x801146c0
80103344:	00 00 00 
  release(&log.lock);
80103347:	68 80 46 11 80       	push   $0x80114680
8010334c:	e8 5f 1a 00 00       	call   80104db0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103351:	8b 0d c8 46 11 80    	mov    0x801146c8,%ecx
80103357:	83 c4 10             	add    $0x10,%esp
8010335a:	85 c9                	test   %ecx,%ecx
8010335c:	0f 8e 85 00 00 00    	jle    801033e7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103362:	a1 b4 46 11 80       	mov    0x801146b4,%eax
80103367:	83 ec 08             	sub    $0x8,%esp
8010336a:	01 d8                	add    %ebx,%eax
8010336c:	83 c0 01             	add    $0x1,%eax
8010336f:	50                   	push   %eax
80103370:	ff 35 c4 46 11 80    	pushl  0x801146c4
80103376:	e8 55 cd ff ff       	call   801000d0 <bread>
8010337b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010337d:	58                   	pop    %eax
8010337e:	5a                   	pop    %edx
8010337f:	ff 34 9d cc 46 11 80 	pushl  -0x7feeb934(,%ebx,4)
80103386:	ff 35 c4 46 11 80    	pushl  0x801146c4
  for (tail = 0; tail < log.lh.n; tail++) {
8010338c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010338f:	e8 3c cd ff ff       	call   801000d0 <bread>
80103394:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103396:	8d 40 5c             	lea    0x5c(%eax),%eax
80103399:	83 c4 0c             	add    $0xc,%esp
8010339c:	68 00 02 00 00       	push   $0x200
801033a1:	50                   	push   %eax
801033a2:	8d 46 5c             	lea    0x5c(%esi),%eax
801033a5:	50                   	push   %eax
801033a6:	e8 15 1b 00 00       	call   80104ec0 <memmove>
    bwrite(to);  // write the log
801033ab:	89 34 24             	mov    %esi,(%esp)
801033ae:	e8 ed cd ff ff       	call   801001a0 <bwrite>
    brelse(from);
801033b3:	89 3c 24             	mov    %edi,(%esp)
801033b6:	e8 25 ce ff ff       	call   801001e0 <brelse>
    brelse(to);
801033bb:	89 34 24             	mov    %esi,(%esp)
801033be:	e8 1d ce ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801033c3:	83 c4 10             	add    $0x10,%esp
801033c6:	3b 1d c8 46 11 80    	cmp    0x801146c8,%ebx
801033cc:	7c 94                	jl     80103362 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801033ce:	e8 bd fd ff ff       	call   80103190 <write_head>
    install_trans(); // Now install writes to home locations
801033d3:	e8 18 fd ff ff       	call   801030f0 <install_trans>
    log.lh.n = 0;
801033d8:	c7 05 c8 46 11 80 00 	movl   $0x0,0x801146c8
801033df:	00 00 00 
    write_head();    // Erase the transaction from the log
801033e2:	e8 a9 fd ff ff       	call   80103190 <write_head>
    acquire(&log.lock);
801033e7:	83 ec 0c             	sub    $0xc,%esp
801033ea:	68 80 46 11 80       	push   $0x80114680
801033ef:	e8 9c 18 00 00       	call   80104c90 <acquire>
    wakeup(&log);
801033f4:	c7 04 24 80 46 11 80 	movl   $0x80114680,(%esp)
    log.committing = 0;
801033fb:	c7 05 c0 46 11 80 00 	movl   $0x0,0x801146c0
80103402:	00 00 00 
    wakeup(&log);
80103405:	e8 36 14 00 00       	call   80104840 <wakeup>
    release(&log.lock);
8010340a:	c7 04 24 80 46 11 80 	movl   $0x80114680,(%esp)
80103411:	e8 9a 19 00 00       	call   80104db0 <release>
80103416:	83 c4 10             	add    $0x10,%esp
}
80103419:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010341c:	5b                   	pop    %ebx
8010341d:	5e                   	pop    %esi
8010341e:	5f                   	pop    %edi
8010341f:	5d                   	pop    %ebp
80103420:	c3                   	ret    
80103421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103428:	83 ec 0c             	sub    $0xc,%esp
8010342b:	68 80 46 11 80       	push   $0x80114680
80103430:	e8 0b 14 00 00       	call   80104840 <wakeup>
  release(&log.lock);
80103435:	c7 04 24 80 46 11 80 	movl   $0x80114680,(%esp)
8010343c:	e8 6f 19 00 00       	call   80104db0 <release>
80103441:	83 c4 10             	add    $0x10,%esp
}
80103444:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103447:	5b                   	pop    %ebx
80103448:	5e                   	pop    %esi
80103449:	5f                   	pop    %edi
8010344a:	5d                   	pop    %ebp
8010344b:	c3                   	ret    
    panic("log.committing");
8010344c:	83 ec 0c             	sub    $0xc,%esp
8010344f:	68 e4 85 10 80       	push   $0x801085e4
80103454:	e8 37 cf ff ff       	call   80100390 <panic>
80103459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103460 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	53                   	push   %ebx
80103464:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103467:	8b 15 c8 46 11 80    	mov    0x801146c8,%edx
{
8010346d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103470:	83 fa 1d             	cmp    $0x1d,%edx
80103473:	0f 8f 9d 00 00 00    	jg     80103516 <log_write+0xb6>
80103479:	a1 b8 46 11 80       	mov    0x801146b8,%eax
8010347e:	83 e8 01             	sub    $0x1,%eax
80103481:	39 c2                	cmp    %eax,%edx
80103483:	0f 8d 8d 00 00 00    	jge    80103516 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103489:	a1 bc 46 11 80       	mov    0x801146bc,%eax
8010348e:	85 c0                	test   %eax,%eax
80103490:	0f 8e 8d 00 00 00    	jle    80103523 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103496:	83 ec 0c             	sub    $0xc,%esp
80103499:	68 80 46 11 80       	push   $0x80114680
8010349e:	e8 ed 17 00 00       	call   80104c90 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801034a3:	8b 0d c8 46 11 80    	mov    0x801146c8,%ecx
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	83 f9 00             	cmp    $0x0,%ecx
801034af:	7e 57                	jle    80103508 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034b1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801034b4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034b6:	3b 15 cc 46 11 80    	cmp    0x801146cc,%edx
801034bc:	75 0b                	jne    801034c9 <log_write+0x69>
801034be:	eb 38                	jmp    801034f8 <log_write+0x98>
801034c0:	39 14 85 cc 46 11 80 	cmp    %edx,-0x7feeb934(,%eax,4)
801034c7:	74 2f                	je     801034f8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801034c9:	83 c0 01             	add    $0x1,%eax
801034cc:	39 c1                	cmp    %eax,%ecx
801034ce:	75 f0                	jne    801034c0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801034d0:	89 14 85 cc 46 11 80 	mov    %edx,-0x7feeb934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801034d7:	83 c0 01             	add    $0x1,%eax
801034da:	a3 c8 46 11 80       	mov    %eax,0x801146c8
  b->flags |= B_DIRTY; // prevent eviction
801034df:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801034e2:	c7 45 08 80 46 11 80 	movl   $0x80114680,0x8(%ebp)
}
801034e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034ec:	c9                   	leave  
  release(&log.lock);
801034ed:	e9 be 18 00 00       	jmp    80104db0 <release>
801034f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801034f8:	89 14 85 cc 46 11 80 	mov    %edx,-0x7feeb934(,%eax,4)
801034ff:	eb de                	jmp    801034df <log_write+0x7f>
80103501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103508:	8b 43 08             	mov    0x8(%ebx),%eax
8010350b:	a3 cc 46 11 80       	mov    %eax,0x801146cc
  if (i == log.lh.n)
80103510:	75 cd                	jne    801034df <log_write+0x7f>
80103512:	31 c0                	xor    %eax,%eax
80103514:	eb c1                	jmp    801034d7 <log_write+0x77>
    panic("too big a transaction");
80103516:	83 ec 0c             	sub    $0xc,%esp
80103519:	68 f3 85 10 80       	push   $0x801085f3
8010351e:	e8 6d ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103523:	83 ec 0c             	sub    $0xc,%esp
80103526:	68 09 86 10 80       	push   $0x80108609
8010352b:	e8 60 ce ff ff       	call   80100390 <panic>

80103530 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	53                   	push   %ebx
80103534:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103537:	e8 c4 09 00 00       	call   80103f00 <cpuid>
8010353c:	89 c3                	mov    %eax,%ebx
8010353e:	e8 bd 09 00 00       	call   80103f00 <cpuid>
80103543:	83 ec 04             	sub    $0x4,%esp
80103546:	53                   	push   %ebx
80103547:	50                   	push   %eax
80103548:	68 24 86 10 80       	push   $0x80108624
8010354d:	e8 0e d1 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103552:	e8 79 2c 00 00       	call   801061d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103557:	e8 24 09 00 00       	call   80103e80 <mycpu>
8010355c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010355e:	b8 01 00 00 00       	mov    $0x1,%eax
80103563:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010356a:	e8 d1 0d 00 00       	call   80104340 <scheduler>
8010356f:	90                   	nop

80103570 <mpenter>:
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103576:	e8 d5 3d 00 00       	call   80107350 <switchkvm>
  seginit();
8010357b:	e8 40 3d 00 00       	call   801072c0 <seginit>
  lapicinit();
80103580:	e8 9b f7 ff ff       	call   80102d20 <lapicinit>
  mpmain();
80103585:	e8 a6 ff ff ff       	call   80103530 <mpmain>
8010358a:	66 90                	xchg   %ax,%ax
8010358c:	66 90                	xchg   %ax,%ax
8010358e:	66 90                	xchg   %ax,%ax

80103590 <main>:
{
80103590:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103594:	83 e4 f0             	and    $0xfffffff0,%esp
80103597:	ff 71 fc             	pushl  -0x4(%ecx)
8010359a:	55                   	push   %ebp
8010359b:	89 e5                	mov    %esp,%ebp
8010359d:	53                   	push   %ebx
8010359e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010359f:	83 ec 08             	sub    $0x8,%esp
801035a2:	68 00 00 40 80       	push   $0x80400000
801035a7:	68 a8 f9 11 80       	push   $0x8011f9a8
801035ac:	e8 af f4 ff ff       	call   80102a60 <kinit1>
  kvmalloc();      // kernel page table
801035b1:	e8 fa 45 00 00       	call   80107bb0 <kvmalloc>
  mpinit();        // detect other processors
801035b6:	e8 75 01 00 00       	call   80103730 <mpinit>
  lapicinit();     // interrupt controller
801035bb:	e8 60 f7 ff ff       	call   80102d20 <lapicinit>
  seginit();       // segment descriptors
801035c0:	e8 fb 3c 00 00       	call   801072c0 <seginit>
  picinit();       // disable pic
801035c5:	e8 46 03 00 00       	call   80103910 <picinit>
  ioapicinit();    // another interrupt controller
801035ca:	e8 c1 f2 ff ff       	call   80102890 <ioapicinit>
  consoleinit();   // console hardware
801035cf:	e8 ec d3 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801035d4:	e8 57 2f 00 00       	call   80106530 <uartinit>
  pinit();         // process table
801035d9:	e8 82 08 00 00       	call   80103e60 <pinit>
  tvinit();        // trap vectors
801035de:	e8 6d 2b 00 00       	call   80106150 <tvinit>
  binit();         // buffer cache
801035e3:	e8 58 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
801035e8:	e8 c3 d7 ff ff       	call   80100db0 <fileinit>
  ideinit();       // disk 
801035ed:	e8 7e f0 ff ff       	call   80102670 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801035f2:	83 c4 0c             	add    $0xc,%esp
801035f5:	68 8a 00 00 00       	push   $0x8a
801035fa:	68 8c b4 10 80       	push   $0x8010b48c
801035ff:	68 00 70 00 80       	push   $0x80007000
80103604:	e8 b7 18 00 00       	call   80104ec0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103609:	69 05 00 4d 11 80 b0 	imul   $0xb0,0x80114d00,%eax
80103610:	00 00 00 
80103613:	83 c4 10             	add    $0x10,%esp
80103616:	05 80 47 11 80       	add    $0x80114780,%eax
8010361b:	3d 80 47 11 80       	cmp    $0x80114780,%eax
80103620:	76 71                	jbe    80103693 <main+0x103>
80103622:	bb 80 47 11 80       	mov    $0x80114780,%ebx
80103627:	89 f6                	mov    %esi,%esi
80103629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103630:	e8 4b 08 00 00       	call   80103e80 <mycpu>
80103635:	39 d8                	cmp    %ebx,%eax
80103637:	74 41                	je     8010367a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103639:	e8 f2 f4 ff ff       	call   80102b30 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010363e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103643:	c7 05 f8 6f 00 80 70 	movl   $0x80103570,0x80006ff8
8010364a:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010364d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103654:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103657:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010365c:	0f b6 03             	movzbl (%ebx),%eax
8010365f:	83 ec 08             	sub    $0x8,%esp
80103662:	68 00 70 00 00       	push   $0x7000
80103667:	50                   	push   %eax
80103668:	e8 03 f8 ff ff       	call   80102e70 <lapicstartap>
8010366d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103670:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103676:	85 c0                	test   %eax,%eax
80103678:	74 f6                	je     80103670 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010367a:	69 05 00 4d 11 80 b0 	imul   $0xb0,0x80114d00,%eax
80103681:	00 00 00 
80103684:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010368a:	05 80 47 11 80       	add    $0x80114780,%eax
8010368f:	39 c3                	cmp    %eax,%ebx
80103691:	72 9d                	jb     80103630 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103693:	83 ec 08             	sub    $0x8,%esp
80103696:	68 00 00 00 8e       	push   $0x8e000000
8010369b:	68 00 00 40 80       	push   $0x80400000
801036a0:	e8 2b f4 ff ff       	call   80102ad0 <kinit2>
  userinit();      // first user process
801036a5:	e8 a6 08 00 00       	call   80103f50 <userinit>
  mpmain();        // finish this processor's setup
801036aa:	e8 81 fe ff ff       	call   80103530 <mpmain>
801036af:	90                   	nop

801036b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801036b0:	55                   	push   %ebp
801036b1:	89 e5                	mov    %esp,%ebp
801036b3:	57                   	push   %edi
801036b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801036b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801036bb:	53                   	push   %ebx
  e = addr+len;
801036bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801036bf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801036c2:	39 de                	cmp    %ebx,%esi
801036c4:	72 10                	jb     801036d6 <mpsearch1+0x26>
801036c6:	eb 50                	jmp    80103718 <mpsearch1+0x68>
801036c8:	90                   	nop
801036c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d0:	39 fb                	cmp    %edi,%ebx
801036d2:	89 fe                	mov    %edi,%esi
801036d4:	76 42                	jbe    80103718 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036d6:	83 ec 04             	sub    $0x4,%esp
801036d9:	8d 7e 10             	lea    0x10(%esi),%edi
801036dc:	6a 04                	push   $0x4
801036de:	68 38 86 10 80       	push   $0x80108638
801036e3:	56                   	push   %esi
801036e4:	e8 77 17 00 00       	call   80104e60 <memcmp>
801036e9:	83 c4 10             	add    $0x10,%esp
801036ec:	85 c0                	test   %eax,%eax
801036ee:	75 e0                	jne    801036d0 <mpsearch1+0x20>
801036f0:	89 f1                	mov    %esi,%ecx
801036f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801036f8:	0f b6 11             	movzbl (%ecx),%edx
801036fb:	83 c1 01             	add    $0x1,%ecx
801036fe:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103700:	39 f9                	cmp    %edi,%ecx
80103702:	75 f4                	jne    801036f8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103704:	84 c0                	test   %al,%al
80103706:	75 c8                	jne    801036d0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103708:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010370b:	89 f0                	mov    %esi,%eax
8010370d:	5b                   	pop    %ebx
8010370e:	5e                   	pop    %esi
8010370f:	5f                   	pop    %edi
80103710:	5d                   	pop    %ebp
80103711:	c3                   	ret    
80103712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103718:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010371b:	31 f6                	xor    %esi,%esi
}
8010371d:	89 f0                	mov    %esi,%eax
8010371f:	5b                   	pop    %ebx
80103720:	5e                   	pop    %esi
80103721:	5f                   	pop    %edi
80103722:	5d                   	pop    %ebp
80103723:	c3                   	ret    
80103724:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010372a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103730 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	57                   	push   %edi
80103734:	56                   	push   %esi
80103735:	53                   	push   %ebx
80103736:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103739:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103740:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103747:	c1 e0 08             	shl    $0x8,%eax
8010374a:	09 d0                	or     %edx,%eax
8010374c:	c1 e0 04             	shl    $0x4,%eax
8010374f:	85 c0                	test   %eax,%eax
80103751:	75 1b                	jne    8010376e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103753:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010375a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103761:	c1 e0 08             	shl    $0x8,%eax
80103764:	09 d0                	or     %edx,%eax
80103766:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103769:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010376e:	ba 00 04 00 00       	mov    $0x400,%edx
80103773:	e8 38 ff ff ff       	call   801036b0 <mpsearch1>
80103778:	85 c0                	test   %eax,%eax
8010377a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010377d:	0f 84 3d 01 00 00    	je     801038c0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103783:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103786:	8b 58 04             	mov    0x4(%eax),%ebx
80103789:	85 db                	test   %ebx,%ebx
8010378b:	0f 84 4f 01 00 00    	je     801038e0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103791:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103797:	83 ec 04             	sub    $0x4,%esp
8010379a:	6a 04                	push   $0x4
8010379c:	68 55 86 10 80       	push   $0x80108655
801037a1:	56                   	push   %esi
801037a2:	e8 b9 16 00 00       	call   80104e60 <memcmp>
801037a7:	83 c4 10             	add    $0x10,%esp
801037aa:	85 c0                	test   %eax,%eax
801037ac:	0f 85 2e 01 00 00    	jne    801038e0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801037b2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801037b9:	3c 01                	cmp    $0x1,%al
801037bb:	0f 95 c2             	setne  %dl
801037be:	3c 04                	cmp    $0x4,%al
801037c0:	0f 95 c0             	setne  %al
801037c3:	20 c2                	and    %al,%dl
801037c5:	0f 85 15 01 00 00    	jne    801038e0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801037cb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801037d2:	66 85 ff             	test   %di,%di
801037d5:	74 1a                	je     801037f1 <mpinit+0xc1>
801037d7:	89 f0                	mov    %esi,%eax
801037d9:	01 f7                	add    %esi,%edi
  sum = 0;
801037db:	31 d2                	xor    %edx,%edx
801037dd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801037e0:	0f b6 08             	movzbl (%eax),%ecx
801037e3:	83 c0 01             	add    $0x1,%eax
801037e6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801037e8:	39 c7                	cmp    %eax,%edi
801037ea:	75 f4                	jne    801037e0 <mpinit+0xb0>
801037ec:	84 d2                	test   %dl,%dl
801037ee:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801037f1:	85 f6                	test   %esi,%esi
801037f3:	0f 84 e7 00 00 00    	je     801038e0 <mpinit+0x1b0>
801037f9:	84 d2                	test   %dl,%dl
801037fb:	0f 85 df 00 00 00    	jne    801038e0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103801:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103807:	a3 7c 46 11 80       	mov    %eax,0x8011467c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010380c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103813:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103819:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010381e:	01 d6                	add    %edx,%esi
80103820:	39 c6                	cmp    %eax,%esi
80103822:	76 23                	jbe    80103847 <mpinit+0x117>
    switch(*p){
80103824:	0f b6 10             	movzbl (%eax),%edx
80103827:	80 fa 04             	cmp    $0x4,%dl
8010382a:	0f 87 ca 00 00 00    	ja     801038fa <mpinit+0x1ca>
80103830:	ff 24 95 7c 86 10 80 	jmp    *-0x7fef7984(,%edx,4)
80103837:	89 f6                	mov    %esi,%esi
80103839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103840:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103843:	39 c6                	cmp    %eax,%esi
80103845:	77 dd                	ja     80103824 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103847:	85 db                	test   %ebx,%ebx
80103849:	0f 84 9e 00 00 00    	je     801038ed <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010384f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103852:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103856:	74 15                	je     8010386d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103858:	b8 70 00 00 00       	mov    $0x70,%eax
8010385d:	ba 22 00 00 00       	mov    $0x22,%edx
80103862:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103863:	ba 23 00 00 00       	mov    $0x23,%edx
80103868:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103869:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010386c:	ee                   	out    %al,(%dx)
  }
}
8010386d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103870:	5b                   	pop    %ebx
80103871:	5e                   	pop    %esi
80103872:	5f                   	pop    %edi
80103873:	5d                   	pop    %ebp
80103874:	c3                   	ret    
80103875:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103878:	8b 0d 00 4d 11 80    	mov    0x80114d00,%ecx
8010387e:	83 f9 07             	cmp    $0x7,%ecx
80103881:	7f 19                	jg     8010389c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103883:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103887:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010388d:	83 c1 01             	add    $0x1,%ecx
80103890:	89 0d 00 4d 11 80    	mov    %ecx,0x80114d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103896:	88 97 80 47 11 80    	mov    %dl,-0x7feeb880(%edi)
      p += sizeof(struct mpproc);
8010389c:	83 c0 14             	add    $0x14,%eax
      continue;
8010389f:	e9 7c ff ff ff       	jmp    80103820 <mpinit+0xf0>
801038a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801038a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801038ac:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801038af:	88 15 60 47 11 80    	mov    %dl,0x80114760
      continue;
801038b5:	e9 66 ff ff ff       	jmp    80103820 <mpinit+0xf0>
801038ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801038c0:	ba 00 00 01 00       	mov    $0x10000,%edx
801038c5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801038ca:	e8 e1 fd ff ff       	call   801036b0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038cf:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801038d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038d4:	0f 85 a9 fe ff ff    	jne    80103783 <mpinit+0x53>
801038da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801038e0:	83 ec 0c             	sub    $0xc,%esp
801038e3:	68 3d 86 10 80       	push   $0x8010863d
801038e8:	e8 a3 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801038ed:	83 ec 0c             	sub    $0xc,%esp
801038f0:	68 5c 86 10 80       	push   $0x8010865c
801038f5:	e8 96 ca ff ff       	call   80100390 <panic>
      ismp = 0;
801038fa:	31 db                	xor    %ebx,%ebx
801038fc:	e9 26 ff ff ff       	jmp    80103827 <mpinit+0xf7>
80103901:	66 90                	xchg   %ax,%ax
80103903:	66 90                	xchg   %ax,%ax
80103905:	66 90                	xchg   %ax,%ax
80103907:	66 90                	xchg   %ax,%ax
80103909:	66 90                	xchg   %ax,%ax
8010390b:	66 90                	xchg   %ax,%ax
8010390d:	66 90                	xchg   %ax,%ax
8010390f:	90                   	nop

80103910 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103910:	55                   	push   %ebp
80103911:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103916:	ba 21 00 00 00       	mov    $0x21,%edx
8010391b:	89 e5                	mov    %esp,%ebp
8010391d:	ee                   	out    %al,(%dx)
8010391e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103923:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103924:	5d                   	pop    %ebp
80103925:	c3                   	ret    
80103926:	66 90                	xchg   %ax,%ax
80103928:	66 90                	xchg   %ax,%ax
8010392a:	66 90                	xchg   %ax,%ax
8010392c:	66 90                	xchg   %ax,%ax
8010392e:	66 90                	xchg   %ax,%ax

80103930 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	57                   	push   %edi
80103934:	56                   	push   %esi
80103935:	53                   	push   %ebx
80103936:	83 ec 0c             	sub    $0xc,%esp
80103939:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010393c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010393f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103945:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010394b:	e8 80 d4 ff ff       	call   80100dd0 <filealloc>
80103950:	85 c0                	test   %eax,%eax
80103952:	89 03                	mov    %eax,(%ebx)
80103954:	74 22                	je     80103978 <pipealloc+0x48>
80103956:	e8 75 d4 ff ff       	call   80100dd0 <filealloc>
8010395b:	85 c0                	test   %eax,%eax
8010395d:	89 06                	mov    %eax,(%esi)
8010395f:	74 3f                	je     801039a0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103961:	e8 ca f1 ff ff       	call   80102b30 <kalloc>
80103966:	85 c0                	test   %eax,%eax
80103968:	89 c7                	mov    %eax,%edi
8010396a:	75 54                	jne    801039c0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010396c:	8b 03                	mov    (%ebx),%eax
8010396e:	85 c0                	test   %eax,%eax
80103970:	75 34                	jne    801039a6 <pipealloc+0x76>
80103972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103978:	8b 06                	mov    (%esi),%eax
8010397a:	85 c0                	test   %eax,%eax
8010397c:	74 0c                	je     8010398a <pipealloc+0x5a>
    fileclose(*f1);
8010397e:	83 ec 0c             	sub    $0xc,%esp
80103981:	50                   	push   %eax
80103982:	e8 09 d5 ff ff       	call   80100e90 <fileclose>
80103987:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010398a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010398d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103992:	5b                   	pop    %ebx
80103993:	5e                   	pop    %esi
80103994:	5f                   	pop    %edi
80103995:	5d                   	pop    %ebp
80103996:	c3                   	ret    
80103997:	89 f6                	mov    %esi,%esi
80103999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801039a0:	8b 03                	mov    (%ebx),%eax
801039a2:	85 c0                	test   %eax,%eax
801039a4:	74 e4                	je     8010398a <pipealloc+0x5a>
    fileclose(*f0);
801039a6:	83 ec 0c             	sub    $0xc,%esp
801039a9:	50                   	push   %eax
801039aa:	e8 e1 d4 ff ff       	call   80100e90 <fileclose>
  if(*f1)
801039af:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801039b1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801039b4:	85 c0                	test   %eax,%eax
801039b6:	75 c6                	jne    8010397e <pipealloc+0x4e>
801039b8:	eb d0                	jmp    8010398a <pipealloc+0x5a>
801039ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801039c0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801039c3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801039ca:	00 00 00 
  p->writeopen = 1;
801039cd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801039d4:	00 00 00 
  p->nwrite = 0;
801039d7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801039de:	00 00 00 
  p->nread = 0;
801039e1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801039e8:	00 00 00 
  initlock(&p->lock, "pipe");
801039eb:	68 90 86 10 80       	push   $0x80108690
801039f0:	50                   	push   %eax
801039f1:	e8 aa 11 00 00       	call   80104ba0 <initlock>
  (*f0)->type = FD_PIPE;
801039f6:	8b 03                	mov    (%ebx),%eax
  return 0;
801039f8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801039fb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103a01:	8b 03                	mov    (%ebx),%eax
80103a03:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103a07:	8b 03                	mov    (%ebx),%eax
80103a09:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103a0d:	8b 03                	mov    (%ebx),%eax
80103a0f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103a12:	8b 06                	mov    (%esi),%eax
80103a14:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103a1a:	8b 06                	mov    (%esi),%eax
80103a1c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103a20:	8b 06                	mov    (%esi),%eax
80103a22:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103a26:	8b 06                	mov    (%esi),%eax
80103a28:	89 78 0c             	mov    %edi,0xc(%eax)
}
80103a2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103a2e:	31 c0                	xor    %eax,%eax
}
80103a30:	5b                   	pop    %ebx
80103a31:	5e                   	pop    %esi
80103a32:	5f                   	pop    %edi
80103a33:	5d                   	pop    %ebp
80103a34:	c3                   	ret    
80103a35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a40 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	56                   	push   %esi
80103a44:	53                   	push   %ebx
80103a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a48:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103a4b:	83 ec 0c             	sub    $0xc,%esp
80103a4e:	53                   	push   %ebx
80103a4f:	e8 3c 12 00 00       	call   80104c90 <acquire>
  if(writable){
80103a54:	83 c4 10             	add    $0x10,%esp
80103a57:	85 f6                	test   %esi,%esi
80103a59:	74 45                	je     80103aa0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a5b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a61:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103a64:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a6b:	00 00 00 
    wakeup(&p->nread);
80103a6e:	50                   	push   %eax
80103a6f:	e8 cc 0d 00 00       	call   80104840 <wakeup>
80103a74:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a77:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a7d:	85 d2                	test   %edx,%edx
80103a7f:	75 0a                	jne    80103a8b <pipeclose+0x4b>
80103a81:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a87:	85 c0                	test   %eax,%eax
80103a89:	74 35                	je     80103ac0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a8b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a91:	5b                   	pop    %ebx
80103a92:	5e                   	pop    %esi
80103a93:	5d                   	pop    %ebp
    release(&p->lock);
80103a94:	e9 17 13 00 00       	jmp    80104db0 <release>
80103a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103aa0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103aa6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103aa9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103ab0:	00 00 00 
    wakeup(&p->nwrite);
80103ab3:	50                   	push   %eax
80103ab4:	e8 87 0d 00 00       	call   80104840 <wakeup>
80103ab9:	83 c4 10             	add    $0x10,%esp
80103abc:	eb b9                	jmp    80103a77 <pipeclose+0x37>
80103abe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103ac0:	83 ec 0c             	sub    $0xc,%esp
80103ac3:	53                   	push   %ebx
80103ac4:	e8 e7 12 00 00       	call   80104db0 <release>
    kfree((char*)p);
80103ac9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103acc:	83 c4 10             	add    $0x10,%esp
}
80103acf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ad2:	5b                   	pop    %ebx
80103ad3:	5e                   	pop    %esi
80103ad4:	5d                   	pop    %ebp
    kfree((char*)p);
80103ad5:	e9 a6 ee ff ff       	jmp    80102980 <kfree>
80103ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ae0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	57                   	push   %edi
80103ae4:	56                   	push   %esi
80103ae5:	53                   	push   %ebx
80103ae6:	83 ec 28             	sub    $0x28,%esp
80103ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103aec:	53                   	push   %ebx
80103aed:	e8 9e 11 00 00       	call   80104c90 <acquire>
  for(i = 0; i < n; i++){
80103af2:	8b 45 10             	mov    0x10(%ebp),%eax
80103af5:	83 c4 10             	add    $0x10,%esp
80103af8:	85 c0                	test   %eax,%eax
80103afa:	0f 8e c9 00 00 00    	jle    80103bc9 <pipewrite+0xe9>
80103b00:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103b03:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103b09:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103b0f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103b12:	03 4d 10             	add    0x10(%ebp),%ecx
80103b15:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b18:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103b1e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103b24:	39 d0                	cmp    %edx,%eax
80103b26:	75 71                	jne    80103b99 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103b28:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b2e:	85 c0                	test   %eax,%eax
80103b30:	74 4e                	je     80103b80 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b32:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103b38:	eb 3a                	jmp    80103b74 <pipewrite+0x94>
80103b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103b40:	83 ec 0c             	sub    $0xc,%esp
80103b43:	57                   	push   %edi
80103b44:	e8 f7 0c 00 00       	call   80104840 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b49:	5a                   	pop    %edx
80103b4a:	59                   	pop    %ecx
80103b4b:	53                   	push   %ebx
80103b4c:	56                   	push   %esi
80103b4d:	e8 fe 0a 00 00       	call   80104650 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b52:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b58:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b5e:	83 c4 10             	add    $0x10,%esp
80103b61:	05 00 02 00 00       	add    $0x200,%eax
80103b66:	39 c2                	cmp    %eax,%edx
80103b68:	75 36                	jne    80103ba0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103b6a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b70:	85 c0                	test   %eax,%eax
80103b72:	74 0c                	je     80103b80 <pipewrite+0xa0>
80103b74:	e8 a7 03 00 00       	call   80103f20 <myproc>
80103b79:	8b 40 24             	mov    0x24(%eax),%eax
80103b7c:	85 c0                	test   %eax,%eax
80103b7e:	74 c0                	je     80103b40 <pipewrite+0x60>
        release(&p->lock);
80103b80:	83 ec 0c             	sub    $0xc,%esp
80103b83:	53                   	push   %ebx
80103b84:	e8 27 12 00 00       	call   80104db0 <release>
        return -1;
80103b89:	83 c4 10             	add    $0x10,%esp
80103b8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103b91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b94:	5b                   	pop    %ebx
80103b95:	5e                   	pop    %esi
80103b96:	5f                   	pop    %edi
80103b97:	5d                   	pop    %ebp
80103b98:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b99:	89 c2                	mov    %eax,%edx
80103b9b:	90                   	nop
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103ba0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103ba3:	8d 42 01             	lea    0x1(%edx),%eax
80103ba6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103bac:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103bb2:	83 c6 01             	add    $0x1,%esi
80103bb5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103bb9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103bbc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103bbf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103bc3:	0f 85 4f ff ff ff    	jne    80103b18 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103bc9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103bcf:	83 ec 0c             	sub    $0xc,%esp
80103bd2:	50                   	push   %eax
80103bd3:	e8 68 0c 00 00       	call   80104840 <wakeup>
  release(&p->lock);
80103bd8:	89 1c 24             	mov    %ebx,(%esp)
80103bdb:	e8 d0 11 00 00       	call   80104db0 <release>
  return n;
80103be0:	83 c4 10             	add    $0x10,%esp
80103be3:	8b 45 10             	mov    0x10(%ebp),%eax
80103be6:	eb a9                	jmp    80103b91 <pipewrite+0xb1>
80103be8:	90                   	nop
80103be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bf0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
80103bf6:	83 ec 18             	sub    $0x18,%esp
80103bf9:	8b 75 08             	mov    0x8(%ebp),%esi
80103bfc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103bff:	56                   	push   %esi
80103c00:	e8 8b 10 00 00       	call   80104c90 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c05:	83 c4 10             	add    $0x10,%esp
80103c08:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c0e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c14:	75 6a                	jne    80103c80 <piperead+0x90>
80103c16:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103c1c:	85 db                	test   %ebx,%ebx
80103c1e:	0f 84 c4 00 00 00    	je     80103ce8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103c24:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103c2a:	eb 2d                	jmp    80103c59 <piperead+0x69>
80103c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c30:	83 ec 08             	sub    $0x8,%esp
80103c33:	56                   	push   %esi
80103c34:	53                   	push   %ebx
80103c35:	e8 16 0a 00 00       	call   80104650 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c3a:	83 c4 10             	add    $0x10,%esp
80103c3d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c43:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c49:	75 35                	jne    80103c80 <piperead+0x90>
80103c4b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103c51:	85 d2                	test   %edx,%edx
80103c53:	0f 84 8f 00 00 00    	je     80103ce8 <piperead+0xf8>
    if(myproc()->killed){
80103c59:	e8 c2 02 00 00       	call   80103f20 <myproc>
80103c5e:	8b 48 24             	mov    0x24(%eax),%ecx
80103c61:	85 c9                	test   %ecx,%ecx
80103c63:	74 cb                	je     80103c30 <piperead+0x40>
      release(&p->lock);
80103c65:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c68:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c6d:	56                   	push   %esi
80103c6e:	e8 3d 11 00 00       	call   80104db0 <release>
      return -1;
80103c73:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103c76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c79:	89 d8                	mov    %ebx,%eax
80103c7b:	5b                   	pop    %ebx
80103c7c:	5e                   	pop    %esi
80103c7d:	5f                   	pop    %edi
80103c7e:	5d                   	pop    %ebp
80103c7f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c80:	8b 45 10             	mov    0x10(%ebp),%eax
80103c83:	85 c0                	test   %eax,%eax
80103c85:	7e 61                	jle    80103ce8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103c87:	31 db                	xor    %ebx,%ebx
80103c89:	eb 13                	jmp    80103c9e <piperead+0xae>
80103c8b:	90                   	nop
80103c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c90:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c96:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c9c:	74 1f                	je     80103cbd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103c9e:	8d 41 01             	lea    0x1(%ecx),%eax
80103ca1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103ca7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103cad:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103cb2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103cb5:	83 c3 01             	add    $0x1,%ebx
80103cb8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103cbb:	75 d3                	jne    80103c90 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103cbd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103cc3:	83 ec 0c             	sub    $0xc,%esp
80103cc6:	50                   	push   %eax
80103cc7:	e8 74 0b 00 00       	call   80104840 <wakeup>
  release(&p->lock);
80103ccc:	89 34 24             	mov    %esi,(%esp)
80103ccf:	e8 dc 10 00 00       	call   80104db0 <release>
  return i;
80103cd4:	83 c4 10             	add    $0x10,%esp
}
80103cd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cda:	89 d8                	mov    %ebx,%eax
80103cdc:	5b                   	pop    %ebx
80103cdd:	5e                   	pop    %esi
80103cde:	5f                   	pop    %edi
80103cdf:	5d                   	pop    %ebp
80103ce0:	c3                   	ret    
80103ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ce8:	31 db                	xor    %ebx,%ebx
80103cea:	eb d1                	jmp    80103cbd <piperead+0xcd>
80103cec:	66 90                	xchg   %ax,%ax
80103cee:	66 90                	xchg   %ax,%ax

80103cf0 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void) {
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	56                   	push   %esi
80103cf4:	53                   	push   %ebx
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cf5:	bb 54 4d 11 80       	mov    $0x80114d54,%ebx
    acquire(&ptable.lock);
80103cfa:	83 ec 0c             	sub    $0xc,%esp
80103cfd:	68 20 4d 11 80       	push   $0x80114d20
80103d02:	e8 89 0f 00 00       	call   80104c90 <acquire>
80103d07:	83 c4 10             	add    $0x10,%esp
80103d0a:	eb 16                	jmp    80103d22 <allocproc+0x32>
80103d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d10:	81 c3 90 02 00 00    	add    $0x290,%ebx
80103d16:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80103d1c:	0f 83 be 00 00 00    	jae    80103de0 <allocproc+0xf0>
        if (p->state == UNUSED)
80103d22:	8b 43 0c             	mov    0xc(%ebx),%eax
80103d25:	85 c0                	test   %eax,%eax
80103d27:	75 e7                	jne    80103d10 <allocproc+0x20>
    release(&ptable.lock);
    return 0;

    found:
    p->state = EMBRYO;
    p->pid = nextpid++;
80103d29:	a1 04 b0 10 80       	mov    0x8010b004,%eax

    release(&ptable.lock);
80103d2e:	83 ec 0c             	sub    $0xc,%esp
    p->state = EMBRYO;
80103d31:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
    p->pid = nextpid++;
80103d38:	8d 50 01             	lea    0x1(%eax),%edx
80103d3b:	89 43 10             	mov    %eax,0x10(%ebx)
    release(&ptable.lock);
80103d3e:	68 20 4d 11 80       	push   $0x80114d20
    p->pid = nextpid++;
80103d43:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
    release(&ptable.lock);
80103d49:	e8 62 10 00 00       	call   80104db0 <release>

    // Allocate kernel stack.
    if ((p->kstack = kalloc()) == 0) {
80103d4e:	e8 dd ed ff ff       	call   80102b30 <kalloc>
80103d53:	83 c4 10             	add    $0x10,%esp
80103d56:	85 c0                	test   %eax,%eax
80103d58:	89 c6                	mov    %eax,%esi
80103d5a:	89 43 08             	mov    %eax,0x8(%ebx)
80103d5d:	0f 84 98 00 00 00    	je     80103dfb <allocproc+0x10b>
        return 0;
    }
    sp = p->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
80103d63:	8d 80 b4 0f 00 00    	lea    0xfb4(%eax),%eax
80103d69:	89 43 18             	mov    %eax,0x18(%ebx)
    p->tf = (struct trapframe *) sp;

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
    *(uint *) sp = (uint) trapret;
80103d6c:	c7 86 b0 0f 00 00 3f 	movl   $0x8010613f,0xfb0(%esi)
80103d73:	61 10 80 

    if(p->pid > 2) createSwapFile(p);
80103d76:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
80103d7a:	7f 54                	jg     80103dd0 <allocproc+0xe0>
    p->last_in_queue = 0;
    p->page_fault_counter = 0;

    sp -= sizeof *p->context;
    p->context = (struct context *) sp;
    memset(p->context, 0, sizeof *p->context);
80103d7c:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *p->context;
80103d7f:	81 c6 9c 0f 00 00    	add    $0xf9c,%esi
    p->pages_in_file = 0;
80103d85:	c7 83 80 02 00 00 00 	movl   $0x0,0x280(%ebx)
80103d8c:	00 00 00 
    p->last_in_queue = 0;
80103d8f:	c7 83 84 02 00 00 00 	movl   $0x0,0x284(%ebx)
80103d96:	00 00 00 
    p->page_fault_counter = 0;
80103d99:	c7 83 8c 02 00 00 00 	movl   $0x0,0x28c(%ebx)
80103da0:	00 00 00 
    p->context = (struct context *) sp;
80103da3:	89 73 1c             	mov    %esi,0x1c(%ebx)
    memset(p->context, 0, sizeof *p->context);
80103da6:	6a 14                	push   $0x14
80103da8:	6a 00                	push   $0x0
80103daa:	56                   	push   %esi
80103dab:	e8 60 10 00 00       	call   80104e10 <memset>
    p->context->eip = (uint) forkret;
80103db0:	8b 43 1c             	mov    0x1c(%ebx),%eax


    return p;
80103db3:	83 c4 10             	add    $0x10,%esp
    p->context->eip = (uint) forkret;
80103db6:	c7 40 10 10 3e 10 80 	movl   $0x80103e10,0x10(%eax)
}
80103dbd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dc0:	89 d8                	mov    %ebx,%eax
80103dc2:	5b                   	pop    %ebx
80103dc3:	5e                   	pop    %esi
80103dc4:	5d                   	pop    %ebp
80103dc5:	c3                   	ret    
80103dc6:	8d 76 00             	lea    0x0(%esi),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->pid > 2) createSwapFile(p);
80103dd0:	83 ec 0c             	sub    $0xc,%esp
80103dd3:	53                   	push   %ebx
80103dd4:	e8 47 e4 ff ff       	call   80102220 <createSwapFile>
80103dd9:	83 c4 10             	add    $0x10,%esp
80103ddc:	eb 9e                	jmp    80103d7c <allocproc+0x8c>
80103dde:	66 90                	xchg   %ax,%ax
    release(&ptable.lock);
80103de0:	83 ec 0c             	sub    $0xc,%esp
    return 0;
80103de3:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80103de5:	68 20 4d 11 80       	push   $0x80114d20
80103dea:	e8 c1 0f 00 00       	call   80104db0 <release>
    return 0;
80103def:	83 c4 10             	add    $0x10,%esp
}
80103df2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df5:	89 d8                	mov    %ebx,%eax
80103df7:	5b                   	pop    %ebx
80103df8:	5e                   	pop    %esi
80103df9:	5d                   	pop    %ebp
80103dfa:	c3                   	ret    
        p->state = UNUSED;
80103dfb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        return 0;
80103e02:	31 db                	xor    %ebx,%ebx
80103e04:	eb b7                	jmp    80103dbd <allocproc+0xcd>
80103e06:	8d 76 00             	lea    0x0(%esi),%esi
80103e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e10 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void) {
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	83 ec 14             	sub    $0x14,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80103e16:	68 20 4d 11 80       	push   $0x80114d20
80103e1b:	e8 90 0f 00 00       	call   80104db0 <release>

    if (first) {
80103e20:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103e25:	83 c4 10             	add    $0x10,%esp
80103e28:	85 c0                	test   %eax,%eax
80103e2a:	75 04                	jne    80103e30 <forkret+0x20>
        iinit(ROOTDEV);
        initlog(ROOTDEV);
    }

    // Return to "caller", actually trapret (see allocproc).
}
80103e2c:	c9                   	leave  
80103e2d:	c3                   	ret    
80103e2e:	66 90                	xchg   %ax,%ax
        iinit(ROOTDEV);
80103e30:	83 ec 0c             	sub    $0xc,%esp
        first = 0;
80103e33:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103e3a:	00 00 00 
        iinit(ROOTDEV);
80103e3d:	6a 01                	push   $0x1
80103e3f:	e8 ac d6 ff ff       	call   801014f0 <iinit>
        initlog(ROOTDEV);
80103e44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103e4b:	e8 a0 f3 ff ff       	call   801031f0 <initlog>
80103e50:	83 c4 10             	add    $0x10,%esp
}
80103e53:	c9                   	leave  
80103e54:	c3                   	ret    
80103e55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e60 <pinit>:
pinit(void) {
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	83 ec 10             	sub    $0x10,%esp
    initlock(&ptable.lock, "ptable");
80103e66:	68 95 86 10 80       	push   $0x80108695
80103e6b:	68 20 4d 11 80       	push   $0x80114d20
80103e70:	e8 2b 0d 00 00       	call   80104ba0 <initlock>
}
80103e75:	83 c4 10             	add    $0x10,%esp
80103e78:	c9                   	leave  
80103e79:	c3                   	ret    
80103e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e80 <mycpu>:
mycpu(void) {
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	56                   	push   %esi
80103e84:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e85:	9c                   	pushf  
80103e86:	58                   	pop    %eax
    if (readeflags() & FL_IF)
80103e87:	f6 c4 02             	test   $0x2,%ah
80103e8a:	75 5e                	jne    80103eea <mycpu+0x6a>
    apicid = lapicid();
80103e8c:	e8 8f ef ff ff       	call   80102e20 <lapicid>
    for (i = 0; i < ncpu; ++i) {
80103e91:	8b 35 00 4d 11 80    	mov    0x80114d00,%esi
80103e97:	85 f6                	test   %esi,%esi
80103e99:	7e 42                	jle    80103edd <mycpu+0x5d>
        if (cpus[i].apicid == apicid)
80103e9b:	0f b6 15 80 47 11 80 	movzbl 0x80114780,%edx
80103ea2:	39 d0                	cmp    %edx,%eax
80103ea4:	74 30                	je     80103ed6 <mycpu+0x56>
80103ea6:	b9 30 48 11 80       	mov    $0x80114830,%ecx
    for (i = 0; i < ncpu; ++i) {
80103eab:	31 d2                	xor    %edx,%edx
80103ead:	8d 76 00             	lea    0x0(%esi),%esi
80103eb0:	83 c2 01             	add    $0x1,%edx
80103eb3:	39 f2                	cmp    %esi,%edx
80103eb5:	74 26                	je     80103edd <mycpu+0x5d>
        if (cpus[i].apicid == apicid)
80103eb7:	0f b6 19             	movzbl (%ecx),%ebx
80103eba:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103ec0:	39 c3                	cmp    %eax,%ebx
80103ec2:	75 ec                	jne    80103eb0 <mycpu+0x30>
80103ec4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103eca:	05 80 47 11 80       	add    $0x80114780,%eax
}
80103ecf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ed2:	5b                   	pop    %ebx
80103ed3:	5e                   	pop    %esi
80103ed4:	5d                   	pop    %ebp
80103ed5:	c3                   	ret    
        if (cpus[i].apicid == apicid)
80103ed6:	b8 80 47 11 80       	mov    $0x80114780,%eax
            return &cpus[i];
80103edb:	eb f2                	jmp    80103ecf <mycpu+0x4f>
    panic("unknown apicid\n");
80103edd:	83 ec 0c             	sub    $0xc,%esp
80103ee0:	68 9c 86 10 80       	push   $0x8010869c
80103ee5:	e8 a6 c4 ff ff       	call   80100390 <panic>
        panic("mycpu called with interrupts enabled\n");
80103eea:	83 ec 0c             	sub    $0xc,%esp
80103eed:	68 80 87 10 80       	push   $0x80108780
80103ef2:	e8 99 c4 ff ff       	call   80100390 <panic>
80103ef7:	89 f6                	mov    %esi,%esi
80103ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f00 <cpuid>:
cpuid() {
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	83 ec 08             	sub    $0x8,%esp
    return mycpu() - cpus;
80103f06:	e8 75 ff ff ff       	call   80103e80 <mycpu>
80103f0b:	2d 80 47 11 80       	sub    $0x80114780,%eax
}
80103f10:	c9                   	leave  
    return mycpu() - cpus;
80103f11:	c1 f8 04             	sar    $0x4,%eax
80103f14:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f1a:	c3                   	ret    
80103f1b:	90                   	nop
80103f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f20 <myproc>:
myproc(void) {
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	53                   	push   %ebx
80103f24:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80103f27:	e8 24 0d 00 00       	call   80104c50 <pushcli>
    c = mycpu();
80103f2c:	e8 4f ff ff ff       	call   80103e80 <mycpu>
    p = c->proc;
80103f31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103f37:	e8 14 0e 00 00       	call   80104d50 <popcli>
}
80103f3c:	83 c4 04             	add    $0x4,%esp
80103f3f:	89 d8                	mov    %ebx,%eax
80103f41:	5b                   	pop    %ebx
80103f42:	5d                   	pop    %ebp
80103f43:	c3                   	ret    
80103f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103f50 <userinit>:
userinit(void) {
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 04             	sub    $0x4,%esp
    p = allocproc();
80103f57:	e8 94 fd ff ff       	call   80103cf0 <allocproc>
80103f5c:	89 c3                	mov    %eax,%ebx
    initproc = p;
80103f5e:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
    if ((p->pgdir = setupkvm()) == 0)
80103f63:	e8 c8 3b 00 00       	call   80107b30 <setupkvm>
80103f68:	85 c0                	test   %eax,%eax
80103f6a:	89 43 04             	mov    %eax,0x4(%ebx)
80103f6d:	0f 84 bd 00 00 00    	je     80104030 <userinit+0xe0>
    inituvm(p->pgdir, _binary_initcode_start, (int) _binary_initcode_size);
80103f73:	83 ec 04             	sub    $0x4,%esp
80103f76:	68 2c 00 00 00       	push   $0x2c
80103f7b:	68 60 b4 10 80       	push   $0x8010b460
80103f80:	50                   	push   %eax
80103f81:	e8 fa 34 00 00       	call   80107480 <inituvm>
    memset(p->tf, 0, sizeof(*p->tf));
80103f86:	83 c4 0c             	add    $0xc,%esp
    p->sz = PGSIZE;
80103f89:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
    memset(p->tf, 0, sizeof(*p->tf));
80103f8f:	6a 4c                	push   $0x4c
80103f91:	6a 00                	push   $0x0
80103f93:	ff 73 18             	pushl  0x18(%ebx)
80103f96:	e8 75 0e 00 00       	call   80104e10 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f9b:	8b 43 18             	mov    0x18(%ebx),%eax
80103f9e:	ba 1b 00 00 00       	mov    $0x1b,%edx
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103fa3:	b9 23 00 00 00       	mov    $0x23,%ecx
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103fa8:	83 c4 0c             	add    $0xc,%esp
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103fab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103faf:	8b 43 18             	mov    0x18(%ebx),%eax
80103fb2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
    p->tf->es = p->tf->ds;
80103fb6:	8b 43 18             	mov    0x18(%ebx),%eax
80103fb9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103fbd:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80103fc1:	8b 43 18             	mov    0x18(%ebx),%eax
80103fc4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103fc8:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80103fcc:	8b 43 18             	mov    0x18(%ebx),%eax
80103fcf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80103fd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103fd9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80103fe0:	8b 43 18             	mov    0x18(%ebx),%eax
80103fe3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103fea:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103fed:	6a 10                	push   $0x10
80103fef:	68 c5 86 10 80       	push   $0x801086c5
80103ff4:	50                   	push   %eax
80103ff5:	e8 f6 0f 00 00       	call   80104ff0 <safestrcpy>
    p->cwd = namei("/");
80103ffa:	c7 04 24 ce 86 10 80 	movl   $0x801086ce,(%esp)
80104001:	e8 4a df ff ff       	call   80101f50 <namei>
80104006:	89 43 68             	mov    %eax,0x68(%ebx)
    acquire(&ptable.lock);
80104009:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80104010:	e8 7b 0c 00 00       	call   80104c90 <acquire>
    p->state = RUNNABLE;
80104015:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    release(&ptable.lock);
8010401c:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80104023:	e8 88 0d 00 00       	call   80104db0 <release>
}
80104028:	83 c4 10             	add    $0x10,%esp
8010402b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010402e:	c9                   	leave  
8010402f:	c3                   	ret    
        panic("userinit: out of memory?");
80104030:	83 ec 0c             	sub    $0xc,%esp
80104033:	68 ac 86 10 80       	push   $0x801086ac
80104038:	e8 53 c3 ff ff       	call   80100390 <panic>
8010403d:	8d 76 00             	lea    0x0(%esi),%esi

80104040 <growproc>:
growproc(int n) {
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	56                   	push   %esi
80104044:	53                   	push   %ebx
80104045:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
80104048:	e8 03 0c 00 00       	call   80104c50 <pushcli>
    c = mycpu();
8010404d:	e8 2e fe ff ff       	call   80103e80 <mycpu>
    p = c->proc;
80104052:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104058:	e8 f3 0c 00 00       	call   80104d50 <popcli>
    if (n > 0) {
8010405d:	83 fe 00             	cmp    $0x0,%esi
    sz = curproc->sz;
80104060:	8b 03                	mov    (%ebx),%eax
    if (n > 0) {
80104062:	7f 1c                	jg     80104080 <growproc+0x40>
    } else if (n < 0) {
80104064:	75 3a                	jne    801040a0 <growproc+0x60>
    switchuvm(curproc);
80104066:	83 ec 0c             	sub    $0xc,%esp
    curproc->sz = sz;
80104069:	89 03                	mov    %eax,(%ebx)
    switchuvm(curproc);
8010406b:	53                   	push   %ebx
8010406c:	e8 ff 32 00 00       	call   80107370 <switchuvm>
    return 0;
80104071:	83 c4 10             	add    $0x10,%esp
80104074:	31 c0                	xor    %eax,%eax
}
80104076:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104079:	5b                   	pop    %ebx
8010407a:	5e                   	pop    %esi
8010407b:	5d                   	pop    %ebp
8010407c:	c3                   	ret    
8010407d:	8d 76 00             	lea    0x0(%esi),%esi
        if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104080:	83 ec 04             	sub    $0x4,%esp
80104083:	01 c6                	add    %eax,%esi
80104085:	56                   	push   %esi
80104086:	50                   	push   %eax
80104087:	ff 73 04             	pushl  0x4(%ebx)
8010408a:	e8 81 38 00 00       	call   80107910 <allocuvm>
8010408f:	83 c4 10             	add    $0x10,%esp
80104092:	85 c0                	test   %eax,%eax
80104094:	75 d0                	jne    80104066 <growproc+0x26>
            return -1;
80104096:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010409b:	eb d9                	jmp    80104076 <growproc+0x36>
8010409d:	8d 76 00             	lea    0x0(%esi),%esi
        if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801040a0:	83 ec 04             	sub    $0x4,%esp
801040a3:	01 c6                	add    %eax,%esi
801040a5:	56                   	push   %esi
801040a6:	50                   	push   %eax
801040a7:	ff 73 04             	pushl  0x4(%ebx)
801040aa:	e8 d1 39 00 00       	call   80107a80 <deallocuvm>
801040af:	83 c4 10             	add    $0x10,%esp
801040b2:	85 c0                	test   %eax,%eax
801040b4:	75 b0                	jne    80104066 <growproc+0x26>
801040b6:	eb de                	jmp    80104096 <growproc+0x56>
801040b8:	90                   	nop
801040b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040c0 <copy_ram_monitor>:
void copy_ram_monitor(struct proc *np) {
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	57                   	push   %edi
801040c4:	56                   	push   %esi
801040c5:	53                   	push   %ebx
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
801040c6:	31 f6                	xor    %esi,%esi
void copy_ram_monitor(struct proc *np) {
801040c8:	83 ec 1c             	sub    $0x1c,%esp
801040cb:	8b 7d 08             	mov    0x8(%ebp),%edi
801040ce:	8d 9f 80 00 00 00    	lea    0x80(%edi),%ebx
801040d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pushcli();
801040d8:	e8 73 0b 00 00       	call   80104c50 <pushcli>
    c = mycpu();
801040dd:	e8 9e fd ff ff       	call   80103e80 <mycpu>
    p = c->proc;
801040e2:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801040e8:	83 c3 10             	add    $0x10,%ebx
801040eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    popcli();
801040ee:	e8 5d 0c 00 00       	call   80104d50 <popcli>
        np->ram_monitor[i] = myproc()->ram_monitor[i];
801040f3:	8d 46 08             	lea    0x8(%esi),%eax
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
801040f6:	83 c6 01             	add    $0x1,%esi
        np->ram_monitor[i] = myproc()->ram_monitor[i];
801040f9:	c1 e0 04             	shl    $0x4,%eax
801040fc:	03 45 e4             	add    -0x1c(%ebp),%eax
801040ff:	8b 08                	mov    (%eax),%ecx
80104101:	89 4b f0             	mov    %ecx,-0x10(%ebx)
80104104:	8b 48 04             	mov    0x4(%eax),%ecx
80104107:	89 4b f4             	mov    %ecx,-0xc(%ebx)
8010410a:	8b 48 08             	mov    0x8(%eax),%ecx
8010410d:	89 4b f8             	mov    %ecx,-0x8(%ebx)
80104110:	8b 40 0c             	mov    0xc(%eax),%eax
80104113:	89 43 fc             	mov    %eax,-0x4(%ebx)
        np->ram_monitor[i].pgdir = np->pgdir;
80104116:	8b 47 04             	mov    0x4(%edi),%eax
80104119:	89 43 f4             	mov    %eax,-0xc(%ebx)
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
8010411c:	83 fe 10             	cmp    $0x10,%esi
8010411f:	75 b7                	jne    801040d8 <copy_ram_monitor+0x18>
}
80104121:	83 c4 1c             	add    $0x1c,%esp
80104124:	5b                   	pop    %ebx
80104125:	5e                   	pop    %esi
80104126:	5f                   	pop    %edi
80104127:	5d                   	pop    %ebp
80104128:	c3                   	ret    
80104129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104130 <copy_swap_monitor>:
void copy_swap_monitor(struct proc *np) {
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	53                   	push   %ebx
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; i++) {
80104136:	31 f6                	xor    %esi,%esi
void copy_swap_monitor(struct proc *np) {
80104138:	83 ec 1c             	sub    $0x1c,%esp
8010413b:	8b 7d 08             	mov    0x8(%ebp),%edi
8010413e:	8d 9f 80 01 00 00    	lea    0x180(%edi),%ebx
80104144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pushcli();
80104148:	e8 03 0b 00 00       	call   80104c50 <pushcli>
    c = mycpu();
8010414d:	e8 2e fd ff ff       	call   80103e80 <mycpu>
    p = c->proc;
80104152:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104158:	83 c3 10             	add    $0x10,%ebx
8010415b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    popcli();
8010415e:	e8 ed 0b 00 00       	call   80104d50 <popcli>
        np->swap_monitor[i] = myproc()->swap_monitor[i];
80104163:	8d 46 18             	lea    0x18(%esi),%eax
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; i++) {
80104166:	83 c6 01             	add    $0x1,%esi
        np->swap_monitor[i] = myproc()->swap_monitor[i];
80104169:	c1 e0 04             	shl    $0x4,%eax
8010416c:	03 45 e4             	add    -0x1c(%ebp),%eax
8010416f:	8b 08                	mov    (%eax),%ecx
80104171:	89 4b f0             	mov    %ecx,-0x10(%ebx)
80104174:	8b 48 04             	mov    0x4(%eax),%ecx
80104177:	89 4b f4             	mov    %ecx,-0xc(%ebx)
8010417a:	8b 48 08             	mov    0x8(%eax),%ecx
8010417d:	89 4b f8             	mov    %ecx,-0x8(%ebx)
80104180:	8b 40 0c             	mov    0xc(%eax),%eax
80104183:	89 43 fc             	mov    %eax,-0x4(%ebx)
        np->swap_monitor[i].pgdir = np->pgdir;
80104186:	8b 47 04             	mov    0x4(%edi),%eax
80104189:	89 43 f4             	mov    %eax,-0xc(%ebx)
    for (int i = 0; i < MAX_TOTAL_PAGES - MAX_PYSC_PAGES; i++) {
8010418c:	83 fe 10             	cmp    $0x10,%esi
8010418f:	75 b7                	jne    80104148 <copy_swap_monitor+0x18>
}
80104191:	83 c4 1c             	add    $0x1c,%esp
80104194:	5b                   	pop    %ebx
80104195:	5e                   	pop    %esi
80104196:	5f                   	pop    %edi
80104197:	5d                   	pop    %ebp
80104198:	c3                   	ret    
80104199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041a0 <fork>:
fork(void) {
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	57                   	push   %edi
801041a4:	56                   	push   %esi
801041a5:	53                   	push   %ebx
801041a6:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
801041a9:	e8 a2 0a 00 00       	call   80104c50 <pushcli>
    c = mycpu();
801041ae:	e8 cd fc ff ff       	call   80103e80 <mycpu>
    p = c->proc;
801041b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801041b9:	e8 92 0b 00 00       	call   80104d50 <popcli>
    if ((np = allocproc()) == 0) {
801041be:	e8 2d fb ff ff       	call   80103cf0 <allocproc>
801041c3:	85 c0                	test   %eax,%eax
801041c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801041c8:	0f 84 2c 01 00 00    	je     801042fa <fork+0x15a>
    if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0) {
801041ce:	83 ec 08             	sub    $0x8,%esp
801041d1:	ff 33                	pushl  (%ebx)
801041d3:	ff 73 04             	pushl  0x4(%ebx)
801041d6:	89 c7                	mov    %eax,%edi
801041d8:	e8 23 3a 00 00       	call   80107c00 <copyuvm>
801041dd:	83 c4 10             	add    $0x10,%esp
801041e0:	85 c0                	test   %eax,%eax
801041e2:	89 47 04             	mov    %eax,0x4(%edi)
801041e5:	0f 84 16 01 00 00    	je     80104301 <fork+0x161>
    np->sz = curproc->sz;
801041eb:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801041ee:	8b 03                	mov    (%ebx),%eax
801041f0:	89 01                	mov    %eax,(%ecx)
    pushcli();
801041f2:	e8 59 0a 00 00       	call   80104c50 <pushcli>
    c = mycpu();
801041f7:	e8 84 fc ff ff       	call   80103e80 <mycpu>
    p = c->proc;
801041fc:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104202:	e8 49 0b 00 00       	call   80104d50 <popcli>
    if (myproc()->pid > 2) {
80104207:	83 7e 10 02          	cmpl   $0x2,0x10(%esi)
8010420b:	0f 8f af 00 00 00    	jg     801042c0 <fork+0x120>
    np->parent = curproc;
80104211:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    *np->tf = *curproc->tf;
80104214:	b9 13 00 00 00       	mov    $0x13,%ecx
    np->parent = curproc;
80104219:	89 58 14             	mov    %ebx,0x14(%eax)
    *np->tf = *curproc->tf;
8010421c:	8b 78 18             	mov    0x18(%eax),%edi
8010421f:	8b 73 18             	mov    0x18(%ebx),%esi
80104222:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    for (i = 0; i < NOFILE; i++)
80104224:	31 f6                	xor    %esi,%esi
    np->tf->eax = 0;
80104226:	8b 40 18             	mov    0x18(%eax),%eax
80104229:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
        if (curproc->ofile[i])
80104230:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104234:	85 c0                	test   %eax,%eax
80104236:	74 13                	je     8010424b <fork+0xab>
            np->ofile[i] = filedup(curproc->ofile[i]);
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	50                   	push   %eax
8010423c:	e8 ff cb ff ff       	call   80100e40 <filedup>
80104241:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104244:	83 c4 10             	add    $0x10,%esp
80104247:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
    for (i = 0; i < NOFILE; i++)
8010424b:	83 c6 01             	add    $0x1,%esi
8010424e:	83 fe 10             	cmp    $0x10,%esi
80104251:	75 dd                	jne    80104230 <fork+0x90>
    np->cwd = idup(curproc->cwd);
80104253:	83 ec 0c             	sub    $0xc,%esp
80104256:	ff 73 68             	pushl  0x68(%ebx)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104259:	83 c3 6c             	add    $0x6c,%ebx
    np->cwd = idup(curproc->cwd);
8010425c:	e8 5f d4 ff ff       	call   801016c0 <idup>
80104261:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104264:	83 c4 0c             	add    $0xc,%esp
    np->cwd = idup(curproc->cwd);
80104267:	89 47 68             	mov    %eax,0x68(%edi)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010426a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010426d:	6a 10                	push   $0x10
8010426f:	53                   	push   %ebx
80104270:	50                   	push   %eax
80104271:	e8 7a 0d 00 00       	call   80104ff0 <safestrcpy>
    np->page_fault_counter = 0;
80104276:	c7 87 8c 02 00 00 00 	movl   $0x0,0x28c(%edi)
8010427d:	00 00 00 
    np->pages_in_file = 0;
80104280:	c7 87 80 02 00 00 00 	movl   $0x0,0x280(%edi)
80104287:	00 00 00 
    pid = np->pid;
8010428a:	8b 5f 10             	mov    0x10(%edi),%ebx
    acquire(&ptable.lock);
8010428d:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80104294:	e8 f7 09 00 00       	call   80104c90 <acquire>
    np->state = RUNNABLE;
80104299:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
    release(&ptable.lock);
801042a0:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
801042a7:	e8 04 0b 00 00       	call   80104db0 <release>
    return pid;
801042ac:	83 c4 10             	add    $0x10,%esp
}
801042af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042b2:	89 d8                	mov    %ebx,%eax
801042b4:	5b                   	pop    %ebx
801042b5:	5e                   	pop    %esi
801042b6:	5f                   	pop    %edi
801042b7:	5d                   	pop    %ebp
801042b8:	c3                   	ret    
801042b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (copyParentSwapFile(np) < 0) panic("fork: error copying swap file from parent!");
801042c0:	83 ec 0c             	sub    $0xc,%esp
801042c3:	ff 75 e4             	pushl  -0x1c(%ebp)
801042c6:	e8 55 e0 ff ff       	call   80102320 <copyParentSwapFile>
801042cb:	83 c4 10             	add    $0x10,%esp
801042ce:	85 c0                	test   %eax,%eax
801042d0:	78 55                	js     80104327 <fork+0x187>
        np->last_in_queue = curproc->last_in_queue;
801042d2:	8b 83 84 02 00 00    	mov    0x284(%ebx),%eax
801042d8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        copy_swap_monitor(np);
801042db:	83 ec 0c             	sub    $0xc,%esp
        np->last_in_queue = curproc->last_in_queue;
801042de:	89 87 84 02 00 00    	mov    %eax,0x284(%edi)
        copy_swap_monitor(np);
801042e4:	57                   	push   %edi
801042e5:	e8 46 fe ff ff       	call   80104130 <copy_swap_monitor>
        copy_ram_monitor(np);
801042ea:	89 3c 24             	mov    %edi,(%esp)
801042ed:	e8 ce fd ff ff       	call   801040c0 <copy_ram_monitor>
801042f2:	83 c4 10             	add    $0x10,%esp
801042f5:	e9 17 ff ff ff       	jmp    80104211 <fork+0x71>
        return -1;
801042fa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801042ff:	eb ae                	jmp    801042af <fork+0x10f>
        kfree(np->kstack);
80104301:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104304:	83 ec 0c             	sub    $0xc,%esp
        return -1;
80104307:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kfree(np->kstack);
8010430c:	ff 77 08             	pushl  0x8(%edi)
8010430f:	e8 6c e6 ff ff       	call   80102980 <kfree>
        np->kstack = 0;
80104314:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
        np->state = UNUSED;
8010431b:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
        return -1;
80104322:	83 c4 10             	add    $0x10,%esp
80104325:	eb 88                	jmp    801042af <fork+0x10f>
        if (copyParentSwapFile(np) < 0) panic("fork: error copying swap file from parent!");
80104327:	83 ec 0c             	sub    $0xc,%esp
8010432a:	68 a8 87 10 80       	push   $0x801087a8
8010432f:	e8 5c c0 ff ff       	call   80100390 <panic>
80104334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010433a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104340 <scheduler>:
scheduler(void) {
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	83 ec 0c             	sub    $0xc,%esp
    struct cpu *c = mycpu();
80104349:	e8 32 fb ff ff       	call   80103e80 <mycpu>
8010434e:	8d 78 04             	lea    0x4(%eax),%edi
80104351:	89 c6                	mov    %eax,%esi
    c->proc = 0;
80104353:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010435a:	00 00 00 
8010435d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104360:	fb                   	sti    
        acquire(&ptable.lock);
80104361:	83 ec 0c             	sub    $0xc,%esp
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104364:	bb 54 4d 11 80       	mov    $0x80114d54,%ebx
        acquire(&ptable.lock);
80104369:	68 20 4d 11 80       	push   $0x80114d20
8010436e:	e8 1d 09 00 00       	call   80104c90 <acquire>
80104373:	83 c4 10             	add    $0x10,%esp
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if (p->state != RUNNABLE)
80104380:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104384:	75 33                	jne    801043b9 <scheduler+0x79>
            switchuvm(p);
80104386:	83 ec 0c             	sub    $0xc,%esp
            c->proc = p;
80104389:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
            switchuvm(p);
8010438f:	53                   	push   %ebx
80104390:	e8 db 2f 00 00       	call   80107370 <switchuvm>
            swtch(&(c->scheduler), p->context);
80104395:	58                   	pop    %eax
80104396:	5a                   	pop    %edx
80104397:	ff 73 1c             	pushl  0x1c(%ebx)
8010439a:	57                   	push   %edi
            p->state = RUNNING;
8010439b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
            swtch(&(c->scheduler), p->context);
801043a2:	e8 a4 0c 00 00       	call   8010504b <swtch>
            switchkvm();
801043a7:	e8 a4 2f 00 00       	call   80107350 <switchkvm>
            c->proc = 0;
801043ac:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801043b3:	00 00 00 
801043b6:	83 c4 10             	add    $0x10,%esp
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801043b9:	81 c3 90 02 00 00    	add    $0x290,%ebx
801043bf:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
801043c5:	72 b9                	jb     80104380 <scheduler+0x40>
        release(&ptable.lock);
801043c7:	83 ec 0c             	sub    $0xc,%esp
801043ca:	68 20 4d 11 80       	push   $0x80114d20
801043cf:	e8 dc 09 00 00       	call   80104db0 <release>
        sti();
801043d4:	83 c4 10             	add    $0x10,%esp
801043d7:	eb 87                	jmp    80104360 <scheduler+0x20>
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043e0 <sched>:
sched(void) {
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
    pushcli();
801043e5:	e8 66 08 00 00       	call   80104c50 <pushcli>
    c = mycpu();
801043ea:	e8 91 fa ff ff       	call   80103e80 <mycpu>
    p = c->proc;
801043ef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801043f5:	e8 56 09 00 00       	call   80104d50 <popcli>
    if (!holding(&ptable.lock))
801043fa:	83 ec 0c             	sub    $0xc,%esp
801043fd:	68 20 4d 11 80       	push   $0x80114d20
80104402:	e8 09 08 00 00       	call   80104c10 <holding>
80104407:	83 c4 10             	add    $0x10,%esp
8010440a:	85 c0                	test   %eax,%eax
8010440c:	74 4f                	je     8010445d <sched+0x7d>
    if (mycpu()->ncli != 1)
8010440e:	e8 6d fa ff ff       	call   80103e80 <mycpu>
80104413:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010441a:	75 68                	jne    80104484 <sched+0xa4>
    if (p->state == RUNNING)
8010441c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104420:	74 55                	je     80104477 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104422:	9c                   	pushf  
80104423:	58                   	pop    %eax
    if (readeflags() & FL_IF)
80104424:	f6 c4 02             	test   $0x2,%ah
80104427:	75 41                	jne    8010446a <sched+0x8a>
    intena = mycpu()->intena;
80104429:	e8 52 fa ff ff       	call   80103e80 <mycpu>
    swtch(&p->context, mycpu()->scheduler);
8010442e:	83 c3 1c             	add    $0x1c,%ebx
    intena = mycpu()->intena;
80104431:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&p->context, mycpu()->scheduler);
80104437:	e8 44 fa ff ff       	call   80103e80 <mycpu>
8010443c:	83 ec 08             	sub    $0x8,%esp
8010443f:	ff 70 04             	pushl  0x4(%eax)
80104442:	53                   	push   %ebx
80104443:	e8 03 0c 00 00       	call   8010504b <swtch>
    mycpu()->intena = intena;
80104448:	e8 33 fa ff ff       	call   80103e80 <mycpu>
}
8010444d:	83 c4 10             	add    $0x10,%esp
    mycpu()->intena = intena;
80104450:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104456:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104459:	5b                   	pop    %ebx
8010445a:	5e                   	pop    %esi
8010445b:	5d                   	pop    %ebp
8010445c:	c3                   	ret    
        panic("sched ptable.lock");
8010445d:	83 ec 0c             	sub    $0xc,%esp
80104460:	68 d0 86 10 80       	push   $0x801086d0
80104465:	e8 26 bf ff ff       	call   80100390 <panic>
        panic("sched interruptible");
8010446a:	83 ec 0c             	sub    $0xc,%esp
8010446d:	68 fc 86 10 80       	push   $0x801086fc
80104472:	e8 19 bf ff ff       	call   80100390 <panic>
        panic("sched running");
80104477:	83 ec 0c             	sub    $0xc,%esp
8010447a:	68 ee 86 10 80       	push   $0x801086ee
8010447f:	e8 0c bf ff ff       	call   80100390 <panic>
        panic("sched locks");
80104484:	83 ec 0c             	sub    $0xc,%esp
80104487:	68 e2 86 10 80       	push   $0x801086e2
8010448c:	e8 ff be ff ff       	call   80100390 <panic>
80104491:	eb 0d                	jmp    801044a0 <exit>
80104493:	90                   	nop
80104494:	90                   	nop
80104495:	90                   	nop
80104496:	90                   	nop
80104497:	90                   	nop
80104498:	90                   	nop
80104499:	90                   	nop
8010449a:	90                   	nop
8010449b:	90                   	nop
8010449c:	90                   	nop
8010449d:	90                   	nop
8010449e:	90                   	nop
8010449f:	90                   	nop

801044a0 <exit>:
exit(void) {
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	57                   	push   %edi
801044a4:	56                   	push   %esi
801044a5:	53                   	push   %ebx
801044a6:	83 ec 0c             	sub    $0xc,%esp
    pushcli();
801044a9:	e8 a2 07 00 00       	call   80104c50 <pushcli>
    c = mycpu();
801044ae:	e8 cd f9 ff ff       	call   80103e80 <mycpu>
    p = c->proc;
801044b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801044b9:	e8 92 08 00 00       	call   80104d50 <popcli>
    if (curproc == initproc)
801044be:	39 1d b8 b5 10 80    	cmp    %ebx,0x8010b5b8
801044c4:	8d 73 28             	lea    0x28(%ebx),%esi
801044c7:	8d 7b 68             	lea    0x68(%ebx),%edi
801044ca:	0f 84 22 01 00 00    	je     801045f2 <exit+0x152>
        if (curproc->ofile[fd]) {
801044d0:	8b 06                	mov    (%esi),%eax
801044d2:	85 c0                	test   %eax,%eax
801044d4:	74 12                	je     801044e8 <exit+0x48>
            fileclose(curproc->ofile[fd]);
801044d6:	83 ec 0c             	sub    $0xc,%esp
801044d9:	50                   	push   %eax
801044da:	e8 b1 c9 ff ff       	call   80100e90 <fileclose>
            curproc->ofile[fd] = 0;
801044df:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801044e5:	83 c4 10             	add    $0x10,%esp
801044e8:	83 c6 04             	add    $0x4,%esi
    for (fd = 0; fd < NOFILE; fd++) {
801044eb:	39 fe                	cmp    %edi,%esi
801044ed:	75 e1                	jne    801044d0 <exit+0x30>
    if(curproc->pid >2){
801044ef:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
801044f3:	0f 8f d8 00 00 00    	jg     801045d1 <exit+0x131>
    begin_op();
801044f9:	e8 92 ed ff ff       	call   80103290 <begin_op>
    iput(curproc->cwd);
801044fe:	83 ec 0c             	sub    $0xc,%esp
80104501:	ff 73 68             	pushl  0x68(%ebx)
80104504:	e8 17 d3 ff ff       	call   80101820 <iput>
    end_op();
80104509:	e8 f2 ed ff ff       	call   80103300 <end_op>
    curproc->cwd = 0;
8010450e:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
    acquire(&ptable.lock);
80104515:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
8010451c:	e8 6f 07 00 00       	call   80104c90 <acquire>
    wakeup1(curproc->parent);
80104521:	8b 53 14             	mov    0x14(%ebx),%edx
80104524:	83 c4 10             	add    $0x10,%esp
// The ptable lock must be held.
static void
wakeup1(void *chan) {
    struct proc *p;

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104527:	b8 54 4d 11 80       	mov    $0x80114d54,%eax
8010452c:	eb 0e                	jmp    8010453c <exit+0x9c>
8010452e:	66 90                	xchg   %ax,%ax
80104530:	05 90 02 00 00       	add    $0x290,%eax
80104535:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
8010453a:	73 1e                	jae    8010455a <exit+0xba>
        if (p->state == SLEEPING && p->chan == chan)
8010453c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104540:	75 ee                	jne    80104530 <exit+0x90>
80104542:	3b 50 20             	cmp    0x20(%eax),%edx
80104545:	75 e9                	jne    80104530 <exit+0x90>
            p->state = RUNNABLE;
80104547:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010454e:	05 90 02 00 00       	add    $0x290,%eax
80104553:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
80104558:	72 e2                	jb     8010453c <exit+0x9c>
            p->parent = initproc;
8010455a:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104560:	ba 54 4d 11 80       	mov    $0x80114d54,%edx
80104565:	eb 17                	jmp    8010457e <exit+0xde>
80104567:	89 f6                	mov    %esi,%esi
80104569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104570:	81 c2 90 02 00 00    	add    $0x290,%edx
80104576:	81 fa 54 f1 11 80    	cmp    $0x8011f154,%edx
8010457c:	73 3a                	jae    801045b8 <exit+0x118>
        if (p->parent == curproc) {
8010457e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104581:	75 ed                	jne    80104570 <exit+0xd0>
            if (p->state == ZOMBIE)
80104583:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
            p->parent = initproc;
80104587:	89 4a 14             	mov    %ecx,0x14(%edx)
            if (p->state == ZOMBIE)
8010458a:	75 e4                	jne    80104570 <exit+0xd0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010458c:	b8 54 4d 11 80       	mov    $0x80114d54,%eax
80104591:	eb 11                	jmp    801045a4 <exit+0x104>
80104593:	90                   	nop
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104598:	05 90 02 00 00       	add    $0x290,%eax
8010459d:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
801045a2:	73 cc                	jae    80104570 <exit+0xd0>
        if (p->state == SLEEPING && p->chan == chan)
801045a4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045a8:	75 ee                	jne    80104598 <exit+0xf8>
801045aa:	3b 48 20             	cmp    0x20(%eax),%ecx
801045ad:	75 e9                	jne    80104598 <exit+0xf8>
            p->state = RUNNABLE;
801045af:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801045b6:	eb e0                	jmp    80104598 <exit+0xf8>
    curproc->state = ZOMBIE;
801045b8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
    sched();
801045bf:	e8 1c fe ff ff       	call   801043e0 <sched>
    panic("zombie exit");
801045c4:	83 ec 0c             	sub    $0xc,%esp
801045c7:	68 1d 87 10 80       	push   $0x8010871d
801045cc:	e8 bf bd ff ff       	call   80100390 <panic>
        if (removeSwapFile(curproc)!=0)
801045d1:	83 ec 0c             	sub    $0xc,%esp
801045d4:	53                   	push   %ebx
801045d5:	e8 46 da ff ff       	call   80102020 <removeSwapFile>
801045da:	83 c4 10             	add    $0x10,%esp
801045dd:	85 c0                	test   %eax,%eax
801045df:	0f 84 14 ff ff ff    	je     801044f9 <exit+0x59>
            panic("exit ERROR: swap file wasn't deleted.");
801045e5:	83 ec 0c             	sub    $0xc,%esp
801045e8:	68 d4 87 10 80       	push   $0x801087d4
801045ed:	e8 9e bd ff ff       	call   80100390 <panic>
        panic("init exiting");
801045f2:	83 ec 0c             	sub    $0xc,%esp
801045f5:	68 10 87 10 80       	push   $0x80108710
801045fa:	e8 91 bd ff ff       	call   80100390 <panic>
801045ff:	90                   	nop

80104600 <yield>:
yield(void) {
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
80104604:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104607:	68 20 4d 11 80       	push   $0x80114d20
8010460c:	e8 7f 06 00 00       	call   80104c90 <acquire>
    pushcli();
80104611:	e8 3a 06 00 00       	call   80104c50 <pushcli>
    c = mycpu();
80104616:	e8 65 f8 ff ff       	call   80103e80 <mycpu>
    p = c->proc;
8010461b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104621:	e8 2a 07 00 00       	call   80104d50 <popcli>
    myproc()->state = RUNNABLE;
80104626:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    sched();
8010462d:	e8 ae fd ff ff       	call   801043e0 <sched>
    release(&ptable.lock);
80104632:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
80104639:	e8 72 07 00 00       	call   80104db0 <release>
}
8010463e:	83 c4 10             	add    $0x10,%esp
80104641:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104644:	c9                   	leave  
80104645:	c3                   	ret    
80104646:	8d 76 00             	lea    0x0(%esi),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <sleep>:
sleep(void *chan, struct spinlock *lk) {
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	53                   	push   %ebx
80104656:	83 ec 0c             	sub    $0xc,%esp
80104659:	8b 7d 08             	mov    0x8(%ebp),%edi
8010465c:	8b 75 0c             	mov    0xc(%ebp),%esi
    pushcli();
8010465f:	e8 ec 05 00 00       	call   80104c50 <pushcli>
    c = mycpu();
80104664:	e8 17 f8 ff ff       	call   80103e80 <mycpu>
    p = c->proc;
80104669:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
8010466f:	e8 dc 06 00 00       	call   80104d50 <popcli>
    if (p == 0)
80104674:	85 db                	test   %ebx,%ebx
80104676:	0f 84 87 00 00 00    	je     80104703 <sleep+0xb3>
    if (lk == 0)
8010467c:	85 f6                	test   %esi,%esi
8010467e:	74 76                	je     801046f6 <sleep+0xa6>
    if (lk != &ptable.lock) {  //DOC: sleeplock0
80104680:	81 fe 20 4d 11 80    	cmp    $0x80114d20,%esi
80104686:	74 50                	je     801046d8 <sleep+0x88>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104688:	83 ec 0c             	sub    $0xc,%esp
8010468b:	68 20 4d 11 80       	push   $0x80114d20
80104690:	e8 fb 05 00 00       	call   80104c90 <acquire>
        release(lk);
80104695:	89 34 24             	mov    %esi,(%esp)
80104698:	e8 13 07 00 00       	call   80104db0 <release>
    p->chan = chan;
8010469d:	89 7b 20             	mov    %edi,0x20(%ebx)
    p->state = SLEEPING;
801046a0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    sched();
801046a7:	e8 34 fd ff ff       	call   801043e0 <sched>
    p->chan = 0;
801046ac:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
        release(&ptable.lock);
801046b3:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
801046ba:	e8 f1 06 00 00       	call   80104db0 <release>
        acquire(lk);
801046bf:	89 75 08             	mov    %esi,0x8(%ebp)
801046c2:	83 c4 10             	add    $0x10,%esp
}
801046c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046c8:	5b                   	pop    %ebx
801046c9:	5e                   	pop    %esi
801046ca:	5f                   	pop    %edi
801046cb:	5d                   	pop    %ebp
        acquire(lk);
801046cc:	e9 bf 05 00 00       	jmp    80104c90 <acquire>
801046d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->chan = chan;
801046d8:	89 7b 20             	mov    %edi,0x20(%ebx)
    p->state = SLEEPING;
801046db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    sched();
801046e2:	e8 f9 fc ff ff       	call   801043e0 <sched>
    p->chan = 0;
801046e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801046ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046f1:	5b                   	pop    %ebx
801046f2:	5e                   	pop    %esi
801046f3:	5f                   	pop    %edi
801046f4:	5d                   	pop    %ebp
801046f5:	c3                   	ret    
        panic("sleep without lk");
801046f6:	83 ec 0c             	sub    $0xc,%esp
801046f9:	68 2f 87 10 80       	push   $0x8010872f
801046fe:	e8 8d bc ff ff       	call   80100390 <panic>
        panic("sleep");
80104703:	83 ec 0c             	sub    $0xc,%esp
80104706:	68 29 87 10 80       	push   $0x80108729
8010470b:	e8 80 bc ff ff       	call   80100390 <panic>

80104710 <wait>:
wait(void) {
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
    pushcli();
80104715:	e8 36 05 00 00       	call   80104c50 <pushcli>
    c = mycpu();
8010471a:	e8 61 f7 ff ff       	call   80103e80 <mycpu>
    p = c->proc;
8010471f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104725:	e8 26 06 00 00       	call   80104d50 <popcli>
    acquire(&ptable.lock);
8010472a:	83 ec 0c             	sub    $0xc,%esp
8010472d:	68 20 4d 11 80       	push   $0x80114d20
80104732:	e8 59 05 00 00       	call   80104c90 <acquire>
80104737:	83 c4 10             	add    $0x10,%esp
        havekids = 0;
8010473a:	31 c0                	xor    %eax,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010473c:	bb 54 4d 11 80       	mov    $0x80114d54,%ebx
80104741:	eb 13                	jmp    80104756 <wait+0x46>
80104743:	90                   	nop
80104744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104748:	81 c3 90 02 00 00    	add    $0x290,%ebx
8010474e:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80104754:	73 1e                	jae    80104774 <wait+0x64>
            if (p->parent != curproc)
80104756:	39 73 14             	cmp    %esi,0x14(%ebx)
80104759:	75 ed                	jne    80104748 <wait+0x38>
            if (p->state == ZOMBIE) {
8010475b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010475f:	74 3f                	je     801047a0 <wait+0x90>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104761:	81 c3 90 02 00 00    	add    $0x290,%ebx
            havekids = 1;
80104767:	b8 01 00 00 00       	mov    $0x1,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010476c:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80104772:	72 e2                	jb     80104756 <wait+0x46>
        if (!havekids || curproc->killed) {
80104774:	85 c0                	test   %eax,%eax
80104776:	0f 84 aa 00 00 00    	je     80104826 <wait+0x116>
8010477c:	8b 46 24             	mov    0x24(%esi),%eax
8010477f:	85 c0                	test   %eax,%eax
80104781:	0f 85 9f 00 00 00    	jne    80104826 <wait+0x116>
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104787:	83 ec 08             	sub    $0x8,%esp
8010478a:	68 20 4d 11 80       	push   $0x80114d20
8010478f:	56                   	push   %esi
80104790:	e8 bb fe ff ff       	call   80104650 <sleep>
        havekids = 0;
80104795:	83 c4 10             	add    $0x10,%esp
80104798:	eb a0                	jmp    8010473a <wait+0x2a>
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                kfree(p->kstack);
801047a0:	83 ec 0c             	sub    $0xc,%esp
                pid = p->pid;
801047a3:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
801047a6:	ff 73 08             	pushl  0x8(%ebx)
801047a9:	e8 d2 e1 ff ff       	call   80102980 <kfree>
                p->kstack = 0;
801047ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
801047b5:	5a                   	pop    %edx
801047b6:	ff 73 04             	pushl  0x4(%ebx)
801047b9:	e8 f2 32 00 00       	call   80107ab0 <freevm>
801047be:	8d 93 80 01 00 00    	lea    0x180(%ebx),%edx
801047c4:	8d 8b 80 02 00 00    	lea    0x280(%ebx),%ecx
                p->pid = 0;
801047ca:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
801047d1:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
801047d8:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
801047dc:	83 c4 10             	add    $0x10,%esp
                p->killed = 0;
801047df:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
801047e6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801047ed:	89 d0                	mov    %edx,%eax
801047ef:	90                   	nop
                    p->swap_monitor[i].used = 0;
801047f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801047f6:	83 c0 10             	add    $0x10,%eax
                for (int i =0 ; i <MAX_TOTAL_PAGES-MAX_PYSC_PAGES; ++i) {
801047f9:	39 c1                	cmp    %eax,%ecx
801047fb:	75 f3                	jne    801047f0 <wait+0xe0>
801047fd:	83 eb 80             	sub    $0xffffff80,%ebx
                    p->ram_monitor[i].used = 0;
80104800:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104806:	83 c3 10             	add    $0x10,%ebx
                for (int i = 0; i <MAX_PYSC_PAGES; ++i) {
80104809:	39 da                	cmp    %ebx,%edx
8010480b:	75 f3                	jne    80104800 <wait+0xf0>
                release(&ptable.lock);
8010480d:	83 ec 0c             	sub    $0xc,%esp
80104810:	68 20 4d 11 80       	push   $0x80114d20
80104815:	e8 96 05 00 00       	call   80104db0 <release>
                return pid;
8010481a:	83 c4 10             	add    $0x10,%esp
}
8010481d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104820:	89 f0                	mov    %esi,%eax
80104822:	5b                   	pop    %ebx
80104823:	5e                   	pop    %esi
80104824:	5d                   	pop    %ebp
80104825:	c3                   	ret    
            release(&ptable.lock);
80104826:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104829:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
8010482e:	68 20 4d 11 80       	push   $0x80114d20
80104833:	e8 78 05 00 00       	call   80104db0 <release>
            return -1;
80104838:	83 c4 10             	add    $0x10,%esp
8010483b:	eb e0                	jmp    8010481d <wait+0x10d>
8010483d:	8d 76 00             	lea    0x0(%esi),%esi

80104840 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan) {
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 10             	sub    $0x10,%esp
80104847:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
8010484a:	68 20 4d 11 80       	push   $0x80114d20
8010484f:	e8 3c 04 00 00       	call   80104c90 <acquire>
80104854:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104857:	b8 54 4d 11 80       	mov    $0x80114d54,%eax
8010485c:	eb 0e                	jmp    8010486c <wakeup+0x2c>
8010485e:	66 90                	xchg   %ax,%ax
80104860:	05 90 02 00 00       	add    $0x290,%eax
80104865:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
8010486a:	73 1e                	jae    8010488a <wakeup+0x4a>
        if (p->state == SLEEPING && p->chan == chan)
8010486c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104870:	75 ee                	jne    80104860 <wakeup+0x20>
80104872:	3b 58 20             	cmp    0x20(%eax),%ebx
80104875:	75 e9                	jne    80104860 <wakeup+0x20>
            p->state = RUNNABLE;
80104877:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010487e:	05 90 02 00 00       	add    $0x290,%eax
80104883:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
80104888:	72 e2                	jb     8010486c <wakeup+0x2c>
    wakeup1(chan);
    release(&ptable.lock);
8010488a:	c7 45 08 20 4d 11 80 	movl   $0x80114d20,0x8(%ebp)
}
80104891:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104894:	c9                   	leave  
    release(&ptable.lock);
80104895:	e9 16 05 00 00       	jmp    80104db0 <release>
8010489a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048a0 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid) {
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	53                   	push   %ebx
801048a4:	83 ec 10             	sub    $0x10,%esp
801048a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;

    acquire(&ptable.lock);
801048aa:	68 20 4d 11 80       	push   $0x80114d20
801048af:	e8 dc 03 00 00       	call   80104c90 <acquire>
801048b4:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048b7:	b8 54 4d 11 80       	mov    $0x80114d54,%eax
801048bc:	eb 0e                	jmp    801048cc <kill+0x2c>
801048be:	66 90                	xchg   %ax,%ax
801048c0:	05 90 02 00 00       	add    $0x290,%eax
801048c5:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
801048ca:	73 34                	jae    80104900 <kill+0x60>
        if (p->pid == pid) {
801048cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801048cf:	75 ef                	jne    801048c0 <kill+0x20>
            p->killed = 1;
            // Wake process from sleep if necessary.
            if (p->state == SLEEPING)
801048d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
            p->killed = 1;
801048d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            if (p->state == SLEEPING)
801048dc:	75 07                	jne    801048e5 <kill+0x45>
                p->state = RUNNABLE;
801048de:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
            release(&ptable.lock);
801048e5:	83 ec 0c             	sub    $0xc,%esp
801048e8:	68 20 4d 11 80       	push   $0x80114d20
801048ed:	e8 be 04 00 00       	call   80104db0 <release>
            return 0;
801048f2:	83 c4 10             	add    $0x10,%esp
801048f5:	31 c0                	xor    %eax,%eax
        }
    }
    release(&ptable.lock);
    return -1;
}
801048f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048fa:	c9                   	leave  
801048fb:	c3                   	ret    
801048fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104900:	83 ec 0c             	sub    $0xc,%esp
80104903:	68 20 4d 11 80       	push   $0x80114d20
80104908:	e8 a3 04 00 00       	call   80104db0 <release>
    return -1;
8010490d:	83 c4 10             	add    $0x10,%esp
80104910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104915:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104918:	c9                   	leave  
80104919:	c3                   	ret    
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104920 <used_swap_pages>:

int used_swap_pages(struct proc *p){
80104920:	55                   	push   %ebp
    int amount_to_return =0;
80104921:	31 c0                	xor    %eax,%eax
int used_swap_pages(struct proc *p){
80104923:	89 e5                	mov    %esp,%ebp
80104925:	53                   	push   %ebx
80104926:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104929:	8d 93 80 01 00 00    	lea    0x180(%ebx),%edx
8010492f:	81 c3 80 02 00 00    	add    $0x280,%ebx
80104935:	8d 76 00             	lea    0x0(%esi),%esi
    for(int i=0; i<MAX_TOTAL_PAGES-MAX_PYSC_PAGES; i++){
        if(p->swap_monitor[i].used == 1)
            amount_to_return++;
80104938:	31 c9                	xor    %ecx,%ecx
8010493a:	83 3a 01             	cmpl   $0x1,(%edx)
8010493d:	0f 94 c1             	sete   %cl
80104940:	83 c2 10             	add    $0x10,%edx
80104943:	01 c8                	add    %ecx,%eax
    for(int i=0; i<MAX_TOTAL_PAGES-MAX_PYSC_PAGES; i++){
80104945:	39 da                	cmp    %ebx,%edx
80104947:	75 ef                	jne    80104938 <used_swap_pages+0x18>
    }
    return amount_to_return;
}
80104949:	5b                   	pop    %ebx
8010494a:	5d                   	pop    %ebp
8010494b:	c3                   	ret    
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104950 <procdump>:
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) {
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	57                   	push   %edi
80104954:	56                   	push   %esi
80104955:	53                   	push   %ebx
    char *state;
    uint pc[10];
    int total_available_pages;
    int swap_pages;

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104956:	be 54 4d 11 80       	mov    $0x80114d54,%esi
procdump(void) {
8010495b:	83 ec 3c             	sub    $0x3c,%esp
8010495e:	66 90                	xchg   %ax,%ax
        if (p->state == UNUSED)
80104960:	8b 46 0c             	mov    0xc(%esi),%eax
80104963:	85 c0                	test   %eax,%eax
80104965:	0f 84 b5 00 00 00    	je     80104a20 <procdump+0xd0>
            continue;
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010496b:	83 f8 05             	cmp    $0x5,%eax
            state = states[p->state];
        else
            state = "???";
8010496e:	ba 40 87 10 80       	mov    $0x80108740,%edx
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104973:	77 11                	ja     80104986 <procdump+0x36>
80104975:	8b 14 85 50 88 10 80 	mov    -0x7fef77b0(,%eax,4),%edx
            state = "???";
8010497c:	b8 40 87 10 80       	mov    $0x80108740,%eax
80104981:	85 d2                	test   %edx,%edx
80104983:	0f 44 d0             	cmove  %eax,%edx
        cprintf("%d %s\n", p->pid, state);
80104986:	83 ec 04             	sub    $0x4,%esp
80104989:	8d be 80 02 00 00    	lea    0x280(%esi),%edi
8010498f:	52                   	push   %edx
80104990:	ff 76 10             	pushl  0x10(%esi)
80104993:	68 44 87 10 80       	push   $0x80108744
80104998:	e8 c3 bc ff ff       	call   80100660 <cprintf>
        total_available_pages = PGROUNDUP(p->sz)/PGSIZE;
8010499d:	8b 06                	mov    (%esi),%eax
8010499f:	83 c4 10             	add    $0x10,%esp
    int amount_to_return =0;
801049a2:	31 d2                	xor    %edx,%edx
        total_available_pages = PGROUNDUP(p->sz)/PGSIZE;
801049a4:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801049aa:	8d 86 80 01 00 00    	lea    0x180(%esi),%eax
801049b0:	c1 eb 0c             	shr    $0xc,%ebx
801049b3:	90                   	nop
801049b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            amount_to_return++;
801049b8:	31 c9                	xor    %ecx,%ecx
801049ba:	83 38 01             	cmpl   $0x1,(%eax)
801049bd:	0f 94 c1             	sete   %cl
801049c0:	83 c0 10             	add    $0x10,%eax
801049c3:	01 ca                	add    %ecx,%edx
    for(int i=0; i<MAX_TOTAL_PAGES-MAX_PYSC_PAGES; i++){
801049c5:	39 f8                	cmp    %edi,%eax
801049c7:	75 ef                	jne    801049b8 <procdump+0x68>
        swap_pages = used_swap_pages(p);
        p->protected = 0;
        cprintf("\ntotal_pages:%d swap_pages:%d protected:%d page_fault:%d pages_in_file:%d name:%s\n",total_available_pages, swap_pages, p->protected,p->page_fault_counter, p->pages_in_file,  p->name);
801049c9:	8d 46 6c             	lea    0x6c(%esi),%eax
801049cc:	83 ec 04             	sub    $0x4,%esp
        p->protected = 0;
801049cf:	c7 86 88 02 00 00 00 	movl   $0x0,0x288(%esi)
801049d6:	00 00 00 
        cprintf("\ntotal_pages:%d swap_pages:%d protected:%d page_fault:%d pages_in_file:%d name:%s\n",total_available_pages, swap_pages, p->protected,p->page_fault_counter, p->pages_in_file,  p->name);
801049d9:	50                   	push   %eax
801049da:	ff b6 80 02 00 00    	pushl  0x280(%esi)
801049e0:	ff b6 8c 02 00 00    	pushl  0x28c(%esi)
801049e6:	6a 00                	push   $0x0
801049e8:	52                   	push   %edx
801049e9:	53                   	push   %ebx
801049ea:	68 fc 87 10 80       	push   $0x801087fc
801049ef:	e8 6c bc ff ff       	call   80100660 <cprintf>
        if (p->state == SLEEPING) {
801049f4:	83 c4 20             	add    $0x20,%esp
801049f7:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
801049fb:	74 3d                	je     80104a3a <procdump+0xea>
            getcallerpcs((uint *) p->context->ebp + 2, pc);
            for (i = 0; i < 10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("%d /%d \n", free_pages_in_system() , total_available_pages);
801049fd:	e8 9e e1 ff ff       	call   80102ba0 <free_pages_in_system>
80104a02:	83 ec 04             	sub    $0x4,%esp
80104a05:	53                   	push   %ebx
80104a06:	50                   	push   %eax
80104a07:	68 4b 87 10 80       	push   $0x8010874b
80104a0c:	e8 4f bc ff ff       	call   80100660 <cprintf>
        cprintf("\n");
80104a11:	c7 04 24 52 87 10 80 	movl   $0x80108752,(%esp)
80104a18:	e8 43 bc ff ff       	call   80100660 <cprintf>
80104a1d:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104a20:	81 c6 90 02 00 00    	add    $0x290,%esi
80104a26:	81 fe 54 f1 11 80    	cmp    $0x8011f154,%esi
80104a2c:	0f 82 2e ff ff ff    	jb     80104960 <procdump+0x10>
    }
}
80104a32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a35:	5b                   	pop    %ebx
80104a36:	5e                   	pop    %esi
80104a37:	5f                   	pop    %edi
80104a38:	5d                   	pop    %ebp
80104a39:	c3                   	ret    
            getcallerpcs((uint *) p->context->ebp + 2, pc);
80104a3a:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104a3d:	83 ec 08             	sub    $0x8,%esp
80104a40:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104a43:	50                   	push   %eax
80104a44:	8b 46 1c             	mov    0x1c(%esi),%eax
80104a47:	8b 40 0c             	mov    0xc(%eax),%eax
80104a4a:	83 c0 08             	add    $0x8,%eax
80104a4d:	50                   	push   %eax
80104a4e:	e8 6d 01 00 00       	call   80104bc0 <getcallerpcs>
80104a53:	83 c4 10             	add    $0x10,%esp
80104a56:	8d 76 00             	lea    0x0(%esi),%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for (i = 0; i < 10 && pc[i] != 0; i++)
80104a60:	8b 07                	mov    (%edi),%eax
80104a62:	85 c0                	test   %eax,%eax
80104a64:	74 97                	je     801049fd <procdump+0xad>
                cprintf(" %p", pc[i]);
80104a66:	83 ec 08             	sub    $0x8,%esp
80104a69:	83 c7 04             	add    $0x4,%edi
80104a6c:	50                   	push   %eax
80104a6d:	68 21 81 10 80       	push   $0x80108121
80104a72:	e8 e9 bb ff ff       	call   80100660 <cprintf>
            for (i = 0; i < 10 && pc[i] != 0; i++)
80104a77:	8d 45 e8             	lea    -0x18(%ebp),%eax
80104a7a:	83 c4 10             	add    $0x10,%esp
80104a7d:	39 f8                	cmp    %edi,%eax
80104a7f:	75 df                	jne    80104a60 <procdump+0x110>
80104a81:	e9 77 ff ff ff       	jmp    801049fd <procdump+0xad>
80104a86:	66 90                	xchg   %ax,%ax
80104a88:	66 90                	xchg   %ax,%ax
80104a8a:	66 90                	xchg   %ax,%ax
80104a8c:	66 90                	xchg   %ax,%ax
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 0c             	sub    $0xc,%esp
80104a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104a9a:	68 68 88 10 80       	push   $0x80108868
80104a9f:	8d 43 04             	lea    0x4(%ebx),%eax
80104aa2:	50                   	push   %eax
80104aa3:	e8 f8 00 00 00       	call   80104ba0 <initlock>
  lk->name = name;
80104aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104aab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104ab1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104ab4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104abb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ac1:	c9                   	leave  
80104ac2:	c3                   	ret    
80104ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
80104ad5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ad8:	83 ec 0c             	sub    $0xc,%esp
80104adb:	8d 73 04             	lea    0x4(%ebx),%esi
80104ade:	56                   	push   %esi
80104adf:	e8 ac 01 00 00       	call   80104c90 <acquire>
  while (lk->locked) {
80104ae4:	8b 13                	mov    (%ebx),%edx
80104ae6:	83 c4 10             	add    $0x10,%esp
80104ae9:	85 d2                	test   %edx,%edx
80104aeb:	74 16                	je     80104b03 <acquiresleep+0x33>
80104aed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104af0:	83 ec 08             	sub    $0x8,%esp
80104af3:	56                   	push   %esi
80104af4:	53                   	push   %ebx
80104af5:	e8 56 fb ff ff       	call   80104650 <sleep>
  while (lk->locked) {
80104afa:	8b 03                	mov    (%ebx),%eax
80104afc:	83 c4 10             	add    $0x10,%esp
80104aff:	85 c0                	test   %eax,%eax
80104b01:	75 ed                	jne    80104af0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104b03:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104b09:	e8 12 f4 ff ff       	call   80103f20 <myproc>
80104b0e:	8b 40 10             	mov    0x10(%eax),%eax
80104b11:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104b14:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104b17:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b1a:	5b                   	pop    %ebx
80104b1b:	5e                   	pop    %esi
80104b1c:	5d                   	pop    %ebp
  release(&lk->lk);
80104b1d:	e9 8e 02 00 00       	jmp    80104db0 <release>
80104b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
80104b35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	8d 73 04             	lea    0x4(%ebx),%esi
80104b3e:	56                   	push   %esi
80104b3f:	e8 4c 01 00 00       	call   80104c90 <acquire>
  lk->locked = 0;
80104b44:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104b4a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104b51:	89 1c 24             	mov    %ebx,(%esp)
80104b54:	e8 e7 fc ff ff       	call   80104840 <wakeup>
  release(&lk->lk);
80104b59:	89 75 08             	mov    %esi,0x8(%ebp)
80104b5c:	83 c4 10             	add    $0x10,%esp
}
80104b5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b62:	5b                   	pop    %ebx
80104b63:	5e                   	pop    %esi
80104b64:	5d                   	pop    %ebp
  release(&lk->lk);
80104b65:	e9 46 02 00 00       	jmp    80104db0 <release>
80104b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b70 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104b78:	83 ec 0c             	sub    $0xc,%esp
80104b7b:	8d 5e 04             	lea    0x4(%esi),%ebx
80104b7e:	53                   	push   %ebx
80104b7f:	e8 0c 01 00 00       	call   80104c90 <acquire>
  r = lk->locked;
80104b84:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104b86:	89 1c 24             	mov    %ebx,(%esp)
80104b89:	e8 22 02 00 00       	call   80104db0 <release>
  return r;
}
80104b8e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b91:	89 f0                	mov    %esi,%eax
80104b93:	5b                   	pop    %ebx
80104b94:	5e                   	pop    %esi
80104b95:	5d                   	pop    %ebp
80104b96:	c3                   	ret    
80104b97:	66 90                	xchg   %ax,%ax
80104b99:	66 90                	xchg   %ax,%ax
80104b9b:	66 90                	xchg   %ax,%ax
80104b9d:	66 90                	xchg   %ax,%ax
80104b9f:	90                   	nop

80104ba0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ba6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104ba9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104baf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104bb2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104bb9:	5d                   	pop    %ebp
80104bba:	c3                   	ret    
80104bbb:	90                   	nop
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104bc0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104bc1:	31 d2                	xor    %edx,%edx
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104bc6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104bc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104bcc:	83 e8 08             	sub    $0x8,%eax
80104bcf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104bd0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104bd6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104bdc:	77 1a                	ja     80104bf8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104bde:	8b 58 04             	mov    0x4(%eax),%ebx
80104be1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104be4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104be7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104be9:	83 fa 0a             	cmp    $0xa,%edx
80104bec:	75 e2                	jne    80104bd0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104bee:	5b                   	pop    %ebx
80104bef:	5d                   	pop    %ebp
80104bf0:	c3                   	ret    
80104bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bf8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bfb:	83 c1 28             	add    $0x28,%ecx
80104bfe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c06:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104c09:	39 c1                	cmp    %eax,%ecx
80104c0b:	75 f3                	jne    80104c00 <getcallerpcs+0x40>
}
80104c0d:	5b                   	pop    %ebx
80104c0e:	5d                   	pop    %ebp
80104c0f:	c3                   	ret    

80104c10 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	53                   	push   %ebx
80104c14:	83 ec 04             	sub    $0x4,%esp
80104c17:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
80104c1a:	8b 02                	mov    (%edx),%eax
80104c1c:	85 c0                	test   %eax,%eax
80104c1e:	75 10                	jne    80104c30 <holding+0x20>
}
80104c20:	83 c4 04             	add    $0x4,%esp
80104c23:	31 c0                	xor    %eax,%eax
80104c25:	5b                   	pop    %ebx
80104c26:	5d                   	pop    %ebp
80104c27:	c3                   	ret    
80104c28:	90                   	nop
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104c30:	8b 5a 08             	mov    0x8(%edx),%ebx
80104c33:	e8 48 f2 ff ff       	call   80103e80 <mycpu>
80104c38:	39 c3                	cmp    %eax,%ebx
80104c3a:	0f 94 c0             	sete   %al
}
80104c3d:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
80104c40:	0f b6 c0             	movzbl %al,%eax
}
80104c43:	5b                   	pop    %ebx
80104c44:	5d                   	pop    %ebp
80104c45:	c3                   	ret    
80104c46:	8d 76 00             	lea    0x0(%esi),%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c50 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	53                   	push   %ebx
80104c54:	83 ec 04             	sub    $0x4,%esp
80104c57:	9c                   	pushf  
80104c58:	5b                   	pop    %ebx
  asm volatile("cli");
80104c59:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104c5a:	e8 21 f2 ff ff       	call   80103e80 <mycpu>
80104c5f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104c65:	85 c0                	test   %eax,%eax
80104c67:	75 11                	jne    80104c7a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104c69:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104c6f:	e8 0c f2 ff ff       	call   80103e80 <mycpu>
80104c74:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104c7a:	e8 01 f2 ff ff       	call   80103e80 <mycpu>
80104c7f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104c86:	83 c4 04             	add    $0x4,%esp
80104c89:	5b                   	pop    %ebx
80104c8a:	5d                   	pop    %ebp
80104c8b:	c3                   	ret    
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c90 <acquire>:
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c95:	e8 b6 ff ff ff       	call   80104c50 <pushcli>
  if(holding(lk))
80104c9a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104c9d:	8b 03                	mov    (%ebx),%eax
80104c9f:	85 c0                	test   %eax,%eax
80104ca1:	0f 85 81 00 00 00    	jne    80104d28 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
80104ca7:	ba 01 00 00 00       	mov    $0x1,%edx
80104cac:	eb 05                	jmp    80104cb3 <acquire+0x23>
80104cae:	66 90                	xchg   %ax,%ax
80104cb0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cb3:	89 d0                	mov    %edx,%eax
80104cb5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104cb8:	85 c0                	test   %eax,%eax
80104cba:	75 f4                	jne    80104cb0 <acquire+0x20>
  __sync_synchronize();
80104cbc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104cc1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cc4:	e8 b7 f1 ff ff       	call   80103e80 <mycpu>
  for(i = 0; i < 10; i++){
80104cc9:	31 d2                	xor    %edx,%edx
  getcallerpcs(&lk, lk->pcs);
80104ccb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  lk->cpu = mycpu();
80104cce:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104cd1:	89 e8                	mov    %ebp,%eax
80104cd3:	90                   	nop
80104cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cd8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104cde:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104ce4:	77 1a                	ja     80104d00 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
80104ce6:	8b 58 04             	mov    0x4(%eax),%ebx
80104ce9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104cec:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104cef:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104cf1:	83 fa 0a             	cmp    $0xa,%edx
80104cf4:	75 e2                	jne    80104cd8 <acquire+0x48>
}
80104cf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cf9:	5b                   	pop    %ebx
80104cfa:	5e                   	pop    %esi
80104cfb:	5d                   	pop    %ebp
80104cfc:	c3                   	ret    
80104cfd:	8d 76 00             	lea    0x0(%esi),%esi
80104d00:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104d03:	83 c1 28             	add    $0x28,%ecx
80104d06:	8d 76 00             	lea    0x0(%esi),%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104d10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d16:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104d19:	39 c8                	cmp    %ecx,%eax
80104d1b:	75 f3                	jne    80104d10 <acquire+0x80>
}
80104d1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d20:	5b                   	pop    %ebx
80104d21:	5e                   	pop    %esi
80104d22:	5d                   	pop    %ebp
80104d23:	c3                   	ret    
80104d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104d28:	8b 73 08             	mov    0x8(%ebx),%esi
80104d2b:	e8 50 f1 ff ff       	call   80103e80 <mycpu>
80104d30:	39 c6                	cmp    %eax,%esi
80104d32:	0f 85 6f ff ff ff    	jne    80104ca7 <acquire+0x17>
    panic("acquire");
80104d38:	83 ec 0c             	sub    $0xc,%esp
80104d3b:	68 73 88 10 80       	push   $0x80108873
80104d40:	e8 4b b6 ff ff       	call   80100390 <panic>
80104d45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <popcli>:

void
popcli(void)
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104d56:	9c                   	pushf  
80104d57:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104d58:	f6 c4 02             	test   $0x2,%ah
80104d5b:	75 35                	jne    80104d92 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104d5d:	e8 1e f1 ff ff       	call   80103e80 <mycpu>
80104d62:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104d69:	78 34                	js     80104d9f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104d6b:	e8 10 f1 ff ff       	call   80103e80 <mycpu>
80104d70:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104d76:	85 d2                	test   %edx,%edx
80104d78:	74 06                	je     80104d80 <popcli+0x30>
    sti();
}
80104d7a:	c9                   	leave  
80104d7b:	c3                   	ret    
80104d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104d80:	e8 fb f0 ff ff       	call   80103e80 <mycpu>
80104d85:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104d8b:	85 c0                	test   %eax,%eax
80104d8d:	74 eb                	je     80104d7a <popcli+0x2a>
  asm volatile("sti");
80104d8f:	fb                   	sti    
}
80104d90:	c9                   	leave  
80104d91:	c3                   	ret    
    panic("popcli - interruptible");
80104d92:	83 ec 0c             	sub    $0xc,%esp
80104d95:	68 7b 88 10 80       	push   $0x8010887b
80104d9a:	e8 f1 b5 ff ff       	call   80100390 <panic>
    panic("popcli");
80104d9f:	83 ec 0c             	sub    $0xc,%esp
80104da2:	68 92 88 10 80       	push   $0x80108892
80104da7:	e8 e4 b5 ff ff       	call   80100390 <panic>
80104dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104db0 <release>:
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
80104db5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104db8:	8b 03                	mov    (%ebx),%eax
80104dba:	85 c0                	test   %eax,%eax
80104dbc:	74 0c                	je     80104dca <release+0x1a>
80104dbe:	8b 73 08             	mov    0x8(%ebx),%esi
80104dc1:	e8 ba f0 ff ff       	call   80103e80 <mycpu>
80104dc6:	39 c6                	cmp    %eax,%esi
80104dc8:	74 16                	je     80104de0 <release+0x30>
    panic("release");
80104dca:	83 ec 0c             	sub    $0xc,%esp
80104dcd:	68 99 88 10 80       	push   $0x80108899
80104dd2:	e8 b9 b5 ff ff       	call   80100390 <panic>
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lk->pcs[0] = 0;
80104de0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104de7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104dee:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104df3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104df9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dfc:	5b                   	pop    %ebx
80104dfd:	5e                   	pop    %esi
80104dfe:	5d                   	pop    %ebp
  popcli();
80104dff:	e9 4c ff ff ff       	jmp    80104d50 <popcli>
80104e04:	66 90                	xchg   %ax,%ax
80104e06:	66 90                	xchg   %ax,%ax
80104e08:	66 90                	xchg   %ax,%ax
80104e0a:	66 90                	xchg   %ax,%ax
80104e0c:	66 90                	xchg   %ax,%ax
80104e0e:	66 90                	xchg   %ax,%ax

80104e10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
80104e14:	53                   	push   %ebx
80104e15:	8b 55 08             	mov    0x8(%ebp),%edx
80104e18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104e1b:	f6 c2 03             	test   $0x3,%dl
80104e1e:	75 05                	jne    80104e25 <memset+0x15>
80104e20:	f6 c1 03             	test   $0x3,%cl
80104e23:	74 13                	je     80104e38 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104e25:	89 d7                	mov    %edx,%edi
80104e27:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e2a:	fc                   	cld    
80104e2b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104e2d:	5b                   	pop    %ebx
80104e2e:	89 d0                	mov    %edx,%eax
80104e30:	5f                   	pop    %edi
80104e31:	5d                   	pop    %ebp
80104e32:	c3                   	ret    
80104e33:	90                   	nop
80104e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104e38:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104e3c:	c1 e9 02             	shr    $0x2,%ecx
80104e3f:	89 f8                	mov    %edi,%eax
80104e41:	89 fb                	mov    %edi,%ebx
80104e43:	c1 e0 18             	shl    $0x18,%eax
80104e46:	c1 e3 10             	shl    $0x10,%ebx
80104e49:	09 d8                	or     %ebx,%eax
80104e4b:	09 f8                	or     %edi,%eax
80104e4d:	c1 e7 08             	shl    $0x8,%edi
80104e50:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104e52:	89 d7                	mov    %edx,%edi
80104e54:	fc                   	cld    
80104e55:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104e57:	5b                   	pop    %ebx
80104e58:	89 d0                	mov    %edx,%eax
80104e5a:	5f                   	pop    %edi
80104e5b:	5d                   	pop    %ebp
80104e5c:	c3                   	ret    
80104e5d:	8d 76 00             	lea    0x0(%esi),%esi

80104e60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	53                   	push   %ebx
80104e66:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104e69:	8b 75 08             	mov    0x8(%ebp),%esi
80104e6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e6f:	85 db                	test   %ebx,%ebx
80104e71:	74 29                	je     80104e9c <memcmp+0x3c>
    if(*s1 != *s2)
80104e73:	0f b6 16             	movzbl (%esi),%edx
80104e76:	0f b6 0f             	movzbl (%edi),%ecx
80104e79:	38 d1                	cmp    %dl,%cl
80104e7b:	75 2b                	jne    80104ea8 <memcmp+0x48>
80104e7d:	b8 01 00 00 00       	mov    $0x1,%eax
80104e82:	eb 14                	jmp    80104e98 <memcmp+0x38>
80104e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e88:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104e8c:	83 c0 01             	add    $0x1,%eax
80104e8f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104e94:	38 ca                	cmp    %cl,%dl
80104e96:	75 10                	jne    80104ea8 <memcmp+0x48>
  while(n-- > 0){
80104e98:	39 d8                	cmp    %ebx,%eax
80104e9a:	75 ec                	jne    80104e88 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104e9c:	5b                   	pop    %ebx
  return 0;
80104e9d:	31 c0                	xor    %eax,%eax
}
80104e9f:	5e                   	pop    %esi
80104ea0:	5f                   	pop    %edi
80104ea1:	5d                   	pop    %ebp
80104ea2:	c3                   	ret    
80104ea3:	90                   	nop
80104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104ea8:	0f b6 c2             	movzbl %dl,%eax
}
80104eab:	5b                   	pop    %ebx
      return *s1 - *s2;
80104eac:	29 c8                	sub    %ecx,%eax
}
80104eae:	5e                   	pop    %esi
80104eaf:	5f                   	pop    %edi
80104eb0:	5d                   	pop    %ebp
80104eb1:	c3                   	ret    
80104eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	56                   	push   %esi
80104ec4:	53                   	push   %ebx
80104ec5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ec8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104ecb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ece:	39 c3                	cmp    %eax,%ebx
80104ed0:	73 26                	jae    80104ef8 <memmove+0x38>
80104ed2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104ed5:	39 c8                	cmp    %ecx,%eax
80104ed7:	73 1f                	jae    80104ef8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ed9:	85 f6                	test   %esi,%esi
80104edb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104ede:	74 0f                	je     80104eef <memmove+0x2f>
      *--d = *--s;
80104ee0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ee4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104ee7:	83 ea 01             	sub    $0x1,%edx
80104eea:	83 fa ff             	cmp    $0xffffffff,%edx
80104eed:	75 f1                	jne    80104ee0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104eef:	5b                   	pop    %ebx
80104ef0:	5e                   	pop    %esi
80104ef1:	5d                   	pop    %ebp
80104ef2:	c3                   	ret    
80104ef3:	90                   	nop
80104ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104ef8:	31 d2                	xor    %edx,%edx
80104efa:	85 f6                	test   %esi,%esi
80104efc:	74 f1                	je     80104eef <memmove+0x2f>
80104efe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104f00:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104f04:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104f07:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104f0a:	39 d6                	cmp    %edx,%esi
80104f0c:	75 f2                	jne    80104f00 <memmove+0x40>
}
80104f0e:	5b                   	pop    %ebx
80104f0f:	5e                   	pop    %esi
80104f10:	5d                   	pop    %ebp
80104f11:	c3                   	ret    
80104f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104f23:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104f24:	eb 9a                	jmp    80104ec0 <memmove>
80104f26:	8d 76 00             	lea    0x0(%esi),%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	56                   	push   %esi
80104f35:	8b 7d 10             	mov    0x10(%ebp),%edi
80104f38:	53                   	push   %ebx
80104f39:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104f3f:	85 ff                	test   %edi,%edi
80104f41:	74 2f                	je     80104f72 <strncmp+0x42>
80104f43:	0f b6 01             	movzbl (%ecx),%eax
80104f46:	0f b6 1e             	movzbl (%esi),%ebx
80104f49:	84 c0                	test   %al,%al
80104f4b:	74 37                	je     80104f84 <strncmp+0x54>
80104f4d:	38 c3                	cmp    %al,%bl
80104f4f:	75 33                	jne    80104f84 <strncmp+0x54>
80104f51:	01 f7                	add    %esi,%edi
80104f53:	eb 13                	jmp    80104f68 <strncmp+0x38>
80104f55:	8d 76 00             	lea    0x0(%esi),%esi
80104f58:	0f b6 01             	movzbl (%ecx),%eax
80104f5b:	84 c0                	test   %al,%al
80104f5d:	74 21                	je     80104f80 <strncmp+0x50>
80104f5f:	0f b6 1a             	movzbl (%edx),%ebx
80104f62:	89 d6                	mov    %edx,%esi
80104f64:	38 d8                	cmp    %bl,%al
80104f66:	75 1c                	jne    80104f84 <strncmp+0x54>
    n--, p++, q++;
80104f68:	8d 56 01             	lea    0x1(%esi),%edx
80104f6b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104f6e:	39 fa                	cmp    %edi,%edx
80104f70:	75 e6                	jne    80104f58 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104f72:	5b                   	pop    %ebx
    return 0;
80104f73:	31 c0                	xor    %eax,%eax
}
80104f75:	5e                   	pop    %esi
80104f76:	5f                   	pop    %edi
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret    
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f80:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104f84:	29 d8                	sub    %ebx,%eax
}
80104f86:	5b                   	pop    %ebx
80104f87:	5e                   	pop    %esi
80104f88:	5f                   	pop    %edi
80104f89:	5d                   	pop    %ebp
80104f8a:	c3                   	ret    
80104f8b:	90                   	nop
80104f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	56                   	push   %esi
80104f94:	53                   	push   %ebx
80104f95:	8b 45 08             	mov    0x8(%ebp),%eax
80104f98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104f9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f9e:	89 c2                	mov    %eax,%edx
80104fa0:	eb 19                	jmp    80104fbb <strncpy+0x2b>
80104fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fa8:	83 c3 01             	add    $0x1,%ebx
80104fab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104faf:	83 c2 01             	add    $0x1,%edx
80104fb2:	84 c9                	test   %cl,%cl
80104fb4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104fb7:	74 09                	je     80104fc2 <strncpy+0x32>
80104fb9:	89 f1                	mov    %esi,%ecx
80104fbb:	85 c9                	test   %ecx,%ecx
80104fbd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104fc0:	7f e6                	jg     80104fa8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104fc2:	31 c9                	xor    %ecx,%ecx
80104fc4:	85 f6                	test   %esi,%esi
80104fc6:	7e 17                	jle    80104fdf <strncpy+0x4f>
80104fc8:	90                   	nop
80104fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104fd0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104fd4:	89 f3                	mov    %esi,%ebx
80104fd6:	83 c1 01             	add    $0x1,%ecx
80104fd9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104fdb:	85 db                	test   %ebx,%ebx
80104fdd:	7f f1                	jg     80104fd0 <strncpy+0x40>
  return os;
}
80104fdf:	5b                   	pop    %ebx
80104fe0:	5e                   	pop    %esi
80104fe1:	5d                   	pop    %ebp
80104fe2:	c3                   	ret    
80104fe3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ff0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	53                   	push   %ebx
80104ff5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80104ffb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104ffe:	85 c9                	test   %ecx,%ecx
80105000:	7e 26                	jle    80105028 <safestrcpy+0x38>
80105002:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105006:	89 c1                	mov    %eax,%ecx
80105008:	eb 17                	jmp    80105021 <safestrcpy+0x31>
8010500a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105010:	83 c2 01             	add    $0x1,%edx
80105013:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105017:	83 c1 01             	add    $0x1,%ecx
8010501a:	84 db                	test   %bl,%bl
8010501c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010501f:	74 04                	je     80105025 <safestrcpy+0x35>
80105021:	39 f2                	cmp    %esi,%edx
80105023:	75 eb                	jne    80105010 <safestrcpy+0x20>
    ;
  *s = 0;
80105025:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105028:	5b                   	pop    %ebx
80105029:	5e                   	pop    %esi
8010502a:	5d                   	pop    %ebp
8010502b:	c3                   	ret    
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <strlen>:

int
strlen(const char *s)
{
80105030:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105031:	31 c0                	xor    %eax,%eax
{
80105033:	89 e5                	mov    %esp,%ebp
80105035:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105038:	80 3a 00             	cmpb   $0x0,(%edx)
8010503b:	74 0c                	je     80105049 <strlen+0x19>
8010503d:	8d 76 00             	lea    0x0(%esi),%esi
80105040:	83 c0 01             	add    $0x1,%eax
80105043:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105047:	75 f7                	jne    80105040 <strlen+0x10>
    ;
  return n;
}
80105049:	5d                   	pop    %ebp
8010504a:	c3                   	ret    

8010504b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010504b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010504f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105053:	55                   	push   %ebp
  pushl %ebx
80105054:	53                   	push   %ebx
  pushl %esi
80105055:	56                   	push   %esi
  pushl %edi
80105056:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105057:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105059:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010505b:	5f                   	pop    %edi
  popl %esi
8010505c:	5e                   	pop    %esi
  popl %ebx
8010505d:	5b                   	pop    %ebx
  popl %ebp
8010505e:	5d                   	pop    %ebp
  ret
8010505f:	c3                   	ret    

80105060 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip) {
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	53                   	push   %ebx
80105064:	83 ec 04             	sub    $0x4,%esp
80105067:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *curproc = myproc();
8010506a:	e8 b1 ee ff ff       	call   80103f20 <myproc>

    if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010506f:	8b 00                	mov    (%eax),%eax
80105071:	39 d8                	cmp    %ebx,%eax
80105073:	76 1b                	jbe    80105090 <fetchint+0x30>
80105075:	8d 53 04             	lea    0x4(%ebx),%edx
80105078:	39 d0                	cmp    %edx,%eax
8010507a:	72 14                	jb     80105090 <fetchint+0x30>
        return -1;
    *ip = *(int *) (addr);
8010507c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010507f:	8b 13                	mov    (%ebx),%edx
80105081:	89 10                	mov    %edx,(%eax)
    return 0;
80105083:	31 c0                	xor    %eax,%eax
}
80105085:	83 c4 04             	add    $0x4,%esp
80105088:	5b                   	pop    %ebx
80105089:	5d                   	pop    %ebp
8010508a:	c3                   	ret    
8010508b:	90                   	nop
8010508c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105095:	eb ee                	jmp    80105085 <fetchint+0x25>
80105097:	89 f6                	mov    %esi,%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050a0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp) {
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	53                   	push   %ebx
801050a4:	83 ec 04             	sub    $0x4,%esp
801050a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char *s, *ep;
    struct proc *curproc = myproc();
801050aa:	e8 71 ee ff ff       	call   80103f20 <myproc>

    if (addr >= curproc->sz)
801050af:	39 18                	cmp    %ebx,(%eax)
801050b1:	76 29                	jbe    801050dc <fetchstr+0x3c>
        return -1;
    *pp = (char *) addr;
801050b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801050b6:	89 da                	mov    %ebx,%edx
801050b8:	89 19                	mov    %ebx,(%ecx)
    ep = (char *) curproc->sz;
801050ba:	8b 00                	mov    (%eax),%eax
    for (s = *pp; s < ep; s++) {
801050bc:	39 c3                	cmp    %eax,%ebx
801050be:	73 1c                	jae    801050dc <fetchstr+0x3c>
        if (*s == 0)
801050c0:	80 3b 00             	cmpb   $0x0,(%ebx)
801050c3:	75 10                	jne    801050d5 <fetchstr+0x35>
801050c5:	eb 39                	jmp    80105100 <fetchstr+0x60>
801050c7:	89 f6                	mov    %esi,%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801050d0:	80 3a 00             	cmpb   $0x0,(%edx)
801050d3:	74 1b                	je     801050f0 <fetchstr+0x50>
    for (s = *pp; s < ep; s++) {
801050d5:	83 c2 01             	add    $0x1,%edx
801050d8:	39 d0                	cmp    %edx,%eax
801050da:	77 f4                	ja     801050d0 <fetchstr+0x30>
        return -1;
801050dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
            return s - *pp;
    }
    return -1;
}
801050e1:	83 c4 04             	add    $0x4,%esp
801050e4:	5b                   	pop    %ebx
801050e5:	5d                   	pop    %ebp
801050e6:	c3                   	ret    
801050e7:	89 f6                	mov    %esi,%esi
801050e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801050f0:	83 c4 04             	add    $0x4,%esp
801050f3:	89 d0                	mov    %edx,%eax
801050f5:	29 d8                	sub    %ebx,%eax
801050f7:	5b                   	pop    %ebx
801050f8:	5d                   	pop    %ebp
801050f9:	c3                   	ret    
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (*s == 0)
80105100:	31 c0                	xor    %eax,%eax
            return s - *pp;
80105102:	eb dd                	jmp    801050e1 <fetchstr+0x41>
80105104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010510a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105110 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip) {
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105115:	e8 06 ee ff ff       	call   80103f20 <myproc>
8010511a:	8b 40 18             	mov    0x18(%eax),%eax
8010511d:	8b 55 08             	mov    0x8(%ebp),%edx
80105120:	8b 40 44             	mov    0x44(%eax),%eax
80105123:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    struct proc *curproc = myproc();
80105126:	e8 f5 ed ff ff       	call   80103f20 <myproc>
    if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010512b:	8b 00                	mov    (%eax),%eax
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
8010512d:	8d 73 04             	lea    0x4(%ebx),%esi
    if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105130:	39 c6                	cmp    %eax,%esi
80105132:	73 1c                	jae    80105150 <argint+0x40>
80105134:	8d 53 08             	lea    0x8(%ebx),%edx
80105137:	39 d0                	cmp    %edx,%eax
80105139:	72 15                	jb     80105150 <argint+0x40>
    *ip = *(int *) (addr);
8010513b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010513e:	8b 53 04             	mov    0x4(%ebx),%edx
80105141:	89 10                	mov    %edx,(%eax)
    return 0;
80105143:	31 c0                	xor    %eax,%eax
}
80105145:	5b                   	pop    %ebx
80105146:	5e                   	pop    %esi
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80105150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80105155:	eb ee                	jmp    80105145 <argint+0x35>
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size) {
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	56                   	push   %esi
80105164:	53                   	push   %ebx
80105165:	83 ec 10             	sub    $0x10,%esp
80105168:	8b 5d 10             	mov    0x10(%ebp),%ebx
    int i;
    struct proc *curproc = myproc();
8010516b:	e8 b0 ed ff ff       	call   80103f20 <myproc>
80105170:	89 c6                	mov    %eax,%esi

    if (argint(n, &i) < 0)
80105172:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105175:	83 ec 08             	sub    $0x8,%esp
80105178:	50                   	push   %eax
80105179:	ff 75 08             	pushl  0x8(%ebp)
8010517c:	e8 8f ff ff ff       	call   80105110 <argint>
        return -1;
    if (size < 0 || (uint) i >= curproc->sz || (uint) i + size > curproc->sz)
80105181:	83 c4 10             	add    $0x10,%esp
80105184:	85 c0                	test   %eax,%eax
80105186:	78 28                	js     801051b0 <argptr+0x50>
80105188:	85 db                	test   %ebx,%ebx
8010518a:	78 24                	js     801051b0 <argptr+0x50>
8010518c:	8b 16                	mov    (%esi),%edx
8010518e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105191:	39 c2                	cmp    %eax,%edx
80105193:	76 1b                	jbe    801051b0 <argptr+0x50>
80105195:	01 c3                	add    %eax,%ebx
80105197:	39 da                	cmp    %ebx,%edx
80105199:	72 15                	jb     801051b0 <argptr+0x50>
        return -1;
    *pp = (char *) i;
8010519b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010519e:	89 02                	mov    %eax,(%edx)
    return 0;
801051a0:	31 c0                	xor    %eax,%eax
}
801051a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051a5:	5b                   	pop    %ebx
801051a6:	5e                   	pop    %esi
801051a7:	5d                   	pop    %ebp
801051a8:	c3                   	ret    
801051a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801051b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051b5:	eb eb                	jmp    801051a2 <argptr+0x42>
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051c0 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp) {
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	83 ec 20             	sub    $0x20,%esp
    int addr;
    if (argint(n, &addr) < 0)
801051c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051c9:	50                   	push   %eax
801051ca:	ff 75 08             	pushl  0x8(%ebp)
801051cd:	e8 3e ff ff ff       	call   80105110 <argint>
801051d2:	83 c4 10             	add    $0x10,%esp
801051d5:	85 c0                	test   %eax,%eax
801051d7:	78 17                	js     801051f0 <argstr+0x30>
        return -1;
    return fetchstr(addr, pp);
801051d9:	83 ec 08             	sub    $0x8,%esp
801051dc:	ff 75 0c             	pushl  0xc(%ebp)
801051df:	ff 75 f4             	pushl  -0xc(%ebp)
801051e2:	e8 b9 fe ff ff       	call   801050a0 <fetchstr>
801051e7:	83 c4 10             	add    $0x10,%esp
}
801051ea:	c9                   	leave  
801051eb:	c3                   	ret    
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801051f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051f5:	c9                   	leave  
801051f6:	c3                   	ret    
801051f7:	89 f6                	mov    %esi,%esi
801051f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105200 <syscall>:
        [SYS_update_protected_pages] sys_update_protected_pages,

};

void
syscall(void) {
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	53                   	push   %ebx
80105204:	83 ec 04             	sub    $0x4,%esp
    int num;
    struct proc *curproc = myproc();
80105207:	e8 14 ed ff ff       	call   80103f20 <myproc>
8010520c:	89 c3                	mov    %eax,%ebx

    num = curproc->tf->eax;
8010520e:	8b 40 18             	mov    0x18(%eax),%eax
80105211:	8b 40 1c             	mov    0x1c(%eax),%eax
    if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105214:	8d 50 ff             	lea    -0x1(%eax),%edx
80105217:	83 fa 18             	cmp    $0x18,%edx
8010521a:	77 1c                	ja     80105238 <syscall+0x38>
8010521c:	8b 14 85 c0 88 10 80 	mov    -0x7fef7740(,%eax,4),%edx
80105223:	85 d2                	test   %edx,%edx
80105225:	74 11                	je     80105238 <syscall+0x38>
        curproc->tf->eax = syscalls[num]();
80105227:	ff d2                	call   *%edx
80105229:	8b 53 18             	mov    0x18(%ebx),%edx
8010522c:	89 42 1c             	mov    %eax,0x1c(%edx)
    } else {
        cprintf("%d %s: unknown sys call %d\n",
                curproc->pid, curproc->name, num);
        curproc->tf->eax = -1;
    }
}
8010522f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105232:	c9                   	leave  
80105233:	c3                   	ret    
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%d %s: unknown sys call %d\n",
80105238:	50                   	push   %eax
                curproc->pid, curproc->name, num);
80105239:	8d 43 6c             	lea    0x6c(%ebx),%eax
        cprintf("%d %s: unknown sys call %d\n",
8010523c:	50                   	push   %eax
8010523d:	ff 73 10             	pushl  0x10(%ebx)
80105240:	68 a1 88 10 80       	push   $0x801088a1
80105245:	e8 16 b4 ff ff       	call   80100660 <cprintf>
        curproc->tf->eax = -1;
8010524a:	8b 43 18             	mov    0x18(%ebx),%eax
8010524d:	83 c4 10             	add    $0x10,%esp
80105250:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105257:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010525a:	c9                   	leave  
8010525b:	c3                   	ret    
8010525c:	66 90                	xchg   %ax,%ax
8010525e:	66 90                	xchg   %ax,%ax

80105260 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	56                   	push   %esi
80105264:	53                   	push   %ebx
80105265:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105267:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010526a:	89 d6                	mov    %edx,%esi
8010526c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010526f:	50                   	push   %eax
80105270:	6a 00                	push   $0x0
80105272:	e8 99 fe ff ff       	call   80105110 <argint>
80105277:	83 c4 10             	add    $0x10,%esp
8010527a:	85 c0                	test   %eax,%eax
8010527c:	78 2a                	js     801052a8 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010527e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105282:	77 24                	ja     801052a8 <argfd.constprop.0+0x48>
80105284:	e8 97 ec ff ff       	call   80103f20 <myproc>
80105289:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010528c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105290:	85 c0                	test   %eax,%eax
80105292:	74 14                	je     801052a8 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80105294:	85 db                	test   %ebx,%ebx
80105296:	74 02                	je     8010529a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105298:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
8010529a:	89 06                	mov    %eax,(%esi)
  return 0;
8010529c:	31 c0                	xor    %eax,%eax
}
8010529e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052a1:	5b                   	pop    %ebx
801052a2:	5e                   	pop    %esi
801052a3:	5d                   	pop    %ebp
801052a4:	c3                   	ret    
801052a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801052a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ad:	eb ef                	jmp    8010529e <argfd.constprop.0+0x3e>
801052af:	90                   	nop

801052b0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801052b0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801052b1:	31 c0                	xor    %eax,%eax
{
801052b3:	89 e5                	mov    %esp,%ebp
801052b5:	56                   	push   %esi
801052b6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801052b7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801052ba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801052bd:	e8 9e ff ff ff       	call   80105260 <argfd.constprop.0>
801052c2:	85 c0                	test   %eax,%eax
801052c4:	78 42                	js     80105308 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
801052c6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801052c9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801052cb:	e8 50 ec ff ff       	call   80103f20 <myproc>
801052d0:	eb 0e                	jmp    801052e0 <sys_dup+0x30>
801052d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801052d8:	83 c3 01             	add    $0x1,%ebx
801052db:	83 fb 10             	cmp    $0x10,%ebx
801052de:	74 28                	je     80105308 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
801052e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052e4:	85 d2                	test   %edx,%edx
801052e6:	75 f0                	jne    801052d8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
801052e8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
801052ec:	83 ec 0c             	sub    $0xc,%esp
801052ef:	ff 75 f4             	pushl  -0xc(%ebp)
801052f2:	e8 49 bb ff ff       	call   80100e40 <filedup>
  return fd;
801052f7:	83 c4 10             	add    $0x10,%esp
}
801052fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052fd:	89 d8                	mov    %ebx,%eax
801052ff:	5b                   	pop    %ebx
80105300:	5e                   	pop    %esi
80105301:	5d                   	pop    %ebp
80105302:	c3                   	ret    
80105303:	90                   	nop
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105308:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010530b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105310:	89 d8                	mov    %ebx,%eax
80105312:	5b                   	pop    %ebx
80105313:	5e                   	pop    %esi
80105314:	5d                   	pop    %ebp
80105315:	c3                   	ret    
80105316:	8d 76 00             	lea    0x0(%esi),%esi
80105319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105320 <sys_read>:

int
sys_read(void)
{
80105320:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105321:	31 c0                	xor    %eax,%eax
{
80105323:	89 e5                	mov    %esp,%ebp
80105325:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105328:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010532b:	e8 30 ff ff ff       	call   80105260 <argfd.constprop.0>
80105330:	85 c0                	test   %eax,%eax
80105332:	78 4c                	js     80105380 <sys_read+0x60>
80105334:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105337:	83 ec 08             	sub    $0x8,%esp
8010533a:	50                   	push   %eax
8010533b:	6a 02                	push   $0x2
8010533d:	e8 ce fd ff ff       	call   80105110 <argint>
80105342:	83 c4 10             	add    $0x10,%esp
80105345:	85 c0                	test   %eax,%eax
80105347:	78 37                	js     80105380 <sys_read+0x60>
80105349:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010534c:	83 ec 04             	sub    $0x4,%esp
8010534f:	ff 75 f0             	pushl  -0x10(%ebp)
80105352:	50                   	push   %eax
80105353:	6a 01                	push   $0x1
80105355:	e8 06 fe ff ff       	call   80105160 <argptr>
8010535a:	83 c4 10             	add    $0x10,%esp
8010535d:	85 c0                	test   %eax,%eax
8010535f:	78 1f                	js     80105380 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105361:	83 ec 04             	sub    $0x4,%esp
80105364:	ff 75 f0             	pushl  -0x10(%ebp)
80105367:	ff 75 f4             	pushl  -0xc(%ebp)
8010536a:	ff 75 ec             	pushl  -0x14(%ebp)
8010536d:	e8 3e bc ff ff       	call   80100fb0 <fileread>
80105372:	83 c4 10             	add    $0x10,%esp
}
80105375:	c9                   	leave  
80105376:	c3                   	ret    
80105377:	89 f6                	mov    %esi,%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105385:	c9                   	leave  
80105386:	c3                   	ret    
80105387:	89 f6                	mov    %esi,%esi
80105389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105390 <sys_write>:

int
sys_write(void)
{
80105390:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105391:	31 c0                	xor    %eax,%eax
{
80105393:	89 e5                	mov    %esp,%ebp
80105395:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105398:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010539b:	e8 c0 fe ff ff       	call   80105260 <argfd.constprop.0>
801053a0:	85 c0                	test   %eax,%eax
801053a2:	78 4c                	js     801053f0 <sys_write+0x60>
801053a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053a7:	83 ec 08             	sub    $0x8,%esp
801053aa:	50                   	push   %eax
801053ab:	6a 02                	push   $0x2
801053ad:	e8 5e fd ff ff       	call   80105110 <argint>
801053b2:	83 c4 10             	add    $0x10,%esp
801053b5:	85 c0                	test   %eax,%eax
801053b7:	78 37                	js     801053f0 <sys_write+0x60>
801053b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053bc:	83 ec 04             	sub    $0x4,%esp
801053bf:	ff 75 f0             	pushl  -0x10(%ebp)
801053c2:	50                   	push   %eax
801053c3:	6a 01                	push   $0x1
801053c5:	e8 96 fd ff ff       	call   80105160 <argptr>
801053ca:	83 c4 10             	add    $0x10,%esp
801053cd:	85 c0                	test   %eax,%eax
801053cf:	78 1f                	js     801053f0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
801053d1:	83 ec 04             	sub    $0x4,%esp
801053d4:	ff 75 f0             	pushl  -0x10(%ebp)
801053d7:	ff 75 f4             	pushl  -0xc(%ebp)
801053da:	ff 75 ec             	pushl  -0x14(%ebp)
801053dd:	e8 5e bc ff ff       	call   80101040 <filewrite>
801053e2:	83 c4 10             	add    $0x10,%esp
}
801053e5:	c9                   	leave  
801053e6:	c3                   	ret    
801053e7:	89 f6                	mov    %esi,%esi
801053e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f5:	c9                   	leave  
801053f6:	c3                   	ret    
801053f7:	89 f6                	mov    %esi,%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <sys_close>:

int
sys_close(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105406:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105409:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010540c:	e8 4f fe ff ff       	call   80105260 <argfd.constprop.0>
80105411:	85 c0                	test   %eax,%eax
80105413:	78 2b                	js     80105440 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105415:	e8 06 eb ff ff       	call   80103f20 <myproc>
8010541a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010541d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105420:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105427:	00 
  fileclose(f);
80105428:	ff 75 f4             	pushl  -0xc(%ebp)
8010542b:	e8 60 ba ff ff       	call   80100e90 <fileclose>
  return 0;
80105430:	83 c4 10             	add    $0x10,%esp
80105433:	31 c0                	xor    %eax,%eax
}
80105435:	c9                   	leave  
80105436:	c3                   	ret    
80105437:	89 f6                	mov    %esi,%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105445:	c9                   	leave  
80105446:	c3                   	ret    
80105447:	89 f6                	mov    %esi,%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_fstat>:

int
sys_fstat(void)
{
80105450:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105451:	31 c0                	xor    %eax,%eax
{
80105453:	89 e5                	mov    %esp,%ebp
80105455:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105458:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010545b:	e8 00 fe ff ff       	call   80105260 <argfd.constprop.0>
80105460:	85 c0                	test   %eax,%eax
80105462:	78 2c                	js     80105490 <sys_fstat+0x40>
80105464:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105467:	83 ec 04             	sub    $0x4,%esp
8010546a:	6a 14                	push   $0x14
8010546c:	50                   	push   %eax
8010546d:	6a 01                	push   $0x1
8010546f:	e8 ec fc ff ff       	call   80105160 <argptr>
80105474:	83 c4 10             	add    $0x10,%esp
80105477:	85 c0                	test   %eax,%eax
80105479:	78 15                	js     80105490 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010547b:	83 ec 08             	sub    $0x8,%esp
8010547e:	ff 75 f4             	pushl  -0xc(%ebp)
80105481:	ff 75 f0             	pushl  -0x10(%ebp)
80105484:	e8 d7 ba ff ff       	call   80100f60 <filestat>
80105489:	83 c4 10             	add    $0x10,%esp
}
8010548c:	c9                   	leave  
8010548d:	c3                   	ret    
8010548e:	66 90                	xchg   %ax,%ax
    return -1;
80105490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105495:	c9                   	leave  
80105496:	c3                   	ret    
80105497:	89 f6                	mov    %esi,%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054a0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	57                   	push   %edi
801054a4:	56                   	push   %esi
801054a5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801054a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801054a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801054ac:	50                   	push   %eax
801054ad:	6a 00                	push   $0x0
801054af:	e8 0c fd ff ff       	call   801051c0 <argstr>
801054b4:	83 c4 10             	add    $0x10,%esp
801054b7:	85 c0                	test   %eax,%eax
801054b9:	0f 88 fb 00 00 00    	js     801055ba <sys_link+0x11a>
801054bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
801054c2:	83 ec 08             	sub    $0x8,%esp
801054c5:	50                   	push   %eax
801054c6:	6a 01                	push   $0x1
801054c8:	e8 f3 fc ff ff       	call   801051c0 <argstr>
801054cd:	83 c4 10             	add    $0x10,%esp
801054d0:	85 c0                	test   %eax,%eax
801054d2:	0f 88 e2 00 00 00    	js     801055ba <sys_link+0x11a>
    return -1;

  begin_op();
801054d8:	e8 b3 dd ff ff       	call   80103290 <begin_op>
  if((ip = namei(old)) == 0){
801054dd:	83 ec 0c             	sub    $0xc,%esp
801054e0:	ff 75 d4             	pushl  -0x2c(%ebp)
801054e3:	e8 68 ca ff ff       	call   80101f50 <namei>
801054e8:	83 c4 10             	add    $0x10,%esp
801054eb:	85 c0                	test   %eax,%eax
801054ed:	89 c3                	mov    %eax,%ebx
801054ef:	0f 84 ea 00 00 00    	je     801055df <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
801054f5:	83 ec 0c             	sub    $0xc,%esp
801054f8:	50                   	push   %eax
801054f9:	e8 f2 c1 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105506:	0f 84 bb 00 00 00    	je     801055c7 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010550c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105511:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105514:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105517:	53                   	push   %ebx
80105518:	e8 23 c1 ff ff       	call   80101640 <iupdate>
  iunlock(ip);
8010551d:	89 1c 24             	mov    %ebx,(%esp)
80105520:	e8 ab c2 ff ff       	call   801017d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105525:	58                   	pop    %eax
80105526:	5a                   	pop    %edx
80105527:	57                   	push   %edi
80105528:	ff 75 d0             	pushl  -0x30(%ebp)
8010552b:	e8 40 ca ff ff       	call   80101f70 <nameiparent>
80105530:	83 c4 10             	add    $0x10,%esp
80105533:	85 c0                	test   %eax,%eax
80105535:	89 c6                	mov    %eax,%esi
80105537:	74 5b                	je     80105594 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105539:	83 ec 0c             	sub    $0xc,%esp
8010553c:	50                   	push   %eax
8010553d:	e8 ae c1 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105542:	83 c4 10             	add    $0x10,%esp
80105545:	8b 03                	mov    (%ebx),%eax
80105547:	39 06                	cmp    %eax,(%esi)
80105549:	75 3d                	jne    80105588 <sys_link+0xe8>
8010554b:	83 ec 04             	sub    $0x4,%esp
8010554e:	ff 73 04             	pushl  0x4(%ebx)
80105551:	57                   	push   %edi
80105552:	56                   	push   %esi
80105553:	e8 38 c9 ff ff       	call   80101e90 <dirlink>
80105558:	83 c4 10             	add    $0x10,%esp
8010555b:	85 c0                	test   %eax,%eax
8010555d:	78 29                	js     80105588 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010555f:	83 ec 0c             	sub    $0xc,%esp
80105562:	56                   	push   %esi
80105563:	e8 18 c4 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80105568:	89 1c 24             	mov    %ebx,(%esp)
8010556b:	e8 b0 c2 ff ff       	call   80101820 <iput>

  end_op();
80105570:	e8 8b dd ff ff       	call   80103300 <end_op>

  return 0;
80105575:	83 c4 10             	add    $0x10,%esp
80105578:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010557a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010557d:	5b                   	pop    %ebx
8010557e:	5e                   	pop    %esi
8010557f:	5f                   	pop    %edi
80105580:	5d                   	pop    %ebp
80105581:	c3                   	ret    
80105582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105588:	83 ec 0c             	sub    $0xc,%esp
8010558b:	56                   	push   %esi
8010558c:	e8 ef c3 ff ff       	call   80101980 <iunlockput>
    goto bad;
80105591:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105594:	83 ec 0c             	sub    $0xc,%esp
80105597:	53                   	push   %ebx
80105598:	e8 53 c1 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
8010559d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801055a2:	89 1c 24             	mov    %ebx,(%esp)
801055a5:	e8 96 c0 ff ff       	call   80101640 <iupdate>
  iunlockput(ip);
801055aa:	89 1c 24             	mov    %ebx,(%esp)
801055ad:	e8 ce c3 ff ff       	call   80101980 <iunlockput>
  end_op();
801055b2:	e8 49 dd ff ff       	call   80103300 <end_op>
  return -1;
801055b7:	83 c4 10             	add    $0x10,%esp
}
801055ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801055bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c2:	5b                   	pop    %ebx
801055c3:	5e                   	pop    %esi
801055c4:	5f                   	pop    %edi
801055c5:	5d                   	pop    %ebp
801055c6:	c3                   	ret    
    iunlockput(ip);
801055c7:	83 ec 0c             	sub    $0xc,%esp
801055ca:	53                   	push   %ebx
801055cb:	e8 b0 c3 ff ff       	call   80101980 <iunlockput>
    end_op();
801055d0:	e8 2b dd ff ff       	call   80103300 <end_op>
    return -1;
801055d5:	83 c4 10             	add    $0x10,%esp
801055d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055dd:	eb 9b                	jmp    8010557a <sys_link+0xda>
    end_op();
801055df:	e8 1c dd ff ff       	call   80103300 <end_op>
    return -1;
801055e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e9:	eb 8f                	jmp    8010557a <sys_link+0xda>
801055eb:	90                   	nop
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055f0 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
801055f5:	53                   	push   %ebx
801055f6:	83 ec 1c             	sub    $0x1c,%esp
801055f9:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801055fc:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105600:	76 3e                	jbe    80105640 <isdirempty+0x50>
80105602:	bb 20 00 00 00       	mov    $0x20,%ebx
80105607:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010560a:	eb 0c                	jmp    80105618 <isdirempty+0x28>
8010560c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105610:	83 c3 10             	add    $0x10,%ebx
80105613:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105616:	73 28                	jae    80105640 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105618:	6a 10                	push   $0x10
8010561a:	53                   	push   %ebx
8010561b:	57                   	push   %edi
8010561c:	56                   	push   %esi
8010561d:	e8 ae c3 ff ff       	call   801019d0 <readi>
80105622:	83 c4 10             	add    $0x10,%esp
80105625:	83 f8 10             	cmp    $0x10,%eax
80105628:	75 23                	jne    8010564d <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010562a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010562f:	74 df                	je     80105610 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105631:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105634:	31 c0                	xor    %eax,%eax
}
80105636:	5b                   	pop    %ebx
80105637:	5e                   	pop    %esi
80105638:	5f                   	pop    %edi
80105639:	5d                   	pop    %ebp
8010563a:	c3                   	ret    
8010563b:	90                   	nop
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105640:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
80105643:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105648:	5b                   	pop    %ebx
80105649:	5e                   	pop    %esi
8010564a:	5f                   	pop    %edi
8010564b:	5d                   	pop    %ebp
8010564c:	c3                   	ret    
      panic("isdirempty: readi");
8010564d:	83 ec 0c             	sub    $0xc,%esp
80105650:	68 28 89 10 80       	push   $0x80108928
80105655:	e8 36 ad ff ff       	call   80100390 <panic>
8010565a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105660 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
80105665:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105666:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105669:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010566c:	50                   	push   %eax
8010566d:	6a 00                	push   $0x0
8010566f:	e8 4c fb ff ff       	call   801051c0 <argstr>
80105674:	83 c4 10             	add    $0x10,%esp
80105677:	85 c0                	test   %eax,%eax
80105679:	0f 88 51 01 00 00    	js     801057d0 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010567f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105682:	e8 09 dc ff ff       	call   80103290 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105687:	83 ec 08             	sub    $0x8,%esp
8010568a:	53                   	push   %ebx
8010568b:	ff 75 c0             	pushl  -0x40(%ebp)
8010568e:	e8 dd c8 ff ff       	call   80101f70 <nameiparent>
80105693:	83 c4 10             	add    $0x10,%esp
80105696:	85 c0                	test   %eax,%eax
80105698:	89 c6                	mov    %eax,%esi
8010569a:	0f 84 37 01 00 00    	je     801057d7 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	50                   	push   %eax
801056a4:	e8 47 c0 ff ff       	call   801016f0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801056a9:	58                   	pop    %eax
801056aa:	5a                   	pop    %edx
801056ab:	68 66 82 10 80       	push   $0x80108266
801056b0:	53                   	push   %ebx
801056b1:	e8 4a c5 ff ff       	call   80101c00 <namecmp>
801056b6:	83 c4 10             	add    $0x10,%esp
801056b9:	85 c0                	test   %eax,%eax
801056bb:	0f 84 d7 00 00 00    	je     80105798 <sys_unlink+0x138>
801056c1:	83 ec 08             	sub    $0x8,%esp
801056c4:	68 65 82 10 80       	push   $0x80108265
801056c9:	53                   	push   %ebx
801056ca:	e8 31 c5 ff ff       	call   80101c00 <namecmp>
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	85 c0                	test   %eax,%eax
801056d4:	0f 84 be 00 00 00    	je     80105798 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801056da:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056dd:	83 ec 04             	sub    $0x4,%esp
801056e0:	50                   	push   %eax
801056e1:	53                   	push   %ebx
801056e2:	56                   	push   %esi
801056e3:	e8 38 c5 ff ff       	call   80101c20 <dirlookup>
801056e8:	83 c4 10             	add    $0x10,%esp
801056eb:	85 c0                	test   %eax,%eax
801056ed:	89 c3                	mov    %eax,%ebx
801056ef:	0f 84 a3 00 00 00    	je     80105798 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
801056f5:	83 ec 0c             	sub    $0xc,%esp
801056f8:	50                   	push   %eax
801056f9:	e8 f2 bf ff ff       	call   801016f0 <ilock>

  if(ip->nlink < 1)
801056fe:	83 c4 10             	add    $0x10,%esp
80105701:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105706:	0f 8e e4 00 00 00    	jle    801057f0 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010570c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105711:	74 65                	je     80105778 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105713:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105716:	83 ec 04             	sub    $0x4,%esp
80105719:	6a 10                	push   $0x10
8010571b:	6a 00                	push   $0x0
8010571d:	57                   	push   %edi
8010571e:	e8 ed f6 ff ff       	call   80104e10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105723:	6a 10                	push   $0x10
80105725:	ff 75 c4             	pushl  -0x3c(%ebp)
80105728:	57                   	push   %edi
80105729:	56                   	push   %esi
8010572a:	e8 a1 c3 ff ff       	call   80101ad0 <writei>
8010572f:	83 c4 20             	add    $0x20,%esp
80105732:	83 f8 10             	cmp    $0x10,%eax
80105735:	0f 85 a8 00 00 00    	jne    801057e3 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010573b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105740:	74 6e                	je     801057b0 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105742:	83 ec 0c             	sub    $0xc,%esp
80105745:	56                   	push   %esi
80105746:	e8 35 c2 ff ff       	call   80101980 <iunlockput>

  ip->nlink--;
8010574b:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105750:	89 1c 24             	mov    %ebx,(%esp)
80105753:	e8 e8 be ff ff       	call   80101640 <iupdate>
  iunlockput(ip);
80105758:	89 1c 24             	mov    %ebx,(%esp)
8010575b:	e8 20 c2 ff ff       	call   80101980 <iunlockput>

  end_op();
80105760:	e8 9b db ff ff       	call   80103300 <end_op>

  return 0;
80105765:	83 c4 10             	add    $0x10,%esp
80105768:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
8010576a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010576d:	5b                   	pop    %ebx
8010576e:	5e                   	pop    %esi
8010576f:	5f                   	pop    %edi
80105770:	5d                   	pop    %ebp
80105771:	c3                   	ret    
80105772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
80105778:	83 ec 0c             	sub    $0xc,%esp
8010577b:	53                   	push   %ebx
8010577c:	e8 6f fe ff ff       	call   801055f0 <isdirempty>
80105781:	83 c4 10             	add    $0x10,%esp
80105784:	85 c0                	test   %eax,%eax
80105786:	75 8b                	jne    80105713 <sys_unlink+0xb3>
    iunlockput(ip);
80105788:	83 ec 0c             	sub    $0xc,%esp
8010578b:	53                   	push   %ebx
8010578c:	e8 ef c1 ff ff       	call   80101980 <iunlockput>
    goto bad;
80105791:	83 c4 10             	add    $0x10,%esp
80105794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105798:	83 ec 0c             	sub    $0xc,%esp
8010579b:	56                   	push   %esi
8010579c:	e8 df c1 ff ff       	call   80101980 <iunlockput>
  end_op();
801057a1:	e8 5a db ff ff       	call   80103300 <end_op>
  return -1;
801057a6:	83 c4 10             	add    $0x10,%esp
801057a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ae:	eb ba                	jmp    8010576a <sys_unlink+0x10a>
    dp->nlink--;
801057b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801057b5:	83 ec 0c             	sub    $0xc,%esp
801057b8:	56                   	push   %esi
801057b9:	e8 82 be ff ff       	call   80101640 <iupdate>
801057be:	83 c4 10             	add    $0x10,%esp
801057c1:	e9 7c ff ff ff       	jmp    80105742 <sys_unlink+0xe2>
801057c6:	8d 76 00             	lea    0x0(%esi),%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801057d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d5:	eb 93                	jmp    8010576a <sys_unlink+0x10a>
    end_op();
801057d7:	e8 24 db ff ff       	call   80103300 <end_op>
    return -1;
801057dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e1:	eb 87                	jmp    8010576a <sys_unlink+0x10a>
    panic("unlink: writei");
801057e3:	83 ec 0c             	sub    $0xc,%esp
801057e6:	68 7a 82 10 80       	push   $0x8010827a
801057eb:	e8 a0 ab ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801057f0:	83 ec 0c             	sub    $0xc,%esp
801057f3:	68 68 82 10 80       	push   $0x80108268
801057f8:	e8 93 ab ff ff       	call   80100390 <panic>
801057fd:	8d 76 00             	lea    0x0(%esi),%esi

80105800 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
80105805:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105806:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105809:	83 ec 44             	sub    $0x44,%esp
8010580c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010580f:	8b 55 10             	mov    0x10(%ebp),%edx
80105812:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105815:	56                   	push   %esi
80105816:	ff 75 08             	pushl  0x8(%ebp)
{
80105819:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010581c:	89 55 c0             	mov    %edx,-0x40(%ebp)
8010581f:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105822:	e8 49 c7 ff ff       	call   80101f70 <nameiparent>
80105827:	83 c4 10             	add    $0x10,%esp
8010582a:	85 c0                	test   %eax,%eax
8010582c:	0f 84 4e 01 00 00    	je     80105980 <create+0x180>
    return 0;
  ilock(dp);
80105832:	83 ec 0c             	sub    $0xc,%esp
80105835:	89 c3                	mov    %eax,%ebx
80105837:	50                   	push   %eax
80105838:	e8 b3 be ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
8010583d:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105840:	83 c4 0c             	add    $0xc,%esp
80105843:	50                   	push   %eax
80105844:	56                   	push   %esi
80105845:	53                   	push   %ebx
80105846:	e8 d5 c3 ff ff       	call   80101c20 <dirlookup>
8010584b:	83 c4 10             	add    $0x10,%esp
8010584e:	85 c0                	test   %eax,%eax
80105850:	89 c7                	mov    %eax,%edi
80105852:	74 3c                	je     80105890 <create+0x90>
    iunlockput(dp);
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	53                   	push   %ebx
80105858:	e8 23 c1 ff ff       	call   80101980 <iunlockput>
    ilock(ip);
8010585d:	89 3c 24             	mov    %edi,(%esp)
80105860:	e8 8b be ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105865:	83 c4 10             	add    $0x10,%esp
80105868:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
8010586d:	0f 85 9d 00 00 00    	jne    80105910 <create+0x110>
80105873:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105878:	0f 85 92 00 00 00    	jne    80105910 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010587e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105881:	89 f8                	mov    %edi,%eax
80105883:	5b                   	pop    %ebx
80105884:	5e                   	pop    %esi
80105885:	5f                   	pop    %edi
80105886:	5d                   	pop    %ebp
80105887:	c3                   	ret    
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80105890:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	50                   	push   %eax
80105898:	ff 33                	pushl  (%ebx)
8010589a:	e8 e1 bc ff ff       	call   80101580 <ialloc>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	85 c0                	test   %eax,%eax
801058a4:	89 c7                	mov    %eax,%edi
801058a6:	0f 84 e8 00 00 00    	je     80105994 <create+0x194>
  ilock(ip);
801058ac:	83 ec 0c             	sub    $0xc,%esp
801058af:	50                   	push   %eax
801058b0:	e8 3b be ff ff       	call   801016f0 <ilock>
  ip->major = major;
801058b5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801058b9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801058bd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801058c1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801058c5:	b8 01 00 00 00       	mov    $0x1,%eax
801058ca:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
801058ce:	89 3c 24             	mov    %edi,(%esp)
801058d1:	e8 6a bd ff ff       	call   80101640 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801058d6:	83 c4 10             	add    $0x10,%esp
801058d9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801058de:	74 50                	je     80105930 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801058e0:	83 ec 04             	sub    $0x4,%esp
801058e3:	ff 77 04             	pushl  0x4(%edi)
801058e6:	56                   	push   %esi
801058e7:	53                   	push   %ebx
801058e8:	e8 a3 c5 ff ff       	call   80101e90 <dirlink>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	0f 88 8f 00 00 00    	js     80105987 <create+0x187>
  iunlockput(dp);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	53                   	push   %ebx
801058fc:	e8 7f c0 ff ff       	call   80101980 <iunlockput>
  return ip;
80105901:	83 c4 10             	add    $0x10,%esp
}
80105904:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105907:	89 f8                	mov    %edi,%eax
80105909:	5b                   	pop    %ebx
8010590a:	5e                   	pop    %esi
8010590b:	5f                   	pop    %edi
8010590c:	5d                   	pop    %ebp
8010590d:	c3                   	ret    
8010590e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105910:	83 ec 0c             	sub    $0xc,%esp
80105913:	57                   	push   %edi
    return 0;
80105914:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105916:	e8 65 c0 ff ff       	call   80101980 <iunlockput>
    return 0;
8010591b:	83 c4 10             	add    $0x10,%esp
}
8010591e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105921:	89 f8                	mov    %edi,%eax
80105923:	5b                   	pop    %ebx
80105924:	5e                   	pop    %esi
80105925:	5f                   	pop    %edi
80105926:	5d                   	pop    %ebp
80105927:	c3                   	ret    
80105928:	90                   	nop
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105930:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105935:	83 ec 0c             	sub    $0xc,%esp
80105938:	53                   	push   %ebx
80105939:	e8 02 bd ff ff       	call   80101640 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010593e:	83 c4 0c             	add    $0xc,%esp
80105941:	ff 77 04             	pushl  0x4(%edi)
80105944:	68 66 82 10 80       	push   $0x80108266
80105949:	57                   	push   %edi
8010594a:	e8 41 c5 ff ff       	call   80101e90 <dirlink>
8010594f:	83 c4 10             	add    $0x10,%esp
80105952:	85 c0                	test   %eax,%eax
80105954:	78 1c                	js     80105972 <create+0x172>
80105956:	83 ec 04             	sub    $0x4,%esp
80105959:	ff 73 04             	pushl  0x4(%ebx)
8010595c:	68 65 82 10 80       	push   $0x80108265
80105961:	57                   	push   %edi
80105962:	e8 29 c5 ff ff       	call   80101e90 <dirlink>
80105967:	83 c4 10             	add    $0x10,%esp
8010596a:	85 c0                	test   %eax,%eax
8010596c:	0f 89 6e ff ff ff    	jns    801058e0 <create+0xe0>
      panic("create dots");
80105972:	83 ec 0c             	sub    $0xc,%esp
80105975:	68 49 89 10 80       	push   $0x80108949
8010597a:	e8 11 aa ff ff       	call   80100390 <panic>
8010597f:	90                   	nop
    return 0;
80105980:	31 ff                	xor    %edi,%edi
80105982:	e9 f7 fe ff ff       	jmp    8010587e <create+0x7e>
    panic("create: dirlink");
80105987:	83 ec 0c             	sub    $0xc,%esp
8010598a:	68 55 89 10 80       	push   $0x80108955
8010598f:	e8 fc a9 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105994:	83 ec 0c             	sub    $0xc,%esp
80105997:	68 3a 89 10 80       	push   $0x8010893a
8010599c:	e8 ef a9 ff ff       	call   80100390 <panic>
801059a1:	eb 0d                	jmp    801059b0 <sys_open>
801059a3:	90                   	nop
801059a4:	90                   	nop
801059a5:	90                   	nop
801059a6:	90                   	nop
801059a7:	90                   	nop
801059a8:	90                   	nop
801059a9:	90                   	nop
801059aa:	90                   	nop
801059ab:	90                   	nop
801059ac:	90                   	nop
801059ad:	90                   	nop
801059ae:	90                   	nop
801059af:	90                   	nop

801059b0 <sys_open>:

int
sys_open(void)
{
801059b0:	55                   	push   %ebp
801059b1:	89 e5                	mov    %esp,%ebp
801059b3:	57                   	push   %edi
801059b4:	56                   	push   %esi
801059b5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801059b6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801059b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801059bc:	50                   	push   %eax
801059bd:	6a 00                	push   $0x0
801059bf:	e8 fc f7 ff ff       	call   801051c0 <argstr>
801059c4:	83 c4 10             	add    $0x10,%esp
801059c7:	85 c0                	test   %eax,%eax
801059c9:	0f 88 1d 01 00 00    	js     80105aec <sys_open+0x13c>
801059cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059d2:	83 ec 08             	sub    $0x8,%esp
801059d5:	50                   	push   %eax
801059d6:	6a 01                	push   $0x1
801059d8:	e8 33 f7 ff ff       	call   80105110 <argint>
801059dd:	83 c4 10             	add    $0x10,%esp
801059e0:	85 c0                	test   %eax,%eax
801059e2:	0f 88 04 01 00 00    	js     80105aec <sys_open+0x13c>
    return -1;

  begin_op();
801059e8:	e8 a3 d8 ff ff       	call   80103290 <begin_op>

  if(omode & O_CREATE){
801059ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801059f1:	0f 85 a9 00 00 00    	jne    80105aa0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801059f7:	83 ec 0c             	sub    $0xc,%esp
801059fa:	ff 75 e0             	pushl  -0x20(%ebp)
801059fd:	e8 4e c5 ff ff       	call   80101f50 <namei>
80105a02:	83 c4 10             	add    $0x10,%esp
80105a05:	85 c0                	test   %eax,%eax
80105a07:	89 c6                	mov    %eax,%esi
80105a09:	0f 84 ac 00 00 00    	je     80105abb <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
80105a0f:	83 ec 0c             	sub    $0xc,%esp
80105a12:	50                   	push   %eax
80105a13:	e8 d8 bc ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a18:	83 c4 10             	add    $0x10,%esp
80105a1b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105a20:	0f 84 aa 00 00 00    	je     80105ad0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105a26:	e8 a5 b3 ff ff       	call   80100dd0 <filealloc>
80105a2b:	85 c0                	test   %eax,%eax
80105a2d:	89 c7                	mov    %eax,%edi
80105a2f:	0f 84 a6 00 00 00    	je     80105adb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105a35:	e8 e6 e4 ff ff       	call   80103f20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105a3a:	31 db                	xor    %ebx,%ebx
80105a3c:	eb 0e                	jmp    80105a4c <sys_open+0x9c>
80105a3e:	66 90                	xchg   %ax,%ax
80105a40:	83 c3 01             	add    $0x1,%ebx
80105a43:	83 fb 10             	cmp    $0x10,%ebx
80105a46:	0f 84 ac 00 00 00    	je     80105af8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105a4c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a50:	85 d2                	test   %edx,%edx
80105a52:	75 ec                	jne    80105a40 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a54:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105a57:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105a5b:	56                   	push   %esi
80105a5c:	e8 6f bd ff ff       	call   801017d0 <iunlock>
  end_op();
80105a61:	e8 9a d8 ff ff       	call   80103300 <end_op>

  f->type = FD_INODE;
80105a66:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105a6c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a6f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105a72:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105a75:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105a7c:	89 d0                	mov    %edx,%eax
80105a7e:	f7 d0                	not    %eax
80105a80:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a83:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105a86:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a89:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105a8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a90:	89 d8                	mov    %ebx,%eax
80105a92:	5b                   	pop    %ebx
80105a93:	5e                   	pop    %esi
80105a94:	5f                   	pop    %edi
80105a95:	5d                   	pop    %ebp
80105a96:	c3                   	ret    
80105a97:	89 f6                	mov    %esi,%esi
80105a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105aa0:	6a 00                	push   $0x0
80105aa2:	6a 00                	push   $0x0
80105aa4:	6a 02                	push   $0x2
80105aa6:	ff 75 e0             	pushl  -0x20(%ebp)
80105aa9:	e8 52 fd ff ff       	call   80105800 <create>
    if(ip == 0){
80105aae:	83 c4 10             	add    $0x10,%esp
80105ab1:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105ab3:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105ab5:	0f 85 6b ff ff ff    	jne    80105a26 <sys_open+0x76>
      end_op();
80105abb:	e8 40 d8 ff ff       	call   80103300 <end_op>
      return -1;
80105ac0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ac5:	eb c6                	jmp    80105a8d <sys_open+0xdd>
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ad0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105ad3:	85 c9                	test   %ecx,%ecx
80105ad5:	0f 84 4b ff ff ff    	je     80105a26 <sys_open+0x76>
    iunlockput(ip);
80105adb:	83 ec 0c             	sub    $0xc,%esp
80105ade:	56                   	push   %esi
80105adf:	e8 9c be ff ff       	call   80101980 <iunlockput>
    end_op();
80105ae4:	e8 17 d8 ff ff       	call   80103300 <end_op>
    return -1;
80105ae9:	83 c4 10             	add    $0x10,%esp
80105aec:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105af1:	eb 9a                	jmp    80105a8d <sys_open+0xdd>
80105af3:	90                   	nop
80105af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105af8:	83 ec 0c             	sub    $0xc,%esp
80105afb:	57                   	push   %edi
80105afc:	e8 8f b3 ff ff       	call   80100e90 <fileclose>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	eb d5                	jmp    80105adb <sys_open+0x12b>
80105b06:	8d 76 00             	lea    0x0(%esi),%esi
80105b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b10 <sys_mkdir>:

int
sys_mkdir(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105b16:	e8 75 d7 ff ff       	call   80103290 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105b1b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b1e:	83 ec 08             	sub    $0x8,%esp
80105b21:	50                   	push   %eax
80105b22:	6a 00                	push   $0x0
80105b24:	e8 97 f6 ff ff       	call   801051c0 <argstr>
80105b29:	83 c4 10             	add    $0x10,%esp
80105b2c:	85 c0                	test   %eax,%eax
80105b2e:	78 30                	js     80105b60 <sys_mkdir+0x50>
80105b30:	6a 00                	push   $0x0
80105b32:	6a 00                	push   $0x0
80105b34:	6a 01                	push   $0x1
80105b36:	ff 75 f4             	pushl  -0xc(%ebp)
80105b39:	e8 c2 fc ff ff       	call   80105800 <create>
80105b3e:	83 c4 10             	add    $0x10,%esp
80105b41:	85 c0                	test   %eax,%eax
80105b43:	74 1b                	je     80105b60 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b45:	83 ec 0c             	sub    $0xc,%esp
80105b48:	50                   	push   %eax
80105b49:	e8 32 be ff ff       	call   80101980 <iunlockput>
  end_op();
80105b4e:	e8 ad d7 ff ff       	call   80103300 <end_op>
  return 0;
80105b53:	83 c4 10             	add    $0x10,%esp
80105b56:	31 c0                	xor    %eax,%eax
}
80105b58:	c9                   	leave  
80105b59:	c3                   	ret    
80105b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105b60:	e8 9b d7 ff ff       	call   80103300 <end_op>
    return -1;
80105b65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b6a:	c9                   	leave  
80105b6b:	c3                   	ret    
80105b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b70 <sys_mknod>:

int
sys_mknod(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105b76:	e8 15 d7 ff ff       	call   80103290 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105b7b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b7e:	83 ec 08             	sub    $0x8,%esp
80105b81:	50                   	push   %eax
80105b82:	6a 00                	push   $0x0
80105b84:	e8 37 f6 ff ff       	call   801051c0 <argstr>
80105b89:	83 c4 10             	add    $0x10,%esp
80105b8c:	85 c0                	test   %eax,%eax
80105b8e:	78 60                	js     80105bf0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105b90:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b93:	83 ec 08             	sub    $0x8,%esp
80105b96:	50                   	push   %eax
80105b97:	6a 01                	push   $0x1
80105b99:	e8 72 f5 ff ff       	call   80105110 <argint>
  if((argstr(0, &path)) < 0 ||
80105b9e:	83 c4 10             	add    $0x10,%esp
80105ba1:	85 c0                	test   %eax,%eax
80105ba3:	78 4b                	js     80105bf0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105ba5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ba8:	83 ec 08             	sub    $0x8,%esp
80105bab:	50                   	push   %eax
80105bac:	6a 02                	push   $0x2
80105bae:	e8 5d f5 ff ff       	call   80105110 <argint>
     argint(1, &major) < 0 ||
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	85 c0                	test   %eax,%eax
80105bb8:	78 36                	js     80105bf0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105bba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105bbe:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105bbf:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105bc3:	50                   	push   %eax
80105bc4:	6a 03                	push   $0x3
80105bc6:	ff 75 ec             	pushl  -0x14(%ebp)
80105bc9:	e8 32 fc ff ff       	call   80105800 <create>
80105bce:	83 c4 10             	add    $0x10,%esp
80105bd1:	85 c0                	test   %eax,%eax
80105bd3:	74 1b                	je     80105bf0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105bd5:	83 ec 0c             	sub    $0xc,%esp
80105bd8:	50                   	push   %eax
80105bd9:	e8 a2 bd ff ff       	call   80101980 <iunlockput>
  end_op();
80105bde:	e8 1d d7 ff ff       	call   80103300 <end_op>
  return 0;
80105be3:	83 c4 10             	add    $0x10,%esp
80105be6:	31 c0                	xor    %eax,%eax
}
80105be8:	c9                   	leave  
80105be9:	c3                   	ret    
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105bf0:	e8 0b d7 ff ff       	call   80103300 <end_op>
    return -1;
80105bf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bfa:	c9                   	leave  
80105bfb:	c3                   	ret    
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c00 <sys_chdir>:

int
sys_chdir(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	56                   	push   %esi
80105c04:	53                   	push   %ebx
80105c05:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105c08:	e8 13 e3 ff ff       	call   80103f20 <myproc>
80105c0d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105c0f:	e8 7c d6 ff ff       	call   80103290 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105c14:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c17:	83 ec 08             	sub    $0x8,%esp
80105c1a:	50                   	push   %eax
80105c1b:	6a 00                	push   $0x0
80105c1d:	e8 9e f5 ff ff       	call   801051c0 <argstr>
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	85 c0                	test   %eax,%eax
80105c27:	78 77                	js     80105ca0 <sys_chdir+0xa0>
80105c29:	83 ec 0c             	sub    $0xc,%esp
80105c2c:	ff 75 f4             	pushl  -0xc(%ebp)
80105c2f:	e8 1c c3 ff ff       	call   80101f50 <namei>
80105c34:	83 c4 10             	add    $0x10,%esp
80105c37:	85 c0                	test   %eax,%eax
80105c39:	89 c3                	mov    %eax,%ebx
80105c3b:	74 63                	je     80105ca0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105c3d:	83 ec 0c             	sub    $0xc,%esp
80105c40:	50                   	push   %eax
80105c41:	e8 aa ba ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c4e:	75 30                	jne    80105c80 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105c50:	83 ec 0c             	sub    $0xc,%esp
80105c53:	53                   	push   %ebx
80105c54:	e8 77 bb ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80105c59:	58                   	pop    %eax
80105c5a:	ff 76 68             	pushl  0x68(%esi)
80105c5d:	e8 be bb ff ff       	call   80101820 <iput>
  end_op();
80105c62:	e8 99 d6 ff ff       	call   80103300 <end_op>
  curproc->cwd = ip;
80105c67:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105c6a:	83 c4 10             	add    $0x10,%esp
80105c6d:	31 c0                	xor    %eax,%eax
}
80105c6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c72:	5b                   	pop    %ebx
80105c73:	5e                   	pop    %esi
80105c74:	5d                   	pop    %ebp
80105c75:	c3                   	ret    
80105c76:	8d 76 00             	lea    0x0(%esi),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	53                   	push   %ebx
80105c84:	e8 f7 bc ff ff       	call   80101980 <iunlockput>
    end_op();
80105c89:	e8 72 d6 ff ff       	call   80103300 <end_op>
    return -1;
80105c8e:	83 c4 10             	add    $0x10,%esp
80105c91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c96:	eb d7                	jmp    80105c6f <sys_chdir+0x6f>
80105c98:	90                   	nop
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105ca0:	e8 5b d6 ff ff       	call   80103300 <end_op>
    return -1;
80105ca5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105caa:	eb c3                	jmp    80105c6f <sys_chdir+0x6f>
80105cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <sys_exec>:

int
sys_exec(void)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	57                   	push   %edi
80105cb4:	56                   	push   %esi
80105cb5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105cb6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105cbc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105cc2:	50                   	push   %eax
80105cc3:	6a 00                	push   $0x0
80105cc5:	e8 f6 f4 ff ff       	call   801051c0 <argstr>
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	85 c0                	test   %eax,%eax
80105ccf:	0f 88 87 00 00 00    	js     80105d5c <sys_exec+0xac>
80105cd5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105cdb:	83 ec 08             	sub    $0x8,%esp
80105cde:	50                   	push   %eax
80105cdf:	6a 01                	push   $0x1
80105ce1:	e8 2a f4 ff ff       	call   80105110 <argint>
80105ce6:	83 c4 10             	add    $0x10,%esp
80105ce9:	85 c0                	test   %eax,%eax
80105ceb:	78 6f                	js     80105d5c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105ced:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105cf3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105cf6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105cf8:	68 80 00 00 00       	push   $0x80
80105cfd:	6a 00                	push   $0x0
80105cff:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105d05:	50                   	push   %eax
80105d06:	e8 05 f1 ff ff       	call   80104e10 <memset>
80105d0b:	83 c4 10             	add    $0x10,%esp
80105d0e:	eb 2c                	jmp    80105d3c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105d10:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105d16:	85 c0                	test   %eax,%eax
80105d18:	74 56                	je     80105d70 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105d1a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105d20:	83 ec 08             	sub    $0x8,%esp
80105d23:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105d26:	52                   	push   %edx
80105d27:	50                   	push   %eax
80105d28:	e8 73 f3 ff ff       	call   801050a0 <fetchstr>
80105d2d:	83 c4 10             	add    $0x10,%esp
80105d30:	85 c0                	test   %eax,%eax
80105d32:	78 28                	js     80105d5c <sys_exec+0xac>
  for(i=0;; i++){
80105d34:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105d37:	83 fb 20             	cmp    $0x20,%ebx
80105d3a:	74 20                	je     80105d5c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105d3c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105d42:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105d49:	83 ec 08             	sub    $0x8,%esp
80105d4c:	57                   	push   %edi
80105d4d:	01 f0                	add    %esi,%eax
80105d4f:	50                   	push   %eax
80105d50:	e8 0b f3 ff ff       	call   80105060 <fetchint>
80105d55:	83 c4 10             	add    $0x10,%esp
80105d58:	85 c0                	test   %eax,%eax
80105d5a:	79 b4                	jns    80105d10 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105d5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105d5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d64:	5b                   	pop    %ebx
80105d65:	5e                   	pop    %esi
80105d66:	5f                   	pop    %edi
80105d67:	5d                   	pop    %ebp
80105d68:	c3                   	ret    
80105d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105d70:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105d76:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105d79:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105d80:	00 00 00 00 
  return exec(path, argv);
80105d84:	50                   	push   %eax
80105d85:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105d8b:	e8 80 ac ff ff       	call   80100a10 <exec>
80105d90:	83 c4 10             	add    $0x10,%esp
}
80105d93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d96:	5b                   	pop    %ebx
80105d97:	5e                   	pop    %esi
80105d98:	5f                   	pop    %edi
80105d99:	5d                   	pop    %ebp
80105d9a:	c3                   	ret    
80105d9b:	90                   	nop
80105d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105da0 <sys_pipe>:

int
sys_pipe(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	56                   	push   %esi
80105da5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105da6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105da9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105dac:	6a 08                	push   $0x8
80105dae:	50                   	push   %eax
80105daf:	6a 00                	push   $0x0
80105db1:	e8 aa f3 ff ff       	call   80105160 <argptr>
80105db6:	83 c4 10             	add    $0x10,%esp
80105db9:	85 c0                	test   %eax,%eax
80105dbb:	0f 88 ae 00 00 00    	js     80105e6f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105dc1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105dc4:	83 ec 08             	sub    $0x8,%esp
80105dc7:	50                   	push   %eax
80105dc8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105dcb:	50                   	push   %eax
80105dcc:	e8 5f db ff ff       	call   80103930 <pipealloc>
80105dd1:	83 c4 10             	add    $0x10,%esp
80105dd4:	85 c0                	test   %eax,%eax
80105dd6:	0f 88 93 00 00 00    	js     80105e6f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ddc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105ddf:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105de1:	e8 3a e1 ff ff       	call   80103f20 <myproc>
80105de6:	eb 10                	jmp    80105df8 <sys_pipe+0x58>
80105de8:	90                   	nop
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105df0:	83 c3 01             	add    $0x1,%ebx
80105df3:	83 fb 10             	cmp    $0x10,%ebx
80105df6:	74 60                	je     80105e58 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105df8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105dfc:	85 f6                	test   %esi,%esi
80105dfe:	75 f0                	jne    80105df0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105e00:	8d 73 08             	lea    0x8(%ebx),%esi
80105e03:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105e07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105e0a:	e8 11 e1 ff ff       	call   80103f20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e0f:	31 d2                	xor    %edx,%edx
80105e11:	eb 0d                	jmp    80105e20 <sys_pipe+0x80>
80105e13:	90                   	nop
80105e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e18:	83 c2 01             	add    $0x1,%edx
80105e1b:	83 fa 10             	cmp    $0x10,%edx
80105e1e:	74 28                	je     80105e48 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105e20:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105e24:	85 c9                	test   %ecx,%ecx
80105e26:	75 f0                	jne    80105e18 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105e28:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105e2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e2f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105e31:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e34:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105e37:	31 c0                	xor    %eax,%eax
}
80105e39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e3c:	5b                   	pop    %ebx
80105e3d:	5e                   	pop    %esi
80105e3e:	5f                   	pop    %edi
80105e3f:	5d                   	pop    %ebp
80105e40:	c3                   	ret    
80105e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105e48:	e8 d3 e0 ff ff       	call   80103f20 <myproc>
80105e4d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105e54:	00 
80105e55:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105e58:	83 ec 0c             	sub    $0xc,%esp
80105e5b:	ff 75 e0             	pushl  -0x20(%ebp)
80105e5e:	e8 2d b0 ff ff       	call   80100e90 <fileclose>
    fileclose(wf);
80105e63:	58                   	pop    %eax
80105e64:	ff 75 e4             	pushl  -0x1c(%ebp)
80105e67:	e8 24 b0 ff ff       	call   80100e90 <fileclose>
    return -1;
80105e6c:	83 c4 10             	add    $0x10,%esp
80105e6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e74:	eb c3                	jmp    80105e39 <sys_pipe+0x99>
80105e76:	66 90                	xchg   %ax,%ax
80105e78:	66 90                	xchg   %ax,%ax
80105e7a:	66 90                	xchg   %ax,%ax
80105e7c:	66 90                	xchg   %ax,%ax
80105e7e:	66 90                	xchg   %ax,%ax

80105e80 <sys_yield>:
#include "mmu.h"
#include "proc.h"


int sys_yield(void)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	83 ec 08             	sub    $0x8,%esp
  yield(); 
80105e86:	e8 75 e7 ff ff       	call   80104600 <yield>
  return 0;
}
80105e8b:	31 c0                	xor    %eax,%eax
80105e8d:	c9                   	leave  
80105e8e:	c3                   	ret    
80105e8f:	90                   	nop

80105e90 <sys_fork>:

int
sys_fork(void)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105e93:	5d                   	pop    %ebp
  return fork();
80105e94:	e9 07 e3 ff ff       	jmp    801041a0 <fork>
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ea0 <sys_exit>:

int
sys_exit(void)
{
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ea6:	e8 f5 e5 ff ff       	call   801044a0 <exit>
  return 0;  // not reached
}
80105eab:	31 c0                	xor    %eax,%eax
80105ead:	c9                   	leave  
80105eae:	c3                   	ret    
80105eaf:	90                   	nop

80105eb0 <sys_wait>:

int
sys_wait(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105eb3:	5d                   	pop    %ebp
  return wait();
80105eb4:	e9 57 e8 ff ff       	jmp    80104710 <wait>
80105eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ec0 <sys_kill>:

int
sys_kill(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ec6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ec9:	50                   	push   %eax
80105eca:	6a 00                	push   $0x0
80105ecc:	e8 3f f2 ff ff       	call   80105110 <argint>
80105ed1:	83 c4 10             	add    $0x10,%esp
80105ed4:	85 c0                	test   %eax,%eax
80105ed6:	78 18                	js     80105ef0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105ed8:	83 ec 0c             	sub    $0xc,%esp
80105edb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ede:	e8 bd e9 ff ff       	call   801048a0 <kill>
80105ee3:	83 c4 10             	add    $0x10,%esp
}
80105ee6:	c9                   	leave  
80105ee7:	c3                   	ret    
80105ee8:	90                   	nop
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ef0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ef5:	c9                   	leave  
80105ef6:	c3                   	ret    
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f00 <sys_getpid>:

int
sys_getpid(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105f06:	e8 15 e0 ff ff       	call   80103f20 <myproc>
80105f0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105f0e:	c9                   	leave  
80105f0f:	c3                   	ret    

80105f10 <sys_sbrk>:

int
sys_sbrk(void)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105f14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f17:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f1a:	50                   	push   %eax
80105f1b:	6a 00                	push   $0x0
80105f1d:	e8 ee f1 ff ff       	call   80105110 <argint>
80105f22:	83 c4 10             	add    $0x10,%esp
80105f25:	85 c0                	test   %eax,%eax
80105f27:	78 27                	js     80105f50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105f29:	e8 f2 df ff ff       	call   80103f20 <myproc>
  if(growproc(n) < 0)
80105f2e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105f31:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105f33:	ff 75 f4             	pushl  -0xc(%ebp)
80105f36:	e8 05 e1 ff ff       	call   80104040 <growproc>
80105f3b:	83 c4 10             	add    $0x10,%esp
80105f3e:	85 c0                	test   %eax,%eax
80105f40:	78 0e                	js     80105f50 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105f42:	89 d8                	mov    %ebx,%eax
80105f44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f47:	c9                   	leave  
80105f48:	c3                   	ret    
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f50:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f55:	eb eb                	jmp    80105f42 <sys_sbrk+0x32>
80105f57:	89 f6                	mov    %esi,%esi
80105f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f60 <sys_sleep>:

int
sys_sleep(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105f64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f6a:	50                   	push   %eax
80105f6b:	6a 00                	push   $0x0
80105f6d:	e8 9e f1 ff ff       	call   80105110 <argint>
80105f72:	83 c4 10             	add    $0x10,%esp
80105f75:	85 c0                	test   %eax,%eax
80105f77:	0f 88 8a 00 00 00    	js     80106007 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105f7d:	83 ec 0c             	sub    $0xc,%esp
80105f80:	68 60 f1 11 80       	push   $0x8011f160
80105f85:	e8 06 ed ff ff       	call   80104c90 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105f8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f8d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105f90:	8b 1d a0 f9 11 80    	mov    0x8011f9a0,%ebx
  while(ticks - ticks0 < n){
80105f96:	85 d2                	test   %edx,%edx
80105f98:	75 27                	jne    80105fc1 <sys_sleep+0x61>
80105f9a:	eb 54                	jmp    80105ff0 <sys_sleep+0x90>
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105fa0:	83 ec 08             	sub    $0x8,%esp
80105fa3:	68 60 f1 11 80       	push   $0x8011f160
80105fa8:	68 a0 f9 11 80       	push   $0x8011f9a0
80105fad:	e8 9e e6 ff ff       	call   80104650 <sleep>
  while(ticks - ticks0 < n){
80105fb2:	a1 a0 f9 11 80       	mov    0x8011f9a0,%eax
80105fb7:	83 c4 10             	add    $0x10,%esp
80105fba:	29 d8                	sub    %ebx,%eax
80105fbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105fbf:	73 2f                	jae    80105ff0 <sys_sleep+0x90>
    if(myproc()->killed){
80105fc1:	e8 5a df ff ff       	call   80103f20 <myproc>
80105fc6:	8b 40 24             	mov    0x24(%eax),%eax
80105fc9:	85 c0                	test   %eax,%eax
80105fcb:	74 d3                	je     80105fa0 <sys_sleep+0x40>
      release(&tickslock);
80105fcd:	83 ec 0c             	sub    $0xc,%esp
80105fd0:	68 60 f1 11 80       	push   $0x8011f160
80105fd5:	e8 d6 ed ff ff       	call   80104db0 <release>
      return -1;
80105fda:	83 c4 10             	add    $0x10,%esp
80105fdd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105fe2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fe5:	c9                   	leave  
80105fe6:	c3                   	ret    
80105fe7:	89 f6                	mov    %esi,%esi
80105fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105ff0:	83 ec 0c             	sub    $0xc,%esp
80105ff3:	68 60 f1 11 80       	push   $0x8011f160
80105ff8:	e8 b3 ed ff ff       	call   80104db0 <release>
  return 0;
80105ffd:	83 c4 10             	add    $0x10,%esp
80106000:	31 c0                	xor    %eax,%eax
}
80106002:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106005:	c9                   	leave  
80106006:	c3                   	ret    
    return -1;
80106007:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010600c:	eb f4                	jmp    80106002 <sys_sleep+0xa2>
8010600e:	66 90                	xchg   %ax,%ax

80106010 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	53                   	push   %ebx
80106014:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106017:	68 60 f1 11 80       	push   $0x8011f160
8010601c:	e8 6f ec ff ff       	call   80104c90 <acquire>
  xticks = ticks;
80106021:	8b 1d a0 f9 11 80    	mov    0x8011f9a0,%ebx
  release(&tickslock);
80106027:	c7 04 24 60 f1 11 80 	movl   $0x8011f160,(%esp)
8010602e:	e8 7d ed ff ff       	call   80104db0 <release>
  return xticks;
}
80106033:	89 d8                	mov    %ebx,%eax
80106035:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106038:	c9                   	leave  
80106039:	c3                   	ret    
8010603a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106040 <sys_set_flag>:


int
sys_set_flag(void){
80106040:	55                   	push   %ebp
80106041:	89 e5                	mov    %esp,%ebp
80106043:	83 ec 20             	sub    $0x20,%esp
    int va, flag, on;
    if(argint(0,&va) < 0 || argint(1,&flag) < 0 || argint(2,&on) < 0)
80106046:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106049:	50                   	push   %eax
8010604a:	6a 00                	push   $0x0
8010604c:	e8 bf f0 ff ff       	call   80105110 <argint>
80106051:	83 c4 10             	add    $0x10,%esp
80106054:	85 c0                	test   %eax,%eax
80106056:	78 48                	js     801060a0 <sys_set_flag+0x60>
80106058:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010605b:	83 ec 08             	sub    $0x8,%esp
8010605e:	50                   	push   %eax
8010605f:	6a 01                	push   $0x1
80106061:	e8 aa f0 ff ff       	call   80105110 <argint>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	85 c0                	test   %eax,%eax
8010606b:	78 33                	js     801060a0 <sys_set_flag+0x60>
8010606d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106070:	83 ec 08             	sub    $0x8,%esp
80106073:	50                   	push   %eax
80106074:	6a 02                	push   $0x2
80106076:	e8 95 f0 ff ff       	call   80105110 <argint>
8010607b:	83 c4 10             	add    $0x10,%esp
8010607e:	85 c0                	test   %eax,%eax
80106080:	78 1e                	js     801060a0 <sys_set_flag+0x60>
        return -1;

    return set_flag(va,flag,on);
80106082:	83 ec 04             	sub    $0x4,%esp
80106085:	ff 75 f4             	pushl  -0xc(%ebp)
80106088:	ff 75 f0             	pushl  -0x10(%ebp)
8010608b:	ff 75 ec             	pushl  -0x14(%ebp)
8010608e:	e8 ed 1d 00 00       	call   80107e80 <set_flag>
80106093:	83 c4 10             	add    $0x10,%esp
}
80106096:	c9                   	leave  
80106097:	c3                   	ret    
80106098:	90                   	nop
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801060a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060a5:	c9                   	leave  
801060a6:	c3                   	ret    
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_get_flags>:

int sys_get_flags(void){
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	83 ec 20             	sub    $0x20,%esp
    int va;
    if(argint(0,&va) < 0 )
801060b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060b9:	50                   	push   %eax
801060ba:	6a 00                	push   $0x0
801060bc:	e8 4f f0 ff ff       	call   80105110 <argint>
801060c1:	83 c4 10             	add    $0x10,%esp
801060c4:	85 c0                	test   %eax,%eax
801060c6:	78 18                	js     801060e0 <sys_get_flags+0x30>
        return -1;

    return get_flags(va);
801060c8:	83 ec 0c             	sub    $0xc,%esp
801060cb:	ff 75 f4             	pushl  -0xc(%ebp)
801060ce:	e8 7d 1d 00 00       	call   80107e50 <get_flags>
801060d3:	83 c4 10             	add    $0x10,%esp
}
801060d6:	c9                   	leave  
801060d7:	c3                   	ret    
801060d8:	90                   	nop
801060d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801060e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060e5:	c9                   	leave  
801060e6:	c3                   	ret    
801060e7:	89 f6                	mov    %esi,%esi
801060e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060f0 <sys_update_protected_pages>:

int sys_update_protected_pages(void){
801060f0:	55                   	push   %ebp
801060f1:	89 e5                	mov    %esp,%ebp
801060f3:	83 ec 20             	sub    $0x20,%esp
    int up;
    if(argint(0,&up) < 0 )
801060f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060f9:	50                   	push   %eax
801060fa:	6a 00                	push   $0x0
801060fc:	e8 0f f0 ff ff       	call   80105110 <argint>
80106101:	83 c4 10             	add    $0x10,%esp
80106104:	85 c0                	test   %eax,%eax
80106106:	78 18                	js     80106120 <sys_update_protected_pages+0x30>
        return -1;

    update_protected_pages(up);
80106108:	83 ec 0c             	sub    $0xc,%esp
8010610b:	ff 75 f4             	pushl  -0xc(%ebp)
8010610e:	e8 9d 1f 00 00       	call   801080b0 <update_protected_pages>
    return 0;
80106113:	83 c4 10             	add    $0x10,%esp
80106116:	31 c0                	xor    %eax,%eax
}
80106118:	c9                   	leave  
80106119:	c3                   	ret    
8010611a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
80106120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106125:	c9                   	leave  
80106126:	c3                   	ret    

80106127 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106127:	1e                   	push   %ds
  pushl %es
80106128:	06                   	push   %es
  pushl %fs
80106129:	0f a0                	push   %fs
  pushl %gs
8010612b:	0f a8                	push   %gs
  pushal
8010612d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010612e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106132:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106134:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106136:	54                   	push   %esp
  call trap
80106137:	e8 c4 00 00 00       	call   80106200 <trap>
  addl $4, %esp
8010613c:	83 c4 04             	add    $0x4,%esp

8010613f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010613f:	61                   	popa   
  popl %gs
80106140:	0f a9                	pop    %gs
  popl %fs
80106142:	0f a1                	pop    %fs
  popl %es
80106144:	07                   	pop    %es
  popl %ds
80106145:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106146:	83 c4 08             	add    $0x8,%esp
  iret
80106149:	cf                   	iret   
8010614a:	66 90                	xchg   %ax,%ax
8010614c:	66 90                	xchg   %ax,%ax
8010614e:	66 90                	xchg   %ax,%ax

80106150 <tvinit>:
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void) {
80106150:	55                   	push   %ebp
    int i;

    for (i = 0; i < 256; i++) SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
80106151:	31 c0                	xor    %eax,%eax
tvinit(void) {
80106153:	89 e5                	mov    %esp,%ebp
80106155:	83 ec 08             	sub    $0x8,%esp
80106158:	90                   	nop
80106159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (i = 0; i < 256; i++) SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
80106160:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106167:	c7 04 c5 a2 f1 11 80 	movl   $0x8e000008,-0x7fee0e5e(,%eax,8)
8010616e:	08 00 00 8e 
80106172:	66 89 14 c5 a0 f1 11 	mov    %dx,-0x7fee0e60(,%eax,8)
80106179:	80 
8010617a:	c1 ea 10             	shr    $0x10,%edx
8010617d:	66 89 14 c5 a6 f1 11 	mov    %dx,-0x7fee0e5a(,%eax,8)
80106184:	80 
80106185:	83 c0 01             	add    $0x1,%eax
80106188:	3d 00 01 00 00       	cmp    $0x100,%eax
8010618d:	75 d1                	jne    80106160 <tvinit+0x10>
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
8010618f:	a1 08 b1 10 80       	mov    0x8010b108,%eax

    initlock(&tickslock, "time");
80106194:	83 ec 08             	sub    $0x8,%esp
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
80106197:	c7 05 a2 f3 11 80 08 	movl   $0xef000008,0x8011f3a2
8010619e:	00 00 ef 
    initlock(&tickslock, "time");
801061a1:	68 65 89 10 80       	push   $0x80108965
801061a6:	68 60 f1 11 80       	push   $0x8011f160
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
801061ab:	66 a3 a0 f3 11 80    	mov    %ax,0x8011f3a0
801061b1:	c1 e8 10             	shr    $0x10,%eax
801061b4:	66 a3 a6 f3 11 80    	mov    %ax,0x8011f3a6
    initlock(&tickslock, "time");
801061ba:	e8 e1 e9 ff ff       	call   80104ba0 <initlock>
}
801061bf:	83 c4 10             	add    $0x10,%esp
801061c2:	c9                   	leave  
801061c3:	c3                   	ret    
801061c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801061ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801061d0 <idtinit>:

void
idtinit(void) {
801061d0:	55                   	push   %ebp
  pd[0] = size-1;
801061d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801061d6:	89 e5                	mov    %esp,%ebp
801061d8:	83 ec 10             	sub    $0x10,%esp
801061db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801061df:	b8 a0 f1 11 80       	mov    $0x8011f1a0,%eax
801061e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801061e8:	c1 e8 10             	shr    $0x10,%eax
801061eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801061ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801061f2:	0f 01 18             	lidtl  (%eax)
    lidt(idt, sizeof(idt));
}
801061f5:	c9                   	leave  
801061f6:	c3                   	ret    
801061f7:	89 f6                	mov    %esi,%esi
801061f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106200 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf) {
80106200:	55                   	push   %ebp
80106201:	89 e5                	mov    %esp,%ebp
80106203:	57                   	push   %edi
80106204:	56                   	push   %esi
80106205:	53                   	push   %ebx
80106206:	83 ec 1c             	sub    $0x1c,%esp
80106209:	8b 7d 08             	mov    0x8(%ebp),%edi
    if (tf->trapno == T_SYSCALL) {
8010620c:	8b 47 30             	mov    0x30(%edi),%eax
8010620f:	83 f8 40             	cmp    $0x40,%eax
80106212:	0f 84 48 01 00 00    	je     80106360 <trap+0x160>
            exit();
        return;
    }
    uint va;

    switch (tf->trapno) {
80106218:	83 e8 0e             	sub    $0xe,%eax
8010621b:	83 f8 31             	cmp    $0x31,%eax
8010621e:	77 50                	ja     80106270 <trap+0x70>
80106220:	ff 24 85 0c 8a 10 80 	jmp    *-0x7fef75f4(,%eax,4)
80106227:	89 f6                	mov    %esi,%esi
80106229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106230:	0f 20 d3             	mov    %cr2,%ebx
            lapiceoi();
            break;

        case T_PGFLT:
            va = rcr2();
            if (myproc()->pid > 2) {
80106233:	e8 e8 dc ff ff       	call   80103f20 <myproc>
80106238:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
8010623c:	7e 32                	jle    80106270 <trap+0x70>
                if ((tf->cs & 3) == 3 && get_flags(va) & PTE_PG) {
8010623e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106242:	83 e0 03             	and    $0x3,%eax
80106245:	66 83 f8 03          	cmp    $0x3,%ax
80106249:	75 25                	jne    80106270 <trap+0x70>
8010624b:	83 ec 0c             	sub    $0xc,%esp
8010624e:	53                   	push   %ebx
8010624f:	e8 fc 1b 00 00       	call   80107e50 <get_flags>
80106254:	83 c4 10             	add    $0x10,%esp
80106257:	f6 c4 02             	test   $0x2,%ah
8010625a:	74 14                	je     80106270 <trap+0x70>
                    if (page_from_disk(va)) {
8010625c:	83 ec 0c             	sub    $0xc,%esp
8010625f:	53                   	push   %ebx
80106260:	e8 7b 1c 00 00       	call   80107ee0 <page_from_disk>
80106265:	83 c4 10             	add    $0x10,%esp
80106268:	85 c0                	test   %eax,%eax
8010626a:	0f 85 88 00 00 00    	jne    801062f8 <trap+0xf8>
80106270:	0f 20 d0             	mov    %cr2,%eax
                }
            }

            //PAGEBREAK: 13
        default:
            if(!(get_flags(rcr2()) & PTE_W)) tf->trapno = 13;
80106273:	83 ec 0c             	sub    $0xc,%esp
80106276:	50                   	push   %eax
80106277:	e8 d4 1b 00 00       	call   80107e50 <get_flags>
8010627c:	83 c4 10             	add    $0x10,%esp
8010627f:	a8 02                	test   $0x2,%al
80106281:	75 07                	jne    8010628a <trap+0x8a>
80106283:	c7 47 30 0d 00 00 00 	movl   $0xd,0x30(%edi)
            if (myproc() == 0 || (tf->cs & 3) == 0) {
8010628a:	e8 91 dc ff ff       	call   80103f20 <myproc>
8010628f:	85 c0                	test   %eax,%eax
80106291:	8b 5f 38             	mov    0x38(%edi),%ebx
80106294:	0f 84 ea 01 00 00    	je     80106484 <trap+0x284>
8010629a:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
8010629e:	0f 84 e0 01 00 00    	je     80106484 <trap+0x284>
801062a4:	0f 20 d1             	mov    %cr2,%ecx
801062a7:	89 4d d8             	mov    %ecx,-0x28(%ebp)
                cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
                        tf->trapno, cpuid(), tf->eip, rcr2());
                panic("trap");
            }
            // In user space, assume process misbehaved.
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801062aa:	e8 51 dc ff ff       	call   80103f00 <cpuid>
801062af:	89 45 dc             	mov    %eax,-0x24(%ebp)
801062b2:	8b 47 34             	mov    0x34(%edi),%eax
801062b5:	8b 77 30             	mov    0x30(%edi),%esi
801062b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                    "eip 0x%x addr 0x%x--kill proc\n",
                    myproc()->pid, myproc()->name, tf->trapno,
801062bb:	e8 60 dc ff ff       	call   80103f20 <myproc>
801062c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801062c3:	e8 58 dc ff ff       	call   80103f20 <myproc>
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801062c8:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801062cb:	8b 55 dc             	mov    -0x24(%ebp),%edx
801062ce:	51                   	push   %ecx
801062cf:	53                   	push   %ebx
801062d0:	52                   	push   %edx
                    myproc()->pid, myproc()->name, tf->trapno,
801062d1:	8b 55 e0             	mov    -0x20(%ebp),%edx
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801062d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801062d7:	56                   	push   %esi
                    myproc()->pid, myproc()->name, tf->trapno,
801062d8:	83 c2 6c             	add    $0x6c,%edx
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801062db:	52                   	push   %edx
801062dc:	ff 70 10             	pushl  0x10(%eax)
801062df:	68 c8 89 10 80       	push   $0x801089c8
801062e4:	e8 77 a3 ff ff       	call   80100660 <cprintf>
                    tf->err, cpuid(), tf->eip, rcr2());
            myproc()->killed = 1;
801062e9:	83 c4 20             	add    $0x20,%esp
801062ec:	e8 2f dc ff ff       	call   80103f20 <myproc>
801062f1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
    }

    // Force process exit if it has been killed and is in user space.
    // (If it is still executing in the kernel, let it keep running
    // until it gets to the regular system call return.)
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
801062f8:	e8 23 dc ff ff       	call   80103f20 <myproc>
801062fd:	85 c0                	test   %eax,%eax
801062ff:	74 1d                	je     8010631e <trap+0x11e>
80106301:	e8 1a dc ff ff       	call   80103f20 <myproc>
80106306:	8b 50 24             	mov    0x24(%eax),%edx
80106309:	85 d2                	test   %edx,%edx
8010630b:	74 11                	je     8010631e <trap+0x11e>
8010630d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106311:	83 e0 03             	and    $0x3,%eax
80106314:	66 83 f8 03          	cmp    $0x3,%ax
80106318:	0f 84 22 01 00 00    	je     80106440 <trap+0x240>
        exit();

    // Force process to give up CPU on clock tick.
    // If interrupts were on while locks held, would need to check nlock.
    if (myproc() && myproc()->state == RUNNING &&
8010631e:	e8 fd db ff ff       	call   80103f20 <myproc>
80106323:	85 c0                	test   %eax,%eax
80106325:	74 0b                	je     80106332 <trap+0x132>
80106327:	e8 f4 db ff ff       	call   80103f20 <myproc>
8010632c:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106330:	74 66                	je     80106398 <trap+0x198>
        tf->trapno == T_IRQ0 + IRQ_TIMER)
        yield();

    // Check if the process has been killed since we yielded
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106332:	e8 e9 db ff ff       	call   80103f20 <myproc>
80106337:	85 c0                	test   %eax,%eax
80106339:	74 19                	je     80106354 <trap+0x154>
8010633b:	e8 e0 db ff ff       	call   80103f20 <myproc>
80106340:	8b 40 24             	mov    0x24(%eax),%eax
80106343:	85 c0                	test   %eax,%eax
80106345:	74 0d                	je     80106354 <trap+0x154>
80106347:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010634b:	83 e0 03             	and    $0x3,%eax
8010634e:	66 83 f8 03          	cmp    $0x3,%ax
80106352:	74 35                	je     80106389 <trap+0x189>
        exit();
}
80106354:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106357:	5b                   	pop    %ebx
80106358:	5e                   	pop    %esi
80106359:	5f                   	pop    %edi
8010635a:	5d                   	pop    %ebp
8010635b:	c3                   	ret    
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (myproc()->killed)
80106360:	e8 bb db ff ff       	call   80103f20 <myproc>
80106365:	8b 58 24             	mov    0x24(%eax),%ebx
80106368:	85 db                	test   %ebx,%ebx
8010636a:	0f 85 c0 00 00 00    	jne    80106430 <trap+0x230>
        myproc()->tf = tf;
80106370:	e8 ab db ff ff       	call   80103f20 <myproc>
80106375:	89 78 18             	mov    %edi,0x18(%eax)
        syscall();
80106378:	e8 83 ee ff ff       	call   80105200 <syscall>
        if (myproc()->killed)
8010637d:	e8 9e db ff ff       	call   80103f20 <myproc>
80106382:	8b 48 24             	mov    0x24(%eax),%ecx
80106385:	85 c9                	test   %ecx,%ecx
80106387:	74 cb                	je     80106354 <trap+0x154>
}
80106389:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010638c:	5b                   	pop    %ebx
8010638d:	5e                   	pop    %esi
8010638e:	5f                   	pop    %edi
8010638f:	5d                   	pop    %ebp
            exit();
80106390:	e9 0b e1 ff ff       	jmp    801044a0 <exit>
80106395:	8d 76 00             	lea    0x0(%esi),%esi
    if (myproc() && myproc()->state == RUNNING &&
80106398:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
8010639c:	75 94                	jne    80106332 <trap+0x132>
        yield();
8010639e:	e8 5d e2 ff ff       	call   80104600 <yield>
801063a3:	eb 8d                	jmp    80106332 <trap+0x132>
801063a5:	8d 76 00             	lea    0x0(%esi),%esi
            if (cpuid() == 0) {
801063a8:	e8 53 db ff ff       	call   80103f00 <cpuid>
801063ad:	85 c0                	test   %eax,%eax
801063af:	0f 84 9b 00 00 00    	je     80106450 <trap+0x250>
            lapiceoi();
801063b5:	e8 86 ca ff ff       	call   80102e40 <lapiceoi>
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
801063ba:	e8 61 db ff ff       	call   80103f20 <myproc>
801063bf:	85 c0                	test   %eax,%eax
801063c1:	0f 85 3a ff ff ff    	jne    80106301 <trap+0x101>
801063c7:	e9 52 ff ff ff       	jmp    8010631e <trap+0x11e>
801063cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kbdintr();
801063d0:	e8 2b c9 ff ff       	call   80102d00 <kbdintr>
            lapiceoi();
801063d5:	e8 66 ca ff ff       	call   80102e40 <lapiceoi>
            break;
801063da:	e9 19 ff ff ff       	jmp    801062f8 <trap+0xf8>
801063df:	90                   	nop
            uartintr();
801063e0:	e8 3b 02 00 00       	call   80106620 <uartintr>
            lapiceoi();
801063e5:	e8 56 ca ff ff       	call   80102e40 <lapiceoi>
            break;
801063ea:	e9 09 ff ff ff       	jmp    801062f8 <trap+0xf8>
801063ef:	90                   	nop
            cprintf("cpu%d: spurious interrupt at %x:%x\n",
801063f0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
801063f4:	8b 77 38             	mov    0x38(%edi),%esi
801063f7:	e8 04 db ff ff       	call   80103f00 <cpuid>
801063fc:	56                   	push   %esi
801063fd:	53                   	push   %ebx
801063fe:	50                   	push   %eax
801063ff:	68 70 89 10 80       	push   $0x80108970
80106404:	e8 57 a2 ff ff       	call   80100660 <cprintf>
            lapiceoi();
80106409:	e8 32 ca ff ff       	call   80102e40 <lapiceoi>
            break;
8010640e:	83 c4 10             	add    $0x10,%esp
80106411:	e9 e2 fe ff ff       	jmp    801062f8 <trap+0xf8>
80106416:	8d 76 00             	lea    0x0(%esi),%esi
80106419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            ideintr();
80106420:	e8 cb c2 ff ff       	call   801026f0 <ideintr>
80106425:	eb 8e                	jmp    801063b5 <trap+0x1b5>
80106427:	89 f6                	mov    %esi,%esi
80106429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            exit();
80106430:	e8 6b e0 ff ff       	call   801044a0 <exit>
80106435:	e9 36 ff ff ff       	jmp    80106370 <trap+0x170>
8010643a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        exit();
80106440:	e8 5b e0 ff ff       	call   801044a0 <exit>
80106445:	e9 d4 fe ff ff       	jmp    8010631e <trap+0x11e>
8010644a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                acquire(&tickslock);
80106450:	83 ec 0c             	sub    $0xc,%esp
80106453:	68 60 f1 11 80       	push   $0x8011f160
80106458:	e8 33 e8 ff ff       	call   80104c90 <acquire>
                wakeup(&ticks);
8010645d:	c7 04 24 a0 f9 11 80 	movl   $0x8011f9a0,(%esp)
                ticks++;
80106464:	83 05 a0 f9 11 80 01 	addl   $0x1,0x8011f9a0
                wakeup(&ticks);
8010646b:	e8 d0 e3 ff ff       	call   80104840 <wakeup>
                release(&tickslock);
80106470:	c7 04 24 60 f1 11 80 	movl   $0x8011f160,(%esp)
80106477:	e8 34 e9 ff ff       	call   80104db0 <release>
8010647c:	83 c4 10             	add    $0x10,%esp
8010647f:	e9 31 ff ff ff       	jmp    801063b5 <trap+0x1b5>
80106484:	0f 20 d6             	mov    %cr2,%esi
                cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106487:	e8 74 da ff ff       	call   80103f00 <cpuid>
8010648c:	83 ec 0c             	sub    $0xc,%esp
8010648f:	56                   	push   %esi
80106490:	53                   	push   %ebx
80106491:	50                   	push   %eax
80106492:	ff 77 30             	pushl  0x30(%edi)
80106495:	68 94 89 10 80       	push   $0x80108994
8010649a:	e8 c1 a1 ff ff       	call   80100660 <cprintf>
                panic("trap");
8010649f:	83 c4 14             	add    $0x14,%esp
801064a2:	68 6a 89 10 80       	push   $0x8010896a
801064a7:	e8 e4 9e ff ff       	call   80100390 <panic>
801064ac:	66 90                	xchg   %ax,%ax
801064ae:	66 90                	xchg   %ax,%ax

801064b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801064b0:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
801064b5:	55                   	push   %ebp
801064b6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801064b8:	85 c0                	test   %eax,%eax
801064ba:	74 1c                	je     801064d8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801064bc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801064c1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801064c2:	a8 01                	test   $0x1,%al
801064c4:	74 12                	je     801064d8 <uartgetc+0x28>
801064c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064cb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801064cc:	0f b6 c0             	movzbl %al,%eax
}
801064cf:	5d                   	pop    %ebp
801064d0:	c3                   	ret    
801064d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801064d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064dd:	5d                   	pop    %ebp
801064de:	c3                   	ret    
801064df:	90                   	nop

801064e0 <uartputc.part.0>:
uartputc(int c)
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
801064e5:	53                   	push   %ebx
801064e6:	89 c7                	mov    %eax,%edi
801064e8:	bb 80 00 00 00       	mov    $0x80,%ebx
801064ed:	be fd 03 00 00       	mov    $0x3fd,%esi
801064f2:	83 ec 0c             	sub    $0xc,%esp
801064f5:	eb 1b                	jmp    80106512 <uartputc.part.0+0x32>
801064f7:	89 f6                	mov    %esi,%esi
801064f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106500:	83 ec 0c             	sub    $0xc,%esp
80106503:	6a 0a                	push   $0xa
80106505:	e8 56 c9 ff ff       	call   80102e60 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010650a:	83 c4 10             	add    $0x10,%esp
8010650d:	83 eb 01             	sub    $0x1,%ebx
80106510:	74 07                	je     80106519 <uartputc.part.0+0x39>
80106512:	89 f2                	mov    %esi,%edx
80106514:	ec                   	in     (%dx),%al
80106515:	a8 20                	test   $0x20,%al
80106517:	74 e7                	je     80106500 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106519:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010651e:	89 f8                	mov    %edi,%eax
80106520:	ee                   	out    %al,(%dx)
}
80106521:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106524:	5b                   	pop    %ebx
80106525:	5e                   	pop    %esi
80106526:	5f                   	pop    %edi
80106527:	5d                   	pop    %ebp
80106528:	c3                   	ret    
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106530 <uartinit>:
{
80106530:	55                   	push   %ebp
80106531:	31 c9                	xor    %ecx,%ecx
80106533:	89 c8                	mov    %ecx,%eax
80106535:	89 e5                	mov    %esp,%ebp
80106537:	57                   	push   %edi
80106538:	56                   	push   %esi
80106539:	53                   	push   %ebx
8010653a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010653f:	89 da                	mov    %ebx,%edx
80106541:	83 ec 0c             	sub    $0xc,%esp
80106544:	ee                   	out    %al,(%dx)
80106545:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010654a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010654f:	89 fa                	mov    %edi,%edx
80106551:	ee                   	out    %al,(%dx)
80106552:	b8 0c 00 00 00       	mov    $0xc,%eax
80106557:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010655c:	ee                   	out    %al,(%dx)
8010655d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106562:	89 c8                	mov    %ecx,%eax
80106564:	89 f2                	mov    %esi,%edx
80106566:	ee                   	out    %al,(%dx)
80106567:	b8 03 00 00 00       	mov    $0x3,%eax
8010656c:	89 fa                	mov    %edi,%edx
8010656e:	ee                   	out    %al,(%dx)
8010656f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106574:	89 c8                	mov    %ecx,%eax
80106576:	ee                   	out    %al,(%dx)
80106577:	b8 01 00 00 00       	mov    $0x1,%eax
8010657c:	89 f2                	mov    %esi,%edx
8010657e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010657f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106584:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106585:	3c ff                	cmp    $0xff,%al
80106587:	74 5a                	je     801065e3 <uartinit+0xb3>
  uart = 1;
80106589:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106590:	00 00 00 
80106593:	89 da                	mov    %ebx,%edx
80106595:	ec                   	in     (%dx),%al
80106596:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010659b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010659c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010659f:	bb d4 8a 10 80       	mov    $0x80108ad4,%ebx
  ioapicenable(IRQ_COM1, 0);
801065a4:	6a 00                	push   $0x0
801065a6:	6a 04                	push   $0x4
801065a8:	e8 93 c3 ff ff       	call   80102940 <ioapicenable>
801065ad:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801065b0:	b8 78 00 00 00       	mov    $0x78,%eax
801065b5:	eb 13                	jmp    801065ca <uartinit+0x9a>
801065b7:	89 f6                	mov    %esi,%esi
801065b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801065c0:	83 c3 01             	add    $0x1,%ebx
801065c3:	0f be 03             	movsbl (%ebx),%eax
801065c6:	84 c0                	test   %al,%al
801065c8:	74 19                	je     801065e3 <uartinit+0xb3>
  if(!uart)
801065ca:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801065d0:	85 d2                	test   %edx,%edx
801065d2:	74 ec                	je     801065c0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801065d4:	83 c3 01             	add    $0x1,%ebx
801065d7:	e8 04 ff ff ff       	call   801064e0 <uartputc.part.0>
801065dc:	0f be 03             	movsbl (%ebx),%eax
801065df:	84 c0                	test   %al,%al
801065e1:	75 e7                	jne    801065ca <uartinit+0x9a>
}
801065e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065e6:	5b                   	pop    %ebx
801065e7:	5e                   	pop    %esi
801065e8:	5f                   	pop    %edi
801065e9:	5d                   	pop    %ebp
801065ea:	c3                   	ret    
801065eb:	90                   	nop
801065ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801065f0 <uartputc>:
  if(!uart)
801065f0:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
801065f6:	55                   	push   %ebp
801065f7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801065f9:	85 d2                	test   %edx,%edx
{
801065fb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801065fe:	74 10                	je     80106610 <uartputc+0x20>
}
80106600:	5d                   	pop    %ebp
80106601:	e9 da fe ff ff       	jmp    801064e0 <uartputc.part.0>
80106606:	8d 76 00             	lea    0x0(%esi),%esi
80106609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106610:	5d                   	pop    %ebp
80106611:	c3                   	ret    
80106612:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106620 <uartintr>:

void
uartintr(void)
{
80106620:	55                   	push   %ebp
80106621:	89 e5                	mov    %esp,%ebp
80106623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106626:	68 b0 64 10 80       	push   $0x801064b0
8010662b:	e8 e0 a1 ff ff       	call   80100810 <consoleintr>
}
80106630:	83 c4 10             	add    $0x10,%esp
80106633:	c9                   	leave  
80106634:	c3                   	ret    

80106635 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106635:	6a 00                	push   $0x0
  pushl $0
80106637:	6a 00                	push   $0x0
  jmp alltraps
80106639:	e9 e9 fa ff ff       	jmp    80106127 <alltraps>

8010663e <vector1>:
.globl vector1
vector1:
  pushl $0
8010663e:	6a 00                	push   $0x0
  pushl $1
80106640:	6a 01                	push   $0x1
  jmp alltraps
80106642:	e9 e0 fa ff ff       	jmp    80106127 <alltraps>

80106647 <vector2>:
.globl vector2
vector2:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $2
80106649:	6a 02                	push   $0x2
  jmp alltraps
8010664b:	e9 d7 fa ff ff       	jmp    80106127 <alltraps>

80106650 <vector3>:
.globl vector3
vector3:
  pushl $0
80106650:	6a 00                	push   $0x0
  pushl $3
80106652:	6a 03                	push   $0x3
  jmp alltraps
80106654:	e9 ce fa ff ff       	jmp    80106127 <alltraps>

80106659 <vector4>:
.globl vector4
vector4:
  pushl $0
80106659:	6a 00                	push   $0x0
  pushl $4
8010665b:	6a 04                	push   $0x4
  jmp alltraps
8010665d:	e9 c5 fa ff ff       	jmp    80106127 <alltraps>

80106662 <vector5>:
.globl vector5
vector5:
  pushl $0
80106662:	6a 00                	push   $0x0
  pushl $5
80106664:	6a 05                	push   $0x5
  jmp alltraps
80106666:	e9 bc fa ff ff       	jmp    80106127 <alltraps>

8010666b <vector6>:
.globl vector6
vector6:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $6
8010666d:	6a 06                	push   $0x6
  jmp alltraps
8010666f:	e9 b3 fa ff ff       	jmp    80106127 <alltraps>

80106674 <vector7>:
.globl vector7
vector7:
  pushl $0
80106674:	6a 00                	push   $0x0
  pushl $7
80106676:	6a 07                	push   $0x7
  jmp alltraps
80106678:	e9 aa fa ff ff       	jmp    80106127 <alltraps>

8010667d <vector8>:
.globl vector8
vector8:
  pushl $8
8010667d:	6a 08                	push   $0x8
  jmp alltraps
8010667f:	e9 a3 fa ff ff       	jmp    80106127 <alltraps>

80106684 <vector9>:
.globl vector9
vector9:
  pushl $0
80106684:	6a 00                	push   $0x0
  pushl $9
80106686:	6a 09                	push   $0x9
  jmp alltraps
80106688:	e9 9a fa ff ff       	jmp    80106127 <alltraps>

8010668d <vector10>:
.globl vector10
vector10:
  pushl $10
8010668d:	6a 0a                	push   $0xa
  jmp alltraps
8010668f:	e9 93 fa ff ff       	jmp    80106127 <alltraps>

80106694 <vector11>:
.globl vector11
vector11:
  pushl $11
80106694:	6a 0b                	push   $0xb
  jmp alltraps
80106696:	e9 8c fa ff ff       	jmp    80106127 <alltraps>

8010669b <vector12>:
.globl vector12
vector12:
  pushl $12
8010669b:	6a 0c                	push   $0xc
  jmp alltraps
8010669d:	e9 85 fa ff ff       	jmp    80106127 <alltraps>

801066a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801066a2:	6a 0d                	push   $0xd
  jmp alltraps
801066a4:	e9 7e fa ff ff       	jmp    80106127 <alltraps>

801066a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801066a9:	6a 0e                	push   $0xe
  jmp alltraps
801066ab:	e9 77 fa ff ff       	jmp    80106127 <alltraps>

801066b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $15
801066b2:	6a 0f                	push   $0xf
  jmp alltraps
801066b4:	e9 6e fa ff ff       	jmp    80106127 <alltraps>

801066b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $16
801066bb:	6a 10                	push   $0x10
  jmp alltraps
801066bd:	e9 65 fa ff ff       	jmp    80106127 <alltraps>

801066c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801066c2:	6a 11                	push   $0x11
  jmp alltraps
801066c4:	e9 5e fa ff ff       	jmp    80106127 <alltraps>

801066c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801066c9:	6a 00                	push   $0x0
  pushl $18
801066cb:	6a 12                	push   $0x12
  jmp alltraps
801066cd:	e9 55 fa ff ff       	jmp    80106127 <alltraps>

801066d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801066d2:	6a 00                	push   $0x0
  pushl $19
801066d4:	6a 13                	push   $0x13
  jmp alltraps
801066d6:	e9 4c fa ff ff       	jmp    80106127 <alltraps>

801066db <vector20>:
.globl vector20
vector20:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $20
801066dd:	6a 14                	push   $0x14
  jmp alltraps
801066df:	e9 43 fa ff ff       	jmp    80106127 <alltraps>

801066e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801066e4:	6a 00                	push   $0x0
  pushl $21
801066e6:	6a 15                	push   $0x15
  jmp alltraps
801066e8:	e9 3a fa ff ff       	jmp    80106127 <alltraps>

801066ed <vector22>:
.globl vector22
vector22:
  pushl $0
801066ed:	6a 00                	push   $0x0
  pushl $22
801066ef:	6a 16                	push   $0x16
  jmp alltraps
801066f1:	e9 31 fa ff ff       	jmp    80106127 <alltraps>

801066f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801066f6:	6a 00                	push   $0x0
  pushl $23
801066f8:	6a 17                	push   $0x17
  jmp alltraps
801066fa:	e9 28 fa ff ff       	jmp    80106127 <alltraps>

801066ff <vector24>:
.globl vector24
vector24:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $24
80106701:	6a 18                	push   $0x18
  jmp alltraps
80106703:	e9 1f fa ff ff       	jmp    80106127 <alltraps>

80106708 <vector25>:
.globl vector25
vector25:
  pushl $0
80106708:	6a 00                	push   $0x0
  pushl $25
8010670a:	6a 19                	push   $0x19
  jmp alltraps
8010670c:	e9 16 fa ff ff       	jmp    80106127 <alltraps>

80106711 <vector26>:
.globl vector26
vector26:
  pushl $0
80106711:	6a 00                	push   $0x0
  pushl $26
80106713:	6a 1a                	push   $0x1a
  jmp alltraps
80106715:	e9 0d fa ff ff       	jmp    80106127 <alltraps>

8010671a <vector27>:
.globl vector27
vector27:
  pushl $0
8010671a:	6a 00                	push   $0x0
  pushl $27
8010671c:	6a 1b                	push   $0x1b
  jmp alltraps
8010671e:	e9 04 fa ff ff       	jmp    80106127 <alltraps>

80106723 <vector28>:
.globl vector28
vector28:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $28
80106725:	6a 1c                	push   $0x1c
  jmp alltraps
80106727:	e9 fb f9 ff ff       	jmp    80106127 <alltraps>

8010672c <vector29>:
.globl vector29
vector29:
  pushl $0
8010672c:	6a 00                	push   $0x0
  pushl $29
8010672e:	6a 1d                	push   $0x1d
  jmp alltraps
80106730:	e9 f2 f9 ff ff       	jmp    80106127 <alltraps>

80106735 <vector30>:
.globl vector30
vector30:
  pushl $0
80106735:	6a 00                	push   $0x0
  pushl $30
80106737:	6a 1e                	push   $0x1e
  jmp alltraps
80106739:	e9 e9 f9 ff ff       	jmp    80106127 <alltraps>

8010673e <vector31>:
.globl vector31
vector31:
  pushl $0
8010673e:	6a 00                	push   $0x0
  pushl $31
80106740:	6a 1f                	push   $0x1f
  jmp alltraps
80106742:	e9 e0 f9 ff ff       	jmp    80106127 <alltraps>

80106747 <vector32>:
.globl vector32
vector32:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $32
80106749:	6a 20                	push   $0x20
  jmp alltraps
8010674b:	e9 d7 f9 ff ff       	jmp    80106127 <alltraps>

80106750 <vector33>:
.globl vector33
vector33:
  pushl $0
80106750:	6a 00                	push   $0x0
  pushl $33
80106752:	6a 21                	push   $0x21
  jmp alltraps
80106754:	e9 ce f9 ff ff       	jmp    80106127 <alltraps>

80106759 <vector34>:
.globl vector34
vector34:
  pushl $0
80106759:	6a 00                	push   $0x0
  pushl $34
8010675b:	6a 22                	push   $0x22
  jmp alltraps
8010675d:	e9 c5 f9 ff ff       	jmp    80106127 <alltraps>

80106762 <vector35>:
.globl vector35
vector35:
  pushl $0
80106762:	6a 00                	push   $0x0
  pushl $35
80106764:	6a 23                	push   $0x23
  jmp alltraps
80106766:	e9 bc f9 ff ff       	jmp    80106127 <alltraps>

8010676b <vector36>:
.globl vector36
vector36:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $36
8010676d:	6a 24                	push   $0x24
  jmp alltraps
8010676f:	e9 b3 f9 ff ff       	jmp    80106127 <alltraps>

80106774 <vector37>:
.globl vector37
vector37:
  pushl $0
80106774:	6a 00                	push   $0x0
  pushl $37
80106776:	6a 25                	push   $0x25
  jmp alltraps
80106778:	e9 aa f9 ff ff       	jmp    80106127 <alltraps>

8010677d <vector38>:
.globl vector38
vector38:
  pushl $0
8010677d:	6a 00                	push   $0x0
  pushl $38
8010677f:	6a 26                	push   $0x26
  jmp alltraps
80106781:	e9 a1 f9 ff ff       	jmp    80106127 <alltraps>

80106786 <vector39>:
.globl vector39
vector39:
  pushl $0
80106786:	6a 00                	push   $0x0
  pushl $39
80106788:	6a 27                	push   $0x27
  jmp alltraps
8010678a:	e9 98 f9 ff ff       	jmp    80106127 <alltraps>

8010678f <vector40>:
.globl vector40
vector40:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $40
80106791:	6a 28                	push   $0x28
  jmp alltraps
80106793:	e9 8f f9 ff ff       	jmp    80106127 <alltraps>

80106798 <vector41>:
.globl vector41
vector41:
  pushl $0
80106798:	6a 00                	push   $0x0
  pushl $41
8010679a:	6a 29                	push   $0x29
  jmp alltraps
8010679c:	e9 86 f9 ff ff       	jmp    80106127 <alltraps>

801067a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801067a1:	6a 00                	push   $0x0
  pushl $42
801067a3:	6a 2a                	push   $0x2a
  jmp alltraps
801067a5:	e9 7d f9 ff ff       	jmp    80106127 <alltraps>

801067aa <vector43>:
.globl vector43
vector43:
  pushl $0
801067aa:	6a 00                	push   $0x0
  pushl $43
801067ac:	6a 2b                	push   $0x2b
  jmp alltraps
801067ae:	e9 74 f9 ff ff       	jmp    80106127 <alltraps>

801067b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $44
801067b5:	6a 2c                	push   $0x2c
  jmp alltraps
801067b7:	e9 6b f9 ff ff       	jmp    80106127 <alltraps>

801067bc <vector45>:
.globl vector45
vector45:
  pushl $0
801067bc:	6a 00                	push   $0x0
  pushl $45
801067be:	6a 2d                	push   $0x2d
  jmp alltraps
801067c0:	e9 62 f9 ff ff       	jmp    80106127 <alltraps>

801067c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801067c5:	6a 00                	push   $0x0
  pushl $46
801067c7:	6a 2e                	push   $0x2e
  jmp alltraps
801067c9:	e9 59 f9 ff ff       	jmp    80106127 <alltraps>

801067ce <vector47>:
.globl vector47
vector47:
  pushl $0
801067ce:	6a 00                	push   $0x0
  pushl $47
801067d0:	6a 2f                	push   $0x2f
  jmp alltraps
801067d2:	e9 50 f9 ff ff       	jmp    80106127 <alltraps>

801067d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $48
801067d9:	6a 30                	push   $0x30
  jmp alltraps
801067db:	e9 47 f9 ff ff       	jmp    80106127 <alltraps>

801067e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801067e0:	6a 00                	push   $0x0
  pushl $49
801067e2:	6a 31                	push   $0x31
  jmp alltraps
801067e4:	e9 3e f9 ff ff       	jmp    80106127 <alltraps>

801067e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801067e9:	6a 00                	push   $0x0
  pushl $50
801067eb:	6a 32                	push   $0x32
  jmp alltraps
801067ed:	e9 35 f9 ff ff       	jmp    80106127 <alltraps>

801067f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801067f2:	6a 00                	push   $0x0
  pushl $51
801067f4:	6a 33                	push   $0x33
  jmp alltraps
801067f6:	e9 2c f9 ff ff       	jmp    80106127 <alltraps>

801067fb <vector52>:
.globl vector52
vector52:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $52
801067fd:	6a 34                	push   $0x34
  jmp alltraps
801067ff:	e9 23 f9 ff ff       	jmp    80106127 <alltraps>

80106804 <vector53>:
.globl vector53
vector53:
  pushl $0
80106804:	6a 00                	push   $0x0
  pushl $53
80106806:	6a 35                	push   $0x35
  jmp alltraps
80106808:	e9 1a f9 ff ff       	jmp    80106127 <alltraps>

8010680d <vector54>:
.globl vector54
vector54:
  pushl $0
8010680d:	6a 00                	push   $0x0
  pushl $54
8010680f:	6a 36                	push   $0x36
  jmp alltraps
80106811:	e9 11 f9 ff ff       	jmp    80106127 <alltraps>

80106816 <vector55>:
.globl vector55
vector55:
  pushl $0
80106816:	6a 00                	push   $0x0
  pushl $55
80106818:	6a 37                	push   $0x37
  jmp alltraps
8010681a:	e9 08 f9 ff ff       	jmp    80106127 <alltraps>

8010681f <vector56>:
.globl vector56
vector56:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $56
80106821:	6a 38                	push   $0x38
  jmp alltraps
80106823:	e9 ff f8 ff ff       	jmp    80106127 <alltraps>

80106828 <vector57>:
.globl vector57
vector57:
  pushl $0
80106828:	6a 00                	push   $0x0
  pushl $57
8010682a:	6a 39                	push   $0x39
  jmp alltraps
8010682c:	e9 f6 f8 ff ff       	jmp    80106127 <alltraps>

80106831 <vector58>:
.globl vector58
vector58:
  pushl $0
80106831:	6a 00                	push   $0x0
  pushl $58
80106833:	6a 3a                	push   $0x3a
  jmp alltraps
80106835:	e9 ed f8 ff ff       	jmp    80106127 <alltraps>

8010683a <vector59>:
.globl vector59
vector59:
  pushl $0
8010683a:	6a 00                	push   $0x0
  pushl $59
8010683c:	6a 3b                	push   $0x3b
  jmp alltraps
8010683e:	e9 e4 f8 ff ff       	jmp    80106127 <alltraps>

80106843 <vector60>:
.globl vector60
vector60:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $60
80106845:	6a 3c                	push   $0x3c
  jmp alltraps
80106847:	e9 db f8 ff ff       	jmp    80106127 <alltraps>

8010684c <vector61>:
.globl vector61
vector61:
  pushl $0
8010684c:	6a 00                	push   $0x0
  pushl $61
8010684e:	6a 3d                	push   $0x3d
  jmp alltraps
80106850:	e9 d2 f8 ff ff       	jmp    80106127 <alltraps>

80106855 <vector62>:
.globl vector62
vector62:
  pushl $0
80106855:	6a 00                	push   $0x0
  pushl $62
80106857:	6a 3e                	push   $0x3e
  jmp alltraps
80106859:	e9 c9 f8 ff ff       	jmp    80106127 <alltraps>

8010685e <vector63>:
.globl vector63
vector63:
  pushl $0
8010685e:	6a 00                	push   $0x0
  pushl $63
80106860:	6a 3f                	push   $0x3f
  jmp alltraps
80106862:	e9 c0 f8 ff ff       	jmp    80106127 <alltraps>

80106867 <vector64>:
.globl vector64
vector64:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $64
80106869:	6a 40                	push   $0x40
  jmp alltraps
8010686b:	e9 b7 f8 ff ff       	jmp    80106127 <alltraps>

80106870 <vector65>:
.globl vector65
vector65:
  pushl $0
80106870:	6a 00                	push   $0x0
  pushl $65
80106872:	6a 41                	push   $0x41
  jmp alltraps
80106874:	e9 ae f8 ff ff       	jmp    80106127 <alltraps>

80106879 <vector66>:
.globl vector66
vector66:
  pushl $0
80106879:	6a 00                	push   $0x0
  pushl $66
8010687b:	6a 42                	push   $0x42
  jmp alltraps
8010687d:	e9 a5 f8 ff ff       	jmp    80106127 <alltraps>

80106882 <vector67>:
.globl vector67
vector67:
  pushl $0
80106882:	6a 00                	push   $0x0
  pushl $67
80106884:	6a 43                	push   $0x43
  jmp alltraps
80106886:	e9 9c f8 ff ff       	jmp    80106127 <alltraps>

8010688b <vector68>:
.globl vector68
vector68:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $68
8010688d:	6a 44                	push   $0x44
  jmp alltraps
8010688f:	e9 93 f8 ff ff       	jmp    80106127 <alltraps>

80106894 <vector69>:
.globl vector69
vector69:
  pushl $0
80106894:	6a 00                	push   $0x0
  pushl $69
80106896:	6a 45                	push   $0x45
  jmp alltraps
80106898:	e9 8a f8 ff ff       	jmp    80106127 <alltraps>

8010689d <vector70>:
.globl vector70
vector70:
  pushl $0
8010689d:	6a 00                	push   $0x0
  pushl $70
8010689f:	6a 46                	push   $0x46
  jmp alltraps
801068a1:	e9 81 f8 ff ff       	jmp    80106127 <alltraps>

801068a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801068a6:	6a 00                	push   $0x0
  pushl $71
801068a8:	6a 47                	push   $0x47
  jmp alltraps
801068aa:	e9 78 f8 ff ff       	jmp    80106127 <alltraps>

801068af <vector72>:
.globl vector72
vector72:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $72
801068b1:	6a 48                	push   $0x48
  jmp alltraps
801068b3:	e9 6f f8 ff ff       	jmp    80106127 <alltraps>

801068b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801068b8:	6a 00                	push   $0x0
  pushl $73
801068ba:	6a 49                	push   $0x49
  jmp alltraps
801068bc:	e9 66 f8 ff ff       	jmp    80106127 <alltraps>

801068c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801068c1:	6a 00                	push   $0x0
  pushl $74
801068c3:	6a 4a                	push   $0x4a
  jmp alltraps
801068c5:	e9 5d f8 ff ff       	jmp    80106127 <alltraps>

801068ca <vector75>:
.globl vector75
vector75:
  pushl $0
801068ca:	6a 00                	push   $0x0
  pushl $75
801068cc:	6a 4b                	push   $0x4b
  jmp alltraps
801068ce:	e9 54 f8 ff ff       	jmp    80106127 <alltraps>

801068d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $76
801068d5:	6a 4c                	push   $0x4c
  jmp alltraps
801068d7:	e9 4b f8 ff ff       	jmp    80106127 <alltraps>

801068dc <vector77>:
.globl vector77
vector77:
  pushl $0
801068dc:	6a 00                	push   $0x0
  pushl $77
801068de:	6a 4d                	push   $0x4d
  jmp alltraps
801068e0:	e9 42 f8 ff ff       	jmp    80106127 <alltraps>

801068e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801068e5:	6a 00                	push   $0x0
  pushl $78
801068e7:	6a 4e                	push   $0x4e
  jmp alltraps
801068e9:	e9 39 f8 ff ff       	jmp    80106127 <alltraps>

801068ee <vector79>:
.globl vector79
vector79:
  pushl $0
801068ee:	6a 00                	push   $0x0
  pushl $79
801068f0:	6a 4f                	push   $0x4f
  jmp alltraps
801068f2:	e9 30 f8 ff ff       	jmp    80106127 <alltraps>

801068f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $80
801068f9:	6a 50                	push   $0x50
  jmp alltraps
801068fb:	e9 27 f8 ff ff       	jmp    80106127 <alltraps>

80106900 <vector81>:
.globl vector81
vector81:
  pushl $0
80106900:	6a 00                	push   $0x0
  pushl $81
80106902:	6a 51                	push   $0x51
  jmp alltraps
80106904:	e9 1e f8 ff ff       	jmp    80106127 <alltraps>

80106909 <vector82>:
.globl vector82
vector82:
  pushl $0
80106909:	6a 00                	push   $0x0
  pushl $82
8010690b:	6a 52                	push   $0x52
  jmp alltraps
8010690d:	e9 15 f8 ff ff       	jmp    80106127 <alltraps>

80106912 <vector83>:
.globl vector83
vector83:
  pushl $0
80106912:	6a 00                	push   $0x0
  pushl $83
80106914:	6a 53                	push   $0x53
  jmp alltraps
80106916:	e9 0c f8 ff ff       	jmp    80106127 <alltraps>

8010691b <vector84>:
.globl vector84
vector84:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $84
8010691d:	6a 54                	push   $0x54
  jmp alltraps
8010691f:	e9 03 f8 ff ff       	jmp    80106127 <alltraps>

80106924 <vector85>:
.globl vector85
vector85:
  pushl $0
80106924:	6a 00                	push   $0x0
  pushl $85
80106926:	6a 55                	push   $0x55
  jmp alltraps
80106928:	e9 fa f7 ff ff       	jmp    80106127 <alltraps>

8010692d <vector86>:
.globl vector86
vector86:
  pushl $0
8010692d:	6a 00                	push   $0x0
  pushl $86
8010692f:	6a 56                	push   $0x56
  jmp alltraps
80106931:	e9 f1 f7 ff ff       	jmp    80106127 <alltraps>

80106936 <vector87>:
.globl vector87
vector87:
  pushl $0
80106936:	6a 00                	push   $0x0
  pushl $87
80106938:	6a 57                	push   $0x57
  jmp alltraps
8010693a:	e9 e8 f7 ff ff       	jmp    80106127 <alltraps>

8010693f <vector88>:
.globl vector88
vector88:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $88
80106941:	6a 58                	push   $0x58
  jmp alltraps
80106943:	e9 df f7 ff ff       	jmp    80106127 <alltraps>

80106948 <vector89>:
.globl vector89
vector89:
  pushl $0
80106948:	6a 00                	push   $0x0
  pushl $89
8010694a:	6a 59                	push   $0x59
  jmp alltraps
8010694c:	e9 d6 f7 ff ff       	jmp    80106127 <alltraps>

80106951 <vector90>:
.globl vector90
vector90:
  pushl $0
80106951:	6a 00                	push   $0x0
  pushl $90
80106953:	6a 5a                	push   $0x5a
  jmp alltraps
80106955:	e9 cd f7 ff ff       	jmp    80106127 <alltraps>

8010695a <vector91>:
.globl vector91
vector91:
  pushl $0
8010695a:	6a 00                	push   $0x0
  pushl $91
8010695c:	6a 5b                	push   $0x5b
  jmp alltraps
8010695e:	e9 c4 f7 ff ff       	jmp    80106127 <alltraps>

80106963 <vector92>:
.globl vector92
vector92:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $92
80106965:	6a 5c                	push   $0x5c
  jmp alltraps
80106967:	e9 bb f7 ff ff       	jmp    80106127 <alltraps>

8010696c <vector93>:
.globl vector93
vector93:
  pushl $0
8010696c:	6a 00                	push   $0x0
  pushl $93
8010696e:	6a 5d                	push   $0x5d
  jmp alltraps
80106970:	e9 b2 f7 ff ff       	jmp    80106127 <alltraps>

80106975 <vector94>:
.globl vector94
vector94:
  pushl $0
80106975:	6a 00                	push   $0x0
  pushl $94
80106977:	6a 5e                	push   $0x5e
  jmp alltraps
80106979:	e9 a9 f7 ff ff       	jmp    80106127 <alltraps>

8010697e <vector95>:
.globl vector95
vector95:
  pushl $0
8010697e:	6a 00                	push   $0x0
  pushl $95
80106980:	6a 5f                	push   $0x5f
  jmp alltraps
80106982:	e9 a0 f7 ff ff       	jmp    80106127 <alltraps>

80106987 <vector96>:
.globl vector96
vector96:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $96
80106989:	6a 60                	push   $0x60
  jmp alltraps
8010698b:	e9 97 f7 ff ff       	jmp    80106127 <alltraps>

80106990 <vector97>:
.globl vector97
vector97:
  pushl $0
80106990:	6a 00                	push   $0x0
  pushl $97
80106992:	6a 61                	push   $0x61
  jmp alltraps
80106994:	e9 8e f7 ff ff       	jmp    80106127 <alltraps>

80106999 <vector98>:
.globl vector98
vector98:
  pushl $0
80106999:	6a 00                	push   $0x0
  pushl $98
8010699b:	6a 62                	push   $0x62
  jmp alltraps
8010699d:	e9 85 f7 ff ff       	jmp    80106127 <alltraps>

801069a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801069a2:	6a 00                	push   $0x0
  pushl $99
801069a4:	6a 63                	push   $0x63
  jmp alltraps
801069a6:	e9 7c f7 ff ff       	jmp    80106127 <alltraps>

801069ab <vector100>:
.globl vector100
vector100:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $100
801069ad:	6a 64                	push   $0x64
  jmp alltraps
801069af:	e9 73 f7 ff ff       	jmp    80106127 <alltraps>

801069b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801069b4:	6a 00                	push   $0x0
  pushl $101
801069b6:	6a 65                	push   $0x65
  jmp alltraps
801069b8:	e9 6a f7 ff ff       	jmp    80106127 <alltraps>

801069bd <vector102>:
.globl vector102
vector102:
  pushl $0
801069bd:	6a 00                	push   $0x0
  pushl $102
801069bf:	6a 66                	push   $0x66
  jmp alltraps
801069c1:	e9 61 f7 ff ff       	jmp    80106127 <alltraps>

801069c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801069c6:	6a 00                	push   $0x0
  pushl $103
801069c8:	6a 67                	push   $0x67
  jmp alltraps
801069ca:	e9 58 f7 ff ff       	jmp    80106127 <alltraps>

801069cf <vector104>:
.globl vector104
vector104:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $104
801069d1:	6a 68                	push   $0x68
  jmp alltraps
801069d3:	e9 4f f7 ff ff       	jmp    80106127 <alltraps>

801069d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801069d8:	6a 00                	push   $0x0
  pushl $105
801069da:	6a 69                	push   $0x69
  jmp alltraps
801069dc:	e9 46 f7 ff ff       	jmp    80106127 <alltraps>

801069e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801069e1:	6a 00                	push   $0x0
  pushl $106
801069e3:	6a 6a                	push   $0x6a
  jmp alltraps
801069e5:	e9 3d f7 ff ff       	jmp    80106127 <alltraps>

801069ea <vector107>:
.globl vector107
vector107:
  pushl $0
801069ea:	6a 00                	push   $0x0
  pushl $107
801069ec:	6a 6b                	push   $0x6b
  jmp alltraps
801069ee:	e9 34 f7 ff ff       	jmp    80106127 <alltraps>

801069f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $108
801069f5:	6a 6c                	push   $0x6c
  jmp alltraps
801069f7:	e9 2b f7 ff ff       	jmp    80106127 <alltraps>

801069fc <vector109>:
.globl vector109
vector109:
  pushl $0
801069fc:	6a 00                	push   $0x0
  pushl $109
801069fe:	6a 6d                	push   $0x6d
  jmp alltraps
80106a00:	e9 22 f7 ff ff       	jmp    80106127 <alltraps>

80106a05 <vector110>:
.globl vector110
vector110:
  pushl $0
80106a05:	6a 00                	push   $0x0
  pushl $110
80106a07:	6a 6e                	push   $0x6e
  jmp alltraps
80106a09:	e9 19 f7 ff ff       	jmp    80106127 <alltraps>

80106a0e <vector111>:
.globl vector111
vector111:
  pushl $0
80106a0e:	6a 00                	push   $0x0
  pushl $111
80106a10:	6a 6f                	push   $0x6f
  jmp alltraps
80106a12:	e9 10 f7 ff ff       	jmp    80106127 <alltraps>

80106a17 <vector112>:
.globl vector112
vector112:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $112
80106a19:	6a 70                	push   $0x70
  jmp alltraps
80106a1b:	e9 07 f7 ff ff       	jmp    80106127 <alltraps>

80106a20 <vector113>:
.globl vector113
vector113:
  pushl $0
80106a20:	6a 00                	push   $0x0
  pushl $113
80106a22:	6a 71                	push   $0x71
  jmp alltraps
80106a24:	e9 fe f6 ff ff       	jmp    80106127 <alltraps>

80106a29 <vector114>:
.globl vector114
vector114:
  pushl $0
80106a29:	6a 00                	push   $0x0
  pushl $114
80106a2b:	6a 72                	push   $0x72
  jmp alltraps
80106a2d:	e9 f5 f6 ff ff       	jmp    80106127 <alltraps>

80106a32 <vector115>:
.globl vector115
vector115:
  pushl $0
80106a32:	6a 00                	push   $0x0
  pushl $115
80106a34:	6a 73                	push   $0x73
  jmp alltraps
80106a36:	e9 ec f6 ff ff       	jmp    80106127 <alltraps>

80106a3b <vector116>:
.globl vector116
vector116:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $116
80106a3d:	6a 74                	push   $0x74
  jmp alltraps
80106a3f:	e9 e3 f6 ff ff       	jmp    80106127 <alltraps>

80106a44 <vector117>:
.globl vector117
vector117:
  pushl $0
80106a44:	6a 00                	push   $0x0
  pushl $117
80106a46:	6a 75                	push   $0x75
  jmp alltraps
80106a48:	e9 da f6 ff ff       	jmp    80106127 <alltraps>

80106a4d <vector118>:
.globl vector118
vector118:
  pushl $0
80106a4d:	6a 00                	push   $0x0
  pushl $118
80106a4f:	6a 76                	push   $0x76
  jmp alltraps
80106a51:	e9 d1 f6 ff ff       	jmp    80106127 <alltraps>

80106a56 <vector119>:
.globl vector119
vector119:
  pushl $0
80106a56:	6a 00                	push   $0x0
  pushl $119
80106a58:	6a 77                	push   $0x77
  jmp alltraps
80106a5a:	e9 c8 f6 ff ff       	jmp    80106127 <alltraps>

80106a5f <vector120>:
.globl vector120
vector120:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $120
80106a61:	6a 78                	push   $0x78
  jmp alltraps
80106a63:	e9 bf f6 ff ff       	jmp    80106127 <alltraps>

80106a68 <vector121>:
.globl vector121
vector121:
  pushl $0
80106a68:	6a 00                	push   $0x0
  pushl $121
80106a6a:	6a 79                	push   $0x79
  jmp alltraps
80106a6c:	e9 b6 f6 ff ff       	jmp    80106127 <alltraps>

80106a71 <vector122>:
.globl vector122
vector122:
  pushl $0
80106a71:	6a 00                	push   $0x0
  pushl $122
80106a73:	6a 7a                	push   $0x7a
  jmp alltraps
80106a75:	e9 ad f6 ff ff       	jmp    80106127 <alltraps>

80106a7a <vector123>:
.globl vector123
vector123:
  pushl $0
80106a7a:	6a 00                	push   $0x0
  pushl $123
80106a7c:	6a 7b                	push   $0x7b
  jmp alltraps
80106a7e:	e9 a4 f6 ff ff       	jmp    80106127 <alltraps>

80106a83 <vector124>:
.globl vector124
vector124:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $124
80106a85:	6a 7c                	push   $0x7c
  jmp alltraps
80106a87:	e9 9b f6 ff ff       	jmp    80106127 <alltraps>

80106a8c <vector125>:
.globl vector125
vector125:
  pushl $0
80106a8c:	6a 00                	push   $0x0
  pushl $125
80106a8e:	6a 7d                	push   $0x7d
  jmp alltraps
80106a90:	e9 92 f6 ff ff       	jmp    80106127 <alltraps>

80106a95 <vector126>:
.globl vector126
vector126:
  pushl $0
80106a95:	6a 00                	push   $0x0
  pushl $126
80106a97:	6a 7e                	push   $0x7e
  jmp alltraps
80106a99:	e9 89 f6 ff ff       	jmp    80106127 <alltraps>

80106a9e <vector127>:
.globl vector127
vector127:
  pushl $0
80106a9e:	6a 00                	push   $0x0
  pushl $127
80106aa0:	6a 7f                	push   $0x7f
  jmp alltraps
80106aa2:	e9 80 f6 ff ff       	jmp    80106127 <alltraps>

80106aa7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $128
80106aa9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106aae:	e9 74 f6 ff ff       	jmp    80106127 <alltraps>

80106ab3 <vector129>:
.globl vector129
vector129:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $129
80106ab5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106aba:	e9 68 f6 ff ff       	jmp    80106127 <alltraps>

80106abf <vector130>:
.globl vector130
vector130:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $130
80106ac1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106ac6:	e9 5c f6 ff ff       	jmp    80106127 <alltraps>

80106acb <vector131>:
.globl vector131
vector131:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $131
80106acd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106ad2:	e9 50 f6 ff ff       	jmp    80106127 <alltraps>

80106ad7 <vector132>:
.globl vector132
vector132:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $132
80106ad9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106ade:	e9 44 f6 ff ff       	jmp    80106127 <alltraps>

80106ae3 <vector133>:
.globl vector133
vector133:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $133
80106ae5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106aea:	e9 38 f6 ff ff       	jmp    80106127 <alltraps>

80106aef <vector134>:
.globl vector134
vector134:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $134
80106af1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106af6:	e9 2c f6 ff ff       	jmp    80106127 <alltraps>

80106afb <vector135>:
.globl vector135
vector135:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $135
80106afd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106b02:	e9 20 f6 ff ff       	jmp    80106127 <alltraps>

80106b07 <vector136>:
.globl vector136
vector136:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $136
80106b09:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106b0e:	e9 14 f6 ff ff       	jmp    80106127 <alltraps>

80106b13 <vector137>:
.globl vector137
vector137:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $137
80106b15:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106b1a:	e9 08 f6 ff ff       	jmp    80106127 <alltraps>

80106b1f <vector138>:
.globl vector138
vector138:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $138
80106b21:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106b26:	e9 fc f5 ff ff       	jmp    80106127 <alltraps>

80106b2b <vector139>:
.globl vector139
vector139:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $139
80106b2d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106b32:	e9 f0 f5 ff ff       	jmp    80106127 <alltraps>

80106b37 <vector140>:
.globl vector140
vector140:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $140
80106b39:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106b3e:	e9 e4 f5 ff ff       	jmp    80106127 <alltraps>

80106b43 <vector141>:
.globl vector141
vector141:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $141
80106b45:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106b4a:	e9 d8 f5 ff ff       	jmp    80106127 <alltraps>

80106b4f <vector142>:
.globl vector142
vector142:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $142
80106b51:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106b56:	e9 cc f5 ff ff       	jmp    80106127 <alltraps>

80106b5b <vector143>:
.globl vector143
vector143:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $143
80106b5d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106b62:	e9 c0 f5 ff ff       	jmp    80106127 <alltraps>

80106b67 <vector144>:
.globl vector144
vector144:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $144
80106b69:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106b6e:	e9 b4 f5 ff ff       	jmp    80106127 <alltraps>

80106b73 <vector145>:
.globl vector145
vector145:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $145
80106b75:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106b7a:	e9 a8 f5 ff ff       	jmp    80106127 <alltraps>

80106b7f <vector146>:
.globl vector146
vector146:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $146
80106b81:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106b86:	e9 9c f5 ff ff       	jmp    80106127 <alltraps>

80106b8b <vector147>:
.globl vector147
vector147:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $147
80106b8d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106b92:	e9 90 f5 ff ff       	jmp    80106127 <alltraps>

80106b97 <vector148>:
.globl vector148
vector148:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $148
80106b99:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106b9e:	e9 84 f5 ff ff       	jmp    80106127 <alltraps>

80106ba3 <vector149>:
.globl vector149
vector149:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $149
80106ba5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106baa:	e9 78 f5 ff ff       	jmp    80106127 <alltraps>

80106baf <vector150>:
.globl vector150
vector150:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $150
80106bb1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106bb6:	e9 6c f5 ff ff       	jmp    80106127 <alltraps>

80106bbb <vector151>:
.globl vector151
vector151:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $151
80106bbd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106bc2:	e9 60 f5 ff ff       	jmp    80106127 <alltraps>

80106bc7 <vector152>:
.globl vector152
vector152:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $152
80106bc9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106bce:	e9 54 f5 ff ff       	jmp    80106127 <alltraps>

80106bd3 <vector153>:
.globl vector153
vector153:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $153
80106bd5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106bda:	e9 48 f5 ff ff       	jmp    80106127 <alltraps>

80106bdf <vector154>:
.globl vector154
vector154:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $154
80106be1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106be6:	e9 3c f5 ff ff       	jmp    80106127 <alltraps>

80106beb <vector155>:
.globl vector155
vector155:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $155
80106bed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106bf2:	e9 30 f5 ff ff       	jmp    80106127 <alltraps>

80106bf7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $156
80106bf9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106bfe:	e9 24 f5 ff ff       	jmp    80106127 <alltraps>

80106c03 <vector157>:
.globl vector157
vector157:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $157
80106c05:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106c0a:	e9 18 f5 ff ff       	jmp    80106127 <alltraps>

80106c0f <vector158>:
.globl vector158
vector158:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $158
80106c11:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106c16:	e9 0c f5 ff ff       	jmp    80106127 <alltraps>

80106c1b <vector159>:
.globl vector159
vector159:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $159
80106c1d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106c22:	e9 00 f5 ff ff       	jmp    80106127 <alltraps>

80106c27 <vector160>:
.globl vector160
vector160:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $160
80106c29:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106c2e:	e9 f4 f4 ff ff       	jmp    80106127 <alltraps>

80106c33 <vector161>:
.globl vector161
vector161:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $161
80106c35:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106c3a:	e9 e8 f4 ff ff       	jmp    80106127 <alltraps>

80106c3f <vector162>:
.globl vector162
vector162:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $162
80106c41:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106c46:	e9 dc f4 ff ff       	jmp    80106127 <alltraps>

80106c4b <vector163>:
.globl vector163
vector163:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $163
80106c4d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106c52:	e9 d0 f4 ff ff       	jmp    80106127 <alltraps>

80106c57 <vector164>:
.globl vector164
vector164:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $164
80106c59:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106c5e:	e9 c4 f4 ff ff       	jmp    80106127 <alltraps>

80106c63 <vector165>:
.globl vector165
vector165:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $165
80106c65:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106c6a:	e9 b8 f4 ff ff       	jmp    80106127 <alltraps>

80106c6f <vector166>:
.globl vector166
vector166:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $166
80106c71:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106c76:	e9 ac f4 ff ff       	jmp    80106127 <alltraps>

80106c7b <vector167>:
.globl vector167
vector167:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $167
80106c7d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106c82:	e9 a0 f4 ff ff       	jmp    80106127 <alltraps>

80106c87 <vector168>:
.globl vector168
vector168:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $168
80106c89:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106c8e:	e9 94 f4 ff ff       	jmp    80106127 <alltraps>

80106c93 <vector169>:
.globl vector169
vector169:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $169
80106c95:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106c9a:	e9 88 f4 ff ff       	jmp    80106127 <alltraps>

80106c9f <vector170>:
.globl vector170
vector170:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $170
80106ca1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ca6:	e9 7c f4 ff ff       	jmp    80106127 <alltraps>

80106cab <vector171>:
.globl vector171
vector171:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $171
80106cad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106cb2:	e9 70 f4 ff ff       	jmp    80106127 <alltraps>

80106cb7 <vector172>:
.globl vector172
vector172:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $172
80106cb9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106cbe:	e9 64 f4 ff ff       	jmp    80106127 <alltraps>

80106cc3 <vector173>:
.globl vector173
vector173:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $173
80106cc5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106cca:	e9 58 f4 ff ff       	jmp    80106127 <alltraps>

80106ccf <vector174>:
.globl vector174
vector174:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $174
80106cd1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106cd6:	e9 4c f4 ff ff       	jmp    80106127 <alltraps>

80106cdb <vector175>:
.globl vector175
vector175:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $175
80106cdd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106ce2:	e9 40 f4 ff ff       	jmp    80106127 <alltraps>

80106ce7 <vector176>:
.globl vector176
vector176:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $176
80106ce9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106cee:	e9 34 f4 ff ff       	jmp    80106127 <alltraps>

80106cf3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $177
80106cf5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106cfa:	e9 28 f4 ff ff       	jmp    80106127 <alltraps>

80106cff <vector178>:
.globl vector178
vector178:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $178
80106d01:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106d06:	e9 1c f4 ff ff       	jmp    80106127 <alltraps>

80106d0b <vector179>:
.globl vector179
vector179:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $179
80106d0d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106d12:	e9 10 f4 ff ff       	jmp    80106127 <alltraps>

80106d17 <vector180>:
.globl vector180
vector180:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $180
80106d19:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106d1e:	e9 04 f4 ff ff       	jmp    80106127 <alltraps>

80106d23 <vector181>:
.globl vector181
vector181:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $181
80106d25:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106d2a:	e9 f8 f3 ff ff       	jmp    80106127 <alltraps>

80106d2f <vector182>:
.globl vector182
vector182:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $182
80106d31:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106d36:	e9 ec f3 ff ff       	jmp    80106127 <alltraps>

80106d3b <vector183>:
.globl vector183
vector183:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $183
80106d3d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106d42:	e9 e0 f3 ff ff       	jmp    80106127 <alltraps>

80106d47 <vector184>:
.globl vector184
vector184:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $184
80106d49:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106d4e:	e9 d4 f3 ff ff       	jmp    80106127 <alltraps>

80106d53 <vector185>:
.globl vector185
vector185:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $185
80106d55:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106d5a:	e9 c8 f3 ff ff       	jmp    80106127 <alltraps>

80106d5f <vector186>:
.globl vector186
vector186:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $186
80106d61:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106d66:	e9 bc f3 ff ff       	jmp    80106127 <alltraps>

80106d6b <vector187>:
.globl vector187
vector187:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $187
80106d6d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106d72:	e9 b0 f3 ff ff       	jmp    80106127 <alltraps>

80106d77 <vector188>:
.globl vector188
vector188:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $188
80106d79:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106d7e:	e9 a4 f3 ff ff       	jmp    80106127 <alltraps>

80106d83 <vector189>:
.globl vector189
vector189:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $189
80106d85:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106d8a:	e9 98 f3 ff ff       	jmp    80106127 <alltraps>

80106d8f <vector190>:
.globl vector190
vector190:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $190
80106d91:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106d96:	e9 8c f3 ff ff       	jmp    80106127 <alltraps>

80106d9b <vector191>:
.globl vector191
vector191:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $191
80106d9d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106da2:	e9 80 f3 ff ff       	jmp    80106127 <alltraps>

80106da7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $192
80106da9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106dae:	e9 74 f3 ff ff       	jmp    80106127 <alltraps>

80106db3 <vector193>:
.globl vector193
vector193:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $193
80106db5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106dba:	e9 68 f3 ff ff       	jmp    80106127 <alltraps>

80106dbf <vector194>:
.globl vector194
vector194:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $194
80106dc1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106dc6:	e9 5c f3 ff ff       	jmp    80106127 <alltraps>

80106dcb <vector195>:
.globl vector195
vector195:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $195
80106dcd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106dd2:	e9 50 f3 ff ff       	jmp    80106127 <alltraps>

80106dd7 <vector196>:
.globl vector196
vector196:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $196
80106dd9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106dde:	e9 44 f3 ff ff       	jmp    80106127 <alltraps>

80106de3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $197
80106de5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106dea:	e9 38 f3 ff ff       	jmp    80106127 <alltraps>

80106def <vector198>:
.globl vector198
vector198:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $198
80106df1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106df6:	e9 2c f3 ff ff       	jmp    80106127 <alltraps>

80106dfb <vector199>:
.globl vector199
vector199:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $199
80106dfd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106e02:	e9 20 f3 ff ff       	jmp    80106127 <alltraps>

80106e07 <vector200>:
.globl vector200
vector200:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $200
80106e09:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106e0e:	e9 14 f3 ff ff       	jmp    80106127 <alltraps>

80106e13 <vector201>:
.globl vector201
vector201:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $201
80106e15:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106e1a:	e9 08 f3 ff ff       	jmp    80106127 <alltraps>

80106e1f <vector202>:
.globl vector202
vector202:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $202
80106e21:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106e26:	e9 fc f2 ff ff       	jmp    80106127 <alltraps>

80106e2b <vector203>:
.globl vector203
vector203:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $203
80106e2d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106e32:	e9 f0 f2 ff ff       	jmp    80106127 <alltraps>

80106e37 <vector204>:
.globl vector204
vector204:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $204
80106e39:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106e3e:	e9 e4 f2 ff ff       	jmp    80106127 <alltraps>

80106e43 <vector205>:
.globl vector205
vector205:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $205
80106e45:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106e4a:	e9 d8 f2 ff ff       	jmp    80106127 <alltraps>

80106e4f <vector206>:
.globl vector206
vector206:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $206
80106e51:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106e56:	e9 cc f2 ff ff       	jmp    80106127 <alltraps>

80106e5b <vector207>:
.globl vector207
vector207:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $207
80106e5d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106e62:	e9 c0 f2 ff ff       	jmp    80106127 <alltraps>

80106e67 <vector208>:
.globl vector208
vector208:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $208
80106e69:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106e6e:	e9 b4 f2 ff ff       	jmp    80106127 <alltraps>

80106e73 <vector209>:
.globl vector209
vector209:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $209
80106e75:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106e7a:	e9 a8 f2 ff ff       	jmp    80106127 <alltraps>

80106e7f <vector210>:
.globl vector210
vector210:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $210
80106e81:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106e86:	e9 9c f2 ff ff       	jmp    80106127 <alltraps>

80106e8b <vector211>:
.globl vector211
vector211:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $211
80106e8d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106e92:	e9 90 f2 ff ff       	jmp    80106127 <alltraps>

80106e97 <vector212>:
.globl vector212
vector212:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $212
80106e99:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106e9e:	e9 84 f2 ff ff       	jmp    80106127 <alltraps>

80106ea3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $213
80106ea5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106eaa:	e9 78 f2 ff ff       	jmp    80106127 <alltraps>

80106eaf <vector214>:
.globl vector214
vector214:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $214
80106eb1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106eb6:	e9 6c f2 ff ff       	jmp    80106127 <alltraps>

80106ebb <vector215>:
.globl vector215
vector215:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $215
80106ebd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106ec2:	e9 60 f2 ff ff       	jmp    80106127 <alltraps>

80106ec7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $216
80106ec9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106ece:	e9 54 f2 ff ff       	jmp    80106127 <alltraps>

80106ed3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $217
80106ed5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106eda:	e9 48 f2 ff ff       	jmp    80106127 <alltraps>

80106edf <vector218>:
.globl vector218
vector218:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $218
80106ee1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106ee6:	e9 3c f2 ff ff       	jmp    80106127 <alltraps>

80106eeb <vector219>:
.globl vector219
vector219:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $219
80106eed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ef2:	e9 30 f2 ff ff       	jmp    80106127 <alltraps>

80106ef7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $220
80106ef9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106efe:	e9 24 f2 ff ff       	jmp    80106127 <alltraps>

80106f03 <vector221>:
.globl vector221
vector221:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $221
80106f05:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106f0a:	e9 18 f2 ff ff       	jmp    80106127 <alltraps>

80106f0f <vector222>:
.globl vector222
vector222:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $222
80106f11:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106f16:	e9 0c f2 ff ff       	jmp    80106127 <alltraps>

80106f1b <vector223>:
.globl vector223
vector223:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $223
80106f1d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106f22:	e9 00 f2 ff ff       	jmp    80106127 <alltraps>

80106f27 <vector224>:
.globl vector224
vector224:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $224
80106f29:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106f2e:	e9 f4 f1 ff ff       	jmp    80106127 <alltraps>

80106f33 <vector225>:
.globl vector225
vector225:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $225
80106f35:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106f3a:	e9 e8 f1 ff ff       	jmp    80106127 <alltraps>

80106f3f <vector226>:
.globl vector226
vector226:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $226
80106f41:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106f46:	e9 dc f1 ff ff       	jmp    80106127 <alltraps>

80106f4b <vector227>:
.globl vector227
vector227:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $227
80106f4d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106f52:	e9 d0 f1 ff ff       	jmp    80106127 <alltraps>

80106f57 <vector228>:
.globl vector228
vector228:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $228
80106f59:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106f5e:	e9 c4 f1 ff ff       	jmp    80106127 <alltraps>

80106f63 <vector229>:
.globl vector229
vector229:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $229
80106f65:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106f6a:	e9 b8 f1 ff ff       	jmp    80106127 <alltraps>

80106f6f <vector230>:
.globl vector230
vector230:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $230
80106f71:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106f76:	e9 ac f1 ff ff       	jmp    80106127 <alltraps>

80106f7b <vector231>:
.globl vector231
vector231:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $231
80106f7d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106f82:	e9 a0 f1 ff ff       	jmp    80106127 <alltraps>

80106f87 <vector232>:
.globl vector232
vector232:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $232
80106f89:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106f8e:	e9 94 f1 ff ff       	jmp    80106127 <alltraps>

80106f93 <vector233>:
.globl vector233
vector233:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $233
80106f95:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106f9a:	e9 88 f1 ff ff       	jmp    80106127 <alltraps>

80106f9f <vector234>:
.globl vector234
vector234:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $234
80106fa1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106fa6:	e9 7c f1 ff ff       	jmp    80106127 <alltraps>

80106fab <vector235>:
.globl vector235
vector235:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $235
80106fad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106fb2:	e9 70 f1 ff ff       	jmp    80106127 <alltraps>

80106fb7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $236
80106fb9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106fbe:	e9 64 f1 ff ff       	jmp    80106127 <alltraps>

80106fc3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $237
80106fc5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106fca:	e9 58 f1 ff ff       	jmp    80106127 <alltraps>

80106fcf <vector238>:
.globl vector238
vector238:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $238
80106fd1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106fd6:	e9 4c f1 ff ff       	jmp    80106127 <alltraps>

80106fdb <vector239>:
.globl vector239
vector239:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $239
80106fdd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106fe2:	e9 40 f1 ff ff       	jmp    80106127 <alltraps>

80106fe7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $240
80106fe9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106fee:	e9 34 f1 ff ff       	jmp    80106127 <alltraps>

80106ff3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $241
80106ff5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106ffa:	e9 28 f1 ff ff       	jmp    80106127 <alltraps>

80106fff <vector242>:
.globl vector242
vector242:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $242
80107001:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107006:	e9 1c f1 ff ff       	jmp    80106127 <alltraps>

8010700b <vector243>:
.globl vector243
vector243:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $243
8010700d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107012:	e9 10 f1 ff ff       	jmp    80106127 <alltraps>

80107017 <vector244>:
.globl vector244
vector244:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $244
80107019:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010701e:	e9 04 f1 ff ff       	jmp    80106127 <alltraps>

80107023 <vector245>:
.globl vector245
vector245:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $245
80107025:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010702a:	e9 f8 f0 ff ff       	jmp    80106127 <alltraps>

8010702f <vector246>:
.globl vector246
vector246:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $246
80107031:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107036:	e9 ec f0 ff ff       	jmp    80106127 <alltraps>

8010703b <vector247>:
.globl vector247
vector247:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $247
8010703d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107042:	e9 e0 f0 ff ff       	jmp    80106127 <alltraps>

80107047 <vector248>:
.globl vector248
vector248:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $248
80107049:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010704e:	e9 d4 f0 ff ff       	jmp    80106127 <alltraps>

80107053 <vector249>:
.globl vector249
vector249:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $249
80107055:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010705a:	e9 c8 f0 ff ff       	jmp    80106127 <alltraps>

8010705f <vector250>:
.globl vector250
vector250:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $250
80107061:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107066:	e9 bc f0 ff ff       	jmp    80106127 <alltraps>

8010706b <vector251>:
.globl vector251
vector251:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $251
8010706d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107072:	e9 b0 f0 ff ff       	jmp    80106127 <alltraps>

80107077 <vector252>:
.globl vector252
vector252:
  pushl $0
80107077:	6a 00                	push   $0x0
  pushl $252
80107079:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010707e:	e9 a4 f0 ff ff       	jmp    80106127 <alltraps>

80107083 <vector253>:
.globl vector253
vector253:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $253
80107085:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010708a:	e9 98 f0 ff ff       	jmp    80106127 <alltraps>

8010708f <vector254>:
.globl vector254
vector254:
  pushl $0
8010708f:	6a 00                	push   $0x0
  pushl $254
80107091:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107096:	e9 8c f0 ff ff       	jmp    80106127 <alltraps>

8010709b <vector255>:
.globl vector255
vector255:
  pushl $0
8010709b:	6a 00                	push   $0x0
  pushl $255
8010709d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801070a2:	e9 80 f0 ff ff       	jmp    80106127 <alltraps>
801070a7:	66 90                	xchg   %ax,%ax
801070a9:	66 90                	xchg   %ax,%ax
801070ab:	66 90                	xchg   %ax,%ax
801070ad:	66 90                	xchg   %ax,%ax
801070af:	90                   	nop

801070b0 <walkpgdir>:

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
    pde_t *pde;
    pte_t *pgtab;

    pde = &pgdir[PDX(va)];
801070b6:	89 d3                	mov    %edx,%ebx
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801070b8:	89 d7                	mov    %edx,%edi
    pde = &pgdir[PDX(va)];
801070ba:	c1 eb 16             	shr    $0x16,%ebx
801070bd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801070c0:	83 ec 0c             	sub    $0xc,%esp
    if (*pde & PTE_P) {
801070c3:	8b 06                	mov    (%esi),%eax
801070c5:	a8 01                	test   $0x1,%al
801070c7:	74 27                	je     801070f0 <walkpgdir+0x40>
        pgtab = (pte_t *) P2V(PTE_ADDR(*pde));
801070c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070ce:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
        // The permissions here are overly generous, but they can
        // be further restricted by the permissions in the page table
        // entries, if necessary.
        *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
    }
    return &pgtab[PTX(va)];
801070d4:	c1 ef 0a             	shr    $0xa,%edi
}
801070d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return &pgtab[PTX(va)];
801070da:	89 fa                	mov    %edi,%edx
801070dc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801070e2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801070e5:	5b                   	pop    %ebx
801070e6:	5e                   	pop    %esi
801070e7:	5f                   	pop    %edi
801070e8:	5d                   	pop    %ebp
801070e9:	c3                   	ret    
801070ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (!alloc || (pgtab = (pte_t *) kalloc()) == 0)
801070f0:	85 c9                	test   %ecx,%ecx
801070f2:	74 2c                	je     80107120 <walkpgdir+0x70>
801070f4:	e8 37 ba ff ff       	call   80102b30 <kalloc>
801070f9:	85 c0                	test   %eax,%eax
801070fb:	89 c3                	mov    %eax,%ebx
801070fd:	74 21                	je     80107120 <walkpgdir+0x70>
        memset(pgtab, 0, PGSIZE);
801070ff:	83 ec 04             	sub    $0x4,%esp
80107102:	68 00 10 00 00       	push   $0x1000
80107107:	6a 00                	push   $0x0
80107109:	50                   	push   %eax
8010710a:	e8 01 dd ff ff       	call   80104e10 <memset>
        *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010710f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107115:	83 c4 10             	add    $0x10,%esp
80107118:	83 c8 07             	or     $0x7,%eax
8010711b:	89 06                	mov    %eax,(%esi)
8010711d:	eb b5                	jmp    801070d4 <walkpgdir+0x24>
8010711f:	90                   	nop
}
80107120:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return 0;
80107123:	31 c0                	xor    %eax,%eax
}
80107125:	5b                   	pop    %ebx
80107126:	5e                   	pop    %esi
80107127:	5f                   	pop    %edi
80107128:	5d                   	pop    %ebp
80107129:	c3                   	ret    
8010712a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107130 <mappages>:

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm) {
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	57                   	push   %edi
80107134:	56                   	push   %esi
80107135:	53                   	push   %ebx
    char *a, *last;
    pte_t *pte;

    a = (char *) PGROUNDDOWN((uint) va);
80107136:	89 d3                	mov    %edx,%ebx
80107138:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm) {
8010713e:	83 ec 1c             	sub    $0x1c,%esp
80107141:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    last = (char *) PGROUNDDOWN(((uint) va) + size - 1);
80107144:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107148:	8b 7d 08             	mov    0x8(%ebp),%edi
8010714b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107150:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for (;;) {
        if ((pte = walkpgdir(pgdir, a, 1)) == 0)
            return -1;
        if (*pte & PTE_P)
            panic("remap");
        *pte = pa | perm | PTE_P;
80107153:	8b 45 0c             	mov    0xc(%ebp),%eax
80107156:	29 df                	sub    %ebx,%edi
80107158:	83 c8 01             	or     $0x1,%eax
8010715b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010715e:	eb 15                	jmp    80107175 <mappages+0x45>
        if (*pte & PTE_P)
80107160:	f6 00 01             	testb  $0x1,(%eax)
80107163:	75 45                	jne    801071aa <mappages+0x7a>
        *pte = pa | perm | PTE_P;
80107165:	0b 75 dc             	or     -0x24(%ebp),%esi
        if (a == last)
80107168:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
        *pte = pa | perm | PTE_P;
8010716b:	89 30                	mov    %esi,(%eax)
        if (a == last)
8010716d:	74 31                	je     801071a0 <mappages+0x70>
            break;
        a += PGSIZE;
8010716f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
        if ((pte = walkpgdir(pgdir, a, 1)) == 0)
80107175:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107178:	b9 01 00 00 00       	mov    $0x1,%ecx
8010717d:	89 da                	mov    %ebx,%edx
8010717f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107182:	e8 29 ff ff ff       	call   801070b0 <walkpgdir>
80107187:	85 c0                	test   %eax,%eax
80107189:	75 d5                	jne    80107160 <mappages+0x30>
        pa += PGSIZE;
    }
    return 0;
}
8010718b:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
8010718e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107193:	5b                   	pop    %ebx
80107194:	5e                   	pop    %esi
80107195:	5f                   	pop    %edi
80107196:	5d                   	pop    %ebp
80107197:	c3                   	ret    
80107198:	90                   	nop
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801071a3:	31 c0                	xor    %eax,%eax
}
801071a5:	5b                   	pop    %ebx
801071a6:	5e                   	pop    %esi
801071a7:	5f                   	pop    %edi
801071a8:	5d                   	pop    %ebp
801071a9:	c3                   	ret    
            panic("remap");
801071aa:	83 ec 0c             	sub    $0xc,%esp
801071ad:	68 dc 8a 10 80       	push   $0x80108adc
801071b2:	e8 d9 91 ff ff       	call   80100390 <panic>
801071b7:	89 f6                	mov    %esi,%esi
801071b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801071c0:	55                   	push   %ebp
801071c1:	89 e5                	mov    %esp,%ebp
801071c3:	57                   	push   %edi
801071c4:	56                   	push   %esi
801071c5:	53                   	push   %ebx
    uint a, pa;

    if (newsz >= oldsz)
        return oldsz;

    a = PGROUNDUP(newsz);
801071c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801071cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801071d2:	83 ec 1c             	sub    $0x1c,%esp
801071d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for (; a < oldsz; a += PGSIZE) {
801071d8:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801071da:	89 55 e0             	mov    %edx,-0x20(%ebp)
801071dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    for (; a < oldsz; a += PGSIZE) {
801071e0:	72 17                	jb     801071f9 <deallocuvm.part.0+0x39>
801071e2:	eb 3e                	jmp    80107222 <deallocuvm.part.0+0x62>
801071e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pte = walkpgdir(pgdir, (char *) a, 0);
        if (!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if ((*pte & PTE_P) != 0) {
801071e8:	8b 00                	mov    (%eax),%eax
801071ea:	a8 01                	test   $0x1,%al
801071ec:	75 42                	jne    80107230 <deallocuvm.part.0+0x70>
    for (; a < oldsz; a += PGSIZE) {
801071ee:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071f4:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
801071f7:	73 29                	jae    80107222 <deallocuvm.part.0+0x62>
        pte = walkpgdir(pgdir, (char *) a, 0);
801071f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071fc:	31 c9                	xor    %ecx,%ecx
801071fe:	89 da                	mov    %ebx,%edx
80107200:	e8 ab fe ff ff       	call   801070b0 <walkpgdir>
        if (!pte)
80107205:	85 c0                	test   %eax,%eax
        pte = walkpgdir(pgdir, (char *) a, 0);
80107207:	89 c6                	mov    %eax,%esi
        if (!pte)
80107209:	75 dd                	jne    801071e8 <deallocuvm.part.0+0x28>
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010720b:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107211:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
    for (; a < oldsz; a += PGSIZE) {
80107217:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010721d:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80107220:	72 d7                	jb     801071f9 <deallocuvm.part.0+0x39>
            }
            *pte = 0;
        }
    }
    return newsz;
}
80107222:	8b 45 d8             	mov    -0x28(%ebp),%eax
80107225:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107228:	5b                   	pop    %ebx
80107229:	5e                   	pop    %esi
8010722a:	5f                   	pop    %edi
8010722b:	5d                   	pop    %ebp
8010722c:	c3                   	ret    
8010722d:	8d 76 00             	lea    0x0(%esi),%esi
            if (pa == 0) {
80107230:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107235:	74 77                	je     801072ae <deallocuvm.part.0+0xee>
            kfree(v);
80107237:	83 ec 0c             	sub    $0xc,%esp
            char *v = P2V(pa);
8010723a:	05 00 00 00 80       	add    $0x80000000,%eax
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
8010723f:	31 ff                	xor    %edi,%edi
            kfree(v);
80107241:	50                   	push   %eax
80107242:	e8 39 b7 ff ff       	call   80102980 <kfree>
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107247:	89 75 dc             	mov    %esi,-0x24(%ebp)
            kfree(v);
8010724a:	83 c4 10             	add    $0x10,%esp
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
8010724d:	89 fe                	mov    %edi,%esi
8010724f:	eb 0f                	jmp    80107260 <deallocuvm.part.0+0xa0>
80107251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107258:	83 c6 01             	add    $0x1,%esi
8010725b:	83 fe 10             	cmp    $0x10,%esi
8010725e:	74 40                	je     801072a0 <deallocuvm.part.0+0xe0>
                    if (myproc()->ram_monitor[i].used == 1 && myproc()->ram_monitor[i].p_va == a &&
80107260:	8d 7e 08             	lea    0x8(%esi),%edi
80107263:	e8 b8 cc ff ff       	call   80103f20 <myproc>
80107268:	c1 e7 04             	shl    $0x4,%edi
8010726b:	83 3c 38 01          	cmpl   $0x1,(%eax,%edi,1)
8010726f:	75 e7                	jne    80107258 <deallocuvm.part.0+0x98>
80107271:	e8 aa cc ff ff       	call   80103f20 <myproc>
80107276:	39 5c 38 08          	cmp    %ebx,0x8(%eax,%edi,1)
8010727a:	75 dc                	jne    80107258 <deallocuvm.part.0+0x98>
                        myproc()->ram_monitor[i].pgdir == pgdir)
8010727c:	e8 9f cc ff ff       	call   80103f20 <myproc>
                    if (myproc()->ram_monitor[i].used == 1 && myproc()->ram_monitor[i].p_va == a &&
80107281:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107284:	3b 54 38 04          	cmp    0x4(%eax,%edi,1),%edx
80107288:	75 ce                	jne    80107258 <deallocuvm.part.0+0x98>
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
8010728a:	83 c6 01             	add    $0x1,%esi
                        myproc()->ram_monitor[i].used = 0;
8010728d:	e8 8e cc ff ff       	call   80103f20 <myproc>
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107292:	83 fe 10             	cmp    $0x10,%esi
                        myproc()->ram_monitor[i].used = 0;
80107295:	c7 04 38 00 00 00 00 	movl   $0x0,(%eax,%edi,1)
                for (int i = 0; i < MAX_PYSC_PAGES; i++) {
8010729c:	75 c2                	jne    80107260 <deallocuvm.part.0+0xa0>
8010729e:	66 90                	xchg   %ax,%ax
801072a0:	8b 75 dc             	mov    -0x24(%ebp),%esi
            *pte = 0;
801072a3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801072a9:	e9 40 ff ff ff       	jmp    801071ee <deallocuvm.part.0+0x2e>
                panic("kfree");
801072ae:	83 ec 0c             	sub    $0xc,%esp
801072b1:	68 aa 83 10 80       	push   $0x801083aa
801072b6:	e8 d5 90 ff ff       	call   80100390 <panic>
801072bb:	90                   	nop
801072bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801072c0 <seginit>:
seginit(void) {
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	83 ec 18             	sub    $0x18,%esp
    c = &cpus[cpuid()];
801072c6:	e8 35 cc ff ff       	call   80103f00 <cpuid>
801072cb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801072d1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801072d6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
    c->gdt[SEG_KCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, 0);
801072da:	c7 80 f8 47 11 80 ff 	movl   $0xffff,-0x7feeb808(%eax)
801072e1:	ff 00 00 
801072e4:	c7 80 fc 47 11 80 00 	movl   $0xcf9a00,-0x7feeb804(%eax)
801072eb:	9a cf 00 
    c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801072ee:	c7 80 00 48 11 80 ff 	movl   $0xffff,-0x7feeb800(%eax)
801072f5:	ff 00 00 
801072f8:	c7 80 04 48 11 80 00 	movl   $0xcf9200,-0x7feeb7fc(%eax)
801072ff:	92 cf 00 
    c->gdt[SEG_UCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, DPL_USER);
80107302:	c7 80 08 48 11 80 ff 	movl   $0xffff,-0x7feeb7f8(%eax)
80107309:	ff 00 00 
8010730c:	c7 80 0c 48 11 80 00 	movl   $0xcffa00,-0x7feeb7f4(%eax)
80107313:	fa cf 00 
    c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107316:	c7 80 10 48 11 80 ff 	movl   $0xffff,-0x7feeb7f0(%eax)
8010731d:	ff 00 00 
80107320:	c7 80 14 48 11 80 00 	movl   $0xcff200,-0x7feeb7ec(%eax)
80107327:	f2 cf 00 
    lgdt(c->gdt, sizeof(c->gdt));
8010732a:	05 f0 47 11 80       	add    $0x801147f0,%eax
  pd[1] = (uint)p;
8010732f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107333:	c1 e8 10             	shr    $0x10,%eax
80107336:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010733a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010733d:	0f 01 10             	lgdtl  (%eax)
}
80107340:	c9                   	leave  
80107341:	c3                   	ret    
80107342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107350 <switchkvm>:
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107350:	a1 a4 f9 11 80       	mov    0x8011f9a4,%eax
switchkvm(void) {
80107355:	55                   	push   %ebp
80107356:	89 e5                	mov    %esp,%ebp
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107358:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010735d:	0f 22 d8             	mov    %eax,%cr3
}
80107360:	5d                   	pop    %ebp
80107361:	c3                   	ret    
80107362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <switchuvm>:
switchuvm(struct proc *p) {
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
80107376:	83 ec 1c             	sub    $0x1c,%esp
80107379:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (p == 0)
8010737c:	85 db                	test   %ebx,%ebx
8010737e:	0f 84 cb 00 00 00    	je     8010744f <switchuvm+0xdf>
    if (p->kstack == 0)
80107384:	8b 43 08             	mov    0x8(%ebx),%eax
80107387:	85 c0                	test   %eax,%eax
80107389:	0f 84 da 00 00 00    	je     80107469 <switchuvm+0xf9>
    if (p->pgdir == 0)
8010738f:	8b 43 04             	mov    0x4(%ebx),%eax
80107392:	85 c0                	test   %eax,%eax
80107394:	0f 84 c2 00 00 00    	je     8010745c <switchuvm+0xec>
    pushcli();
8010739a:	e8 b1 d8 ff ff       	call   80104c50 <pushcli>
    mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010739f:	e8 dc ca ff ff       	call   80103e80 <mycpu>
801073a4:	89 c6                	mov    %eax,%esi
801073a6:	e8 d5 ca ff ff       	call   80103e80 <mycpu>
801073ab:	89 c7                	mov    %eax,%edi
801073ad:	e8 ce ca ff ff       	call   80103e80 <mycpu>
801073b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073b5:	83 c7 08             	add    $0x8,%edi
801073b8:	e8 c3 ca ff ff       	call   80103e80 <mycpu>
801073bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801073c0:	83 c0 08             	add    $0x8,%eax
801073c3:	ba 67 00 00 00       	mov    $0x67,%edx
801073c8:	c1 e8 18             	shr    $0x18,%eax
801073cb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801073d2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801073d9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
    mycpu()->ts.iomb = (ushort) 0xFFFF;
801073df:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073e4:	83 c1 08             	add    $0x8,%ecx
801073e7:	c1 e9 10             	shr    $0x10,%ecx
801073ea:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801073f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801073f5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
    mycpu()->ts.ss0 = SEG_KDATA << 3;
801073fc:	be 10 00 00 00       	mov    $0x10,%esi
    mycpu()->gdt[SEG_TSS].s = 0;
80107401:	e8 7a ca ff ff       	call   80103e80 <mycpu>
80107406:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
    mycpu()->ts.ss0 = SEG_KDATA << 3;
8010740d:	e8 6e ca ff ff       	call   80103e80 <mycpu>
80107412:	66 89 70 10          	mov    %si,0x10(%eax)
    mycpu()->ts.esp0 = (uint) p->kstack + KSTACKSIZE;
80107416:	8b 73 08             	mov    0x8(%ebx),%esi
80107419:	e8 62 ca ff ff       	call   80103e80 <mycpu>
8010741e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107424:	89 70 0c             	mov    %esi,0xc(%eax)
    mycpu()->ts.iomb = (ushort) 0xFFFF;
80107427:	e8 54 ca ff ff       	call   80103e80 <mycpu>
8010742c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107430:	b8 28 00 00 00       	mov    $0x28,%eax
80107435:	0f 00 d8             	ltr    %ax
    lcr3(V2P(p->pgdir));  // switch to process's address space
80107438:	8b 43 04             	mov    0x4(%ebx),%eax
8010743b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107440:	0f 22 d8             	mov    %eax,%cr3
}
80107443:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107446:	5b                   	pop    %ebx
80107447:	5e                   	pop    %esi
80107448:	5f                   	pop    %edi
80107449:	5d                   	pop    %ebp
    popcli();
8010744a:	e9 01 d9 ff ff       	jmp    80104d50 <popcli>
        panic("switchuvm: no process");
8010744f:	83 ec 0c             	sub    $0xc,%esp
80107452:	68 e2 8a 10 80       	push   $0x80108ae2
80107457:	e8 34 8f ff ff       	call   80100390 <panic>
        panic("switchuvm: no pgdir");
8010745c:	83 ec 0c             	sub    $0xc,%esp
8010745f:	68 0d 8b 10 80       	push   $0x80108b0d
80107464:	e8 27 8f ff ff       	call   80100390 <panic>
        panic("switchuvm: no kstack");
80107469:	83 ec 0c             	sub    $0xc,%esp
8010746c:	68 f8 8a 10 80       	push   $0x80108af8
80107471:	e8 1a 8f ff ff       	call   80100390 <panic>
80107476:	8d 76 00             	lea    0x0(%esi),%esi
80107479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107480 <inituvm>:
inituvm(pde_t *pgdir, char *init, uint sz) {
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
80107486:	83 ec 1c             	sub    $0x1c,%esp
80107489:	8b 75 10             	mov    0x10(%ebp),%esi
8010748c:	8b 45 08             	mov    0x8(%ebp),%eax
8010748f:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if (sz >= PGSIZE)
80107492:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
inituvm(pde_t *pgdir, char *init, uint sz) {
80107498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (sz >= PGSIZE)
8010749b:	77 49                	ja     801074e6 <inituvm+0x66>
    mem = kalloc();
8010749d:	e8 8e b6 ff ff       	call   80102b30 <kalloc>
    memset(mem, 0, PGSIZE);
801074a2:	83 ec 04             	sub    $0x4,%esp
    mem = kalloc();
801074a5:	89 c3                	mov    %eax,%ebx
    memset(mem, 0, PGSIZE);
801074a7:	68 00 10 00 00       	push   $0x1000
801074ac:	6a 00                	push   $0x0
801074ae:	50                   	push   %eax
801074af:	e8 5c d9 ff ff       	call   80104e10 <memset>
    mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W | PTE_U);
801074b4:	58                   	pop    %eax
801074b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074c0:	5a                   	pop    %edx
801074c1:	6a 06                	push   $0x6
801074c3:	50                   	push   %eax
801074c4:	31 d2                	xor    %edx,%edx
801074c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074c9:	e8 62 fc ff ff       	call   80107130 <mappages>
    memmove(mem, init, sz);
801074ce:	89 75 10             	mov    %esi,0x10(%ebp)
801074d1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801074d4:	83 c4 10             	add    $0x10,%esp
801074d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801074da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074dd:	5b                   	pop    %ebx
801074de:	5e                   	pop    %esi
801074df:	5f                   	pop    %edi
801074e0:	5d                   	pop    %ebp
    memmove(mem, init, sz);
801074e1:	e9 da d9 ff ff       	jmp    80104ec0 <memmove>
        panic("inituvm: more than a page");
801074e6:	83 ec 0c             	sub    $0xc,%esp
801074e9:	68 21 8b 10 80       	push   $0x80108b21
801074ee:	e8 9d 8e ff ff       	call   80100390 <panic>
801074f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107500 <loaduvm>:
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz) {
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	57                   	push   %edi
80107504:	56                   	push   %esi
80107505:	53                   	push   %ebx
80107506:	83 ec 0c             	sub    $0xc,%esp
    if ((uint) addr % PGSIZE != 0)
80107509:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107510:	0f 85 91 00 00 00    	jne    801075a7 <loaduvm+0xa7>
    for (i = 0; i < sz; i += PGSIZE) {
80107516:	8b 75 18             	mov    0x18(%ebp),%esi
80107519:	31 db                	xor    %ebx,%ebx
8010751b:	85 f6                	test   %esi,%esi
8010751d:	75 1a                	jne    80107539 <loaduvm+0x39>
8010751f:	eb 6f                	jmp    80107590 <loaduvm+0x90>
80107521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107528:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010752e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107534:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107537:	76 57                	jbe    80107590 <loaduvm+0x90>
        if ((pte = walkpgdir(pgdir, addr + i, 0)) == 0)
80107539:	8b 55 0c             	mov    0xc(%ebp),%edx
8010753c:	8b 45 08             	mov    0x8(%ebp),%eax
8010753f:	31 c9                	xor    %ecx,%ecx
80107541:	01 da                	add    %ebx,%edx
80107543:	e8 68 fb ff ff       	call   801070b0 <walkpgdir>
80107548:	85 c0                	test   %eax,%eax
8010754a:	74 4e                	je     8010759a <loaduvm+0x9a>
        pa = PTE_ADDR(*pte);
8010754c:	8b 00                	mov    (%eax),%eax
        if (readi(ip, P2V(pa), offset + i, n) != n)
8010754e:	8b 4d 14             	mov    0x14(%ebp),%ecx
        if (sz - i < PGSIZE)
80107551:	bf 00 10 00 00       	mov    $0x1000,%edi
        pa = PTE_ADDR(*pte);
80107556:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        if (sz - i < PGSIZE)
8010755b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107561:	0f 46 fe             	cmovbe %esi,%edi
        if (readi(ip, P2V(pa), offset + i, n) != n)
80107564:	01 d9                	add    %ebx,%ecx
80107566:	05 00 00 00 80       	add    $0x80000000,%eax
8010756b:	57                   	push   %edi
8010756c:	51                   	push   %ecx
8010756d:	50                   	push   %eax
8010756e:	ff 75 10             	pushl  0x10(%ebp)
80107571:	e8 5a a4 ff ff       	call   801019d0 <readi>
80107576:	83 c4 10             	add    $0x10,%esp
80107579:	39 f8                	cmp    %edi,%eax
8010757b:	74 ab                	je     80107528 <loaduvm+0x28>
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
80107580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107590:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107593:	31 c0                	xor    %eax,%eax
}
80107595:	5b                   	pop    %ebx
80107596:	5e                   	pop    %esi
80107597:	5f                   	pop    %edi
80107598:	5d                   	pop    %ebp
80107599:	c3                   	ret    
            panic("loaduvm: address should exist");
8010759a:	83 ec 0c             	sub    $0xc,%esp
8010759d:	68 3b 8b 10 80       	push   $0x80108b3b
801075a2:	e8 e9 8d ff ff       	call   80100390 <panic>
        panic("loaduvm: addr must be page aligned");
801075a7:	83 ec 0c             	sub    $0xc,%esp
801075aa:	68 d4 8b 10 80       	push   $0x80108bd4
801075af:	e8 dc 8d ff ff       	call   80100390 <panic>
801075b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075c0 <set_flag2>:
set_flag2(uint va, pde_t *pgdir, int flag, int on) {
801075c0:	55                   	push   %ebp
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
801075c1:	31 c9                	xor    %ecx,%ecx
set_flag2(uint va, pde_t *pgdir, int flag, int on) {
801075c3:	89 e5                	mov    %esp,%ebp
801075c5:	56                   	push   %esi
801075c6:	53                   	push   %ebx
801075c7:	8b 75 0c             	mov    0xc(%ebp),%esi
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
801075ca:	8b 55 08             	mov    0x8(%ebp),%edx
set_flag2(uint va, pde_t *pgdir, int flag, int on) {
801075cd:	8b 5d 10             	mov    0x10(%ebp),%ebx
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
801075d0:	89 f0                	mov    %esi,%eax
801075d2:	e8 d9 fa ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
801075d7:	85 c0                	test   %eax,%eax
801075d9:	74 23                	je     801075fe <set_flag2+0x3e>
801075db:	8b 08                	mov    (%eax),%ecx
        *pte = *pte & (~flag);
801075dd:	89 da                	mov    %ebx,%edx
801075df:	f7 d3                	not    %ebx
801075e1:	09 ca                	or     %ecx,%edx
801075e3:	21 cb                	and    %ecx,%ebx
801075e5:	8b 4d 14             	mov    0x14(%ebp),%ecx
801075e8:	85 c9                	test   %ecx,%ecx
801075ea:	0f 45 da             	cmovne %edx,%ebx
    lcr3(V2P(pgdir));
801075ed:	81 c6 00 00 00 80    	add    $0x80000000,%esi
        *pte = *pte & (~flag);
801075f3:	89 18                	mov    %ebx,(%eax)
801075f5:	0f 22 de             	mov    %esi,%cr3
    return 0;
801075f8:	31 c0                	xor    %eax,%eax
}
801075fa:	5b                   	pop    %ebx
801075fb:	5e                   	pop    %esi
801075fc:	5d                   	pop    %ebp
801075fd:	c3                   	ret    
    if (!pte) return -1;
801075fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107603:	eb f5                	jmp    801075fa <set_flag2+0x3a>
80107605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107610 <get_free_ram_idx>:
int get_free_ram_idx() {
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	53                   	push   %ebx
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107614:	31 db                	xor    %ebx,%ebx
int get_free_ram_idx() {
80107616:	83 ec 04             	sub    $0x4,%esp
80107619:	eb 0d                	jmp    80107628 <get_free_ram_idx+0x18>
8010761b:	90                   	nop
8010761c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107620:	83 c3 01             	add    $0x1,%ebx
80107623:	83 fb 10             	cmp    $0x10,%ebx
80107626:	74 20                	je     80107648 <get_free_ram_idx+0x38>
        if (myproc()->ram_monitor[i].used == 0)
80107628:	e8 f3 c8 ff ff       	call   80103f20 <myproc>
8010762d:	8d 53 08             	lea    0x8(%ebx),%edx
80107630:	c1 e2 04             	shl    $0x4,%edx
80107633:	8b 04 10             	mov    (%eax,%edx,1),%eax
80107636:	85 c0                	test   %eax,%eax
80107638:	75 e6                	jne    80107620 <get_free_ram_idx+0x10>
}
8010763a:	83 c4 04             	add    $0x4,%esp
8010763d:	89 d8                	mov    %ebx,%eax
8010763f:	5b                   	pop    %ebx
80107640:	5d                   	pop    %ebp
80107641:	c3                   	ret    
80107642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80107648:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010764d:	83 c4 04             	add    $0x4,%esp
80107650:	89 d8                	mov    %ebx,%eax
80107652:	5b                   	pop    %ebx
80107653:	5d                   	pop    %ebp
80107654:	c3                   	ret    
80107655:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107660 <add2ram>:
void add2ram(pde_t *pgdir, uint p_va) {
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	56                   	push   %esi
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107664:	31 f6                	xor    %esi,%esi
void add2ram(pde_t *pgdir, uint p_va) {
80107666:	53                   	push   %ebx
80107667:	eb 0f                	jmp    80107678 <add2ram+0x18>
80107669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107670:	83 c6 01             	add    $0x1,%esi
80107673:	83 fe 10             	cmp    $0x10,%esi
80107676:	74 58                	je     801076d0 <add2ram+0x70>
        if (myproc()->ram_monitor[i].used == 0)
80107678:	8d 5e 08             	lea    0x8(%esi),%ebx
8010767b:	e8 a0 c8 ff ff       	call   80103f20 <myproc>
80107680:	c1 e3 04             	shl    $0x4,%ebx
80107683:	8b 04 18             	mov    (%eax,%ebx,1),%eax
80107686:	85 c0                	test   %eax,%eax
80107688:	75 e6                	jne    80107670 <add2ram+0x10>
    myproc()->ram_monitor[idx].used = 1;
8010768a:	e8 91 c8 ff ff       	call   80103f20 <myproc>
8010768f:	c7 04 18 01 00 00 00 	movl   $0x1,(%eax,%ebx,1)
    myproc()->ram_monitor[idx].pgdir = pgdir;
80107696:	e8 85 c8 ff ff       	call   80103f20 <myproc>
8010769b:	8b 55 08             	mov    0x8(%ebp),%edx
8010769e:	89 54 18 04          	mov    %edx,0x4(%eax,%ebx,1)
    myproc()->ram_monitor[idx].p_va = p_va;
801076a2:	e8 79 c8 ff ff       	call   80103f20 <myproc>
801076a7:	8b 55 0c             	mov    0xc(%ebp),%edx
801076aa:	89 54 18 08          	mov    %edx,0x8(%eax,%ebx,1)
    myproc()->last_in_queue++;
801076ae:	e8 6d c8 ff ff       	call   80103f20 <myproc>
801076b3:	83 80 84 02 00 00 01 	addl   $0x1,0x284(%eax)
    myproc()->ram_monitor[idx].place_in_queue = myproc()->last_in_queue;
801076ba:	e8 61 c8 ff ff       	call   80103f20 <myproc>
801076bf:	89 c6                	mov    %eax,%esi
801076c1:	e8 5a c8 ff ff       	call   80103f20 <myproc>
801076c6:	8b 96 84 02 00 00    	mov    0x284(%esi),%edx
801076cc:	89 54 18 0c          	mov    %edx,0xc(%eax,%ebx,1)
}
801076d0:	5b                   	pop    %ebx
801076d1:	5e                   	pop    %esi
801076d2:	5d                   	pop    %ebp
801076d3:	c3                   	ret    
801076d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801076da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801076e0 <select_LIFO>:
int select_LIFO() {
801076e0:	55                   	push   %ebp
801076e1:	89 e5                	mov    %esp,%ebp
801076e3:	57                   	push   %edi
801076e4:	56                   	push   %esi
801076e5:	53                   	push   %ebx
    uint loadOrder = 0;
801076e6:	31 f6                	xor    %esi,%esi
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
801076e8:	31 ff                	xor    %edi,%edi
int select_LIFO() {
801076ea:	83 ec 1c             	sub    $0x1c,%esp
    int pageIndex = -1;
801076ed:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
801076f4:	eb 12                	jmp    80107708 <select_LIFO+0x28>
801076f6:	8d 76 00             	lea    0x0(%esi),%esi
801076f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
80107700:	83 c7 01             	add    $0x1,%edi
80107703:	83 ff 10             	cmp    $0x10,%edi
80107706:	74 30                	je     80107738 <select_LIFO+0x58>
        if (myproc()->ram_monitor[i].used == 1 && myproc()->ram_monitor[i].place_in_queue > loadOrder) {
80107708:	8d 5f 08             	lea    0x8(%edi),%ebx
8010770b:	e8 10 c8 ff ff       	call   80103f20 <myproc>
80107710:	c1 e3 04             	shl    $0x4,%ebx
80107713:	83 3c 18 01          	cmpl   $0x1,(%eax,%ebx,1)
80107717:	75 e7                	jne    80107700 <select_LIFO+0x20>
80107719:	e8 02 c8 ff ff       	call   80103f20 <myproc>
8010771e:	39 74 18 0c          	cmp    %esi,0xc(%eax,%ebx,1)
80107722:	76 dc                	jbe    80107700 <select_LIFO+0x20>
            loadOrder = myproc()->ram_monitor[i].place_in_queue;
80107724:	e8 f7 c7 ff ff       	call   80103f20 <myproc>
80107729:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
8010772c:	83 c7 01             	add    $0x1,%edi
            loadOrder = myproc()->ram_monitor[i].place_in_queue;
8010772f:	8b 74 18 0c          	mov    0xc(%eax,%ebx,1),%esi
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
80107733:	83 ff 10             	cmp    $0x10,%edi
80107736:	75 d0                	jne    80107708 <select_LIFO+0x28>
}
80107738:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010773b:	83 c4 1c             	add    $0x1c,%esp
8010773e:	5b                   	pop    %ebx
8010773f:	5e                   	pop    %esi
80107740:	5f                   	pop    %edi
80107741:	5d                   	pop    %ebp
80107742:	c3                   	ret    
80107743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107750 <select_SCFIFO>:
int select_SCFIFO() {
80107750:	55                   	push   %ebp
80107751:	89 e5                	mov    %esp,%ebp
80107753:	57                   	push   %edi
80107754:	56                   	push   %esi
80107755:	53                   	push   %ebx
80107756:	83 ec 1c             	sub    $0x1c,%esp
80107759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    loadOrder = 0xFFFFFFFF;
80107760:	be ff ff ff ff       	mov    $0xffffffff,%esi
    pageIndex = -1;
80107765:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
8010776c:	31 ff                	xor    %edi,%edi
8010776e:	eb 08                	jmp    80107778 <select_SCFIFO+0x28>
80107770:	83 c7 01             	add    $0x1,%edi
80107773:	83 ff 10             	cmp    $0x10,%edi
80107776:	74 38                	je     801077b0 <select_SCFIFO+0x60>
        if (myproc()->ram_monitor[i].used == 1 && myproc()->ram_monitor[i].place_in_queue <= loadOrder) {
80107778:	8d 5f 08             	lea    0x8(%edi),%ebx
8010777b:	e8 a0 c7 ff ff       	call   80103f20 <myproc>
80107780:	c1 e3 04             	shl    $0x4,%ebx
80107783:	83 3c 18 01          	cmpl   $0x1,(%eax,%ebx,1)
80107787:	75 e7                	jne    80107770 <select_SCFIFO+0x20>
80107789:	e8 92 c7 ff ff       	call   80103f20 <myproc>
8010778e:	39 74 18 0c          	cmp    %esi,0xc(%eax,%ebx,1)
80107792:	77 dc                	ja     80107770 <select_SCFIFO+0x20>
            loadOrder = myproc()->ram_monitor[i].place_in_queue;
80107794:	e8 87 c7 ff ff       	call   80103f20 <myproc>
80107799:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
8010779c:	83 c7 01             	add    $0x1,%edi
            loadOrder = myproc()->ram_monitor[i].place_in_queue;
8010779f:	8b 74 18 0c          	mov    0xc(%eax,%ebx,1),%esi
    for (i = 0; i < MAX_PYSC_PAGES; i++) {
801077a3:	83 ff 10             	cmp    $0x10,%edi
801077a6:	75 d0                	jne    80107778 <select_SCFIFO+0x28>
801077a8:	90                   	nop
801077a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(myproc()->ram_monitor[pageIndex].pgdir, (char *) myproc()->ram_monitor[pageIndex].p_va, 0);
801077b0:	e8 6b c7 ff ff       	call   80103f20 <myproc>
801077b5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801077b8:	8d 59 08             	lea    0x8(%ecx),%ebx
801077bb:	c1 e3 04             	shl    $0x4,%ebx
801077be:	8b 74 18 08          	mov    0x8(%eax,%ebx,1),%esi
801077c2:	e8 59 c7 ff ff       	call   80103f20 <myproc>
801077c7:	8b 44 18 04          	mov    0x4(%eax,%ebx,1),%eax
801077cb:	31 c9                	xor    %ecx,%ecx
801077cd:	89 f2                	mov    %esi,%edx
801077cf:	e8 dc f8 ff ff       	call   801070b0 <walkpgdir>
    if (*pte & PTE_A) {
801077d4:	8b 10                	mov    (%eax),%edx
801077d6:	f6 c2 20             	test   $0x20,%dl
801077d9:	74 27                	je     80107802 <select_SCFIFO+0xb2>
        *pte &= ~PTE_A; // turn off PTE_A flag
801077db:	83 e2 df             	and    $0xffffffdf,%edx
801077de:	89 10                	mov    %edx,(%eax)
        myproc()->ram_monitor[pageIndex].place_in_queue = myproc()->last_in_queue++;
801077e0:	e8 3b c7 ff ff       	call   80103f20 <myproc>
801077e5:	8b b0 84 02 00 00    	mov    0x284(%eax),%esi
801077eb:	8d 56 01             	lea    0x1(%esi),%edx
801077ee:	89 90 84 02 00 00    	mov    %edx,0x284(%eax)
801077f4:	e8 27 c7 ff ff       	call   80103f20 <myproc>
801077f9:	89 74 18 0c          	mov    %esi,0xc(%eax,%ebx,1)
        goto recheck;
801077fd:	e9 5e ff ff ff       	jmp    80107760 <select_SCFIFO+0x10>
}
80107802:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107805:	83 c4 1c             	add    $0x1c,%esp
80107808:	5b                   	pop    %ebx
80107809:	5e                   	pop    %esi
8010780a:	5f                   	pop    %edi
8010780b:	5d                   	pop    %ebp
8010780c:	c3                   	ret    
8010780d:	8d 76 00             	lea    0x0(%esi),%esi

80107810 <replace_page_by_policy>:
int replace_page_by_policy() {
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
}
80107813:	5d                   	pop    %ebp
    return select_SCFIFO();
80107814:	e9 37 ff ff ff       	jmp    80107750 <select_SCFIFO>
80107819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107820 <select_NONE>:
int select_NONE() {
80107820:	55                   	push   %ebp
}
80107821:	31 c0                	xor    %eax,%eax
int select_NONE() {
80107823:	89 e5                	mov    %esp,%ebp
}
80107825:	5d                   	pop    %ebp
80107826:	c3                   	ret    
80107827:	89 f6                	mov    %esi,%esi
80107829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107830 <swap>:
void swap(pde_t *pgdir, uint p_va) {
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	57                   	push   %edi
80107834:	56                   	push   %esi
80107835:	53                   	push   %ebx
80107836:	83 ec 1c             	sub    $0x1c,%esp
80107839:	8b 45 08             	mov    0x8(%ebp),%eax
8010783c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010783f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    struct proc *p = myproc();
80107842:	e8 d9 c6 ff ff       	call   80103f20 <myproc>
    p->pages_in_file++;
80107847:	83 80 80 02 00 00 01 	addl   $0x1,0x280(%eax)
    struct proc *p = myproc();
8010784e:	89 c3                	mov    %eax,%ebx
    return select_SCFIFO();
80107850:	e8 fb fe ff ff       	call   80107750 <select_SCFIFO>
80107855:	c1 e0 04             	shl    $0x4,%eax
    pte_t *pte = walkpgdir(p->ram_monitor[ram_idx].pgdir, (int *) p->ram_monitor[ram_idx].p_va, 0);
80107858:	31 c9                	xor    %ecx,%ecx
8010785a:	01 c3                	add    %eax,%ebx
8010785c:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
80107862:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80107868:	e8 43 f8 ff ff       	call   801070b0 <walkpgdir>
    int p_pa = PTE_ADDR(*pte);
8010786d:	8b 30                	mov    (%eax),%esi
    write2file(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir);
8010786f:	83 ec 08             	sub    $0x8,%esp
80107872:	ff b3 84 00 00 00    	pushl  0x84(%ebx)
80107878:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
    int p_pa = PTE_ADDR(*pte);
8010787e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    kfree(P2V(p_pa));
80107884:	81 c6 00 00 00 80    	add    $0x80000000,%esi
    write2file(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir);
8010788a:	e8 a1 ab ff ff       	call   80102430 <write2file>
    kfree(P2V(p_pa));
8010788f:	89 34 24             	mov    %esi,(%esp)
80107892:	e8 e9 b0 ff ff       	call   80102980 <kfree>
    set_flag2(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir, PTE_PG, 1);
80107897:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
8010789d:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
801078a3:	31 c9                	xor    %ecx,%ecx
    p->ram_monitor[ram_idx].used = 0;
801078a5:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801078ac:	00 00 00 
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
801078af:	89 f0                	mov    %esi,%eax
801078b1:	e8 fa f7 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
801078b6:	83 c4 10             	add    $0x10,%esp
801078b9:	85 c0                	test   %eax,%eax
801078bb:	74 0f                	je     801078cc <swap+0x9c>
        *pte = *pte | flag;
801078bd:	81 08 00 02 00 00    	orl    $0x200,(%eax)
    lcr3(V2P(pgdir));
801078c3:	81 c6 00 00 00 80    	add    $0x80000000,%esi
801078c9:	0f 22 de             	mov    %esi,%cr3
    set_flag2(p->ram_monitor[ram_idx].p_va, p->ram_monitor[ram_idx].pgdir, PTE_P, 0);
801078cc:	8b b3 84 00 00 00    	mov    0x84(%ebx),%esi
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
801078d2:	31 c9                	xor    %ecx,%ecx
801078d4:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
801078da:	89 f0                	mov    %esi,%eax
801078dc:	e8 cf f7 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
801078e1:	85 c0                	test   %eax,%eax
801078e3:	74 0c                	je     801078f1 <swap+0xc1>
        *pte = *pte & (~flag);
801078e5:	83 20 fe             	andl   $0xfffffffe,(%eax)
    lcr3(V2P(pgdir));
801078e8:	81 c6 00 00 00 80    	add    $0x80000000,%esi
801078ee:	0f 22 de             	mov    %esi,%cr3
    add2ram(pgdir, p_va);
801078f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078f4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801078f7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801078fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078fd:	5b                   	pop    %ebx
801078fe:	5e                   	pop    %esi
801078ff:	5f                   	pop    %edi
80107900:	5d                   	pop    %ebp
    add2ram(pgdir, p_va);
80107901:	e9 5a fd ff ff       	jmp    80107660 <add2ram>
80107906:	8d 76 00             	lea    0x0(%esi),%esi
80107909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107910 <allocuvm>:
int allocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
80107910:	55                   	push   %ebp
80107911:	89 e5                	mov    %esp,%ebp
80107913:	57                   	push   %edi
80107914:	56                   	push   %esi
80107915:	53                   	push   %ebx
80107916:	83 ec 1c             	sub    $0x1c,%esp
    if (newsz >= KERNBASE)
80107919:	8b 7d 10             	mov    0x10(%ebp),%edi
8010791c:	85 ff                	test   %edi,%edi
8010791e:	0f 88 ec 00 00 00    	js     80107a10 <allocuvm+0x100>
    if (newsz < oldsz)
80107924:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107927:	0f 82 d3 00 00 00    	jb     80107a00 <allocuvm+0xf0>
        if (PGROUNDUP(newsz) / PGSIZE > MAX_TOTAL_PAGES && myproc()->pid > 2) {
8010792d:	8d 9f ff 0f 00 00    	lea    0xfff(%edi),%ebx
80107933:	c1 eb 0c             	shr    $0xc,%ebx
80107936:	83 fb 20             	cmp    $0x20,%ebx
80107939:	0f 87 11 01 00 00    	ja     80107a50 <allocuvm+0x140>
    a = PGROUNDUP(oldsz);
8010793f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107942:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107948:	89 f3                	mov    %esi,%ebx
8010794a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    for (; a < newsz; a += PGSIZE) {
80107950:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107953:	0f 86 aa 00 00 00    	jbe    80107a03 <allocuvm+0xf3>
            if (PGROUNDUP(oldsz) / PGSIZE + i > MAX_PYSC_PAGES) {
80107959:	c1 ee 0c             	shr    $0xc,%esi
8010795c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010795f:	83 c6 01             	add    $0x1,%esi
80107962:	eb 21                	jmp    80107985 <allocuvm+0x75>
80107964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                swap(pgdir, a);
80107968:	83 ec 08             	sub    $0x8,%esp
8010796b:	53                   	push   %ebx
8010796c:	ff 75 08             	pushl  0x8(%ebp)
8010796f:	e8 bc fe ff ff       	call   80107830 <swap>
80107974:	83 c4 10             	add    $0x10,%esp
    for (; a < newsz; a += PGSIZE) {
80107977:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010797d:	83 c6 01             	add    $0x1,%esi
80107980:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107983:	76 69                	jbe    801079ee <allocuvm+0xde>
        mem = kalloc();
80107985:	e8 a6 b1 ff ff       	call   80102b30 <kalloc>
        if (mem == 0) {
8010798a:	85 c0                	test   %eax,%eax
        mem = kalloc();
8010798c:	89 c7                	mov    %eax,%edi
        if (mem == 0) {
8010798e:	0f 84 8c 00 00 00    	je     80107a20 <allocuvm+0x110>
        memset(mem, 0, PGSIZE);
80107994:	83 ec 04             	sub    $0x4,%esp
80107997:	68 00 10 00 00       	push   $0x1000
8010799c:	6a 00                	push   $0x0
8010799e:	50                   	push   %eax
8010799f:	e8 6c d4 ff ff       	call   80104e10 <memset>
        mappages(pgdir, (char *) a, PGSIZE, V2P(mem), PTE_W | PTE_U);
801079a4:	58                   	pop    %eax
801079a5:	5a                   	pop    %edx
801079a6:	8d 97 00 00 00 80    	lea    -0x80000000(%edi),%edx
801079ac:	8b 45 08             	mov    0x8(%ebp),%eax
801079af:	6a 06                	push   $0x6
801079b1:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079b6:	52                   	push   %edx
801079b7:	89 da                	mov    %ebx,%edx
801079b9:	e8 72 f7 ff ff       	call   80107130 <mappages>
        if (!select_NONE() && myproc()->pid > 2) {
801079be:	e8 5d c5 ff ff       	call   80103f20 <myproc>
801079c3:	83 c4 10             	add    $0x10,%esp
801079c6:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
801079ca:	7e ab                	jle    80107977 <allocuvm+0x67>
            if (PGROUNDUP(oldsz) / PGSIZE + i > MAX_PYSC_PAGES) {
801079cc:	83 fe 10             	cmp    $0x10,%esi
801079cf:	77 97                	ja     80107968 <allocuvm+0x58>
                add2ram(pgdir, a);
801079d1:	83 ec 08             	sub    $0x8,%esp
801079d4:	83 c6 01             	add    $0x1,%esi
801079d7:	53                   	push   %ebx
801079d8:	ff 75 08             	pushl  0x8(%ebp)
    for (; a < newsz; a += PGSIZE) {
801079db:	81 c3 00 10 00 00    	add    $0x1000,%ebx
                add2ram(pgdir, a);
801079e1:	e8 7a fc ff ff       	call   80107660 <add2ram>
801079e6:	83 c4 10             	add    $0x10,%esp
    for (; a < newsz; a += PGSIZE) {
801079e9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801079ec:	77 97                	ja     80107985 <allocuvm+0x75>
801079ee:	8b 7d e4             	mov    -0x1c(%ebp),%edi
}
801079f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079f4:	5b                   	pop    %ebx
801079f5:	89 f8                	mov    %edi,%eax
801079f7:	5e                   	pop    %esi
801079f8:	5f                   	pop    %edi
801079f9:	5d                   	pop    %ebp
801079fa:	c3                   	ret    
801079fb:	90                   	nop
801079fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return oldsz;
80107a00:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107a03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a06:	89 f8                	mov    %edi,%eax
80107a08:	5b                   	pop    %ebx
80107a09:	5e                   	pop    %esi
80107a0a:	5f                   	pop    %edi
80107a0b:	5d                   	pop    %ebp
80107a0c:	c3                   	ret    
80107a0d:	8d 76 00             	lea    0x0(%esi),%esi
80107a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
80107a13:	31 ff                	xor    %edi,%edi
}
80107a15:	89 f8                	mov    %edi,%eax
80107a17:	5b                   	pop    %ebx
80107a18:	5e                   	pop    %esi
80107a19:	5f                   	pop    %edi
80107a1a:	5d                   	pop    %ebp
80107a1b:	c3                   	ret    
80107a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("allocuvm out of memory\n");
80107a20:	83 ec 0c             	sub    $0xc,%esp
80107a23:	68 6a 8b 10 80       	push   $0x80108b6a
80107a28:	e8 33 8c ff ff       	call   80100660 <cprintf>
    if (newsz >= oldsz)
80107a2d:	83 c4 10             	add    $0x10,%esp
80107a30:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a33:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a36:	76 d8                	jbe    80107a10 <allocuvm+0x100>
80107a38:	89 c1                	mov    %eax,%ecx
80107a3a:	8b 55 10             	mov    0x10(%ebp),%edx
80107a3d:	8b 45 08             	mov    0x8(%ebp),%eax
80107a40:	e8 7b f7 ff ff       	call   801071c0 <deallocuvm.part.0>
80107a45:	eb bc                	jmp    80107a03 <allocuvm+0xf3>
80107a47:	89 f6                	mov    %esi,%esi
80107a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if (PGROUNDUP(newsz) / PGSIZE > MAX_TOTAL_PAGES && myproc()->pid > 2) {
80107a50:	e8 cb c4 ff ff       	call   80103f20 <myproc>
80107a55:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
80107a59:	0f 8e e0 fe ff ff    	jle    8010793f <allocuvm+0x2f>
            cprintf("proc is too big\n", PGROUNDUP(newsz) / PGSIZE);
80107a5f:	83 ec 08             	sub    $0x8,%esp
            return 0;
80107a62:	31 ff                	xor    %edi,%edi
            cprintf("proc is too big\n", PGROUNDUP(newsz) / PGSIZE);
80107a64:	53                   	push   %ebx
80107a65:	68 59 8b 10 80       	push   $0x80108b59
80107a6a:	e8 f1 8b ff ff       	call   80100660 <cprintf>
            return 0;
80107a6f:	83 c4 10             	add    $0x10,%esp
80107a72:	eb 8f                	jmp    80107a03 <allocuvm+0xf3>
80107a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107a80 <deallocuvm>:
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
80107a80:	55                   	push   %ebp
80107a81:	89 e5                	mov    %esp,%ebp
80107a83:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a86:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a89:	8b 45 08             	mov    0x8(%ebp),%eax
    if (newsz >= oldsz)
80107a8c:	39 d1                	cmp    %edx,%ecx
80107a8e:	73 10                	jae    80107aa0 <deallocuvm+0x20>
}
80107a90:	5d                   	pop    %ebp
80107a91:	e9 2a f7 ff ff       	jmp    801071c0 <deallocuvm.part.0>
80107a96:	8d 76 00             	lea    0x0(%esi),%esi
80107a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107aa0:	89 d0                	mov    %edx,%eax
80107aa2:	5d                   	pop    %ebp
80107aa3:	c3                   	ret    
80107aa4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107aaa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107ab0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir) {
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	57                   	push   %edi
80107ab4:	56                   	push   %esi
80107ab5:	53                   	push   %ebx
80107ab6:	83 ec 0c             	sub    $0xc,%esp
80107ab9:	8b 75 08             	mov    0x8(%ebp),%esi
    uint i;
    if (pgdir == 0)
80107abc:	85 f6                	test   %esi,%esi
80107abe:	74 59                	je     80107b19 <freevm+0x69>
80107ac0:	31 c9                	xor    %ecx,%ecx
80107ac2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107ac7:	89 f0                	mov    %esi,%eax
80107ac9:	e8 f2 f6 ff ff       	call   801071c0 <deallocuvm.part.0>
80107ace:	89 f3                	mov    %esi,%ebx
80107ad0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107ad6:	eb 0f                	jmp    80107ae7 <freevm+0x37>
80107ad8:	90                   	nop
80107ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ae0:	83 c3 04             	add    $0x4,%ebx
        panic("freevm: no pgdir");
    deallocuvm(pgdir, KERNBASE, 0);
    for (i = 0; i < NPDENTRIES; i++) {
80107ae3:	39 fb                	cmp    %edi,%ebx
80107ae5:	74 23                	je     80107b0a <freevm+0x5a>
        if (pgdir[i] & PTE_P) {
80107ae7:	8b 03                	mov    (%ebx),%eax
80107ae9:	a8 01                	test   $0x1,%al
80107aeb:	74 f3                	je     80107ae0 <freevm+0x30>
            char *v = P2V(PTE_ADDR(pgdir[i]));
80107aed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
            kfree(v);
80107af2:	83 ec 0c             	sub    $0xc,%esp
80107af5:	83 c3 04             	add    $0x4,%ebx
            char *v = P2V(PTE_ADDR(pgdir[i]));
80107af8:	05 00 00 00 80       	add    $0x80000000,%eax
            kfree(v);
80107afd:	50                   	push   %eax
80107afe:	e8 7d ae ff ff       	call   80102980 <kfree>
80107b03:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NPDENTRIES; i++) {
80107b06:	39 fb                	cmp    %edi,%ebx
80107b08:	75 dd                	jne    80107ae7 <freevm+0x37>
        }
    }
    kfree((char *) pgdir);
80107b0a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b10:	5b                   	pop    %ebx
80107b11:	5e                   	pop    %esi
80107b12:	5f                   	pop    %edi
80107b13:	5d                   	pop    %ebp
    kfree((char *) pgdir);
80107b14:	e9 67 ae ff ff       	jmp    80102980 <kfree>
        panic("freevm: no pgdir");
80107b19:	83 ec 0c             	sub    $0xc,%esp
80107b1c:	68 82 8b 10 80       	push   $0x80108b82
80107b21:	e8 6a 88 ff ff       	call   80100390 <panic>
80107b26:	8d 76 00             	lea    0x0(%esi),%esi
80107b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107b30 <setupkvm>:
setupkvm(void) {
80107b30:	55                   	push   %ebp
80107b31:	89 e5                	mov    %esp,%ebp
80107b33:	56                   	push   %esi
80107b34:	53                   	push   %ebx
    if ((pgdir = (pde_t *) kalloc()) == 0)
80107b35:	e8 f6 af ff ff       	call   80102b30 <kalloc>
80107b3a:	85 c0                	test   %eax,%eax
80107b3c:	89 c6                	mov    %eax,%esi
80107b3e:	74 42                	je     80107b82 <setupkvm+0x52>
    memset(pgdir, 0, PGSIZE);
80107b40:	83 ec 04             	sub    $0x4,%esp
    for (k = kmap; k < &kmap[NELEM(kmap)];
80107b43:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
    memset(pgdir, 0, PGSIZE);
80107b48:	68 00 10 00 00       	push   $0x1000
80107b4d:	6a 00                	push   $0x0
80107b4f:	50                   	push   %eax
80107b50:	e8 bb d2 ff ff       	call   80104e10 <memset>
80107b55:	83 c4 10             	add    $0x10,%esp
                 (uint) k->phys_start, k->perm) < 0) {
80107b58:	8b 43 04             	mov    0x4(%ebx),%eax
    if (mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107b5b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b5e:	83 ec 08             	sub    $0x8,%esp
80107b61:	8b 13                	mov    (%ebx),%edx
80107b63:	ff 73 0c             	pushl  0xc(%ebx)
80107b66:	50                   	push   %eax
80107b67:	29 c1                	sub    %eax,%ecx
80107b69:	89 f0                	mov    %esi,%eax
80107b6b:	e8 c0 f5 ff ff       	call   80107130 <mappages>
80107b70:	83 c4 10             	add    $0x10,%esp
80107b73:	85 c0                	test   %eax,%eax
80107b75:	78 19                	js     80107b90 <setupkvm+0x60>
    k++)
80107b77:	83 c3 10             	add    $0x10,%ebx
    for (k = kmap; k < &kmap[NELEM(kmap)];
80107b7a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b80:	75 d6                	jne    80107b58 <setupkvm+0x28>
}
80107b82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b85:	89 f0                	mov    %esi,%eax
80107b87:	5b                   	pop    %ebx
80107b88:	5e                   	pop    %esi
80107b89:	5d                   	pop    %ebp
80107b8a:	c3                   	ret    
80107b8b:	90                   	nop
80107b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        freevm(pgdir);
80107b90:	83 ec 0c             	sub    $0xc,%esp
80107b93:	56                   	push   %esi
        return 0;
80107b94:	31 f6                	xor    %esi,%esi
        freevm(pgdir);
80107b96:	e8 15 ff ff ff       	call   80107ab0 <freevm>
        return 0;
80107b9b:	83 c4 10             	add    $0x10,%esp
}
80107b9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ba1:	89 f0                	mov    %esi,%eax
80107ba3:	5b                   	pop    %ebx
80107ba4:	5e                   	pop    %esi
80107ba5:	5d                   	pop    %ebp
80107ba6:	c3                   	ret    
80107ba7:	89 f6                	mov    %esi,%esi
80107ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107bb0 <kvmalloc>:
kvmalloc(void) {
80107bb0:	55                   	push   %ebp
80107bb1:	89 e5                	mov    %esp,%ebp
80107bb3:	83 ec 08             	sub    $0x8,%esp
    kpgdir = setupkvm();
80107bb6:	e8 75 ff ff ff       	call   80107b30 <setupkvm>
80107bbb:	a3 a4 f9 11 80       	mov    %eax,0x8011f9a4
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107bc0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bc5:	0f 22 d8             	mov    %eax,%cr3
}
80107bc8:	c9                   	leave  
80107bc9:	c3                   	ret    
80107bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107bd0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva) {
80107bd0:	55                   	push   %ebp
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
80107bd1:	31 c9                	xor    %ecx,%ecx
clearpteu(pde_t *pgdir, char *uva) {
80107bd3:	89 e5                	mov    %esp,%ebp
80107bd5:	83 ec 08             	sub    $0x8,%esp
    pte = walkpgdir(pgdir, uva, 0);
80107bd8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bdb:	8b 45 08             	mov    0x8(%ebp),%eax
80107bde:	e8 cd f4 ff ff       	call   801070b0 <walkpgdir>
    if (pte == 0)
80107be3:	85 c0                	test   %eax,%eax
80107be5:	74 05                	je     80107bec <clearpteu+0x1c>
        panic("clearpteu");
    *pte &= ~PTE_U;
80107be7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107bea:	c9                   	leave  
80107beb:	c3                   	ret    
        panic("clearpteu");
80107bec:	83 ec 0c             	sub    $0xc,%esp
80107bef:	68 93 8b 10 80       	push   $0x80108b93
80107bf4:	e8 97 87 ff ff       	call   80100390 <panic>
80107bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c00 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t *
copyuvm(pde_t *pgdir, uint sz) {
80107c00:	55                   	push   %ebp
80107c01:	89 e5                	mov    %esp,%ebp
80107c03:	57                   	push   %edi
80107c04:	56                   	push   %esi
80107c05:	53                   	push   %ebx
80107c06:	83 ec 1c             	sub    $0x1c,%esp
    pde_t *d;
    pte_t *pte;
    uint pa, i, flags;
    char *mem;

    if ((d = setupkvm()) == 0)
80107c09:	e8 22 ff ff ff       	call   80107b30 <setupkvm>
80107c0e:	85 c0                	test   %eax,%eax
80107c10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107c13:	0f 84 05 01 00 00    	je     80107d1e <copyuvm+0x11e>
        return 0;
    for (i = 0; i < sz; i += PGSIZE) {
80107c19:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c1c:	85 c9                	test   %ecx,%ecx
80107c1e:	0f 84 fa 00 00 00    	je     80107d1e <copyuvm+0x11e>
    lcr3(V2P(pgdir));
80107c24:	05 00 00 00 80       	add    $0x80000000,%eax
    for (i = 0; i < sz; i += PGSIZE) {
80107c29:	31 f6                	xor    %esi,%esi
    lcr3(V2P(pgdir));
80107c2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107c2e:	eb 69                	jmp    80107c99 <copyuvm+0x99>
            set_flag2(i, d, PTE_PG, 1);
            set_flag2(i, d, PTE_P, 0);
            set_flag2(i, d, ~PTE_FLAGS(pte), 0);
            continue;
        }
        pa = PTE_ADDR(*pte);
80107c30:	89 df                	mov    %ebx,%edi
        flags = PTE_FLAGS(*pte);
80107c32:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
        pa = PTE_ADDR(*pte);
80107c38:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
        if ((mem = kalloc()) == 0)
80107c3e:	e8 ed ae ff ff       	call   80102b30 <kalloc>
80107c43:	85 c0                	test   %eax,%eax
80107c45:	0f 84 e5 00 00 00    	je     80107d30 <copyuvm+0x130>
            goto bad;
        memmove(mem, (char *) P2V(pa), PGSIZE);
80107c4b:	83 ec 04             	sub    $0x4,%esp
80107c4e:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107c54:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c57:	68 00 10 00 00       	push   $0x1000
80107c5c:	57                   	push   %edi
80107c5d:	50                   	push   %eax
80107c5e:	e8 5d d2 ff ff       	call   80104ec0 <memmove>
        if (mappages(d, (void *) i, PGSIZE, V2P(mem), flags) < 0)
80107c63:	58                   	pop    %eax
80107c64:	5a                   	pop    %edx
80107c65:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107c68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c6b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107c70:	53                   	push   %ebx
80107c71:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107c77:	52                   	push   %edx
80107c78:	89 f2                	mov    %esi,%edx
80107c7a:	e8 b1 f4 ff ff       	call   80107130 <mappages>
80107c7f:	83 c4 10             	add    $0x10,%esp
80107c82:	85 c0                	test   %eax,%eax
80107c84:	0f 88 a6 00 00 00    	js     80107d30 <copyuvm+0x130>
    for (i = 0; i < sz; i += PGSIZE) {
80107c8a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107c90:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107c93:	0f 86 85 00 00 00    	jbe    80107d1e <copyuvm+0x11e>
        if ((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c99:	8b 45 08             	mov    0x8(%ebp),%eax
80107c9c:	31 c9                	xor    %ecx,%ecx
80107c9e:	89 f2                	mov    %esi,%edx
80107ca0:	e8 0b f4 ff ff       	call   801070b0 <walkpgdir>
80107ca5:	85 c0                	test   %eax,%eax
80107ca7:	89 c7                	mov    %eax,%edi
80107ca9:	0f 84 a1 00 00 00    	je     80107d50 <copyuvm+0x150>
        if (!(*pte & PTE_P))
80107caf:	8b 18                	mov    (%eax),%ebx
80107cb1:	f6 c3 01             	test   $0x1,%bl
80107cb4:	0f 84 a3 00 00 00    	je     80107d5d <copyuvm+0x15d>
        if (*pte & PTE_PG) {
80107cba:	f6 c7 02             	test   $0x2,%bh
80107cbd:	0f 84 6d ff ff ff    	je     80107c30 <copyuvm+0x30>
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
80107cc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107cc6:	31 c9                	xor    %ecx,%ecx
80107cc8:	89 f2                	mov    %esi,%edx
80107cca:	e8 e1 f3 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
80107ccf:	85 c0                	test   %eax,%eax
80107cd1:	74 0c                	je     80107cdf <copyuvm+0xdf>
        *pte = *pte | flag;
80107cd3:	81 08 00 02 00 00    	orl    $0x200,(%eax)
80107cd9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107cdc:	0f 22 d8             	mov    %eax,%cr3
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
80107cdf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ce2:	31 c9                	xor    %ecx,%ecx
80107ce4:	89 f2                	mov    %esi,%edx
80107ce6:	e8 c5 f3 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
80107ceb:	85 c0                	test   %eax,%eax
80107ced:	74 09                	je     80107cf8 <copyuvm+0xf8>
        *pte = *pte & (~flag);
80107cef:	83 20 fe             	andl   $0xfffffffe,(%eax)
80107cf2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107cf5:	0f 22 d8             	mov    %eax,%cr3
            set_flag2(i, d, ~PTE_FLAGS(pte), 0);
80107cf8:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80107cfe:	6a 00                	push   $0x0
80107d00:	f7 d7                	not    %edi
80107d02:	57                   	push   %edi
80107d03:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d06:	56                   	push   %esi
    for (i = 0; i < sz; i += PGSIZE) {
80107d07:	81 c6 00 10 00 00    	add    $0x1000,%esi
            set_flag2(i, d, ~PTE_FLAGS(pte), 0);
80107d0d:	e8 ae f8 ff ff       	call   801075c0 <set_flag2>
            continue;
80107d12:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < sz; i += PGSIZE) {
80107d15:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d18:	0f 87 7b ff ff ff    	ja     80107c99 <copyuvm+0x99>
    return d;

    bad:
    freevm(d);
    return 0;
}
80107d1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d24:	5b                   	pop    %ebx
80107d25:	5e                   	pop    %esi
80107d26:	5f                   	pop    %edi
80107d27:	5d                   	pop    %ebp
80107d28:	c3                   	ret    
80107d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    freevm(d);
80107d30:	83 ec 0c             	sub    $0xc,%esp
80107d33:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d36:	e8 75 fd ff ff       	call   80107ab0 <freevm>
    return 0;
80107d3b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107d42:	83 c4 10             	add    $0x10,%esp
}
80107d45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d4b:	5b                   	pop    %ebx
80107d4c:	5e                   	pop    %esi
80107d4d:	5f                   	pop    %edi
80107d4e:	5d                   	pop    %ebp
80107d4f:	c3                   	ret    
            panic("copyuvm: pte should exist");
80107d50:	83 ec 0c             	sub    $0xc,%esp
80107d53:	68 9d 8b 10 80       	push   $0x80108b9d
80107d58:	e8 33 86 ff ff       	call   80100390 <panic>
            panic("copyuvm: page not present");
80107d5d:	83 ec 0c             	sub    $0xc,%esp
80107d60:	68 b7 8b 10 80       	push   $0x80108bb7
80107d65:	e8 26 86 ff ff       	call   80100390 <panic>
80107d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d70 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char *
uva2ka(pde_t *pgdir, char *uva) {
80107d70:	55                   	push   %ebp
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
80107d71:	31 c9                	xor    %ecx,%ecx
uva2ka(pde_t *pgdir, char *uva) {
80107d73:	89 e5                	mov    %esp,%ebp
80107d75:	83 ec 08             	sub    $0x8,%esp
    pte = walkpgdir(pgdir, uva, 0);
80107d78:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80107d7e:	e8 2d f3 ff ff       	call   801070b0 <walkpgdir>
    if ((*pte & PTE_P) == 0)
80107d83:	8b 00                	mov    (%eax),%eax
        return 0;
    if ((*pte & PTE_U) == 0)
        return 0;
    return (char *) P2V(PTE_ADDR(*pte));
}
80107d85:	c9                   	leave  
    if ((*pte & PTE_U) == 0)
80107d86:	89 c2                	mov    %eax,%edx
    return (char *) P2V(PTE_ADDR(*pte));
80107d88:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if ((*pte & PTE_U) == 0)
80107d8d:	83 e2 05             	and    $0x5,%edx
    return (char *) P2V(PTE_ADDR(*pte));
80107d90:	05 00 00 00 80       	add    $0x80000000,%eax
80107d95:	83 fa 05             	cmp    $0x5,%edx
80107d98:	ba 00 00 00 00       	mov    $0x0,%edx
80107d9d:	0f 45 c2             	cmovne %edx,%eax
}
80107da0:	c3                   	ret    
80107da1:	eb 0d                	jmp    80107db0 <copyout>
80107da3:	90                   	nop
80107da4:	90                   	nop
80107da5:	90                   	nop
80107da6:	90                   	nop
80107da7:	90                   	nop
80107da8:	90                   	nop
80107da9:	90                   	nop
80107daa:	90                   	nop
80107dab:	90                   	nop
80107dac:	90                   	nop
80107dad:	90                   	nop
80107dae:	90                   	nop
80107daf:	90                   	nop

80107db0 <copyout>:

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len) {
80107db0:	55                   	push   %ebp
80107db1:	89 e5                	mov    %esp,%ebp
80107db3:	57                   	push   %edi
80107db4:	56                   	push   %esi
80107db5:	53                   	push   %ebx
80107db6:	83 ec 1c             	sub    $0x1c,%esp
80107db9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107dbc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107dbf:	8b 7d 10             	mov    0x10(%ebp),%edi
    char *buf, *pa0;
    uint n, va0;

    buf = (char *) p;
    while (len > 0) {
80107dc2:	85 db                	test   %ebx,%ebx
80107dc4:	75 40                	jne    80107e06 <copyout+0x56>
80107dc6:	eb 70                	jmp    80107e38 <copyout+0x88>
80107dc8:	90                   	nop
80107dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        va0 = (uint) PGROUNDDOWN(va);
        pa0 = uva2ka(pgdir, (char *) va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (va - va0);
80107dd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107dd3:	89 f1                	mov    %esi,%ecx
80107dd5:	29 d1                	sub    %edx,%ecx
80107dd7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107ddd:	39 d9                	cmp    %ebx,%ecx
80107ddf:	0f 47 cb             	cmova  %ebx,%ecx
        if (n > len)
            n = len;
        memmove(pa0 + (va - va0), buf, n);
80107de2:	29 f2                	sub    %esi,%edx
80107de4:	83 ec 04             	sub    $0x4,%esp
80107de7:	01 d0                	add    %edx,%eax
80107de9:	51                   	push   %ecx
80107dea:	57                   	push   %edi
80107deb:	50                   	push   %eax
80107dec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107def:	e8 cc d0 ff ff       	call   80104ec0 <memmove>
        len -= n;
        buf += n;
80107df4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    while (len > 0) {
80107df7:	83 c4 10             	add    $0x10,%esp
        va = va0 + PGSIZE;
80107dfa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
        buf += n;
80107e00:	01 cf                	add    %ecx,%edi
    while (len > 0) {
80107e02:	29 cb                	sub    %ecx,%ebx
80107e04:	74 32                	je     80107e38 <copyout+0x88>
        va0 = (uint) PGROUNDDOWN(va);
80107e06:	89 d6                	mov    %edx,%esi
        pa0 = uva2ka(pgdir, (char *) va0);
80107e08:	83 ec 08             	sub    $0x8,%esp
        va0 = (uint) PGROUNDDOWN(va);
80107e0b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107e0e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
        pa0 = uva2ka(pgdir, (char *) va0);
80107e14:	56                   	push   %esi
80107e15:	ff 75 08             	pushl  0x8(%ebp)
80107e18:	e8 53 ff ff ff       	call   80107d70 <uva2ka>
        if (pa0 == 0)
80107e1d:	83 c4 10             	add    $0x10,%esp
80107e20:	85 c0                	test   %eax,%eax
80107e22:	75 ac                	jne    80107dd0 <copyout+0x20>
    }
    return 0;
}
80107e24:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
80107e27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107e2c:	5b                   	pop    %ebx
80107e2d:	5e                   	pop    %esi
80107e2e:	5f                   	pop    %edi
80107e2f:	5d                   	pop    %ebp
80107e30:	c3                   	ret    
80107e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107e3b:	31 c0                	xor    %eax,%eax
}
80107e3d:	5b                   	pop    %ebx
80107e3e:	5e                   	pop    %esi
80107e3f:	5f                   	pop    %edi
80107e40:	5d                   	pop    %ebp
80107e41:	c3                   	ret    
80107e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e50 <get_flags>:

int
get_flags(uint va) {
80107e50:	55                   	push   %ebp
80107e51:	89 e5                	mov    %esp,%ebp
80107e53:	83 ec 08             	sub    $0x8,%esp
    pte_t *pte = walkpgdir(myproc()->pgdir, (void *) va, 0);
80107e56:	e8 c5 c0 ff ff       	call   80103f20 <myproc>
80107e5b:	8b 55 08             	mov    0x8(%ebp),%edx
80107e5e:	8b 40 04             	mov    0x4(%eax),%eax
80107e61:	31 c9                	xor    %ecx,%ecx
80107e63:	e8 48 f2 ff ff       	call   801070b0 <walkpgdir>
    if (pte) return PTE_FLAGS(*pte);
80107e68:	85 c0                	test   %eax,%eax
80107e6a:	74 09                	je     80107e75 <get_flags+0x25>
80107e6c:	8b 00                	mov    (%eax),%eax
    else return -1;
}
80107e6e:	c9                   	leave  
    if (pte) return PTE_FLAGS(*pte);
80107e6f:	25 ff 0f 00 00       	and    $0xfff,%eax
}
80107e74:	c3                   	ret    
    else return -1;
80107e75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107e7a:	c9                   	leave  
80107e7b:	c3                   	ret    
80107e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107e80 <set_flag>:

int
set_flag(uint va, int flag, int on) {
80107e80:	55                   	push   %ebp
80107e81:	89 e5                	mov    %esp,%ebp
80107e83:	53                   	push   %ebx
80107e84:	83 ec 04             	sub    $0x4,%esp
80107e87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    pte_t *pte = walkpgdir(myproc()->pgdir, (void *) va, 0);
80107e8a:	e8 91 c0 ff ff       	call   80103f20 <myproc>
80107e8f:	8b 55 08             	mov    0x8(%ebp),%edx
80107e92:	8b 40 04             	mov    0x4(%eax),%eax
80107e95:	31 c9                	xor    %ecx,%ecx
80107e97:	e8 14 f2 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
80107e9c:	85 c0                	test   %eax,%eax
80107e9e:	74 2c                	je     80107ecc <set_flag+0x4c>
80107ea0:	8b 10                	mov    (%eax),%edx

    // turn flag bit off
    if (!on) {
        *pte = *pte & (~flag);
80107ea2:	89 d9                	mov    %ebx,%ecx
80107ea4:	f7 d3                	not    %ebx
80107ea6:	09 d1                	or     %edx,%ecx
80107ea8:	21 d3                	and    %edx,%ebx
80107eaa:	8b 55 10             	mov    0x10(%ebp),%edx
80107ead:	85 d2                	test   %edx,%edx
80107eaf:	0f 45 d9             	cmovne %ecx,%ebx
80107eb2:	89 18                	mov    %ebx,(%eax)
        // turn flag bit on
    else {
        *pte = *pte | flag;
    }

    lcr3(V2P(myproc()->pgdir));
80107eb4:	e8 67 c0 ff ff       	call   80103f20 <myproc>
80107eb9:	8b 40 04             	mov    0x4(%eax),%eax
80107ebc:	05 00 00 00 80       	add    $0x80000000,%eax
80107ec1:	0f 22 d8             	mov    %eax,%cr3

    return 0;
80107ec4:	31 c0                	xor    %eax,%eax
}
80107ec6:	83 c4 04             	add    $0x4,%esp
80107ec9:	5b                   	pop    %ebx
80107eca:	5d                   	pop    %ebp
80107ecb:	c3                   	ret    
    if (!pte) return -1;
80107ecc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ed1:	eb f3                	jmp    80107ec6 <set_flag+0x46>
80107ed3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ee0 <page_from_disk>:


static char buff[PGSIZE];

int page_from_disk(int va) {
80107ee0:	55                   	push   %ebp
80107ee1:	89 e5                	mov    %esp,%ebp
80107ee3:	57                   	push   %edi
80107ee4:	56                   	push   %esi
80107ee5:	53                   	push   %ebx
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107ee6:	31 ff                	xor    %edi,%edi
int page_from_disk(int va) {
80107ee8:	83 ec 1c             	sub    $0x1c,%esp
    myproc()->page_fault_counter++;
80107eeb:	e8 30 c0 ff ff       	call   80103f20 <myproc>
80107ef0:	83 80 8c 02 00 00 01 	addl   $0x1,0x28c(%eax)
    struct proc *p = myproc();
80107ef7:	e8 24 c0 ff ff       	call   80103f20 <myproc>
    int p_va = PGROUNDDOWN(va);
80107efc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p = myproc();
80107eff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    char *np = kalloc();
80107f02:	e8 29 ac ff ff       	call   80102b30 <kalloc>
    memset(np, 0, PGSIZE);
80107f07:	83 ec 04             	sub    $0x4,%esp
    char *np = kalloc();
80107f0a:	89 c6                	mov    %eax,%esi
    memset(np, 0, PGSIZE);
80107f0c:	68 00 10 00 00       	push   $0x1000
80107f11:	6a 00                	push   $0x0
    int p_va = PGROUNDDOWN(va);
80107f13:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    memset(np, 0, PGSIZE);
80107f19:	50                   	push   %eax
80107f1a:	e8 f1 ce ff ff       	call   80104e10 <memset>
80107f1f:	83 c4 10             	add    $0x10,%esp
80107f22:	eb 0c                	jmp    80107f30 <page_from_disk+0x50>
80107f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (int i = 0; i < MAX_PYSC_PAGES; i++) {
80107f28:	83 c7 01             	add    $0x1,%edi
80107f2b:	83 ff 10             	cmp    $0x10,%edi
80107f2e:	74 60                	je     80107f90 <page_from_disk+0xb0>
        if (myproc()->ram_monitor[i].used == 0)
80107f30:	e8 eb bf ff ff       	call   80103f20 <myproc>
80107f35:	8d 57 08             	lea    0x8(%edi),%edx
80107f38:	c1 e2 04             	shl    $0x4,%edx
80107f3b:	8b 0c 10             	mov    (%eax,%edx,1),%ecx
80107f3e:	85 c9                	test   %ecx,%ecx
80107f40:	75 e6                	jne    80107f28 <page_from_disk+0x48>
    int free_ram_idx = get_free_ram_idx();
    if (free_ram_idx >= 0) {
        set_flag(p_va, PTE_PG, 0);
80107f42:	83 ec 04             	sub    $0x4,%esp
        set_flag(p_va, PTE_P | PTE_W | PTE_U, 1);
        set_flag(p_va, V2P(np), 1);
80107f45:	81 c6 00 00 00 80    	add    $0x80000000,%esi
        set_flag(p_va, PTE_PG, 0);
80107f4b:	6a 00                	push   $0x0
80107f4d:	68 00 02 00 00       	push   $0x200
80107f52:	53                   	push   %ebx
80107f53:	e8 28 ff ff ff       	call   80107e80 <set_flag>
        set_flag(p_va, PTE_P | PTE_W | PTE_U, 1);
80107f58:	83 c4 0c             	add    $0xc,%esp
80107f5b:	6a 01                	push   $0x1
80107f5d:	6a 07                	push   $0x7
80107f5f:	53                   	push   %ebx
80107f60:	e8 1b ff ff ff       	call   80107e80 <set_flag>
        set_flag(p_va, V2P(np), 1);
80107f65:	83 c4 0c             	add    $0xc,%esp
80107f68:	6a 01                	push   $0x1
80107f6a:	56                   	push   %esi
80107f6b:	53                   	push   %ebx
80107f6c:	e8 0f ff ff ff       	call   80107e80 <set_flag>
        read_page_from_disk(p, free_ram_idx, p_va, (char *) p_va);
80107f71:	53                   	push   %ebx
80107f72:	53                   	push   %ebx
80107f73:	57                   	push   %edi
80107f74:	ff 75 e4             	pushl  -0x1c(%ebp)
80107f77:	e8 54 a5 ff ff       	call   801024d0 <read_page_from_disk>
        return 1;
80107f7c:	83 c4 20             	add    $0x20,%esp
80107f7f:	b8 01 00 00 00       	mov    $0x1,%eax
    set_flag2(page.p_va, page.pgdir, PTE_PG, 1);
    set_flag2(page.p_va, page.pgdir, PTE_P, 0);
    char *v = P2V(va1);
    kfree(v);
    return 1;
}
80107f84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f87:	5b                   	pop    %ebx
80107f88:	5e                   	pop    %esi
80107f89:	5f                   	pop    %edi
80107f8a:	5d                   	pop    %ebp
80107f8b:	c3                   	ret    
80107f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->pages_in_file++;
80107f90:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107f93:	83 87 80 02 00 00 01 	addl   $0x1,0x280(%edi)
    return select_SCFIFO();
80107f9a:	e8 b1 f7 ff ff       	call   80107750 <select_SCFIFO>
80107f9f:	89 c2                	mov    %eax,%edx
    struct p_monitor page = p->ram_monitor[ram_idx];
80107fa1:	8d 40 08             	lea    0x8(%eax),%eax
    set_flag(p_va, PTE_PG, 0);
80107fa4:	83 ec 04             	sub    $0x4,%esp
    struct p_monitor page = p->ram_monitor[ram_idx];
80107fa7:	89 55 dc             	mov    %edx,-0x24(%ebp)
80107faa:	c1 e0 04             	shl    $0x4,%eax
80107fad:	01 f8                	add    %edi,%eax
80107faf:	8b 48 04             	mov    0x4(%eax),%ecx
80107fb2:	8b 50 08             	mov    0x8(%eax),%edx
    set_flag(p_va, PTE_PG, 0);
80107fb5:	6a 00                	push   $0x0
80107fb7:	68 00 02 00 00       	push   $0x200
80107fbc:	53                   	push   %ebx
    struct p_monitor page = p->ram_monitor[ram_idx];
80107fbd:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107fc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
    set_flag(p_va, PTE_PG, 0);
80107fc3:	e8 b8 fe ff ff       	call   80107e80 <set_flag>
    set_flag(p_va, PTE_P | PTE_W | PTE_U, 1);
80107fc8:	83 c4 0c             	add    $0xc,%esp
80107fcb:	6a 01                	push   $0x1
80107fcd:	6a 07                	push   $0x7
80107fcf:	53                   	push   %ebx
80107fd0:	e8 ab fe ff ff       	call   80107e80 <set_flag>
    set_flag(p_va, V2P(np), 1);
80107fd5:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107fdb:	83 c4 0c             	add    $0xc,%esp
80107fde:	6a 01                	push   $0x1
80107fe0:	50                   	push   %eax
80107fe1:	53                   	push   %ebx
80107fe2:	e8 99 fe ff ff       	call   80107e80 <set_flag>
    read_page_from_disk(p, ram_idx, p_va, buff);
80107fe7:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107fea:	68 c0 b5 10 80       	push   $0x8010b5c0
80107fef:	53                   	push   %ebx
80107ff0:	52                   	push   %edx
80107ff1:	57                   	push   %edi
80107ff2:	e8 d9 a4 ff ff       	call   801024d0 <read_page_from_disk>
    pte_t *pte = walkpgdir(page.pgdir, (int *) page.p_va, 0);
80107ff7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107ffa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ffd:	83 c4 20             	add    $0x20,%esp
80108000:	31 c9                	xor    %ecx,%ecx
80108002:	e8 a9 f0 ff ff       	call   801070b0 <walkpgdir>
    if (!pte)
80108007:	85 c0                	test   %eax,%eax
80108009:	0f 84 8b 00 00 00    	je     8010809a <page_from_disk+0x1ba>
    memmove(np, buff, PGSIZE);
8010800f:	83 ec 04             	sub    $0x4,%esp
    int va1 = PTE_ADDR(*pte);
80108012:	8b 18                	mov    (%eax),%ebx
    memmove(np, buff, PGSIZE);
80108014:	68 00 10 00 00       	push   $0x1000
80108019:	68 c0 b5 10 80       	push   $0x8010b5c0
8010801e:	56                   	push   %esi
    int va1 = PTE_ADDR(*pte);
8010801f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    memmove(np, buff, PGSIZE);
80108025:	e8 96 ce ff ff       	call   80104ec0 <memmove>
    write2file(page.p_va, page.pgdir);
8010802a:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010802d:	8b 7d e0             	mov    -0x20(%ebp),%edi
80108030:	58                   	pop    %eax
80108031:	5a                   	pop    %edx
80108032:	56                   	push   %esi
80108033:	57                   	push   %edi
80108034:	e8 f7 a3 ff ff       	call   80102430 <write2file>
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
80108039:	31 c9                	xor    %ecx,%ecx
8010803b:	89 fa                	mov    %edi,%edx
8010803d:	89 f0                	mov    %esi,%eax
8010803f:	e8 6c f0 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
80108044:	83 c4 10             	add    $0x10,%esp
80108047:	85 c0                	test   %eax,%eax
80108049:	74 10                	je     8010805b <page_from_disk+0x17b>
        *pte = *pte | flag;
8010804b:	81 08 00 02 00 00    	orl    $0x200,(%eax)
    lcr3(V2P(pgdir));
80108051:	89 f0                	mov    %esi,%eax
80108053:	05 00 00 00 80       	add    $0x80000000,%eax
80108058:	0f 22 d8             	mov    %eax,%cr3
    pte_t *pte = walkpgdir(pgdir, (void *) va, 0);
8010805b:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010805e:	31 c9                	xor    %ecx,%ecx
80108060:	8b 55 e0             	mov    -0x20(%ebp),%edx
80108063:	89 f0                	mov    %esi,%eax
80108065:	e8 46 f0 ff ff       	call   801070b0 <walkpgdir>
    if (!pte) return -1;
8010806a:	85 c0                	test   %eax,%eax
8010806c:	74 0d                	je     8010807b <page_from_disk+0x19b>
        *pte = *pte & (~flag);
8010806e:	83 20 fe             	andl   $0xfffffffe,(%eax)
    lcr3(V2P(pgdir));
80108071:	89 f0                	mov    %esi,%eax
80108073:	05 00 00 00 80       	add    $0x80000000,%eax
80108078:	0f 22 d8             	mov    %eax,%cr3
    kfree(v);
8010807b:	83 ec 0c             	sub    $0xc,%esp
    char *v = P2V(va1);
8010807e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    kfree(v);
80108084:	53                   	push   %ebx
80108085:	e8 f6 a8 ff ff       	call   80102980 <kfree>
    return 1;
8010808a:	83 c4 10             	add    $0x10,%esp
}
8010808d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
80108090:	b8 01 00 00 00       	mov    $0x1,%eax
}
80108095:	5b                   	pop    %ebx
80108096:	5e                   	pop    %esi
80108097:	5f                   	pop    %edi
80108098:	5d                   	pop    %ebp
80108099:	c3                   	ret    
        return -1;
8010809a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010809f:	e9 e0 fe ff ff       	jmp    80107f84 <page_from_disk+0xa4>
801080a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801080aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801080b0 <update_protected_pages>:

void
update_protected_pages(int up){
801080b0:	55                   	push   %ebp
801080b1:	89 e5                	mov    %esp,%ebp
801080b3:	83 ec 08             	sub    $0x8,%esp
    if(up) myproc()->protected++;
801080b6:	8b 45 08             	mov    0x8(%ebp),%eax
801080b9:	85 c0                	test   %eax,%eax
801080bb:	75 13                	jne    801080d0 <update_protected_pages+0x20>
    else myproc()->protected--;
801080bd:	e8 5e be ff ff       	call   80103f20 <myproc>
801080c2:	83 a8 88 02 00 00 01 	subl   $0x1,0x288(%eax)
801080c9:	c9                   	leave  
801080ca:	c3                   	ret    
801080cb:	90                   	nop
801080cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(up) myproc()->protected++;
801080d0:	e8 4b be ff ff       	call   80103f20 <myproc>
801080d5:	83 80 88 02 00 00 01 	addl   $0x1,0x288(%eax)
801080dc:	c9                   	leave  
801080dd:	c3                   	ret    
