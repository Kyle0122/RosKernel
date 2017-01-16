
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

kernel.elf : _start.o ./c/kernel_entry.o ./libs/SystemConsole.o ./libs/string.o ./libs/SystemIO.o ./libs/elf.o kernel.lds
	$(ld) -T kernel.lds -m elf_i386 -Ttext 0x200000 _start.o ./libs/SystemIO.o ./libs/SystemConsole.o ./libs/string.o ./c/kernel_entry.o ./libs/elf.o -o kernel.elf

./libs/elf.o : ./libs/elf.c
	$(cc) $(c_flags) ./libs/elf.c -o ./libs/elf.o

./libs/string.o : ./libs/string.c
	$(cc) $(c_flags) ./libs/string.c -o ./libs/string.o

run: kernel.elf
	qemu-system-i386  -kernel kernel.elf

clean:
	rm -r *.o
	rm ./c/*.o
