function [BilinearizeringConstraints,failure] = deriveBilinearizing(Fi,w,order)

if nargin < 3
    order = 1;
end

BilinearizeringConstraints = set([]);
failure = 0;
Fi = sdpvar(Fi);
if is(Fi,'hermitian')
    Fi = Fi(find(triu(ones(length(Fi)))));
end
Fi = Fi(:);

for i = 1:length(Fi)
    pij = Fi(i);
    [c,v] = coefficients(pij,w);
    for k = 1:length(c)
        if degree(v(k)) > order
            if isa(c(k),'double')
                failure = 1;
                return
            else
                BilinearizeringConstraints = BilinearizeringConstraints + set(c(k) == 0);
            end
        end
    end
end