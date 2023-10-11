clear
close all
clc

lambda = 0.02;

% 0 ou 1 erros
kArray = [0 1];
probs = zeros(1, length(kArray));

for k = kArray
    probs(k+1) = (lambda^k / factorial(k) * exp(-lambda))^100;
end

prob = sum(probs);
fprintf("Probabilidade = %f\n", prob);