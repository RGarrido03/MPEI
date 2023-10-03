clear
close all
clc

%% a)
N = 1e5;    % Número de experiências
n = 2;      % Número total de dados lançados
m = 6;      % Número de faces por dado

experiencias = randi(m, n, N);
as_a = true(1, N);
as_b = true(1, N);
as_c = true(1, N);
as_d = true(1, N);

for i = 1:N
    aux = experiencias(:, i);
    as_a(i) = aux(1) + aux(2) == 9;
    as_b(i) = rem(aux(2), 2) == 0;
    as_c(i) = sum(aux==5) > 0;
    as_d(i) = sum(aux==1) == 0;
end

prob_a = sum(as_a)/N;
prob_b = sum(as_b)/N;
prob_c = sum(as_c)/N;
prob_d = sum(as_d)/N;
fprintf("Alínea a)\n" + ...
    "Acontecimento A: %f\n" + ...
    "Acontecimento B: %f\n" + ...
    "Acontecimento C: %f\n" + ...
    "Acontecimento D: %f\n", ...
    prob_a, prob_b, prob_c, prob_d);


%% Print line
fprintf("\n")


%% b)
CP_a = 36;  % 6*6
CP_b = 6;   % Número de faces

CF_a = 4;   % 6+3, 5+4, vice-versa
CF_b = 3;   % 2, 4, 6

P_a = CF_a/CP_a;
P_b = CF_b/CP_b;
P_ab = 2 / 36;
fprintf("p(AB) = %f\np(A)p(B) = %f\n", P_ab, P_a * P_b)
fprintf("A e B são acontecimentos independentes\n")


%% Print line
fprintf("\n")


%% c)
CP_c = 36;
CP_d = 36;

CF_c = 11;      % 5,1; 5,2; 5,3; ...; 1,5; 2,5; ...; 5,5
CF_d = 36-11;   % Todos menos o caso anterior (mas com 1 em vez de 5)

P_c = CF_c/CP_c;
P_d = CF_d/CP_d;
P_cd = 9 / 36;
fprintf("p(CD) = %f\np(C)p(D) = %f\n", P_cd, P_c * P_d)
fprintf("C e D não são acontecimentos independentes\n")