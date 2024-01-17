clear
close all
clc

%    1   3   5   7   9    FIM
T = [0.0 0.3 0.0 0.3 0.0  0.0
     1/3 0.0 0.5 0.0 0.45 0.0
     1/3 0.3 0.0 0.3 0.0  0.0
     1/3 0.0 0.5 0.0 0.45 0.0
     0.0 0.3 0.0 0.3 0.0  0.0
     0.0 0.1 0.0 0.1 0.1  0.0];

%% c)
state = crawl(T, 1, 6)


%% d)
N = 10^6;
c_array = cell(1, N);

for i = 1:N
    c_array{i} = crawl(T, 1, 6);
end


%% e)
count = 0;
compare = [9 7 1 5 3];

for i = 1:N
    if length(c_array{i}) == length(compare) && c_array{i} == compare
        count = count + 1;
    end
end
count


%% f)
primeiro = 1/5; % 1/5 porque não conseguimos randomizar o primeiro dígito.
segundo = T * [0 0 0 0 1 0]';
terceiro = T * [0 0 0 1 0 0]';
quarto = T * [1 0 0 0 0 0]';
quinto = T * [0 0 1 0 0 0]';

prob = primeiro * segundo(4) * terceiro(1) * quarto(3) * quinto(2);



%% g)
sum = 0;
count = 0;
for i = 1:N
    if c_array{i}(1) == 7
        count = count + 1;
        sum = sum + length(c_array{i});
    end
end

avg = sum/count



%% Functions
% if the Markov chain has more than 1 absorving state the third argument
% must be a vector with the absorving states
% for example in a chain with 5 states,and considering that states 4 and 5 are absorbing states:
% state = crawl(H5, 1,  [4 5])  
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
          if ismember(state(end), last) % verifies if state(end) is absorving
              break;
          end
     end
end

% Returning the next state
% Inputs:
% H - state transition matrix
% currentState - current state
function state = nextState(H, currentState)
     % find the probabilities of reaching all states starting at the current one:
     probVector = H(:,currentState)';  % probVector is a row vector 
     n = length(probVector);  %n is the number of states
     % generate the next state randomly according to probabilities probVector:
     state = discrete_rnd(1:n, probVector);
end

% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector 
function state = discrete_rnd(states, probVector)
     U=rand();
     i = 1 + sum(U > cumsum(probVector));
     state= states(i);
end