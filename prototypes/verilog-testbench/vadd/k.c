#include <stdio.h>
void vadd(int a[8], int b[8], int c[8]) { for (int i = 0; i < 8; i++) c[i] = a[i] + b[i]; }
int main() {
  int a[8], b[8], c[8];
  for (int i = 0; i < 8; i++) { a[i] = i; b[i] = 10 * i; c[i] = 0; }
  vadd(a, b, c);
  for (int i = 0; i < 8; i++) if (c[i] != 11 * i) { printf("FAIL\n"); return 1; }
  printf("PASS\n"); return 0;
}
