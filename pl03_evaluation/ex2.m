clear
close all
clc

load("L.mat")

%% a)
N = length(L)

x = find(sum(L) == 0)


%% b)
H = zeros(N);

for j = 1:N % Colunas
    prob = 1/sum(L(:,j));
    for i = 1:N % Linhas
        if L(i, j) == 1
            H(i, j) = prob;
        end
    end
end


%% c)
% Resolver dead-ends
for idx = x
    for i = 1:N
        H(i,idx) = 1/N;
    end
end

beta = 0.85;
A = beta * H + (1-beta) * (zeros(N) + 1/N);


%% d)
i = 0;
old = (zeros(1,N) + 1/N)';

while true
    i = i + 1;

    new = A * old;
    diff = max(new - old);

    old = new;

    if diff < 1e-4
        break
    end
end


%% e)
new(x)