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
n = length(genres);
m = ceil(-n*log(0.001)/(log(2))^2);
k = round((m/n)*log(2));
genre_bloom = bloomFilterInitialization(m);

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            genre_bloom = bloomFilterInsert(genre_bloom, movies{i, j}, k);
        end
    end
end


%% Genres + Years bloom

totalElements = x * (y - 2);  % Assuming x is the number of rows and y is the number of columns
genres_years = strings(1, totalElements);
count = 1;

for i = 1:x
    for j = 3:y
        if ~ismissing(movies{i, j})
            genre_year = strcat(movies{i, j}, string(movies{i, 2}));
            genres_years(count) = genre_year;
            count = count + 1;
        end
    end
end

genres_years = genres_years(1:count-1);  % Trim the excess preallocated space

n_gy = length(unique(genres_years));
m_gy = ceil(-n_gy*log(0.0001)/(log(2))^2);
k_gy = round((m_gy/n_gy)*log(2));
year_bloom = bloomFilterInitialization(m_gy);

for i = 1:length(genres_years)
    year_bloom = bloomFilterInsert(year_bloom, convertStringsToChars(genres_years(i)), k_gy);
end

%% Signatures
[Set_genre, ~] = createMovieGenreStructure(movies);
[Set_title, Nm] = createMovieTitleStructure(movies);
signatures_genre = getSignatures(Set_genre, Nm, 100);
signatures_title = getSignatures(Set_title, Nm, 100);


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
bloom = zeros(1, n, 'uint16');
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
function [Set, Nm] = createMovieGenreStructure(movies)
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


function [Set, Nm] = createMovieTitleStructure(movies)
% For each movie, get its title split in shingles.
Nm = length(movies);
Set = cell(Nm,1);

for n = 1:Nm % Lines (movies)
    title = movies{n,1};
    for i = 1:length(title)-1
        Set{n} = [Set{n} convertCharsToStrings(title(i:i+1))];
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
