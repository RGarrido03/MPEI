clear
close all
clc

fprintf("Secção 2.2, exercício 5\n\n")

% Probabilidade de um motor falhar
pArray = logspace(-3,log10(1/2),100);
len = length(pArray);
p2Motores = zeros(1, len);
p4Motores = zeros(1, len);

for i = 1:len
    p2Motores(i) = nchoosek(2, 2) * pArray(i)^2 * (1-pArray(i))^(2-2);
    p4Motores(i) = nchoosek(4, 3) * pArray(i)^3 * (1-pArray(i))^(4-3) + ...
        nchoosek(4, 4) * pArray(i)^4 * (1-pArray(i))^(4-4);
end

loglog(pArray, p2Motores)
hold on
loglog(pArray, p4Motores)
legend("2 motores", "4 motores", "Location","southeast")