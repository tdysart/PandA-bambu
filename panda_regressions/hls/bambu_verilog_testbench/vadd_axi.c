#ifdef __BAMBU_SIM__
#include <mdpi/mdpi_user.h>
#endif
#include <stdio.h>

/* The three buffers are reached through m_axi pointers, so the testbench has to say how big they
   are (m_param_alloc) and the hardware sees them in a byte-addressed memory. */
#pragma HLS interface port=a mode=m_axi offset=direct bundle=gmem0
#pragma HLS interface port=b mode=m_axi offset=direct bundle=gmem0
#pragma HLS interface port=c mode=m_axi offset=direct bundle=gmem0
void vadd(int *a, int *b, int *c) { for (int i = 0; i < 8; i++) c[i] = a[i] + b[i]; }

int main(void)
{
  int a[8], b[8], c[8];
  for (int run = 0; run < 2; run++) {
    for (int i = 0; i < 8; i++) { a[i] = i + 100 * run; b[i] = 10 * i - run; c[i] = -7; }
#ifdef __BAMBU_SIM__
    m_param_alloc(0, sizeof(a));
    m_param_alloc(1, sizeof(b));
    m_param_alloc(2, sizeof(c));
#endif
    vadd(a, b, c);
    for (int i = 0; i < 8; i++)
      if (c[i] != a[i] + b[i]) { printf("FAIL\n"); return 1; }
  }
  printf("PASS\n");
  return 0;
}
