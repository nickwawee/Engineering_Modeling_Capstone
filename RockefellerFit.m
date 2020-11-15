%{
Team: Rockefeller
EGR 102 Section 010
Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%}

%{
This code runs the RockefellerRegression function, finding 'a' values for
power generation, Nox emmissions, and CO emmissions. It uses these values
to evaluate power generation and Nox/CO emmissions at different fuel burn
rates (0-2500 MBTU/hr)and temperature (0-100 F). It graphs these values,
and finds allowed fuel burn and temp values given CO and Nox restrictions.
Using this data, it graphs only the allowed values of power generation.
Using that data, it graphs the maximum allowed fuel burn rate for each
temperature.
%}

%% Change zero terms
for i=1:length(turbine2Fuel) %for loop, goes through fuel consumption, setting zero terms to NaN, and setting relevent variables to NaN
    if turbine2Fuel(i)==0
        turbine2CO(i)=NaN;
        turbine2Nox(i)=NaN;
        turbine2Prod(i)=NaN;
        turbine2Fuel(i)=NaN;
    end
end

%% Feb 2013 data fit
startFeb13=find(date=='01-Feb-2013 00:00:00'); %finding index of first data for Feb 2013
endFeb13=find(date=='01-Mar-2013 00:00:00')-1; %finding index of last data for Feb 2013

[ aProdFeb13 ] = RockefellerRegression( startFeb13,endFeb13,turbine2Prod,turbine2Fuel,temp,natGasDensity ) %finds regression coeff for Feb 2013 power
[ aNoxFeb13 ] = RockefellerRegression( startFeb13,endFeb13,turbine2Nox,turbine2Fuel,temp,natGasDensity ) %finds regression coeff for Feb 2013 Nox
[ aCOFeb13 ] = RockefellerRegression( startFeb13,endFeb13,turbine2CO,turbine2Fuel,temp,natGasDensity ) %finds regression coeff for Feb 2013 CO

%% Evaluation over range of fuel and temp data
tempRange=0:0.1:100; %creates a range of temp values from 0 to 100, step 0.1 (F)
fuelRange=0:10:2500; %creates a range of fuel values from 0 to 2500, step 10 (MBTU)

powerRange=zeros(length(tempRange),length(fuelRange)); %initialize powerRange
NoxRange=zeros(length(tempRange),length(fuelRange)); %initialize NoxRange
CORange=zeros(length(tempRange),length(fuelRange)); %initialize CORange

for i=1:length(tempRange) %for loop evaluating power, Nox, and CO values over range of temperature values
    for j=1:length(fuelRange) %for loop evaluating power, Nox, and CO values over range of fuel values
        powerRange(i,j)=sum(aProdFeb13.*[1;fuelRange(j);tempRange(i);fuelRange(j)*tempRange(i);fuelRange(j)^2]); %solve for power using regression a values
        NoxRange(i,j)=sum(aNoxFeb13.*[1;fuelRange(j);tempRange(i);fuelRange(j)*tempRange(i);fuelRange(j)^2]); %solve for Nox using regression a values
        CORange(i,j)=sum(aCOFeb13.*[1;fuelRange(j);tempRange(i);fuelRange(j)*tempRange(i);fuelRange(j)^2]); %solve for CO using regression a values
    end
end

%% Plotting
subplot(2,2,1)
mesh(fuelRange,tempRange,powerRange);
%naming conventions
title('Power Generation Varying Temp and Fuel');
xlabel('Fuel (MBTU/hr)');
ylabel('Temperature (F)');
zlabel('Power (MW)');

subplot(2,2,2)
mesh(fuelRange,tempRange,NoxRange);
%naming conventions
title('Nox Generation Varying Temp and Fuel');
xlabel('Fuel (MBTU/hr)');
ylabel('Temperature (F)');
zlabel('Nox (ppm)');

subplot(2,2,3)
mesh(fuelRange,tempRange,CORange);
%naming conventions
title('CO Generation Varying Temp and Fuel');
xlabel('Fuel (MBTU/hr)');
ylabel('Temperature (F)');
zlabel('CO (ppm)');

%% Plot 4: Power at acceptable ranges

CORangeCap=CORange; %initialize CORangeCap
sizeCORC=size(CORangeCap); %find dimensions of CORangeCap
lengthCORC=sizeCORC(1)*sizeCORC(2); %find total length of CORangeCap
for k=1:lengthCORC %for loop, set all acceptable values of CO emmissions to 0
    if CORange(k)<=5 %check if each index is <= cap
        CORangeCap(k)=0;
    end
end

NoxRangeCap=NoxRange; %initialize NoxRangeCap
sizeNRC=size(NoxRangeCap); %find dimensions of NoxRangeCap
lengthNRC=sizeNRC(1)*sizeNRC(2); %find total length of NoxRangeCap
for i=1:lengthNRC %for loop, set all acceptable values of Nox emmissions to 0
    if NoxRangeCap(i)<=2.5 %check of each index is <= cap
        NoxRangeCap(i)=0;
    end
end

NoxCORangeSum=NoxRangeCap+CORangeCap; %sum NoxRangeCap and CORangeCap. Logic: all acceptable levels of both CO and Nox will still be equal to 0. All else will be >0.
overCap=find(NoxCORangeSum~=0); %find all indecies of non-zero values.
powerRangeCap=powerRange; %initialize powerrangeCap
powerRangeCap(overCap)=NaN; %set all indicies of powerrangeCap equal to overCap to NaN, so they will not be graphed

subplot(2,2,4) %switch to subplot 4
mesh(fuelRange,tempRange,powerRangeCap); %graph powerRangeCap
%naming conventions
title('Power Generation at Acceptable CO and Nox Emissions');
xlabel('Fuel (MBTU/hr)');
ylabel('Temperature (F)');
zlabel('Power (MW)');

%% maxAllowableFR
for i=1:length(powerRangeCap) %for loop, finds the max allowed fuel rate for each temperature
    rowPRC=powerRangeCap(i,:); %isolate a row of powerRangeCap
    maxRowPRC=max(rowPRC); %find the maximum values (non-allowed values =NaN, could not be max)
    index=find(rowPRC==maxRowPRC); %find index of max value
    maxAllowableFR(i)=fuelRange(index); %find fuel burn at that index
end

figure %new figure
plot(tempRange,maxAllowableFR); %plots maxAllowableFR against temperature
%naming coventions
title('Maximum Potential Fuel Burn Rates by Temperature');
xlabel('Temperature (F)');
ylabel('Fuel Burn Rate (MBTU/hr)');
grid on
