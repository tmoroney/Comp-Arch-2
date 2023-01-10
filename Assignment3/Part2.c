#include <stdio.h>

int callCount;
int overflows;
int underflows;
int windowSize;
int stackWindowPointer;

int ack3way(int m, int n, int p)
{
    callCount++;
    if (windowSize < 8) {
        windowSize++;
    }
    int result;
    if(p==0) {
        windowSize--;
        return m+n;
    }
    if(n==0 && p==1) {
        windowSize--;
        return 0;
    }
    if(n==0 && p==2) {
        windowSize--;
        return 1;
    }
    if(n==0) {
        windowSize--;
        return m;
    }
    else {
        if (windowSize >= 8) {
            overflows++;
            stackWindowPointer++;
        }
        int result = ack3way(m,ack3way(m,n-1,p),p-1);
        if (windowSize <= 2 && stackWindowPointer > 0) {
            underflows++;
            stackWindowPointer--;
        }
        if (windowSize > 2) {
            windowSize--;
        }
        return result;
    }
}

int main()
{
    callCount = 1;
    overflows = 0;
    underflows = 0;
    windowSize = 1;
    printf("Result: %d\n", ack3way(10,5,2));
    printf("Num of calls: %d\n", callCount);
    printf("Num of overflows: %d\n", overflows);
    printf("Num of underflows: %d\n", underflows);
    return 0;
}
