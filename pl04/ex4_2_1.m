clear
close all
clc

fprintf("Exercício 4.2.1\n\n")


%% Initial
k = 3;
n = 8000;
m = 1000;

U = readlines("wordlist-preao-20201103.txt");
U1 = convertStringsToChars(U(1:1000));
U2 = convertStringsToChars(U(1001:2000));

bloom = bloomFilterInitialization(n);

for i = 1:length(U1)
    bloom = bloomFilterInsert(bloom, U1{i}, k);
end


%% 2.
result = false(1, length(U1));
for i = 1:length(U1)
    result(i) = bloomFilterCheck(bloom, U1{i}, k);
end

fprintf("Number of false negatives: %d\n", sum(result == false))


%% 3.
result = false(1, length(U2));
for i = 1:length(U2)
    result(i) = bloomFilterCheck(bloom, U2{i}, k);
end

pfp = sum(result == true)/length(U2) * 100;
fprintf("Percentage of false positives: %.2f%%\n", pfp);


%% 4.
pfp_teorico = 100 * (1 - exp(-k * m / n))^k;
fprintf("Theoretical percentage of false positives: %.2f%%\n", pfp_teorico);


%% 5.
k_array = 4:10;
p = zeros(1, length(k_array));
p_teorico = zeros(1, length(k_array));

for i = 1:length(k_array)
    k = k_array(i);

    bloom = bloomFilterInitialization(n);

    for j = 1:length(U1)
        bloom = bloomFilterInsert(bloom, U1{j}, k);
    end

    result = false(1, length(U2));
    for j = 1:length(U2)
        result(j) = bloomFilterCheck(bloom, U2{j}, k);
    end

    p(i) = sum(result == true)/length(U2) * 100;
    p_teorico(i) = 100 * (1 - exp(-k * m / n))^k;
end

figure
plot(k_array, p);
hold on
plot(k_array, p_teorico);
hold off
grid on
xlabel("Número de funções de dispersão, k")
ylabel("Percentagem de falsos positivos (%)")
title("Percentagem de falsos positivos em função de k")


%% Functions

function bloom = bloomFilterInitialization(n)
bloom = false(1, n);
end

function bloom = bloomFilterInsert(bloom, key, k)
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
for i = 1:k
    key = [key num2str(i)];
    hash = mod(aux(i), m) + 1;
    bloom(hash) = true;
end
end

function out = bloomFilterCheck(bloom, key, k)
out = true;
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
for i = 1:k
    key = [key num2str(i)];
    hash = mod(aux(i), m) + 1;
    if ~bloom(hash)
        out = false;
        return;
    end
end
end

function aux= muxDJB31MA(chave, seed, k)
len= length(chave);
chave= double(chave);
h= seed;
aux = zeros(1, k);
for i=1:len
    h = mod(31 * h + chave(i), 2^32 -1) ;
end
for i = 1:k
    h = mod(31 * h + i, 2^32 -1) ;
    aux(i) = h;
end
end