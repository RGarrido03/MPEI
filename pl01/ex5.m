clear
close all
clc

ex3 = probFn(0.5, 15, 6, 1e5, false);
ex4 = probFn(0.5, 15, 6, 1e5, true);

for n = [20 40 100]
    y = zeros(n,1);
    for k = 0:n
        y(k+1) = probFn(0.5, n, k, 1e5, false);
    end
    figure
    stem(0:n, y)
    grid on
end