clear
close all
clc

fprintf("Exercício 1\n\n")

% Matriz de transição:
%    P    NP
%  P 0.7  0.8
% NP 0.3  0.2
T = [0.7 0.8; 0.3 0.2];

%% a)
X = [1 0]'; % Esteve presente

P = T^2 * X; % Duas aulas
P = P(1); % Estar presente
fprintf("a): P = %f\n", P)


%% b)
X = [0 1]'; % Não esteve presente

P = T^2 * X; % Duas aulas
P = P(1); % Estar presente
fprintf("b): P = %f\n", P)


%% c)
nAulas = 30; % 15 semanas x 2 aulas por semana
X = [1 0]'; % Esteve presente

P = T^nAulas * X;
P = P(1); % Estar presente
fprintf("c): P = %f\n", P)


%% d)
P = zeros(1, 30);
X = [0.85 0.15]'; % Estar presente com probabilidade de 85%

for i = 1:nAulas
    P_temp = T^(i-1) * X;
    P(i) = P_temp(2); % Não estar presente
end

plot(1:nAulas, P, 'k-')
hold on
plot(1:nAulas, P, 'b.')
grid on