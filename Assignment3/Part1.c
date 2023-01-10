#include <stdio.h>

int max3(int a, int b, int c) {
    int M = a;
    if(b > M)
        M = b;
    if(c > M)
        M = c;
    return M;
}

int max4(int a, int b, int c, int d)
{
    return (max3(max3(a,b,c),c,d));
}

int main()
{
    max4(50, 99, 100, 111);
    return 0;
}