function  [allRoutes,timing] = planningGrafic()



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
stationID.LA = 3;
stationID.ST = 4;
stationID.AL = 5;
stationID.HA = 7;
stationID.AA = 2;
stationID.HE = 6;




close all
figure
trains = fieldnames(timing);
count =0;
%compleet plot
for i=1:length(trains)
    %if (trains{i}(2) == '1')
    stations = fieldnames(timing.(trains{i}));
    times = zeros(0,0);
    for j=1:length(stations)
        %or two fields for a station (when it is passing) or one field
        %for each station when it is or departure or arrival
        
        actions = fieldnames(timing.(trains{i}).(stations{j}));
        
        if (length(actions) == 2 )
            if (~contains(actions{1} ,'2') && ~contains(actions{2} ,'2')) %so no 2 trains are plotted!
                if actions{1}(1) == 'S' && actions{2}(1) == 'D'
                    times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{2})]];
                    times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{2})-timing.(trains{i}).(stations{j}).(actions{1}))]];
                    
                elseif actions{1}(1) == 'D' && actions{2}(1) == 'S'
                    times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{1})]];
                    times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{1})-timing.(trains{i}).(stations{j}).(actions{2}))]];
                    
                elseif actions{1}(1) == 'A' && actions{2}(1) == 'S'
                    times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{1})]];
                    times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{1})+timing.(trains{i}).(stations{j}).(actions{2}))]];
                    
                elseif actions{1}(1) == 'S' && actions{2}(1) == 'A'
                    times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{2})]];
                    times = [times ; [stationID.(stations{j}), (timing.(trains{i}).(stations{j}).(actions{2})+timing.(trains{i}).(stations{j}).(actions{1}))]];
                    
                end
            end
            
            %some stations of the second train don't have a D-time or an
            %A-time so these only have S-times so don't add these
            %stations (this is for the next hour)
        elseif (length(actions) == 1) && actions{1}(1) ~= 'S'
            times = [times ; [stationID.(stations{j}), timing.(trains{i}).(stations{j}).(actions{1})]];
        end
        
        
    end
    
    times = sortrows(times,2); %so the plot is in the right order
    
    allRoutes.(trains{i}) = times;
    
    amount = size(times);
    
    %to make the color choice variable (not the same paterns for lines
    colors = ['r' ,'g', 'b', 'c', 'm', 'y', 'k', cellstr('#77ac30'), cellstr('#7e2f8e')];
    
    if amount(1,1) ~= 1 %remove useless trains
        count = count+1;
        
        if count > 9
            count = count - 8;
        end
        
        %make a new table with value's under 60 (and two plots to make
        %it all within an hour)
        %if trains{i}(1) == 'K'  %to check only one train
        if (times(1,2) > 60)
            times(:,2) = times(:,2) - 60;
            plot( times(:,2), times(:,1), '-*', 'DisplayName', trains{i},'Color',colors{count}, 'LineWidth',2.5, 'MarkerEdgeColor', colors{length(colors)-count+1});
            text(times(1,2),times(1,1), 'D' , 'FontSize', 15);
            text(times(length(times),2),times(length(times),1), 'A' , 'FontSize', 15);
        else
            for k=1:length(times)
                if  times(k,2) > 60
                    %interpolate at value x = 60
                    y60 = times(k-1,1) + ((60 - times(k-1,2))/(times(k,2)-times(k-1,2))) * (times(k,1) - times(k-1,1));
                    subTimesNorm = [times((1:k-1),(1:2)) ; y60 60];
                    
                    subTimesChange = [times((k:length(times)), (1:2))];
                    subTimesChange(:,2) = subTimesChange(:,2) - 60;
                    subTimesChange = [y60 0;subTimesChange];
                    plot( subTimesNorm(:,2), subTimesNorm(:,1), '-*','HandleVisibility','off','Color',...
                        colors{count}, 'LineWidth',2.5, 'MarkerEdgeColor', colors{length(colors)-count+1});
                    
                    plot(subTimesChange(:,2), subTimesChange(:,1), '-*','DisplayName' ,trains{i},'Color',colors{count},...
                        'LineWidth',2.5, 'MarkerEdgeColor', colors{length(colors)-count+1})
                    
                    text(times(1,2),times(1,1), 'D' , 'FontSize', 15);
                    text(subTimesChange(length(subTimesChange),2),subTimesChange(length(subTimesChange),1), 'A' , 'FontSize', 15);
                    
                    
                    break;
                    
                end
            end
            %end
        end
        
        
        
        
        %plot( times(:,2), times(:,1), '-*', 'Color', colors{count},'DisplayName', trains{i}, 'LineWidth',2.5, 'MarkerEdgeColor', colors{count});
        
        
        %to make the y axis readable
        y_labels = {'Leuven';'Aarschot';'Landen';'Sint-Truiden';'Alken';'Heist';'Hasselt'};
        y_values = [1;2;3;4;5;6;7];
        set(gca, 'Ytick',y_values,'YTickLabel',y_labels);
        
        
        
        legend('FontSize',12);
        hold all
    end
    % end
    
end
yline(3,'HandleVisibility','off');
yline(4,'HandleVisibility','off');
yline(5,'HandleVisibility','off');


%plot for each track
tracks = ['C','M','E','K'];
colors = ['r' ,'g', 'b', 'c', 'm', 'y', 'k', cellstr('#77ac30'), cellstr('#7e2f8e')];
for j=1:length(tracks)
    figure
    hold all
    count = 1;
    for i=1:length(trains)
        amount = size(allRoutes.(trains{i}));
        if (trains{i}(1) == tracks(j) && amount(1,1) ~= 1 )
            
            %start to plot
            %make a new table with value's under 60 (and two plots to make
            %it all within an hour)
            
            if (allRoutes.(trains{i})(1,2) >= 60)
                allRoutes.(trains{i})(:,2) = allRoutes.(trains{i})(:,2) - 60;
                stops = length(allRoutes.(trains{i}));
                
                plot( allRoutes.(trains{i})(:,2), allRoutes.(trains{i})(:,1), '-*','Color',colors{count}, 'DisplayName', trains{i}, 'LineWidth',2.5);
                text(allRoutes.(trains{i})(1,2),allRoutes.(trains{i})(1,1), 'D' , 'FontSize', 15);
                text(allRoutes.(trains{i})( stops ,2),allRoutes.(trains{i})(stops ,1), 'A' , 'FontSize', 15);
                string = ['track '  tracks(j)];
                title(string);
              
                
                
            else
                for k=1:length(allRoutes.(trains{i}))
                    
                    if  allRoutes.(trains{i})(k,2) > 60
                        %interpolate at value x = 60
                        y60 = allRoutes.(trains{i})(k-1,1) + ((60 - allRoutes.(trains{i})(k-1,2))/(allRoutes.(trains{i})(k,2)-allRoutes.(trains{i})(k-1,2))) * (allRoutes.(trains{i})(k,1) - allRoutes.(trains{i})(k-1,1));
                        subTimesNorm = [allRoutes.(trains{i})((1:k-1),(1:2)) ; y60 60];
                        
                        
                        subTimesChange = [allRoutes.(trains{i})((k:length(allRoutes.(trains{i}))), (1:2))];
                        subTimesChange(:,2) = subTimesChange(:,2) - 60;
                        subTimesChange = [y60 0;subTimesChange];
                        
                       
                        
                        plot(subTimesNorm(:,2), subTimesNorm(:,1), '-*','HandleVisibility','off',...
                            'Color',colors{count}, 'LineWidth',2.5);
                        
                        
                        plot(subTimesChange(:,2), subTimesChange(:,1), '-*','Color',colors{count},...
                            'DisplayName',trains{i}, 'LineWidth',2.5)
                        
                        text(allRoutes.(trains{i})(1,2),allRoutes.(trains{i})(1,1), 'D' , 'FontSize', 15);
                        text(subTimesChange(length(subTimesChange),2),subTimesChange(length(subTimesChange),1), 'A' , 'FontSize', 15);
                        
                        
                        string = ['track '  tracks(j)];
                        title(string);
                        
                        
                        break;
                        
                    end
                end
                
            end
            
            count = count +1;
        end
    end
    %to make the y axis readable
    y_labels = {'Leuven';'Aarschot';'Landen';'Sint-Truiden';'Alken';'Heist';'Hasselt'};
    y_values = [1;2;3;4;5;6;7];
    set(gca, 'Ytick',y_values,'YTickLabel',y_labels);
    
    yline(3, 'HandleVisibility','off');
    yline(4, 'HandleVisibility','off');
    yline(5, 'HandleVisibility','off');
    legend('FontSize',12);
    
end

end

