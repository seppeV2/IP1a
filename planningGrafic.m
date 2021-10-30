function times = planningGrafic()

lindoRes = transformLindoData('lindoResults.txt'); %load the struct in 

values = struct2cell(lindoRes); %get all the value's out of the struct
disp(values);
names = fieldnames(lindoRes); %get all the name's out of the struct

for i=1:length(names)
    
    if (names{i}(1) == 'D') || (names{i}(1) == 'A')  % safe the departure and arrival times
        train = extractBetween(names{i},2,length(names{i})-2);
        if values{i}(1) > 60
            times.(train{1}).(names{i}) = (values{i}(1)-60);
        else
           times.(train{1}).(names{i}) = values{i}(1);
        end
    end
    
    
end
end

