library(rstan)
library(bayesplot)

file_beer_sales_2 <- read.csv("3-2-1-beer-sales-2.csv")
sample_size <- nrow(file_beer_sales_2)

formula_lm <- formula(sales ~ temperature)
X <- model.matrix(formula_lm, file_beer_sales_2)
head(X, n = 5)

N <- nrow(file_beer_sales_2)
K <- 2
Y <- file_beer_sales_2$sales

data_list_design <- list(N = N, K = K, Y = Y, X = X)
data_list_design

mcmc_result_design <- stan(
  file = "3-4-1-lm-design-matrix.stan",
  data = data_list_design,
  seed = 1
)

print(mcmc_result_design, probs = c(0.025, 0.5, 0.975))
