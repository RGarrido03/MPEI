%% Pre-clean
clear
close all
clc


%% a), código 1

% Gerar uma matriz com 3 linhas e 10000 colunas de números aleatórios
% entre 0.0 e 1.0 (ou seja, cada coluna representa uma experiência):
experiencias = rand(3,10000);

% Gerar uma matriz com 3 linhas e 10000 colunas com o valor 1 se o valor
% da matriz anterior for superior a 0.5 (ou seja, se saiu cara) ou com o
% valor 0 caso contrário (ou seja, saiu coroa):
lancamentos = experiencias > 0.5; % 0.5 corresponde a 1 - prob. de caras

% Gerar um vetor linha com 10000 elementos com a soma dos valores de cada
% coluna da matriz anterior (ou seja, o nº de caras de cada experiência):
resultados = sum(lancamentos);

% Gerar um vetor linha com 10000 elementos com o valor 1 quando o valor do
% vetor anterior é 2 (ou seja, se a experiência deu 2 caras) ou 0 quando
% é diferente de 2:
sucessos = resultados == 2;

% Determinar o resultado final dividindo o número de experiências com 2
% caras pelo número total de experiências:
probSimulacao = sum(sucessos)/10000;
fprintf("Probabilidade (código 1) = %f\n", probSimulacao)


%% a), código 2

N = 1e5;    % Número de experiências
p = 0.5;    % Probabilidade de cara
k = 2;      % Número de caras
n = 3;      % Número de lançamentos

lancamentos = rand(n,N) > p;
sucessos = sum(lancamentos) == k;
probSimulacao = sum(sucessos)/N;
fprintf("Probabilidade (código 2) = %f\n", probSimulacao)