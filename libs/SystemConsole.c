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
void scroll(int mode){
	if(mode ==1){
		for(int i=80;i<25*80;i++){
			video_memory[i-80]=video_memory[i];
		}
		for(int i=24*80;i<25*80;i++){
			video_memory[i]='\0'|(LightWhite<<4|Black)<<8;
		}
	}else if(mode==2){
		clearConsole();
	}
}
void putChar(char c,char color){
	if(c=='\n'){
		x = 0;y++;
	}else if(c=='\b'&&x){
		x--;
	}else if(c=='\t'){
		x=(x+8)&~(8-1);
	}else if(c=='\r'){
		x=0;
	}else{
		if(x>=80){x=0;y++;}
		if(y>=25){scroll(1);}
		video_memory[y*80+x]= c|color<<8;
        	x++;
	}
	moveCursor();
}

void printWithColor(char *message,char color){
	while(*message){
		putChar(*message,color);
		message++;
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
