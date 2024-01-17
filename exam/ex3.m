clear
close all
clc

%% a)
tabela = readcell("cars.xlsx");
signatures = getSignatures(tabela, 3);
[J, timeCalc] = calculateDistance(tabela, 3);

function signatures = getSignatures(Set, K)
signatures = inf(size(Set,1), K);

for n = 1:size(Set, 1)
    set_n = Set{n, :};
    for i = 1:length(set_n)
        key = num2str(set_n(i));
        hashCode = hf24(set_n(i),K);
        
        signatures(n,:) = min(hashCode, signatures(n,:));
    end
end
end

function [J, timeCalc] = calculateDistance(Set, K)
Nu = length(Set);
J = zeros(Nu);
assinaturas = inf(Nu, K);

for n = 1:Nu
    conjunto = Set{n};
    for i = 1:length(conjunto)
        key = num2str(conjunto(i));
        h_out = hf24(conjunto(i),K);
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