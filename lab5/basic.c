#include<xc.h>
extern unsigned char mysqrt(unsigned char a);

void main(void) {
    volatile unsigned char a = 144;
    volatile unsigned char result = mysqrt(a);
    while(1);
    return;
}
