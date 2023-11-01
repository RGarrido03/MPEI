clear
close all
clc

fprintf("Exercício 5\n\n")

%% a)
T = [0.7 0.2 0.3
     0.2 0.3 0.3
     0.1 0.5 0.4];

fprintf("a) Matriz de transição de estados:\n")
fprintf("   %.4f   %.4f   %.4f\n", T')


%% Print line
fprintf("\n")


%% b)
% Sol no primeiro dia -> Sol
X = [1 0 0]';
P2 = T * X;
P2 = P2(1);

% Sol no segundo dia -> Sol
X = [1 0 0]';
P3 = T * X;
P3 = P3(1);

P = P2 * P3;
fprintf("b) %f\n", P)


%% Print line
fprintf("\n")


%% c)
% Sol no primeiro dia -> Sol ou nuvens
X = [1 0 0]';
P2 = T * X;
P2(3) = 0;

% Sol ou nuvens no segundo dia -> Sol ou nuvens
P3 = T * P2;
P3 = P3(1) + P3(2);

% Print
fprintf("c) %f\n", P3)


%% Print line
fprintf("\n")


%% d)
X = [1 0 0]';

n = 1:30;
probs = zeros(3, length(n));

for i = 1:length(n)
    probs(:,i) = T^n(i) * X;
end

P = sum(probs, 2);
P = P + X;

fprintf("e) Número médio de dias com sol: %f\n" + ...
    "   Número médio de dias com nuvens: %f\n" + ...
    "   Número médio de dias com chuva: %f\n", ...
    P(1), P(2), P(3));


%% Print line
fprintf("\n")


%% e)
X = [0 0 1]';

n = 1:30;
probs = zeros(3, length(n));

for i = 1:length(n)
    probs(:,i) = T^n(i) * X;
end

P = sum(probs, 2);
P = P + X;

fprintf("e) Número médio de dias com sol: %f\n" + ...
    "   Número médio de dias com nuvens: %f\n" + ...
    "   Número médio de dias com chuva: %f\n", ...
    P(1), P(2), P(3));


%% Print line
fprintf("\n")


%% f)
% Sol
reumatismo = [0.1 0.3 0.5];
n = 1:30;
probs = zeros(3, length(n));

X = [1 0 0]';
for i = 1:length(n)
    probs(:,i) = T^n(i) * X;
end

P = sum(probs, 2);
P = P + X;
P = sum(P .* reumatismo');

fprintf("f) Se o primeiro dia for sol, número médio de dias com dores: %f\n", P)

% Chuva
X = [0 0 1]';
for i = 1:length(n)
    probs(:,i) = T^n(i) * X;
end

P = sum(probs, 2);
P = P + X;
P = sum(P .* reumatismo');

fprintf("   Se o primeiro dia for chuva, número médio de dias com dores: %f\n", P)