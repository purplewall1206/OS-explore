void memory_copy(char *source, char *dest, int nbytes) {
    int i;
    for (i = 0;i < nbytes; i++) {
        *(dest + i) = *(source + i);
    }
}

// k & r implementation
void int_to_ascii(int n, char str[]) {
    int i, sign;
    if ((sign = n) < 0) n = -n;
    i = 0;
    do 
}