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
            genre = convertStringsToChars(input("Select a genre: ", 's'));
            count = bloomFilterCheck(genre_bloom, genre, k);
            if count == 0
                fprintf("Genre not found!")
            else
                fprintf("%d movies with genre %s\n", count, genre);
            end
        
        case 3
            % não está a dar os resultados bem - Drama,1904 -> 1  -
            % Comedy,1901 -> 3
            a = input("Select a genre and a year (separated by ','): ", 's');
            a = strsplit(a, ',');
            genre = a{1};
            year = a{2};
            key = convertStringsToChars(strcat(genre, ",", year));

            count_year = bloomFilterCheck(year_bloom, key, 4);
            fprintf("%d movies released in %s with genre %s\n", count_year, year, genre);

        case 4
            a = input("Insert a string: ", "s");
            [topSimilarities, topTitles] = fiveSimilarMovies(a, signatures_title, Set_title);
            fprintf("Top 5 Similar Titles:\n");
            for i = 1:5
                fprintf("\t%s - %f\n", topTitles{i}, topSimilarities(i));
            end

        case 5
            a = input("Select one or more genres (separated by ','): ", "s");

            

        case 6
            break;

        otherwise
            fprintf("INVALID OPTION!\n")

    end
end

function count = bloomFilterCheck(bloom, key, k)
    m = length(bloom);
    aux = muxDJB31MA(key, 127, k);
    count = [];
    for i = 1:k
        key = [key num2str(i)];
        hash = mod(aux(i), m) + 1;
        count = [count bloom(hash)];
    end
    
    if ~isempty(count)
        count = min(count);
    else
        count = 0;
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