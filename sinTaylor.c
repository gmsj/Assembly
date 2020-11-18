/************************************************************
*                                                           *
*                Exemplo de utilização de FPU               *    
*                  e integração C e assembly		    *
*                   Autor: Gabriel Matheus                  *    
*                       github.com/gmsj                     *
*                                                           *
************************************************************/

// Parte complementar em C

#include <stdio.h>
#include <stdlib.h>

float obterAngulo () {
	float angulo;
	printf("Digite o angulo:\n");
	scanf("%f", &angulo);
	return angulo;
}

float obterDif () {
	float diferenca;
	printf("Digite a diferenca:\n");
	scanf("%f", &diferenca);
	return diferenca;
}

void imprimir (float seno, float interacoes) {
	printf("Valor do seno [%f] - Num de interacoes [%.0f]\n", seno, interacoes);
}

float fatorial (float num) {
	if (num > 1)
		num *= fatorial(num-1);
	return num;
}

float pot (float num, float exp) {
	int i;
	float result = 1;
	if (exp == 0) {
		return 1;
	}
	for (i = 0; i < exp; i++) {
		result = result * num;
	}
	return result;
}
