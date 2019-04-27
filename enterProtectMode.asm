; --------------------------------------------------------------;
;																;
;          		 Implementação do modo protegido				;
;                   Autor: Gabriel Matheus						;
;                       github.com/gmsj							;
;																;
; --------------------------------------------------------------;

; Este arquivo deve ser renomeado e usado como kernel junto com os arquivos do bootloaderBase no mesmo repositório

[bits 16]

org 0x7e00
jmp start

GDT:

GDTnull:
	dd 0
	dd 0

GDTcode: ; Criando o descritor de segmento
	dw 0FFFFh 		; Limit low
    dw 0 			; Base low
    db 0 			; Base middle
    db 10011010b	; Access
	; |1|00|11010|
	; | |  |
	; | |  TYPE
	; | DPL
	; P
    db 11001111b	; Granularity
    ; |1|1|0|0|1111|
	; | | | | |
	; | | | | LIMIT
	; | | | AVL
	; | | L
	; | D/B
	; G
    db 0 ; Base high

GDTdata: ; Bem parecido com a GDTcode, mudando o TYPE
	dw 0FFFFh
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0

endOfGDT:

toc:
	dw endOfGDT - GDT -1 ; limit (Size of GDT)
	dd GDT 				 ; base of GDT

installGDT:
	cli				; clear interrupts
	pusha			; save registers
	lgdt [toc]		; load GDT into GDTR
	sti				; enable interrupts
	popa			; restore registers
	ret				; All done

start:
	call installGDT
	cli 			; Desablita as interrupções

	; Setar o bit 0 (PE) para 1
	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp 08h:protectMode

[bits 32]

clearScreen:
	pushad
	cld
	mov edi, 0xB8000
	mov cx, 80*25
	mov ah, 0x0F
	mov al, ' '
	rep stosw
	popad
	ret

welcome:
	mov byte [ds:0x0B8000], 'W'
    mov byte [ds:0x0B8001], 0x0F
    mov byte [ds:0x0B8002], 'e'
    mov byte [ds:0x0B8003], 0x0F
    mov byte [ds:0x0B8004], 'l'
    mov byte [ds:0x0B8005], 0x0F
    mov byte [ds:0x0B8006], 'c'
    mov byte [ds:0x0B8007], 0x0F
    mov byte [ds:0x0B8008], 'o'
    mov byte [ds:0x0B8009], 0x0F
    mov byte [ds:0x0B800A], 'm'
    mov byte [ds:0x0B800B], 0x0F
    mov byte [ds:0x0B800C], 'e'
    mov byte [ds:0x0B800D], 0x0F
    mov byte [ds:0x0B800E], '!'
    mov byte [ds:0x0B800F], 0x0F
    ret

protectMode:
	; Aqui já estamos no modo protegido

	mov	ax, 0x10	; set data segments to data selector (0x10)
	mov	ds, ax
	mov	ss, ax
	mov	es, ax
	mov	esp, 90000h	; stack begins from 90000h

	call clearScreen
	call welcome

stop:
	cli
	hlt
