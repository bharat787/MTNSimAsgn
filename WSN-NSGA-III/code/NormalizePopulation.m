function [pop, params] = NormalizePopulation(pop, params)

    params.zmin = UpdateIdealPoint(pop, params.zmin);
    
    fp = [pop.Cost] - repmat(params.zmin, 1, numel(pop));
    
    params = PerformScalarizing(fp, params);
    
    a = FindHyperplaneIntercepts(params.zmax);
    
    for i = 1:numel(pop)
        pop(i).NormalizedCost = fp(:,i)./a;
    end
    
end

function a = FindHyperplaneIntercepts(zmax)

    w = ones(1, size(zmax,2))/zmax;
    
    a = (1./w)';

end