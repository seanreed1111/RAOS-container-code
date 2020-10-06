
data {
  int<lower=0> N;
  int<lower=0> K;
  vector[N] kid_score;
  vector[N] mom_hs;
  vector[N] mom_iq;
  vector[N] mom_work;
  vector[N] mom_age;
}

transformed data {
  vector[N] y;
  matrix[N, K] x;   // predictor matrix
  matrix[K,N] xT;
  xT[1] = mom_hs';
  xT[2] = mom_iq';  
  xT[3] = mom_work';
  xT[4] = mom_age';
  x = xT';
  y = kid_score;
}
parameters {
  real alpha;           // intercept
  vector[K] beta;       // coefficients for predictors
  real<lower=0> sigma;  // error scale
}
model {
  y ~ normal(x * beta + alpha, sigma);  // likelihood
}
