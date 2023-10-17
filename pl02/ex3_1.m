clear
close all
clc

fprintf("Secção 2.3, exercício 1\n\n")

N = 1e5;
n = 8;

exp_1 = rand(n, N) <= 0.002;
exp_2 = rand(n, N) <= 0.005;
exp_m = rand(n, N) <= 0.01;

%% a)
ex = exp_1 | exp_2 | exp_m;
ex = sum(ex) > 0; % Boxes with at least one deffective toy

prob = sum(ex)/N;
fprintf("a) %f\n", prob);


%% b)
ex_b = ~exp_1 & ~exp_2 & exp_m;
ex_b = sum(ex_b) > 0; % Boxes with at least one deffective toy

prob = sum(ex_b)/sum(ex);
fprintf("a) %f\n", prob);
