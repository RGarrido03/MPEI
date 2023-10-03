clear
close all
clc

casosPossiveis = 3 * 3;

a = 1 / casosPossiveis;
b = 5 / casosPossiveis;
c = (casosPossiveis - 1) / casosPossiveis;
fprintf("Alínea a): %f\n" + ...
    "Alínea b): %f\n" + ...
    "Alínea c): %f\n", ...
    a, b, c);


% d)
% A -> "Sequência incluir um"
% B -> "Sequência incluir dois"
% P(A|B) = P(AB) * P(B)

P_AB = 2 / casosPossiveis; 
P_B = 5 / casosPossiveis;
d = P_AB / P_B;
fprintf("Alínea d): %f\n", d)