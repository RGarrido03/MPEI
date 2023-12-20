clear
close all
clc

%% Read
movies = readcell('movies.csv', 'Delimiter', ',');


%% Get genres
genres = {};
[x, y] = size(movies);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            if ~ismember(convertCharsToStrings(movies{i, j}), genres)
                genres = [genres convertCharsToStrings(movies{i, j})];
            end
        end
    end
end


%% Genres bloom
genre_bloom = bloomFilterInitialization(1000);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            genre_bloom = bloomFilterInsert(genre_bloom, movies{i, j}, 4);
        end
    end
end


%% Genres + Years bloom
year_bloom = bloomFilterInitialization(1000);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            key = convertStringsToChars(strcat(movies{i,j}, ",", string(movies{i,2})));
            year_bloom = bloomFilterInsert(year_bloom, key, 4);
        end
    end
end


%% Signatures
[Set, Nu] = createStructure(movies);
signatures = getSignatures(Set, Nu, 100);


%% Hash function
function aux = muxDJB31MA(chave, seed, k)
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


%% Bloom functions
function bloom = bloomFilterInitialization(n)
bloom = zeros(1, n);
end

function bloom = bloomFilterInsert(bloom, key, k)
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
for i = 1:k
    hash = mod(aux(i), m) + 1;
    bloom(hash) = bloom(hash) + 1;
end
end


%% MinHash functions
function [Set, Nm] = createStructure(movies)
% For each movie, get its genres
Nm = length(movies);
Set = cell(Nm,1);

for n = 1:Nm % Lines (movies)
    for g = 3:12 % Columns (genres)
        if ~ismissing(movies{n, g})
            Set{n} = [Set{n} convertCharsToStrings(movies{n,g})];
        end
    end
end
end


function signatures = getSignatures(Set, Nm, K)
signatures = inf(Nm, K);

for n = 1:Nm
    set_n = Set{n};
    for i = 1:length(set_n)
        key = num2str(set_n(i));
        h_out = muxDJB31MA(key, 127, K);
        signatures(n,:) = min(h_out, signatures(n,:));
    end
end
end