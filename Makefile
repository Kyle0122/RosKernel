all: kernel.elf

_start.o : _start.asm
	nasm -f elf -o _start.o _start.asm

./c/kernel_entry.o : ./c/kernel_entry.c
	gcc -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./c/kernel_entry.c -o ./c/kernel_entry.o

./c/printf.o : ./c/printf.c
	gcc -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./c/printf.c -o ./c/printf.o

kernel.elf : _start.o ./c/kernel_entry.o ./c/printf.o kernel.lds
	ld -T kernel.lds -m elf_i386 -Ttext 0x200000 _start.o ./c/printf.o ./c/kernel_entry.o -o kernel.elf

run: kernel.elf
	qemu-system-i386  -kernel kernel.elf
