#include <stdio.h>
#include "nwd.h"
#include "logger.h"

int main() 
{
    logger_initConsoleLogger(stderr);
    logger_setLevel(LogLevel_DEBUG);
    LOG_INFO("console logging");
    
    int liczba1, liczba2;

    printf("Enter the first number: ");
    scanf("%d", &liczba1);

    printf("Enter the second number: ");
    scanf("%d", &liczba2);

    int wynikNWD = obliczNWD(liczba1, liczba2);

    printf("GCD(%d, %d) = %d\n", liczba1, liczba2, wynikNWD);

    return 0;
}
