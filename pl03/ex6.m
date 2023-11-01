clear
close all
clc

fprintf("Exercício 6\n\n")

%% a)
%     1    2    4    3    5
T = [0.8  0.0  0.3  0.0  0.0
     0.2  0.6  0.2  0.0  0.0
     0.0  0.1  0.4  0.0  0.0
     0.0  0.3  0.0  1.0  0.0
     0.0  0.0  0.1  0.0  1.0];

fprintf("a) Matriz de transição de estados:\n")
fprintf("   %.4f   %.4f   %.4f   %.4f   %.4f\n", T')


%% Print line
fprintf("\n")


%% b)
n = 1:100;
probs = zeros(1, length(n));
X = [1 0 0 0 0]';

for i = n
    a = T^i * X;
    probs(i) = a(2);
end

figure
plot(n, probs)
grid on
xlabel("n")
ylabel("Probabilidade")
title("Probabilidade de estar no estado 3 a partir do estado 1")


%% c)
n = 1:100;
probs_3 = zeros(1, length(n));
probs_5 = zeros(1, length(n));

X = [1 0 0 0 0]';

for i = n
    a = T^i * X;
    probs_3(i) = a(4);
    probs_3(i) = a(5);
end

figure
plot(n, probs_3)
hold on
plot(n, probs_5)
hold off

grid on
legend("Estado 3", "Estado 5")
xlabel("n")
ylabel("Probabilidade")
title("Probabilidade de estar num determinado estado a partir do estado 1")


%% d)
Q = T(1:3, 1:3);

fprintf("d) Matriz Q:\n")
fprintf("   %.4f   %.4f   %.4f\n", Q')


%% Print line
fprintf("\n")


%% e)
F = (eye(3) - Q)^-1;
R = T(4:5, 1:3);
B = R * F;

fprintf("e) Matriz F:\n")
fprintf("   %.4f   %.4f   %.4f\n", F')

fprintf("\n   Matriz R:\n")
fprintf("   %.4f   %.4f   %.4f\n", R')

fprintf("\n   Matriz B:\n")
fprintf("   %.4f   %.4f   %.4f\n", B')