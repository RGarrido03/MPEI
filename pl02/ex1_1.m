clear
close all
clc

%% a)
p = 0.5;
n = 2;
k = 1;
N = 10000;
MoL = true;

prob = probFn(p, n, k, N, MoL);
fprintf("Alínea a): %f\n", prob)


%% b)
p = 0.5;
n = 4;
k = 3;

prob = probFnAnaltica(p, n, k);
fprintf("Alínea b): %f\n", 1-prob)


%% c)
experiencias = rand(2,10000) > 0.5;
CF = sum(experiencias) == 2;
CP = sum(experiencias) >= 1;

prob = sum(CF)/sum(CP);
fprintf("Alínea c): %f\n", prob)


%% d)
experiencias = rand(2,10000) > 0.5;
CF = sum(experiencias) == 2;
CP = experiencias(1,:);

prob = sum(CF)/sum(CP);
fprintf("Alínea d): %f\n", prob)


%% e)
experiencias = rand(5,10000) > 0.5;
CF = sum(experiencias) == 2;
CP = sum(experiencias) >= 1;

prob = sum(CF)/sum(CP);
fprintf("Alínea e): %f\n", prob)


%% f)
experiencias = rand(5,10000) > 0.5;
CF = sum(experiencias) >= 2;
CP = sum(experiencias) >= 1;

prob = sum(CF)/sum(CP);
fprintf("Alínea f): %f\n", prob)