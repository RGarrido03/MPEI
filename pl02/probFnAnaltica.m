function [prob] = probFnAnaltica(p, n, k)
prob = nchoosek(n,k) * p^k * (1-p)^(n-k);
end
