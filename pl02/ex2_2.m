clear
close all
clc

%% a)
% Espaço de amostragem: 100
% Probabilidade: 0.01


%% b)
% Variável aletória discreta (apenas 3 valores possíveis).
% P(5)   = 0.900
% P(50)  = 0.090
% P(100) = 0.001


%% c)
x = [5 50 100];
px = [0.9 0.09 0.01];
stairs([0 x 110], [0 cumsum(px) 1])
grid
title("Exercício 2.2 c)")
xlim([0 110])
ylim([0 1.05])