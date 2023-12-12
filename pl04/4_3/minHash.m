clear
close all
clc

fprintf("Exercise 4.3 using MinHash\n\n")

udata = load('u.data');
u = udata(1:end,1:2);
clear udata;

[Set, Nu, users] = createStructure(u);
[J, timeCalc] = calculateDistance(Set, Nu, 100);
save("result.mat", "J")
[similarUsers, timeFind] = findSimilar(J, 0.4, Nu, users);

fprintf("Users with Jaccard distance below %.1f\n", 0.4);
fprintf("n1  | n2  | Distance\n");
fprintf("%d | %d | %.4f\n", similarUsers');

fprintf("\nJaccard distance calculation time: %f seconds\n", timeCalc);
fprintf("Below-threshold finding time: %f seconds\n", timeFind);


function [Set, Nu, users] = createStructure(u)
users = unique(u(:,1));
Nu = length(users);

Set= cell(Nu,1);
for n = 1:Nu
    ind = u(:,1) == users(n);
    Set{n} = [Set{n} u(ind,2)];
end
end


function [J, timeCalc] = calculateDistance(Set, Nu, K)
J = zeros(Nu);
assinaturas = inf(Nu, K);

for n = 1:Nu
    conjunto = Set{n};
    for i = 1:length(conjunto)
        key = num2str(conjunto(i));
        h_out = muxDJB31MA(key, 127, K);
        assinaturas(n,:) = min(h_out, assinaturas(n,:));
    end
end

t = tic;
for n1= 1:Nu
    for n2= n1+1:Nu
        J(n1, n2) = sum(assinaturas(n1, :) ~= assinaturas(n2, :))/K;
    end
end
timeCalc = toc(t);
end


function [similarUsers, timeFind] = findSimilar(J, threshold, Nu, users)
% FINDSIMILAR Find similar pairs (i.e., with distance below threshold)
%   Returns an array with schema [user1, user2, distance]
similarUsers = zeros(1,3);
k = 1;

t = tic;
for n1= 1:Nu
    for n2= n1+1:Nu
        if J(n1, n2) < threshold
            similarUsers(k,:) = [users(n1) users(n2) J(n1,n2)];
            k= k+1;
        end
    end
end
timeFind = toc(t);

similarUsers = sortrows(similarUsers, 3);
end


function aux= muxDJB31MA(chave, seed, k)
len = length(chave);
chave = double(chave);
h = seed;
aux = zeros(1, k);
for i=1:len
    h = mod(31 * h + chave(i), 2^32 -1) ;
end
for i = 1:k
    h = mod(31 * h + i, 2^32 -1) ;
    aux(i) = h;
end
end