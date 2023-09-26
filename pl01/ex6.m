clear
close all
clc

p = 0.5;
k = [2 6];
n = [3, 15];

for i = 1:length(n)
    fprintf("Probabilidade: %f\n", nchoosek(n(i),k(i)) * p^k(i) * (1-p)^(n(i)-k(i)));
end