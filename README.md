## Exemplos de códigos e implementações em assembly

### Sumário:
  
  Todos os arquivos possuem uma breve descrição da sua funcionalidade internamente, mas temos esse sumário para agilizar a busca...
  
  * **enterProtectMode.asm**
    
    Implementação do modo protegido
    
  * **exInt.asm**
    
    Implementação de interrupção
    
  * **genericFuntions.asm**
    
    Implementação de funções genéricas
    
  * **helloWorld.asm**
    
    Esse dispensa descrição
    
  * **sinTaylor.asm** e **sinTaylor.c**
    Implementação de utilização de FPU e integração C e assembly, estes são arquivos dependentes, o exemplo usado é o cálculo da série de taylor

### Programas necessários e instalação (Ubuntu, só testei nele hehehe):

  Execute os comandos no terminal do ubuntu:

  * Qemu  (sudo apt-get install qemu)
  * Nasm  (sudo apt-get install nasm)
  * Make  (geralmente pré-instalado no ubuntu)
  
### Para compilar e executar:
  
  Execute os comandos no terminal do ubuntu no diretório dos arquivos:
  
  * nasm -f bin "nomeDoArquivo".asm -o "nomeDoArquivoExec".bin
  * qemu-system-i386 "nomeDoArquivoExec".bin
