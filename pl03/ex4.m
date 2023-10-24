clear
close all
clc

fprintf("Exercício 4\n\n")

%% a)
p = 0.4;
q = 0.6;

T = [p^2      0  0  q^2;
     (1-p)^2  0  0  q*(1-q);
     p*(1-p)  0  0  q*(1-q);
     p*(1-p)  1  1  (1-q)^2];

fprintf("a) Matriz de transição de estados:\n")
fprintf("%.4f   %.4f   %.4f   %.4f\n", T')


%% Print line
fprintf("\n")


%% b)
nTransicoes = [5 10 100 200];
probs = zeros(4, length(nTransicoes));
X = [1 0 0 0]';

fprintf("b) Probabilidade de transição do estado A\n")

for i = 1:length(nTransicoes)
    T_temp = T^nTransicoes(i) * X;
    probs(:,i) = T_temp;
    fprintf("%-15s p(A)=%f, p(B)=%f, p(C)=%f, p(D)=%f\n", nTransicoes(i) + " transições:", T_temp(1), T_temp(2), T_temp(3), T_temp(4))
end


%% Print line
fprintf("\n")


%% c)
M = [T-eye(4); ones(1,4)];
X = [0 0 0 0 1]';
u = M\X;

fprintf("d) Probabilidades limite\n")
fprintf("p(A)=%f\n" + ...
    "p(B)=%f\n" + ...
    "p(C)=%f\n" + ...
    "p(D)=%f\n", ...
    u(1), u(2), u(3), u(4));