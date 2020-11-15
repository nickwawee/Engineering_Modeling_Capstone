%% 
%{
Team: Rockefeller
EGR 102 Section 010
Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%}

%{
This script plots demanded energy and production of energy of specific dates. This script also calculates the lost revenue in a day due to unmet
%demand. The unmetdemand function is used in the script.
%}

%% 
Feb2ndStart= find(date== '02-Feb-2014 00:00:00');
Feb2ndEnd=find(date=='03-Feb-2014 00:00:00')-1;
Feb2ndDemand= demand(Feb2ndStart:Feb2ndEnd);
Jan2ndStart= find(date== '02-Jan-2014 00:00:00');
Jan2ndEnd= find(date== '03-Jan-2014 00:00:00')-1;
Jan2ndDemand= demand(Jan2ndStart:Jan2ndEnd);
Mar6thStart= find(date== '06-Mar-2015 00:00:00');
Mar6thEnd= find(date== '07-Mar-2015 00:00:00')-1;
Mar6thDemand= demand(Mar6thStart:Mar6thEnd);
Mar6thProduction= totalProd(Mar6thStart:Mar6thEnd);
Mar6thSalePrice= salePrice(Mar6thStart:Mar6thEnd);
figure
subplot(2,1,1)
plot(date(Feb2ndStart:Feb2ndEnd),Feb2ndDemand);
title('Demanded Energy for February 2, 2014');
xlabel('Hour of Day');
ylabel('Demanded Energy (MW)');
subplot(2,1,2)
plot(date(Jan2ndStart:Jan2ndEnd),Jan2ndDemand)
title('Demanded Energy for January 2, 2014')
xlabel('Hour of Day');
ylabel('Demanded Energy (MW)');
figure
plot(date(Mar6thStart:Mar6thEnd),Mar6thDemand,date(Mar6thStart:Mar6thEnd),totalProd(Mar6thStart:Mar6thEnd))
title('Total Demand vs Total Production of Power')
xlabel('Hour of Day');
ylabel('Energy (MW)');
legend('Demand', 'Production');
[unmetDemand] =RockefellerUnmetDemand( Mar6thStart, Mar6thEnd, Mar6thDemand,Mar6thProduction);
lostrevenue=sum(sum(unmetDemand*.25.*Mar6thSalePrice)); %calculates the lost revenue ($)