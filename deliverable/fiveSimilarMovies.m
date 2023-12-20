function [topSimilarities, topTitles] = fiveSimilarMovies(title, signatures_title, Set_title)
%fiveSimilarMovies
    signature = muxDJB31MA(title, 127, size(signatures_title, 2));
    k = 100;
    similarities = zeros(1, size(signatures_title, 1));
    
    for n = 1:size(signatures_title, 1)
        similarities(n) = 1 - sum(signature ~= signatures_title(n, :)) / k;
    end
    
    [sortedSimilarities, indices] = sort(similarities, 'descend');
    topSimilarities = sortedSimilarities(1:5);
    topTitles = Set_title(indices(1:5));
end