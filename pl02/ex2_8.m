clear
close all
clc

fprintf("Secção 2.2, exercício 8\n\n")

lambda = 0.02 * 100;

% 0 ou 1 erros
kArray = [0 1];
probs = zeros(1, length(kArray));

for k = kArray
    probs(k+1) = (lambda^k / factorial(k) * exp(-lambda));
end

prob = sum(probs);
fprintf("Probabilidade = %f\n", prob);