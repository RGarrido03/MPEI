clear
close all
clc

%% a)
T = [0   0   0.9 0   0
     1   0   0   0   0
     0   0.8 0   0   0
     0   0.2 0   1   0
     0   0   0.1 0   1];

%% b)
X = [0 1 0 0 0]'; % Estado inicial
P = T^9 * X;
fprintf("b) %.4f\n",P(2));

%% c)
Q = T(1:3, 1:3); % Retirar estados absorventes
F = (eye(3) - Q)^-1;
t = sum(F);

fprintf("c) %.4f iterações\n", t(2)) % t(2) porque estado inicial = 2.

%% d)
R = T(4:5, 1:3);
B = R * F;

fprintf("d) Probabilidade: %.4f\n", B(2,2));
