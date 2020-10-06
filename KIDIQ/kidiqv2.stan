
data {
  int<lower=0> N;
  int<lower=0> K;
  vector[N] kid_score;
  row_vector[N] mom_hs;
  row_vector[N] mom_iq;
  row_vector[N] mom_work;
  row_vector[N] mom_age;
}

transformed data {
  vector[N] y;
  matrix[N, K] x;   // predictor matrix
  matrix[K,N] xT;
  // declarations below needed for QR decomposition
  matrix[N, K] Q_ast;
  matrix[K, K] R_ast;
  matrix[K, K] R_ast_inverse;
  //combine vectors into matrices
  xT[1] = mom_hs;
  xT[2] = mom_iq - mean(mom_iq);  
  xT[3] = mom_work;
  xT[4] = mom_age - mean(mom_age);

  // flip back into matrix of column vectors again
  x = xT';

  // thin and scale the QR decomposition
  Q_ast = qr_thin_Q(x) * sqrt(N - 1);
  R_ast = qr_thin_R(x) / sqrt(N - 1);
  R_ast_inverse = inverse(R_ast);
  
  y = kid_score; //outcome vector
}
parameters {
  real alpha;           // intercept
  vector[K] theta;       // coefficients on Q_ast
  real<lower=0> sigma;  // error scale
}
model {
  y ~ normal(Q_ast * theta + alpha, sigma);  // likelihood
}
generated quantities {
  vector[K] beta;
  beta = R_ast_inverse * theta; //coefficients on x

}
