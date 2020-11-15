function [ a ] = RockefellerRegression( startIndex,endIndex,zValues,fuel,temp,gasDensity )
%{
Team: Rockefeller
EGR 102 Section 010
Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%}

%{
This function performs a regression between indecies for given data.
Inputs are the start and end indicies of the data, the zValues for what is
being evaluated, the fuel consumption, the temperature, and the gas
density.
Output is a values for regression.
%}

%% Initial data, unit conversions
gD=gasDensity(startIndex:endIndex,:);

FhSCF=fuel(startIndex:endIndex,:); %finding the desired values of fuel data
F=FhSCF.*gD./10000; %converting fuel values from hSCF to MBTU

T=temp(startIndex:endIndex,:); %finding the desired value of temp data

zValueshSCF=zValues(startIndex:endIndex,:); %finding desired indecies of power data
P=zValueshSCF; %renaming zValueshSCF

n=length(P); %length of data vectors

%% Minimizing sum of square residuals
%A matrix for system of equations
A=[n, sum(F), sum(T), sum(T.*F), sum(F.^2);...
    sum(F), sum(F.^2), sum(T.*F),sum(T.*F.^2), sum(F.^3);...
    sum(T), sum(T.*F), sum(T.^2), sum(T.^2.*F),sum(T.*F.^2);...
    sum(T.*F), sum(T.*F.^2), sum(T.^2.*F), sum(T.^2.*F.^2), sum(T.*F.^3);...
    sum(F.^2), sum(F.^3), sum(T.*F.^2), sum(T.*F.^3), sum(F.^4)];

b=[sum(P); sum(F.*P); sum(T.*P); sum(T.*F.*P); sum(F.^2.*P)]; %b matrix for system of equations

a=A\b; %solve the system of equations

end

