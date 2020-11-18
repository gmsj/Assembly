; --------------------------------------------------------------;
;								;
;          	 Exemplo de utilização de FPU	                ;
;                  e integração C e assembly		        ;
;                   Autor: Gabriel Matheus                      ;
;                       github.com/gmsj                         ;
;								;
; --------------------------------------------------------------;

; Função para cálculo do valor do seno de um ângulo, a partir da série de Taylor
; Usar os dois arquivos na mesma pasta: sinTaylor.asm e sinTaylor.c
; Para compilar: nasm -f elf sinTaylor.asm && gcc -m32 -o exec sinTaylor.c sinTaylor.o

section .data
result  dd 0.0
angulo 	dd 0.0
dif 	dd 0.0
inter 	dd 1.0
senoFPU dd 0.0
piRad 	dd 180.0
tmp 	dd 0.0
const0 	dd -1.0
constN 	dd 0.0
teste 	dd 0

section .text

extern obterAngulo, obterDif, imprimir, fatorial, pot

global main

main:
	finit
	call obterAngulo		; Obtem o valor do angulo

	fldpi 					; Empilhando pi para converter pra radianos
	fmulp st1, st0 			; Multiplica pi pelo angulo salva em st1 e desempilha st0
	fld dword [piRad] 		; Empilha 180
	;fxch 					; Troca st0 com st1
	fdivp st1, st0			; Divido st1 por st0, salvo resultado em st1 e desempiliho st0
	fst dword [angulo] 		; Salvando valor retornado

	fsin 					; Calcula o sen e salva em st0
	fstp dword [senoFPU]	; Salva o resultado e desempilha

	call obterDif			; Obtem a diferenca e
	fstp dword [dif]		; Salva o valor e desempilha

	mov eax, [angulo]		; Movendo o valor inicial de result
	mov [result], eax

	condicional:

		; Verificando a condição do loop
		fld dword [result]
		fld dword [senoFPU]
		fsubp st1, st0 			; Subtraindo os dois para fazer a comparação, o resultado está em st0
		fabs 					; Obtendo o valor absoluto
		fcomp dword [dif]		; comparando o resultado com a maxDif e desempilhando
		fstsw ax
		sahf
		jb end 					; Caso o resultado seja menor, já pula pra o final

		; Calculo da constante
		fld1
		fld1
		faddp 					; Somando st0 e st1 e ficando com 2, salva em st1 e desempilha st0
		fld dword [inter]
		fmulp st1, st0 			; Multiplica st0 por st1, salva em st1 e desempilha st0
		fld1
		faddp 					; Somando 1 ao valor da multiplicação
		fstp dword [constN]		; Salvando o resultado da constante e desempilhando

		; Calculo do -1 do numerador
		push dword [inter]
		push dword [const0]
		call pot 				; Empilha o resultado em st0
		add esp, 8

		; Calculo da segunda parte do numerador
		push dword [constN]
		push dword [angulo]
		call pot 				; Empilha o resultado em st0
		add esp, 8

		; Multiplicando os dois
		fmulp st1, st0 			; Multiplica st0 por st1, salva em st1 e desempilha st0

		; Calculo do denominador
		push dword [constN]
		call fatorial 			; Salva o resultado em eax
		add esp, 4

		; Calculo total
		fdivp st1, st0			; Divide st1 por st0 e salva o resultado em st1, e desempilha st0

		; Atualizando o valor de result
		fld dword [result]		; Colocando result na pilha
		faddp 					; Somando o resultado da divisão com result, e desempilhando st0
		fstp dword [result] 	; Atualizando de fato o valor de result

		; Incrementando interação
		fld dword [inter]
		fld1
		faddp
		fstp dword [inter]
		jmp condicional 		; Retorna pra o topo do loop

	end:
		; Ajustando a interação, pois começa com 1
		fld dword [inter]
		fld1
		fsubp st1, st0 			; Subtraindo 1

		fst dword [inter]
		push dword [inter]		; Empilha o valor das interacoes pra o printf
		push dword [result]		; Empilha o resultado pra o printf
		call imprimir
		add esp, 8				; Normaliza a pilha
		
