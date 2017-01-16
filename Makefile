
cc = gcc
ld = ld
as = nasm

c_flags =  -c -m32 -Wall -nostdinc -fno-builtin -fno-stack-protector -Iinclude

all: kernel.elf

_start.o : _start.asm
	$(as) -f elf -o _start.o _start.asm

./c/kernel_entry.o : ./c/kernel_entry.c
	$(cc) $(c_flags) ./c/kernel_entry.c -o ./c/kernel_entry.o

./libs/SystemConsole.o : ./libs/SystemConsole.c ./libs/SystemIO.o
	$(cc) $(c_flags) ./libs/SystemConsole.c -o ./libs/SystemConsole.o

./libs/SystemIO.o : ./libs/SystemIO.c
	$(cc) $(c_flags) ./libs/SystemIO.c -o ./libs/SystemIO.o

kernel.elf : _start.o ./c/kernel_entry.o ./libs/SystemConsole.o ./libs/SystemIO.o kernel.lds
	$(ld) -T kernel.lds -m elf_i386 -Ttext 0x200000 _start.o ./libs/SystemIO.o ./libs/SystemConsole.o ./c/kernel_entry.o -o kernel.elf

run: kernel.elf
	qemu-system-i386  -kernel kernel.elf

clean:
	rm -r *.o
	rm ./c/*.o
