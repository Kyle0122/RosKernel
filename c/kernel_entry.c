#include<SystemConsole.h>

void kernel_entry(){
	clearConsole();
	for(int i=0;i<=20;i++)
	print("Hello OS\n");
}
