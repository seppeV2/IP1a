function timing = planningGrafic()



%% This section makes a struct with all the necessary data for the graph
lindoRes = transformLindoData('lindoResults.txt'); %load the struct in 

values = struct2cell(lindoRes); %get all the value's out of the struct
disp(values);
names = fieldnames(lindoRes); %get all the name's out of the struct

trains = zeros(0,0);

for i=1:length(names) %making a struct with all usefull information
    
    if ((names{i}(1) == 'D') && (names{i}(2)  ~= 'E' && names{i}(3) ~= 'V')) || names{i}(1) == 'A' % safe the departure and arrival times
        trainName = extractBetween(names{i},2,length(names{i})-2);
        if ~(ismember(trainName{1},  trains))
          trains = [trains,trainName];
        end
    end
end

for i=1:length(names)
    for j=1:length(trains)
        trainName1 = extractBetween(names{i}, 2, length(names{i})-2);
        trainName2 = extractBetween(names{i}, 3, length(names{i})-2);
        station = extractBetween(names{i}, length(names{i})-1, length(names{i}));
        
        if  isequal(trainName1{1}, trains{j}) && (names{i}(1) == 'D' || names{i}(1) == 'A')
            timing.(trains{j}).(station{1}).(names{i}) = (values{i}(1));
            
            %might do this later
%             if values{i}(1) > 60
%                 timing.(trains{j}).(station{1}).(names{i}) = (values{i}(1)-60);
%             else
%                 timing.(trains{j}).(station{1}).(names{i}) = (values{i}(1));
%             end
        end
        
        typeOfTrain = eraseBetween(trains{j},2,2);  
        if isequal(trainName2{1} ,typeOfTrain) && (names{i}(1) == 'S' )
             timing.(trains{j}).(station{1}).(names{i}) = values{i}(1);
        end
   end
end
%% this section is to make the actual graph



end

