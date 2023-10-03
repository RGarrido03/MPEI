clear
close all
clc

%% a)
N = 1e5;    % Número de experiências
n = 10;     % Número total de keys
m = 1000;   % Número de casos possíveis

experiencias = randi(m, n, N) - 1;
as = true(1, N);

for i = 1:N
    aux = experiencias(:, i);
    as(i) = length(unique(aux)) ~= n; % Probabilidade de ter duas keys iguais
end

prob = sum(as)/N;
fprintf("Alínea a): %f\n", prob)


%% b)
N = 1e5;    % Número de experiências
n = [10 50 100 500 1000];     % Número de keys
m = 1000;   % Número de casos possíveis

probabilidades = zeros(1, length(n));

for i = 1:length(n)
    experiencias = randi(m, n(i), N) - 1;
    as = true(1, N);

    for j = 1:N
        aux = experiencias(:, j);
        as(j) = length(unique(aux)) ~= n(i); % Probabilidade de ter duas ou mais keys iguais
    end

    probabilidades(i) = sum(as)/N;
end

stem(n, probabilidades)


%% c)
% To be continued