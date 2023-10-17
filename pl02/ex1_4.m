clear
close all
clc

fprintf("Secção 2.1, exercício 4\n\n")


%% a)
N = 1e5;    % Número de experiências
n = 1;      % Número total de pessoas (dinâmico)
m = 365;    % Número de casos possíveis

n = ex4Simulador(N, n, m, 0.5);

fprintf("a) n = %d\n", n)


%% b)
N = 1e5;    % Número de experiências
n = 1;      % Número total de pessoas (dinâmico)
m = 365;    % Número de casos possíveis

n = ex4Simulador(N, n, m, 0.9);
fprintf("b) n = %d\n", n)


%% function
function n = ex4Simulador(N, n, m, desiredProb)
prob = 0;
while prob <= desiredProb
    n = n + 1;

    experiencias = randi(m, n, N) - 1;
    as = true(1, N);

    for i = 1:N
        aux = experiencias(:, i);
        as(i) = length(unique(aux)) ~= n;
    end

    prob = sum(as)/N;
end
end