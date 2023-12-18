#include "nwd.h"

int obliczNWD(int a, int b) 
{
    while (a != b) 
    {
        if (a > b) 
        {
            a -= b;
        } 
        else 
        {
            b -= a;
        }
    }
    return a;
}
