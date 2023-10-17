clear
close all
clc

fprintf("Secção 2.2, exercício 1\n\n")

x = [1 2 3 4 5 6];
y = [1/6 1/6 1/6 1/6 1/6 1/6];
figure

%% a)
subplot(2,1,1)
stem(x, y)
title("Função massa de probabilidade")


%% b)
subplot(2,1,2)
stairs([0 x 7], [0 cumsum(y) 1])
title("Função de distribuição acumulada")
xlim([0 7])