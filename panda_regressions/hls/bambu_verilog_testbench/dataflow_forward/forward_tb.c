#include <stdio.h>
#include <string.h>

/* Reference model of the dataflow design: D = 0.5 * (A * B) + 0.1f * C. The three dataflow
   nodes (matmul, scale-and-add, store) compute exactly this, in single precision, with no
   fused multiply-add. */
void forward(float A[8][6], float B[6][4], float C[8][4], float D[8][4])
{
  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 4; j++) {
      float acc = 0.0f;
      for (int k = 0; k < 6; k++) acc = acc + A[i][k] * B[k][j];
      D[i][j] = acc * 0.5f + C[i][j] * 0.1f;
    }
}

int main(void)
{
  float A[8][6], B[6][4], C[8][4], D[8][4];
  for (int i = 0; i < 8; i++) for (int k = 0; k < 6; k++) A[i][k] = (i + 1) * 0.25f - k * 0.125f;
  for (int k = 0; k < 6; k++) for (int j = 0; j < 4; j++) B[k][j] = (k + 2) * 0.5f + j * 0.375f;
  for (int i = 0; i < 8; i++) for (int j = 0; j < 4; j++) { C[i][j] = i * 1.5f - j; D[i][j] = -1.0f; }
  forward(A, B, C, D);
  printf("D[0][0]=%f D[7][3]=%f\n", D[0][0], D[7][3]);
  return 0;
}
