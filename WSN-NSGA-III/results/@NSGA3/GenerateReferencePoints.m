function nsga3 = GenerateReferencePoints(nsga3)

    nsga3.Zr = GetFixedRowSumIntegerMatrix(nsga3.numberOfObjectives, nsga3.nDivision)' / nsga3.nDivision;

end

function A = GetFixedRowSumIntegerMatrix(M, RowSum)

    if M < 1
        error('M cannot be less than 1.');
    end
    
    if floor(M) ~= M
        error('M must be an integer.');
    end
    
    if M == 1
        A = RowSum;
        return;
    end

    A = [];
    for i = 0:RowSum
        B = GetFixedRowSumIntegerMatrix(M - 1, RowSum - i);
        A = [A; i*ones(size(B,1),1) B];
    end

end
