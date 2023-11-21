function keys = generateKeys(N, i_min, i_max, char, prob)
%GENERATEKEYS Generate a cell array of size N with differemt keys
%   Detailed explanation goes here
if ~exist('prob', 'var')
    prob = zeros(1,length(char)) + 1/length(char);
end

keys = cell(1, N);
cum_prob = cumsum(prob);

% Generate keys
for i=1:N
    keys{i} = generateKey(i_min, i_max, char, cum_prob);
end

while true
    diff = N - length(unique(keys));

    if diff == 0
        break
    end
    
    keys = [unique(keys) generateKeys(diff, i_min, i_max, char, prob)];
end
end

function key = generateKey(i_min, i_max, char, cum_prob)
    % Get number of characters and define array
    num_chars = randi([i_min,i_max]);
    key = '';

    % Generate chars for each key
    for j=1:num_chars
        k = 1 + sum(rand() > cum_prob);
        key = append(key, char(k));
    end
end