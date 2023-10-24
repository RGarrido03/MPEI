clear
close all
clc

fprintf("Exercício 2\n\n")

% Matriz de transição:
%    A    B     C
% A  1/3  0.25  0
% B  1/3  0.55  0.5
% C  1/3  0.2   0.5

T = [1/3 0.25 0; 1/3 0.55 0.5; 1/3 0.2 0.5];

%% a)
fprintf("a) Matriz de transição de estados:\n")
fprintf("%.4f   %.4f   %.4f\n", T')


%% New line
fprintf("\n")


%% b)
syms a b c
[a, b, c] = solve(a+b+c == 90, a == 2*(b+c), b==c);

a = double(a);
b = double(b);
c = double(c);

X = [a b c]';
fprintf("b) Vetor com o estado inicial:\n")
fprintf("%d\n", X')


%% New line
fprintf("\n")


%% c)
A = T^30 * X;
fprintf("c) Número de alunos em cada grupo após 30 aulas\n" + ...
    "Grupo A: %f\n" + ...
    "Grupo B: %f\n" + ...
    "Grupo C: %f\n", ...
    A(1), A(2), A(3));


%% New line
fprintf("\n")


%% d)
X = [30 30 30]';
A = T^30 * X;
fprintf("d) Número de alunos em cada grupo após 30 aulas (distribuição equitativa)\n" + ...
    "Grupo A: %f\n" + ...
    "Grupo B: %f\n" + ...
    "Grupo C: %f\n", ...
    A(1), A(2), A(3));