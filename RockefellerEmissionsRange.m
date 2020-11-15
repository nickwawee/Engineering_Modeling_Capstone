function [rangeNOx, rangeCO] = RockefellerEmissionsRange(startIndex,endIndex,date,NOx,CO)
%% 
%Module 5 - Emissions: RockefellerEmissionsRange
%Team Rockefeller
%EGR 102 Section 010
%Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%The purpose of this function is to utilize the Emissions average function
%with a starting and ending index. It generates a vector of range of values
%for NOx emissions and CO emissions for turbine 1 (ppm). The inputs to this
%function is the starting index, ending index, and date in date time
%format. Additional inputs is the NOx and CO vector from turbine one,
%(ppm).
%% 
index=startIndex; %defines the index for the function to be the start index
avgNOx= zeros(endIndex-startIndex+1, 1);% creates zero vectors for the average values of CO and NOx emissions
avgCO= zeros(endIndex-startIndex+1, 1);
[avgNOx(1), avgCO(1)]= RockefellerEmissionsAvg(index,date,NOx,CO); % assigns initial values for the averages
for i = 1:(endIndex-startIndex) % i runs for the length of the given time periods each rollling avg wil be calculated
    [avgNOx(i+1), avgCO(i+1)]= RockefellerEmissionsAvg(index+i,date,NOx,CO); % calculates avgNOx and avgCO emission vectors. The ith component is added to the starting index to eventually end up at the end index when the length is met
end
rangeNOx=avgNOx;% assigns the calculated average values to the range vector for NOx and CO respectively, (ppm).
rangeCO=avgCO;
end
