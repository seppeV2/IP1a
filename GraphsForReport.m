[allRoutes, timing] = planningGrafic;

fields = fieldnames(allRoutes);

close all 
figure
pointer = 1;
color = ['r','c','g','b'];
for i=1:length(fields) 
    
    if contains(fields(i),'K') && ~contains(fields(i) , '2')
        plot(allRoutes.(fields{i})(:,2), allRoutes.(fields{i})(:,1),'-*',...
            'LineWidth',2.5,'DisplayName' ,fields{i},'Color', color(pointer));
        
        legend
        hold on 
        before = [allRoutes.(fields{i})(:,1) allRoutes.(fields{i})(:,2)-60];
        after = [allRoutes.(fields{i})(:,1) allRoutes.(fields{i})(:,2)+60];
        
        plot(before(:,2), before(:,1),'-*', 'HandleVisibility','off',...
            'LineWidth',2.5,'Color', color(pointer))
        plot(after(:,2), after(:,1), '-*','HandleVisibility','off',...
            'LineWidth',2.5,'Color', color(pointer))
        
        stops = length(allRoutes.(fields{i}));
        text(allRoutes.(fields{i})(1,2),allRoutes.(fields{i})(1,1), 'D' , 'FontSize', 15);
        text(allRoutes.(fields{i})(stops ,2),allRoutes.(fields{i})(stops ,1), 'A' , 'FontSize', 15);
        
        text(before(1,2),before(1,1), 'D' , 'FontSize', 15);
        text(after( stops ,2),after(stops ,1), 'A' , 'FontSize', 15);
        pointer = pointer +1;
        
        
        
    end
    
    
    
end
y_labels = {'Leuven';'';'Landen';'Sint-Truiden';'Alken';'';'Hasselt'};
y_values = [1;2;3;4;5;6;7];
set(gca, 'Ytick',y_values,'YTickLabel',y_labels);
yline(3,'HandleVisibility','off');
yline(4,'HandleVisibility','off');
yline(5,'HandleVisibility','off');
xline(40,'HandleVisibility','off');
xline(100,'HandleVisibility','off');
xline(160 , 'HandleVisibility', 'off');
        