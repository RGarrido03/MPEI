clear
close all
clc

fprintf("Exercise 4.3 using Jaccard distance definition\n\n")

udata = load('u.data');
u = udata(1:end,1:2);
clear udata;

[Set, Nu, users] = createStructure(u);
[J, timeCalc] = calculateDistance(Set, Nu);
save("result.mat", "J")
[similarUsers, timeFind] = findSimilar(J, 0.4, Nu, users);

fprintf("Users with Jaccard distance below %.1f\n", threshold);
fprintf("n1  | n2  | Distance\n");
fprintf("%d | %d | %.4f\n", SimilarUsers');

fprintf("\nJaccard distance calculation time: %f seconds\n", time_calc);
fprintf("Below-threshold finding time: %f seconds\n", time_find);


function [Set, Nu, users] = createStructure(u)
users = unique(u(:,1));
Nu = length(users);

Set = cell(Nu,1);
for n = 1:Nu
    ind = u(:,1) == users(n);
    Set{n} = [Set{n} u(ind,2)];
end
end


function [J, timeCalc] = calculateDistance(Set, Nu)
J=zeros(Nu);

t = tic;
for n1= 1:Nu
    for n2= n1+1:Nu
        movies_n1 = Set{n1};
        movies_n2 = Set{n2};
        similar = length(intersect(movies_n1, movies_n2));
        diferente = length(movies_n1) + length(movies_n2) - similar;
        J(n1, n2) = 1 - similar/diferente;
    end
end
timeCalc = toc(t);
end


function [similarUsers, timeFind] = findSimilar(J, threshold, Nu, users)
% FINDSIMILAR Find similar pairs (i.e., with distance below threshold)
%   Returns an array with schema [user1, user2, distance]
similarUsers = zeros(1,3);
k= 1;
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