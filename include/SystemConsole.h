#ifndef SYSTEMCONSOLE_H_
#define SYSTEMCONSOLE_H_

typedef enum 
{
	
} BackgroundColor;

typedef enum
{
	
} ForegroundColor;

void println();
void print();
void printWithColor();
void scroll(int mode); //mode =1 for PageDown; 2 for PageUp;

#endif // SYSTEMCONSOLE_H_