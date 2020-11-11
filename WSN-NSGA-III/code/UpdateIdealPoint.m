function zmin = UpdateIdealPoint(pop, prev_zmin)
    
    if ~exist('prev_zmin', 'var') || isempty(prev_zmin)
        prev_zmin = inf(size(pop(1).Cost));
    end
    
    zmin = prev_zmin;
    for i = 1:numel(pop)
try
    zmin = min(zmin, pop(i).Cost);
catch
end
end

end