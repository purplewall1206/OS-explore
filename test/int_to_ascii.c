#include <stdio.h>

void int_to_ascii(int n, char str[]) {
    int i, sign;
    if ((sign = n) < 0) n = -n;
    i = 0;
    do {
        str[i++] = n % 10 + '0';
    } while ((n /= 10) > 0);

    if (sign < 0) str[i++] = '-';
    str[i] = '\0';

    /* TODO: implement "reverse" */
}

int main()
{
    char buf[256];
    for (int i = 0;i < 25;i++) {
        int_to_ascii(i, buf);
        printf("%s\n", buf);
    }
    return 0;
}