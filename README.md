# Exemplos de códigos e implementações em assembly

## Programas necessários e instalação (Ubuntu, só testei nele hehehe):

  Execute os comandos no terminal do ubuntu:

  * Qemu  (sudo apt-get install qemu)
  * Nasm  (sudo apt-get install nasm)
  * Make  (geralmente pré-instalado no ubuntu)
  
## Para compilar e executar:
  
  Execute os comandos no terminal do ubuntu no diretório dos arquivos:
  
  * nasm -f bin "nomeDoArquivo".asm -o "nomeDoArquivoExec".bin
  * qemu-system-i386 "nomeDoArquivoExec".bin
