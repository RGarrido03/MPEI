clear
close all
clc

fprintf("Exercício 1\n\n")

%% a)
N = 1e5;
i_min = 6;
i_max = 20;
char = ['A':'Z' 'a':'z'];
keys = generateKeys(N, i_min, i_max, char);


%% b)
N = 1e5;
i_min = 6;
i_max = 20;
char = 'a':'z';
prob = textread('prob_pt.txt')';
keys = generateKeys(N, i_min, i_max, char, prob);