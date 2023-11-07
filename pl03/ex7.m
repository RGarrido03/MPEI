clear
close all
clc

fprintf("Exercício 7\n\n")


%% a)
%    A    B    C    D    E    F
H = [0.0  0.0  0.0  0.0  1/3  0.0   % A
     1.0  0.0  0.0  0.0  1/3  0.0   % B
     0.0  1/2  0.0  1.0  0.0  0.0   % C
     0.0  0.0  1.0  0.0  0.0  0.0   % D
     0.0  1/2  0.0  0.0  0.0  0.0   % E
     0.0  0.0  0.0  0.0  1/3  0.0]; % F

r = H^10 * [1/6 1/6 1/6 1/6 1/6 1/6]';
fprintf("a) P(A) = %f\n   " + ...
    "P(B) = %f\n   " + ...
    "P(C) = %f\n   " + ...
    "P(D) = %f\n   " + ...
    "P(E) = %f\n   " + ...
    "P(F) = %f\n", r);


%% Print line
fprintf("\n")


%% b)
fprintf("b) O dead-end é a página F.\n")
fprintf("   A spider-trap encontra-se nas páginas C e D.\n")


%% Print line
fprintf("\n")


%% c)
%    A     B    C    D    E    F
H2 = [0.0  0.0  0.0  0.0  1/3  1/6   % A
      1.0  0.0  0.0  0.0  1/3  1/6   % B
      0.0  1/2  0.0  1.0  0.0  1/6   % C
      0.0  0.0  1.0  0.0  0.0  1/6   % D
      0.0  1/2  0.0  0.0  0.0  1/6   % E
      0.0  0.0  0.0  0.0  1/3  1/6]; % F

r = H2^10 * [1/6 1/6 1/6 1/6 1/6 1/6]';
fprintf("c) P(A) = %f\n   " + ...
    "P(B) = %f\n   " + ...
    "P(C) = %f\n   " + ...
    "P(D) = %f\n   " + ...
    "P(E) = %f\n   " + ...
    "P(F) = %f\n", r);


%% Print line
fprintf("\n")


%% d)
beta = 0.8;
A = beta * H2 + (1-beta) * (zeros(6) + 1/6);

r = A^10 * [1/6 1/6 1/6 1/6 1/6 1/6]';
fprintf("d) P(A) = %f\n   " + ...
    "P(B) = %f\n   " + ...
    "P(C) = %f\n   " + ...
    "P(D) = %f\n   " + ...
    "P(E) = %f\n   " + ...
    "P(F) = %f\n", r);


%% Print line
fprintf("\n")


%% e)
i = 0;
old = [1/6 1/6 1/6 1/6 1/6 1/6]';

while true
    i = i + 1;

    new = A * old;
    diff = max(new - old);

    old = new;

    if diff < 1e-4
        break
    end
end

fprintf("e) Número de iterações necessárias: %d\n", i);
fprintf("   P(A) = %f\n   " + ...
    "P(B) = %f\n   " + ...
    "P(C) = %f\n   " + ...
    "P(D) = %f\n   " + ...
    "P(E) = %f\n   " + ...
    "P(F) = %f\n", new);