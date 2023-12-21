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
            a = input("Select a genre and a year (separated by ','): ", 's');
            a = strsplit(a, ',');

            genre = a{1};
            count_genre = bloomFilterCheck(genre_bloom, genre, k);
            if count_genre == 0
                fprintf("Genre not found!\n")
                break
            end

            year = a{2};
            if isempty(str2num(year))
                fprintf("Invalid number!\n")
                break
            end

            key = convertStringsToChars(strcat(genre, year));

            count_year = bloomFilterCheck(year_bloom, key, k_gy);
            fprintf("%d movies released in %s with genre %s\n", count_year, year, genre);

        case 4
            a = input("Insert a string: ", "s");
            Set = cell(1,1);
            for i = 1:length(a)-1
                Set{1} = [Set{1} convertCharsToStrings(a(i:i+1))];
            end

            k = 100;
            signatures = getSignatures(Set, 1, k);
            size_titles = size(signatures_title, 1);
            similarities = zeros(1, size_titles);
            

            for n = 1:size_titles
                similarities(n) = 1 - (sum(signatures ~= signatures_title(n, :)) / k);
            end
            
            [sortedSimilarities, indices] = sort(similarities, 'descend');
            topSimilarities = sortedSimilarities(1:5);
            topTitles = Set_title(indices(1:5));
            fprintf("Top 5 Similar Titles:\n");
            concatenatedTitle = strings(length(topTitles{i}) + 1);
            for i = 1:5
                for j= 1:length(topTitles{i})
                    concatenatedTitle(i) = strcat(concatenatedTitle(i), topTitles{i}{j}(1));
                end
                concatenatedTitle(i) = strcat(concatenatedTitle(i), topTitles{i}{j}(2));
                fprintf("\t%s - %f\n", concatenatedTitle(i), topSimilarities(i));
            end

        case 5
            a = input("Select one or more genres (separated by ','): ", "s");
            a = strsplit(a, ',');
            Set = strings(length(a),1);
            for i= 1:length(a)
                Set(i,1) = convertCharsToStrings(a(i));
            end
            b = cell(1,1);
            b{1} = Set;
            k = 100;
            signatures = getSignatures(b, length(b), k);
            size_genre = size(signatures_genre, 1);
            similarities = zeros(1, size_genre);


            for n = 1:size_genre
                similarities(n) = 1 - (sum(signatures ~= signatures_genre(n, :)) / k);
            end

            
            [sortedSimilarities, indices] = sort(similarities, 'descend');
            topSimilarities = sortedSimilarities(1:5);
            topTitles = movies(indices(1:5), 1);
            fprintf("Top 5 Similar Titles:\n");
            for i = 1:5
                fprintf("\t%s - %f\n", topTitles{i}, topSimilarities(i));
            end
            

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