clear
close all
clc

% a)
totalProgramas = 100;
probAndre = 20 / totalProgramas;
probBruno = 30 / totalProgramas;
probCarlos = 50 / totalProgramas;

probErro = 0.01 * probAndre + 0.05 * probBruno + 0.001 * probCarlos;

probCarlosSeErro = 0.001 * probCarlos / probErro;
fprintf("Alínea a): %f\n", probCarlosSeErro);


% Print line
fprintf("\n");


% b)
probAndreSeErro = 0.01 * probAndre / probErro;
probBrunoSeErro = 0.05 * probBruno / probErro;

fprintf("Alínea b)\n" + ...
    "Probabilidade de ser o André: %f\n" + ...
    "Probabilidade de ser o Bruno: %f\n" + ...
    "Probabilidade de ser o Carlos: %f\n", ...
    probAndreSeErro, probBrunoSeErro, probCarlosSeErro);
fprintf("É mais provável ser do Bruno.\n")