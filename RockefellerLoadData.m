%{
Team: Rockefeller
EGR 102 Section 010
Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%}

%{
This script opens the .csv data file and creates a separate vector for each
column of data.
%}

data=csvread('data.csv',2); %load data file, starting in row 2 to avoid text error

%% Create Individual Vectors
%using data matrix, create a separate vector for each column of data, named
%using the first cell of each column

date=data(:,1); %date (excel format)
date=datetime(date,'ConvertFrom','Excel'); %convert Excel dates to matlab format

salePrice=data(:,2); %$/MWhr
fuelCost=data(:,3); %$/MBTU
demand=data(:,4); %MW
totalProd=data(:,5); %MW
SteamSold=data(:,6); %kip/hr
turbine1Prod=data(:,7); %MW
turbine1Fuel=data(:,8); %hSCF/hr
turbine1CO=data(:,9); %ppm
turbine1Nox=data(:,10); %ppm
turbine2Prod=data(:,11); %MW
turbine2Fuel=data(:,12); %hSCF/hr
turbine2CO=data(:,13); %ppm
turbine2Nox=data(:,14); %ppm
db1Fuel=data(:,15); %hSCF/hr
db1Steam=data(:,16); %kip/hr
db2Fuel=data(:,17); %hSCF/hr
db2Steam=data(:,18); %kip/hr
steamProd=data(:,19); %MW
steamFuel=data(:,20); %kip/hr
natGasDensity=data(:,21); %BTU/SCF
temp=data(:,22); %fahrenheit (F)
