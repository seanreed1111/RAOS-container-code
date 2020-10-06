
data {
  int<lower=0> N;
  vector[N] growth;
  vector[N] inc_party_vote;
}
parameters {
  real alpha;
  real beta;
  real <lower=0> sigma;
}
model {
  inc_party_vote ~ normal(alpha + beta * growth, sigma);
}
