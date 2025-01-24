#include <xc.h>
extern unsigned int multi_signed(unsigned char a, unsigned char b);

void main(void) {
    volatile unsigned char a = -128;
    volatile unsigned char b = 3;
    volatile unsigned int result = multi_signed(a,b);
    while(1);
    return;
}
