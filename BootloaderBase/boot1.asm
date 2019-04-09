org 0x7c00
jmp 0x0000:start

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x50 ; 0x50<<1 = 0x500 (início de boot2.asm)
    mov es, ax
    xor bx, bx   ; Posição = es<<1+bx

    jmp reset

reset:
    mov ah, 00h ; Reseta o controlador de disco
    mov dl, 0   ; Floppy disk
    int 13h

    jc reset    ; Se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ; Lê um setor do disco
    mov al, 1   ; Quantidade de setores ocupados pelo boot2
    mov ch, 0   ; Track 0
    mov cl, 2   ; Sector 2
    mov dh, 0   ; Head 0
    mov dl, 0   ; Drive 0
    int 13h

    jc load     ; Se o acesso falhar, tenta novamente

    jmp 0x500   ; Pula para o setor de endereco 0x500 (start do boot2)

times 510-($-$$) db 0 ; 512 bytes
dw 0xaa55             ; Assinatura
