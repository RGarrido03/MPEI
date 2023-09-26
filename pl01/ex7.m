clear
close all
clc


%% a)
probFn(0.7, 5, 3, 1e5, false)
probFnAnaltica(0.3, 5, 3)

%% b)
probFn(0.3, 5, 3, 1e5, true) % Inverte (pelo menos 3 peças não defeituosas)
probFnAnaltica(0.3, 5, 2) % Corrigir