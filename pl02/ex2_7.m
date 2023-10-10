clear
close all
clc

fprintf("Secção 2.2, exercício 7\n\n")
lambda = 15;

%% a)
k = 0;
prob = lambda^k / factorial(k) * exp(-lambda);
fprintf("a) = %f\n", prob);


%% b)
% Receber mais de 10 mensagens é o mesmo que não receber até 10 mensagens.
kArray = 0:10;
probs = zeros(1, length(kArray));

for k = kArray
    probs(k+1) = lambda^k / factorial(k) * exp(-lambda);
end

prob = 1 - sum(probs);
fprintf("b) = %f\n", prob);