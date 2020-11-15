%% This is the parents script that runs all of the scripts. 
% This is the only script that the TA must run.
% Adjust the names of the scripts to make your project code run.

clc
clear

RockefellerLoadData;
	
RockefellerPlot;
	% Calls teamNameUnmetDemand

RockefellerEmissionsPlot;
	% Calls teamNameEmissionsRange
			% Calls teamNameEmissionsAvg

RockefellerFit;
	% Calls teamNameRegression