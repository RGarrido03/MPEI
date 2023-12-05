clear
close all
clc

load("keysA.mat")
N = length(keys);

T_array = [5e5, 1e6, 2e6];
functions = ["DJB31MA", "hashstring", "sdbm", "djb2"];

P_cell = cell(length(T_array), length(functions)); % Assignments cell
H = zeros(length(T_array), length(functions), N); % Store hashcodes
collisions = zeros(length(T_array), length(functions)); % Store collisions number
times = zeros(length(T_array), length(functions)); % Store times

count = 0;
for t_idx = 1:length(T_array)
    T = T_array(t_idx);

    for fn_idx = 1:length(functions)
        count = count + 1;

        fn = functions(fn_idx);

        P = zeros(1,T); % Store assignments number
        
        starttime = tic;

        for i = 1:N
            hash = DJB31MA(keys{i}, 127);

            switch fn
                case "DJB31MA"
                    hash = DJB31MA(keys{i}, 127);
                case "hashstring"
                    hash = hashstring(keys{i}, T);
                case "sdbm"
                    hash = string2hash(keys{i}, 'sdbm');
                case "djb2"
                    hash = string2hash(keys{i}, 'djb2');
            end

            hash = mod(hash, T) + 1;
            H(t_idx, fn_idx, i) = hash;
            P(hash) = P(hash) + 1;
        end
        for i = 1:T
            if P(i) > 1
                collisions(t_idx, fn_idx) = collisions(t_idx, fn_idx) + P(i) - 1;
            end
        end

        P_cell{t_idx, fn_idx} = P;

        times(t_idx, fn_idx) = toc(starttime); % Store execution time

        subplot(length(T_array), length(functions), count)
        histogram(H(t_idx, fn_idx, :),100);

        Hnorm = H(t_idx, fn_idx, :)/T;
        for i = [2 5 10]
            fprintf("Momento %2d: teórico %.5f, medido %.5f\n", i, 1/(i+1), mean(Hnorm.^i));
        end
        
        fprintf("\nNumber of collisions = %d\n", collisions(t_idx, fn_idx));
        fprintf("Maximum number of assignments = %d\n", max(P_cell{t_idx, fn_idx}));
        fprintf("Simulation time = %.5f seconds\n\n", times(t_idx, fn_idx));
    end
end