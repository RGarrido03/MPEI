clear
close all
clc

fprintf("Exercício 3\n\n")

%% a)
n = 20;
T = rand(n);

for i = 1:n
    s = sum(T(:,i));
    T(:,i) = T(:,i) / s;
end

fprintf("a) Matriz de transição\n")
fprintf("%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f\n", T')


%% Print line
fprintf("\n")


%% b)
fprintf("b) Probabilidade de passar do estado 1 para o estado 20\n")

nTransicoes = [2 5 10 100];
for i = 1:length(nTransicoes)
    T_temp = T^nTransicoes(i);
    fprintf("%-16s%2.4f%%\n", nTransicoes(i) + " transições:", T_temp(20, 1) * 100)
end