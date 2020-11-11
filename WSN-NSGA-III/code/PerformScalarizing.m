function params = PerformScalarizing(z, params)

    nObj = size(z,1);
    nPop = size(z,2);
    
    if ~isempty(params.smin)
        zmax = params.zmax;
        smin = params.smin;
    else
        zmax = zeros(nObj, nObj);
        smin = inf(1,nObj);
    end
    
    for j = 1:nObj
       
        w = GetScalarizingVector(nObj, j);
        
        s = zeros(1,nPop);
        for i = 1:nPop
            s(i) = max(z(:,i)./w);
        end

        [sminj, ind] = min(s);
        
        if sminj < smin(j)
            zmax(:, j) = z(:, ind);
            smin(j) = sminj;
        end
        
    end
    
    params.zmax = zmax;
    params.smin = smin;
    
end

function w = GetScalarizingVector(nObj, j)

    epsilon = 1e-10;
    
    w = epsilon*ones(nObj, 1);
    
    w(j) = 1;

end