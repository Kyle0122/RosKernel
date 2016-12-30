#include<types.h>

static uint16_t *video_memory = (uint16_t *)0xB8000;


int printf(char *thestr){
	char* videomemory=(char*)0xB8000;
	unsigned charcount;
	for(charcount=0;*thestr!=0;charcount++){
		*(videomemory++)=*(thestr++);
		*(videomemory++)=0xcf;
	}
	return charcount;
}

void clear_console(){
	uint8_t attribute_byte =(0<<4)|(15&0x0f);
	uint16_t blank = 0x20 | (attribute_byte << 8);
	
	for(int i=0;i<80*25;i++){
		video_memory[i] = blank;
	}
	
}
