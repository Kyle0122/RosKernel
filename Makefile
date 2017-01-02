
cc = i386-elf-gcc
ld = i386-elf-ld
as = i386-elf-nasm

all: kernel.elf

_start.o : _start.asm
	$(as) -f elf -o _start.o _start.asm

./c/kernel_entry.o : ./c/kernel_entry.c
	$(cc) -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./c/kernel_entry.c -o ./c/kernel_entry.o

./libs/SystemConsole.o : ./libs/SystemConsole.c
	$(cc) -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude ./libs/SystemConsole.c -o ./libs/SystemConsole.o

kernel.elf : _start.o ./c/kernel_entry.o ./libs/SystemConsole.o kernel.lds
	$(ld) -T kernel.lds -m elf_i386 -Ttext 0x200000 _start.o ./libs/SystemConsole.o ./c/kernel_entry.o -o kernel.elf

run: kernel.elf
	qemu-system-i386  -kernel kernel.elf

clean:
	rm -r *.o
	rm ./c/*.o
