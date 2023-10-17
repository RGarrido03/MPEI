clear
close all
clc

fprintf("Secção 2.2, exercício 9\n\n")

media = 14;
desvioPadrao = 2;
N = 1e5;

y = desvioPadrao .* randn(1,N) + media;

%% a)
prob = sum(y >= 12 & y <= 16) / N;
fprintf("a) %f\n", prob)


%% b)
prob = sum(y >= 10 & y <= 18) / N;
fprintf("b) %f\n", prob)


%% c)
prob = sum(y >= 10) / N;
fprintf("c) %f\n", prob)


%% d)
p_a = normcdf([12 16], media, desvioPadrao);
prob_a = p_a(2) - p_a(1);

p_b = normcdf([10 18], media, desvioPadrao);
prob_b = p_b(2) - p_b(1);

prob_c = 1 - normcdf(10, media, desvioPadrao);

histogram(y)
fprintf("\nAlínea d):\n" + ...
    "a) %f\n" + ...
    "b) %f\n" + ...
    "c) %f\n", ...
    prob_a, prob_b, prob_c ...
);
