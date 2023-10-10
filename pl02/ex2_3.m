clear
close all
clc

fprintf("Secção 2.2, exercício 3\n\n")

%% a)
N = 1e5;    % Número de experiências
n = 4;      % Número total de lançamentos
m = 2;      % Número de casos possíveis

x = 0:n;
px = zeros(1, n+1);

for k = x
    experiencias = randi(m, n, N) - 1;
    as = true(1, N);

    for i = 1:N
        aux = experiencias(:, i);
        as(i) = sum(aux) == k;
    end

    px(k+1) = sum(as)/N;
end

figure
stairs([0:n 4.1], [cumsum(px) 1])
grid on
xlim([0 4.1])
ylim([0 1.1])


%% b)
valorEsperado = x * px';
variancia = x.^2 * px' - valorEsperado^2;
desvioPadrao = sqrt(variancia);
fprintf("Alínea b)\n" + ...
    "Valor esperado = %f\n" + ...
    "Variância = %f\n" + ...
    "Desvio padrão = %f\n", ...
    valorEsperado, variancia, desvioPadrao);


%% New line
fprintf("\n")


%% c)
% Variável discreta, logo a distribuição é binomial.
% n = 4, uma vez que são feitos 4 lançamentos.
p = 0.5;


%% d)
pxTeorico = zeros(1, n+1);
for k = x
    pxTeorico(k+1) = nchoosek(n, k) * p^k * (1-p)^(n-k);
end


%% e)
valorEsperadoTeorico = x * pxTeorico';
varianciaTeorico = x.^2 * pxTeorico' - valorEsperadoTeorico^2;
desvioPadraoTeorico = sqrt(varianciaTeorico);
fprintf("Alínea e)\n" + ...
    "Valor esperado = %f\n" + ...
    "Variância = %f\n" + ...
    "Desvio padrão = %f\n", ...
    valorEsperadoTeorico, varianciaTeorico, desvioPadraoTeorico);


%% New line
fprintf("\n")


%% f)
probPM2Coroas = sum(pxTeorico(3:5));
probAte1Coroa = 1 - probPM2Coroas;
probEntre1e3Coroas = sum(pxTeorico(2:4));

fprintf("Alínea f)\n" + ...
    "Probabilidade de obter pelo menos 2 coroas = %f\n" + ...
    "Probabilidade de obter até 1 coroa = %f\n" + ...
    "Probabilidade de obter entre 1 e 3 coroas = %f\n", ...
    probPM2Coroas, probAte1Coroa, probEntre1e3Coroas);
