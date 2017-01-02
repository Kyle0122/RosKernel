
cc = gcc
ld = ld
as = nasm

all: kernel.elf

_start.o : _start.asm
	$(as) -f elf -o _start.o _start.asm

./c/kernel_entry.o : ./c/kernel_entry.c
	$(cc) -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./c/kernel_entry.c -o ./c/kernel_entry.o

./c/SystemConsole.o : ./c/SystemConsole.c
	$(cc) -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./c/SystemConsole.c -o ./c/SystemConsole.o

kernel.elf : _start.o ./c/kernel_entry.o ./c/SystemConsole.o kernel.lds
	$(ld) -T kernel.lds -m elf_i386 -Ttext 0x200000 _start.o ./c/SystemConsole.o ./c/kernel_entry.o -o kernel.elf

run: kernel.elf
	qemu-system-i386  -kernel kernel.elf

clean:
	rm -r *.o
	rm ./c/*.o
