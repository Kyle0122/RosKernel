#ifndef SYSTEMCONSOLE_H_
#define SYSTEMCONSOLE_H_

typedef enum Color{
Black	= 0x0,Grey	= 0x8,
Blue	= 0x1,SkyBlue	= 0x9,
Green	= 0x2,LightGreen	= 0xa,
Cyan	= 0x3,LightCyan	= 0xb,
Red	= 0x4,LightRed	= 0xc,
Magenta	= 0x5,LightMagenta	= 0xd,
Brown	= 0x6,Yellow	= 0xe,
White	= 0x7,LightWhite	= 0xf,
} Color;


void println();
void print();
void printWithColor();
void scroll(int mode); //mode =1 for PageDown; 2 for PageUp;

#endif // SYSTEMCONSOLE_H_
