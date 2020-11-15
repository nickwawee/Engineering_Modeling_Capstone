%Module 5 - Emissions: RockefellerEmissionsPlot
%Team Rockefeller
%EGR 102 Section 010
%Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%This script plots the rolling average of emissions of NOx and CO2 for the
%BP Whiting refinery, and determines which values are over EPA limits.]
RockefellerLoadData%import necessary data
startIndex = find(date == '01-Jul-2015',1);%starting july 1st
endIndex = find(date == '01-Aug-2015',1) - 1;%until the end of july
[rangeNOx, rangeCO] = RockefellerEmissionsRange(startIndex,endIndex,date,turbine1Nox,turbine1CO);
%calculate our rolling average vectors in ppm
%Graphing:
%nitrous oxide limit is 3 ppm
%carbon monoxide limit is 9 ppm
%the following loops make new vectors overNOx and overCO which contain
%values over their respective limit.
overCO = 0;%initialize overage arrays
overNOx = 0;
for n = 1:length(rangeNOx)
    if rangeNOx(n) >= 3
        overNOx(n) = rangeNOx(n);
        dateNOx(n) = date(startIndex+n);
    end
end
for n = 1:length(rangeCO)
    if rangeCO(n) >= 9
        overCO(n) = rangeCO(n);
        dateCO(n) = date(startIndex+n);
    end
end
figure%Plot of NOx emissions
if overNOx == 0 %if there are no overages, plot without overages
    plot(date(startIndex:endIndex),rangeNOx,'b');
else%if there are overages, plot with overages
    plot(date(startIndex:endIndex),rangeNOx,'b',dateNOx,overNOx,'*r');
end
xlabel('Date');
title('NOx emissions during July 2015');
ylabel('Nitrous Oxide Concentration, ppm');
legend('NOx concentration','NOx concentration above limit');
%ylim([0 (max(rangeNOx)+1)])
figure%Plot of CO emissions
if overCO == 0 %if there are no overages, plot without overages
    plot(date(startIndex:endIndex),rangeCO,'b');
else%if there are overages, plot with overages
    plot(date(startIndex:endIndex),rangeCO,'b',dateCO,overCO,'*r');
end
title('CO emissions during July 2015');
xlabel('Date');
ylabel('Carbon Monoxide Concentration, ppm');
%ylim([0 (max(rangeCO)+1)])
legend('CO concentration','CO concentration above limit');