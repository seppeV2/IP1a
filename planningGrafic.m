function  timing = planningGrafic()



%% This section makes a struct with all the necessary data for the graph
lindoRes = transformLindoData('lindoResults.txt'); %load the struct in 

values = struct2cell(lindoRes); %get all the value's out of the struct

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
% only plotting the trains 1 trains as the 2 trains don't have enough info

%to plot everything every station has an id code made here in a struct
stationID.LE = 1;
stationID.LA = 2;
stationID.ST = 4;
stationID.AL = 6;
stationID.HA = 7;
stationID.AA = 3;
stationID.HE = 5;

close all 
figure

trains = fieldnames(timing);
for i=1:length(trains)
   %if (trains{i}(2) == '1')
       stations = fieldnames(timing.(trains{i}));
       times = zeros(0,0);
       for j=1:length(stations)
           %or two fields for a station (when it is passing) or one field
           %for each station when it is or departure or arrival
           
           actions = fieldnames(timing.(trains{i}).(stations{j}));
           
           
           if (length(actions) == 2)
               if actions{1}(1) == 'S'  
                times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{2})]];
                times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{2})-timing.(trains{i}).(stations{j}).(actions{1}))]];
               else
                times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{1})]];
                times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{1})-timing.(trains{i}).(stations{j}).(actions{2}))]];
               end
            
               %some stations of the second train don't have a D-time or an
               %A-time so these only have S-times so don't add these
               %stations (this is for the next hour)
           elseif (length(actions) == 1) && actions{1}(1) ~= 'S'
               times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{1})]];
           end
         
               
       end
       
        times = sortrows(times,2); %so the plot is in the right order
        disp(trains{i});
        disp(times);
      
        
        amount = size(times);
        colors = 'rgbcmyk';
        choice = randi(length(colors));
        
        if amount(1,1) ~= 1 %remove useless trains 
            plot( times(:,2), times(:,1), '-*', 'DisplayName', trains{i}, 'LineWidth',1.5, 'MarkerEdgeColor', colors(choice));
           

            %to make the y axis readable
            y_labels = {'Leuven';'Landen';'Aarschot';'Sint-Truiden';'Heist';'Alken';'Hasselt'};
            y_values = [1;2;3;4;5;6;7];
            set(gca, 'Ytick',y_values,'YTickLabel',y_labels);
            
            text(times(1,2),times(1,1), 'D' , 'FontSize', 15);
            text(times(length(times),2),times(length(times),1), 'A' , 'FontSize', 15);

            legend('FontSize',12);
            hold all
        end
% end
  
end



end

