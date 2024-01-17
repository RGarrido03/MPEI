clear
close all
clc

%% a)
load("data.mat")
fprintf("Número total de pessoas: %d\n", size(names, 1))

bloom = bloomFilterInitialization(300);

for i = 1:length(names)
    bloom = bloomFilterInsert(bloom, names{i}, 3);
end

count = bloomFilterCheck(bloom, 'Paolo', 3);
fprintf("Paolo: %d\n", count);


%% b)
count = zeros(length(test), 1);
for i = 1:length(test)
    count(i) = bloomFilterCheck(bloom, test{i}, 3);
end

zero = sum(count==0)/length(test);
one = sum(count==1)/length(test);
two = sum(count==2)/length(test);
three_or_more = 1 - zero - one - two;

fprintf("prob. 0 : %.4f\n", zero);
fprintf("prob. 1 : %.4f\n", one);
fprintf("prob. 2 : %.4f\n", two);
fprintf("prob. 3+: %.4f\n", three_or_more);

%% Functions
function bloom = bloomFilterInitialization(n)
bloom = zeros(1, n);
end

function bloom = bloomFilterInsert(bloom, key, k)
m = length(bloom);
aux = kHashValues(key, k);
for i = 1:k
    hash = mod(aux(i), m) + 1;
    bloom(hash) = bloom(hash) + 1;
end
end

function count = bloomFilterCheck(bloom, key, k)
m = length(bloom);
aux = kHashValues(key, k);
count = [];
for i = 1:k
    hash = mod(aux(i), m) + 1;
    count = [count bloom(hash)];
end

if ~isempty(count)
    count = min(count);
else
    count = 0;
end
end