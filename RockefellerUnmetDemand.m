%% 
%{
Team: Rockefeller
EGR 102 Section 010
Members: Brad Luzenski, Konrad Rauscher, Nick Wawee
%}
%{
The purpose of this function is to produce a vector that outputs unmet
%demand per quarter over a given time index. sI and eI is the starting and
%ending time index respectively (units). The d and p represents the total
%demand of energy (MW) and the total production of energy
(MW)respectively
%}
function [ unmetDemand] =RockefellerUnmetDemand( startingIndex, endingIndex, demand, production )
range= startingIndex:endingIndex;

for i= 1:length(range)
    unmetDemand(i)= demand(i) - production(i);% unmet demand in MW
    if unmetDemand(i)<0
       unmetDemand(i)=0;
    end
end
