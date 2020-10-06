
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

  //add vectors into matrices one by one
  xT[1] = mom_hs;
  xT[2] = mom_iq;  
  xT[3] = mom_work;
  xT[4] = mom_age;

  // flip back into matrix of column vectors again
  x = xT';

  y = kid_score; //outcome vector
}
parameters {
  real alpha;           // intercept
  vector[K] beta;       // coefficients on x
  real<lower=0> sigma;  // error scale
}
model {
  y ~ normal(alpha + x * beta, sigma);  // likelihood
}
