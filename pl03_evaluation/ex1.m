clear
close all
clc

inicial = [1/4 1/4 1/4 1/4];

%    A     B     C     D 
T = [0.10  0.30  0.25  0.50
     0.30  0.10  0.25  0.30
     0.30  0.30  0.10  0.10
     0.30  0.30  0.40  0.10];

%% c)
% 5 transições
c = T^5 * inicial';
fprintf("c) %f\n", c(2));
fprintf("\n")


%% d)
M = [T-eye(4); ones(1,4)];
X = [0 0 0 0 1]';
u = M\X;

fprintf("d) Probabilidades limite\n")
fprintf("p(A)=%f\n" + ...
    "p(B)=%f\n" + ...
    "p(C)=%f\n" + ...
    "p(D)=%f\n", ...
    u(1), u(2), u(3), u(4));


b = u(2) * 60

hora = 5*60/2;
hora_end = 17*60/2;


%% e)
% 6 transições
segundo = T * [1 0 0 0]';
sexto = T^4 * [0 1 0 0]';
setimo = T * [0 1 0 0]';

p_ABXXXBA = segundo(2) * sexto(2) * setimo(1)