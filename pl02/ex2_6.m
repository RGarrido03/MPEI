clear
close all
clc

fprintf("Secção 2.2, exercício 6\n\n")

%% a)
p = 1/1000;
n = 8000;
k = 7;

prob_a = nchoosek(n, k) * p^k * (1-p)^(n-k);
fprintf("a) = %f\n", prob_a)


%% b)
lambda = n*p;
prob_b = (lambda^k)/factorial(k) * exp(-lambda);
fprintf("b) = %f\n", prob_b)