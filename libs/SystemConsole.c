#include<types.h>
#include<SystemConsole.h>

static uint16_t *video_memory = (uint16_t *)0xB8000;

void putCharsWithColor(char *message,char color){
	char* videomemory=(char*)video_memory;
	while(*message!=0){
		*(videomemory++)=*(message++);
		*(videomemory++)=color;
	}
}

void putChars(char *message){
	putCharsWithColor(message,LightWhite<<4|Black);
}

void clear_console(){
	uint8_t attribute_byte = LightWhite<<4|Black;
	uint16_t blank = '\0' | (attribute_byte << 8);
	
	for(int i=0;i<80*25;i++){
		video_memory[i] = blank;
	}
	
}
