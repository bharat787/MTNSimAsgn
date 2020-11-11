function ch=Mutate(nsga3,x,sigma)
global sinkNodePosition RsValues RcValues

    

xMutate = x.x+randi([-sigma sigma],size(x.x,1),1); %mutate the whole positions of nodes  
xMutate(xMutate<nsga3.lowerBounds(2))=[];  % remove out of range values
xMutate(xMutate>nsga3.upperBounds(2))=[];

yMutate = x.y+randi([-sigma sigma],size(x.y,1),1); 
yMutate(yMutate<nsga3.lowerBounds(3))=[];
yMutate(yMutate>nsga3.upperBounds(3))=[];

ch = nsga3.solutionStruct;
xValues = [x.x;xMutate];
yValues = [x.y;yMutate];
chConect=false;
while(~chConect)
    
    % Generate a random number of solutions
    numberOfSensors = randi([nsga3.lowerBounds(1) nsga3.upperBounds(1)]);
    ch.numberOfSensors = numberOfSensors;
    % Generate randomly the x y coordinates
    randXIndices = randi(length(xValues),numberOfSensors,1);
    randYIndices = randi(length(yValues),numberOfSensors,1);
    ch.x = [xValues(randXIndices);sinkNodePosition(1)];
    ch.y = [yValues(randYIndices);sinkNodePosition(2)];
    
    % Generate the sensing range for each sensor
    [covered,RsiMin] = ComputeMinimumRsi(ch,nsga3.lowerBounds(2),nsga3.upperBounds(2),RsValues(end));
    if covered
        % The environment could be covered by the sensors
        ch.Rs = RsiMin;
    else
        % The environment could not be covered by the sensors
        continue;
    end
    
    % Generate the connectivity radius for each sensor
    [connected,RciMin] = ComputeMinimumRci(ch,RcValues(end));
    if connected
        % The network is connected
        ch.Rc = RciMin;
        chConect = true;
    else
        % The network is not connected
        continue;
    end
end