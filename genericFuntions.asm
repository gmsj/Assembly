org 0x7c00
jmp 0x0000:start

initVideo:
	mov al, 13h
	mov ah, 0
	int 10h
	ret

putPixel:
	; mov al, Cor do Pixel
	; mov cx, X (0 a 319)
	; mov dx, Y (0 a 199)
	mov ah, 0ch
	int 10h
	ret

putchar: ; Label para printar
	mov ah, 0eh
	int 10h
	ret

getchar: ; Label para ler do teclado, após a execução dessa interrupção o caractere lido estará armazenado em AL
	mov ah,0
	int 16h
	ret

newline: ; Label para pular linha e voltar para o inicio após ler o enter
	mov al, 10 ; Line Feed
	call putchar
	mov al, 13 ; Carriage Return
	call putchar
	jmp start

delChar: ; Label para deletar e voltar um espaco após ler o delete
	mov al, 0x08
	call putchar
	mov al, ''
	call putchar
	mov al, 0x08
	call putchar
	jmp start

stoi:
	xor cx, cx
	xor ax, ax
	.loop1:
		push ax
		lodsb
		mov cl, al
		pop ax
		cmp cl, 0 ; check EOF
		je .endloop1
		sub cl, 48 ; '9'-'0' = 9
		mov bx, 10
		mul bx ; 999*10 = 9990
		add ax, cx ; 9990+9 = 9999
		jmp .loop1
	.endloop1:
	ret

start: ; Main do programa
	call getchar
	cmp al, 0x08
	je delChar
	cmp al, 0x0d
	je newline
	call putchar
	jmp start

times 510 - ($ - $$) db 0
dw 0xaa55

; Backspace 0x08
; Enter 0x0d
