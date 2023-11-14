clear
close all
clc

fprintf("Exercício suplementar 1\n\n")


%% a)

H = [0.8  0.0  0.3  0.0  0.0
     0.2  0.6  0.2  0.0  0.0
     0.0  0.1  0.4  0.0  0.0
     0.0  0.3  0.0  1.0  0.0
     0.0  0.0  0.1  0.0  1.0];

N = 10000;
steps = zeros(1, N);

% 6f)
start = [1 2 3];
avg_matrix = zeros(1, length(start));

for i = 1:length(start)
    for n = 1:N
        steps(n) = length(crawl(H, start(i), [4 5]));
    end
    avg_matrix(i) = sum(steps)/N - 1;
end

fprintf("a) Exercício 6f) por simulação\n")
fprintf("   A partir do estado 1: %f\n", avg_matrix(1))
fprintf("   A partir do estado 2: %f\n", avg_matrix(2))
fprintf("   A partir do estado 4: %f\n", avg_matrix(3))


% 6g)
last_matrix = zeros(1, N);
for n = 1:N
    steps = crawl(H, 1, [4 5]);
    last_matrix(n) = steps(end);
end

prob_4 = sum(last_matrix == 4)/N;
prob_5 = sum(last_matrix == 5)/N;

fprintf("\n   Exercício 6g) por simulação\n")
fprintf("   A partir do estado 1, probabilidade de acabar\n")
fprintf("   → No estado 3: %f\n", prob_4)
fprintf("   → No estado 5: %f\n", prob_5)


%% Print line
fprintf("\n")


%% b)
N_cells = 10000;
N = 10000;

c_array = cell(1, N_cells);
m = zeros(1, N_cells);

for i = 1:N_cells
    temp = crawl(H, randi(3, 1), [4 5]);
    c_array{i} = temp;
    m(i) = length(temp);
end

[~, min_idx] = min(m);
[~, max_idx] = max(m);

fprintf("b) Minimum length: %d\n   [", m(min_idx))
fprintf("%g ", c_array{min_idx}(1:end-1))
fprintf("%g]", c_array{min_idx}(end))

fprintf("\n\n   Maximum length: %d\n   [", m(max_idx))
fprintf("%g ", c_array{max_idx}(1:end-1))
fprintf("%g]", c_array{max_idx}(end))


%% Functions

% Random walk on the Markov chain
% Inputs:
% H - state transition matrix
% first - initial state
% last - terminal or absorving state
function [state] = crawl(H, first, last)
    % the sequence of states will be saved in the vector "state"
    % initially, the vector contains only the initial state:
    state = [first];
    
    % keep moving from state to state until state "last" is reached:
    while (1)
        state(end+1) = nextState(H, state(end));
        if ismember(state(end), last) % verifies if state(end) is absorbing
            break
        end
    end
end

% Returning the next state
% Inputs:
% H - state transition matrix
% currentState - current state
function state = nextState(H, currentState)
    % find the probabilities of reaching all states starting at the current one:
    probVector = H(:,currentState)'; % probVector is a row vector
    n = length(probVector); %n is the number of states
    % generate the next state randomly according to probabilities probVector:
    state = discrete_rnd(1:n, probVector);
end

% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector
function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector)); state= states(i);
end