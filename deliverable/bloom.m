function bloom = bloomFilterInitialization(n)
bloom = false(1, n);
end

function bloom = bloomFilterInsert(bloom, key, k)
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
for i = 1:k
    key = [key num2str(i)];
    hash = mod(aux(i), m) + 1;
    bloom(hash) = true;
end
end

function out = bloomFilterCheck(bloom, key, k)
out = true;
m = length(bloom);
aux = muxDJB31MA(key, 127, k);
for i = 1:k
    key = [key num2str(i)];
    hash = mod(aux(i), m) + 1;
    if ~bloom(hash)
        out = false;
        return;
    end
end
end