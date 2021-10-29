function lindoResults = transformLindoData(fileName)

fileID = fopen(fileName); %open the text file with the lindo results
res = 1;

while res ~= -1
    res = fgetl(fileID);
    if res ~= -1 %when no line anymore fgetl gives a -1 result
        x = split(res); %split the line to get all the usefull content
        lindoResults.(x{2}) = str2double(x(3)); %make a sturct with all the variables
        
    end
  
end

fclose(fileID); %close the text file with the lindo results

end