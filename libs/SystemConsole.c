#include<types.h>
#include<SystemConsole.h>
#include<SystemIO.h>
static uint16_t *video_memory = (uint16_t *)0xB8000;
static uint8_t x=0;
static uint8_t y=0;

static void moveCursor(){
	uint16_t location = 80*y + x;
	outb(0x3D4,14);
	outb(0x3D5,location>>8);
	outb(0x3D4,15);
	outb(0x3D5,location);
}

void printWithColor(char *message,char color){
	while(*message){
		video_memory[y*80+x]=*(message++) | color<<8;
		x++;
		if(x==81){
			x=0;
			y++;
		}
		moveCursor();
	}
}

void print(char *message){
	printWithColor(message,LightWhite<<4|Black);
}
void println(char *message){
	printWithColor(message,LightWhite<<4|Black);
	printWithColor("\n",LightWhite<<4|Black);
}

void clearConsole(){
	uint8_t colorByte = LightWhite<<4|Black;
	uint16_t blank = ' ' | (colorByte << 8);
	for(int i=0;i<80*25;i++){
		video_memory[i] = blank;
	}
	x=0;y=0;
	moveCursor();
}
