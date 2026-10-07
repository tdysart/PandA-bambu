#include <stdio.h>
void vadd(int a[8], int b[8], int c[8]) { for (int i = 0; i < 8; i++) c[i] = a[i] + b[i]; }
int main() {
  int a[8], b[8], c[8], d[8];
  int bad = 0;
  for (int run = 0; run < 2; run++) {
    for (int i = 0; i < 8; i++) { a[i] = i + 100 * run; b[i] = 10 * i - run; c[i] = -7; }
    vadd(a, b, c);
    for (int i = 0; i < 8; i++) if (c[i] != a[i] + b[i]) bad++;
  }
  /* a call that depends on the previous call's output */
  for (int i = 0; i < 8; i++) b[i] = 3;
  vadd(c, b, d);
  for (int i = 0; i < 8; i++) if (d[i] != c[i] + 3) bad++;
  printf(bad ? "FAIL\n" : "PASS\n");
  return bad != 0;
}
