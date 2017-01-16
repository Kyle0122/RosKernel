#include<SystemConsole.h>
#include<multiboot.h>
extern multiboot_t *glb_mboot_ptr;
void kernel_entry(){
	clearConsole();
	for(int i=0;i<=3;i++){
		print("Hello OS\n");
	}
	println("---------------------");
	readNames(glb_mboot_ptr);
	println("---------------------");
}
