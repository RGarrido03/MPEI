clear
close all
clc

N = 1e5;    % Número de experiências
p = 0.5;    % Probabilidade de cara
k = 6;      % Número de caras
n = 15;     % Número de lançamentos

lancamentos = rand(n,N) > p;
sucessos = sum(lancamentos) == k;
probSimulacao = sum(sucessos)/N;
fprintf("Probabilidade = %f\n", probSimulacao)