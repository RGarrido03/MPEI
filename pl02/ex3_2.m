clear
close all
clc

fprintf("Secção 2.3, exercício 2\n\n")

N = 1e5;
n = 8;

p_1 = 0.002;
p_2 = 0.005;
p_m = 0.01;

exp_1 = rand(n, N) <= p_1;
exp_2 = rand(n, N) <= p_2;
exp_m = rand(n, N) <= p_m;


%% a)
ex = exp_1 | exp_2 | exp_m;
ex = sum(ex) == 0; % Boxes with no deffective toy

prob = sum(ex)/N;
fprintf("a) %f\n", prob);


%% b)
prob = ((1-p_1) * (1-p_2) * (1-p_m))^8;
fprintf("b) %f\n", prob);


%% c)
n = 2:20;
probs = zeros(1, length(n));

for i = 1:length(n)
    exp_1 = rand(n(i), N) <= p_1;
    exp_2 = rand(n(i), N) <= p_2;
    exp_m = rand(n(i), N) <= p_m;

    ex = exp_1 | exp_2 | exp_m;
    ex = sum(ex) == 0; % Boxes with no deffective toy

    probs(i) = sum(ex)/N;
end

plot(n,probs)
hold on
plot(n, probs, 'b.')
hold off
grid on
title("Exercício 2. c)")


%% d)
fprintf("d) n = 6")