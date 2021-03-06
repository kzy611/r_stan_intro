data {
  int T;        // データ取得期間の長さ
  int len_obs;
  int y[len_obs];  // 観測値
  int obs_no[len_obs];
}
parameters {
  vector[T] mu;
  real<lower=0> s_w;
}
model {
  s_w ~ student_t(3, 0, 10);
  for(i in 2:T){
    mu[i] ~ normal(mu[i-1], s_w);
  }
  for(i in 1:len_obs){
    y[i] ~ bernoulli_logit(mu[obs_no[i]]);
  }
}
generated quantities{
  vector[T] probs;
  probs = inv_logit(mu);
}
