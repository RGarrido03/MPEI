while true
    fprintf("\n1 - Display available genres\n" + ...
        "2 - Number of movies of a genre\n" + ...
        "3 - Number of movies of a genre on a given year\n" + ...
        "4 - Search movie titles\n" + ...
        "5 - Search movie based on genres\n" + ...
        "6 - Exit\n");
    opt = input("Select an option: ");

    switch opt
        case 1
            fprintf("\nAvailable genres:\n");
            for i = 1:length(genres)
                fprintf("\t%s\n", genres{i});
            end
        
        case 2
            genre = input("Select a genre: ", 's');
            count = bloomFilterCheck(genre_bloom, genre, 4);
            fprintf("%d movies with genre %s\n", count, genre);
        
        case 3
            a = input("Select a genre and a year (separated by ','): ", 's');
            a = strsplit(a, ',');
            genre = a{1};
            year = a{2};

            count_genre = bloomFilterCheck(genre_bloom, genre, 4);
            count_year = bloomFilterCheck(year_bloom, year, 4);
            fprintf("%d movies with genre %s\n", count_genre, genre);
        
        case 6
            break;
    end
end

function count = bloomFilterCheck(bloom, key, k)
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
count = [];
for i = 1:k
    key = [key num2str(i)];
    hash = mod(aux(i), m) + 1;
    if bloom(hash) > 0
        count = [count bloom(hash)];
    end
end
count = min(count);
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