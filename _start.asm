MULTIBOOT_HEADER_MAGIC equ 0x1BADB002
MULTIBOOT_HEADER_FLAGS equ 0x00000003
MULTIBOOT_HEADER_CHECKSUM equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

extern kernel_entry
global _start
global glb_mboot_ptr

align 4

[section .text]

multibootheader:
dd MULTIBOOT_HEADER_MAGIC
dd MULTIBOOT_HEADER_FLAGS
dd MULTIBOOT_HEADER_CHECKSUM

_start:
cli

mov esp, STACK_TOP
mov ebp,0
and esp,0FFFFFFF0H
mov [glb_mboot_ptr],ebx

call kernel_entry
hlt
jmp$


[section .bss]
stack:
	resb 32768
glb_mboot_ptr:
	resb 4
STACK_TOP equ $-stack-1
