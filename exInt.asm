; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;
;           Exemplo de implementação de interrupção
;                   Autor: Gabriel Matheus
;                       github.com/gmsj
;
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


org 0x7c00
jmp 0x0000:start

string db 'Temos uma interrupcao funcionando...', 0

configIVT: ; Label completamente desnecessária para configurar a IVT (pode ser feito direto na main)
    push ds
    xor ax, ax
	mov ds, ax
	mov es, ax
    mov di, 100h ; Número da instrução * 4 para o deslocamento na IVT
    mov word[di], int40h ; Salvando IP naquela posição de memória, onde (CS << 4 + IP) tem que resultar na posição de memória onde está a rotina de tratamento
    mov word[di+2], 0 ; Salvando CS
    pop ds
    ret

int40h: ; Criação da interrupção
    ; Como isso é apenas um exemplo, a rotina de tratamento é bem simples, nesse caso "chama" a label print_string
    pusha ; Salvando contexto anterior
    mov si, string
    call print_string
    popa ; Restaurando contexto anterior
    iret ; Retorno da interrupção

print_string:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0eh
    int 10h
    jmp print_string
    .done:
    ret

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    call configIVT ; Chamada da configuração
    int 40h ; Chamada da interrupção
	jmp done

done:
	jmp $ ; $ = linha atual

times 510 - ($ - $$) db 0
dw 0xaa55
