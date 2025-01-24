#include <xc.h>
extern unsigned int add(unsigned int a, unsigned int b);

void main(void) {
    volatile unsigned int result = add(12,34);
    while(1);
    return;
}
