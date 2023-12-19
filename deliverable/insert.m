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

genres = genres(1:length(genres) - 1);

%% Genres bloom
genre_bloom = bloomFilterInitialization(1000);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            genre_bloom = bloomFilterInsert(genre_bloom, movies{i, j}, 4);
        end
    end
end

%% Years bloom
year_bloom = bloomFilterInitialization(1000);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            key = convertStringsToChars(strcat(movies{i,j}, ",", string(movies{i,2})));
            year_bloom = bloomFilterInsert(year_bloom, key, 4);
        end
    end
end


%% Functions
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
