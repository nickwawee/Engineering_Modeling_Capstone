
function [avgNOx,avgCO] = RockefellerEmissionsAvg(index,date,NOx,CO)
%% 
%Module 5 - Emissions: RockefellerEmissionsAvg
%Team Rockefeller
%EGR 102 Section 010
%Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%This calculates a 3-hour rolling average and a 1-hour rolling average for
%emissions of NOx and CO from turbine 1 respectively (ppm). The purpose of
%this function is to effectively calcuate the rolling average of each per
%indice supplied.
%%
%----NOx Avg------------------------------------------------------------

NOxduration= duration(2,59,0); %Defines the that the duration for the NOx rolling average to be 02:59:00. 
i=1;% initializes i
while date(index)-date(index-i)<=NOxduration % states that if the diferrence between the date between the starting index and the index that is being subracted by 1 is less than or equal to 02:59:00, then the loop runs are tries again. 
    i=i+1;
end
NOxbeginindice= index - i;% states that the beginning indice is equal to the index - the i value
NOxavgvector= NOx(NOxbeginindice:index); % makes a vector out of the starting and ending indices
avgNOx= mean(NOxavgvector); % calculates 3 hour rolling average of NOx emissions (ppm)

%----- CO Avg-----------------------------------------------------------

COduration1= duration(0,59,0); % Defines the that the duration for the CO rolling average to be 00:59:00. 
i=1; % initializes i
while date(index)-date(index-i)<COduration1 % does the same thing as the NOx while loop, but with the duration as 00:59:00
    i=i+1;
end
CObeginindice=index - i;% states that the beginning indice is equal to the index - the i value
COavgvector= CO(CObeginindice:index); % makes a vector out of the starting and ending indices
avgCO= mean(COavgvector);% calculates the average after a 1 hour time period of CO (ppm)

end

