org 0x7e00
jmp 0x0000:start

start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	jmp done

done:
	jmp $

dw 0xaa55
