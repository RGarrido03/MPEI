clear
close all
clc

fprintf("Secção 2.2, exercício 4\n\n")


%% a)
% i.
N = 1e5;    % Número de experiências
n = 5;      % Número total de peças
p = 0.3;

x = 0:n;
px = zeros(1, n+1);
fprintf("Alínea a)\ni.   ")

for k = x
    experiencias = rand(n,N) <= 0.3;
    as = true(1, N);

    for i = 1:N
        aux = experiencias(:, i);
        as(i) = sum(aux) == k;
    end

    px(k+1) = sum(as)/N;
    fprintf("f(%d)=%f ", k, px(k+1))
end
fprintf("\n")


% ii.
figure
stairs([-1 x n+1], [0 cumsum(px) 1])
grid on
xlim([-1 n+1])
ylim([0 1.1])


% iii.
probMax2Pecas = sum(px(1:3));
fprintf("iii. Probabilidade = %f\n", probMax2Pecas)


%% Print line
fprintf("\n")


%% b)
% i.
pxTeorico = zeros(1, n+1);
for k = x
    pxTeorico(k+1) = nchoosek(n, k) * p^k * (1-p)^(n-k);
end

% ii.
probMax2Pecas = sum(pxTeorico(1:3));
fprintf("Alínea b)\nii.  Probabilidade = %f\n", probMax2Pecas)