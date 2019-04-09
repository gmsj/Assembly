org 0x500
jmp 0x0000:start

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x7e0 ; 0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;Posição es<<1+bx

    jmp reset

reset:
    mov ah, 00h ; Reseta o controlador de disco
    mov dl, 0   ; Floppy disk
    int 13h

    jc reset    ; Se o acesso falhar, tenta novamente

    jmp load


load:
    mov ah, 02h ; Lê um setor do disco
    mov al, 20  ; Quantidade de setores ocupados pelo kernel
    mov ch, 0   ; Track 0
    mov cl, 3   ; Sector 3
    mov dh, 0   ; Head 0
    mov dl, 0   ; Drive 0
    int 13h

    jc load     ; Se o acesso falhar, tenta novamente

    jmp 0x7e00  ; Pula para o setor de endereco 0x7e00 (start do boot2)
