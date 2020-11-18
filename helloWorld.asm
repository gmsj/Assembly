; --------------------------------------------------------------;
;								                                ;
;          	       Exemplo de um hello world       	            ;
;                   Autor: Gabriel Matheus                      ;
;                       github.com/gmsj                         ;
;								                                ;
; --------------------------------------------------------------;

org 0x7c00        ; Endereço de memória em que o programa será carregado
jmp 0x0000:start  ; Far jump - seta cs para 0

hello db 'Hello, World!', 13, 10, 0 ; Reserva espaço na memória para a string

start:
    xor ax, ax  ; Zera ax, xor é mais rápido que mov
    mov ds, ax  ; Zera ds (não pode ser zerado diretamente)
    mov es, ax  ; Zera es

    mov si, hello ; Faz si apontar para início de 'hello'
    call print_string

    jmp done

print_string:
    lodsb       ; Carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ; Chegou no final? (equivalente a um \0)
    je .done

    mov ah, 0eh ; Código da instrução para imprimir um caractere que está em al
    int 10h     ; Interrupção de vídeo.
    jmp print_string
    .done:
        ret     ; Retorna para o start

done:
    jmp $       ; $ = linha atual

times 510 - ($ - $$) db 0
dw 0xaa55       ; Assinatura de boot
