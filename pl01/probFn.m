function [probSimulacao] = probFn(p, n, k, N, MoL)
% p - probabilidade de cara
% n - número de lançamentos
% k - número de caras
% N - número de experiências
% MoL - More or less. Caso true, >=. Caso false, ==.

lancamentos = rand(n,N) > p;

if (MoL)
    sucessos = sum(lancamentos) >= k;
else
    sucessos = sum(lancamentos) == k;
end

probSimulacao = sum(sucessos)/N;
end