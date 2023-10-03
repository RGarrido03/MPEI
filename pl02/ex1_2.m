clear
close
clc

%% a)
N = 1e5;
n = 20;
m = 100;

experiencias = randi(m, n, N);
as = true(1, N);

for i = 1:N
    aux = experiencias(:, i);
    as(i) = length(unique(aux)) == n;
end

prob = sum(as)/N;
fprintf("Alínea a): %f\n", prob)


%% b)
N = 1e5;
n = 20;
m = 100;

experiencias = randi(m, n, N);
as = true(1, N);

for i = 1:N
    aux = experiencias(:, i);
    as(i) = length(unique(aux)) ~= n;
end

prob = sum(as)/N;
fprintf("Alínea b): %f\n", prob)


%% c)
N = 1e5;
m = [1000, 100000];
n = 10:10:100;

figure
for m_iter = 1:length(m)
    % Inicializar vetor de probabilidades em função de n
    probabilities = zeros(1, length(n));

    for n_iter = 1:length(n)
        experiencias = randi(m(m_iter), n(n_iter), N);
        as = true(1, N);

        for i = 1:N
            aux = experiencias(:, i);
            as(i) = length(unique(aux)) ~= n(n_iter);
        end

        probabilities(n_iter) = sum(as)/N;
    end

    % Dar plot das probabilidades, em função de m
    subplot(1, 2, m_iter)
    plot(n, probabilities)

    % Configurações dos gráficos
    grid
    xlim([n(1) n(end)])
    xlabel("n")
    ylabel("Probabilidade")
    title("m = " + m(m_iter))
end


%% d)
N = 1e5;
m = [200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
n = 100;

probabilities = zeros(1, length(m));
for m_iter = 1:length(m)
    experiencias = randi(m(m_iter), n, N);
    as = true(1, N);

    for i = 1:N
        aux = experiencias(:, i);
        as(i) = length(unique(aux)) ~= n;
    end

    probabilities(m_iter) = sum(as)/N;
end

figure
plot(m, probabilities)
grid
xlim([m(1) m(end)])
xlabel("m")
ylabel("Probabilidade")
title("Probabilidade em função de m, para n=" + n)