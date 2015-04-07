function [ output_args ] = changePointPruning( CP1, trial1, CP2, trial2 )
%CHANGEPOINTPRUNING 
% This function will divide up the trial sequence by changePoints
% Thereafter a multidimensional time sequence alignment will output a
% matching
% INPUT: Changepoints list of times (CP1, CP2)
%        Trials: (trial1, trial2) data series as a NxD array where D is
%        state dimension, N is length
%        Changepoints(end)<size(trial,2)
% OUTPUT: 
%         changePointsNew: list of updated changepoints
%         trail: updated trial sequence N'xD (N'<D)
%         changePointsRemoved:  culled changepoints
%         dataCulled: cell array containing culled trial sequences

% if changepoint not a column vectorof times, make it one.

%% put data into segments
segments1 ={};
for i = 1:length(CP1(:,1))+1    
    if i ==1
        tStart = 1;            
        tEnd = CP1(i,1);
    elseif i == length(CP1(:,1))+1
        tStart = CP1(i,1); % last changepoint
        tEnd = length(trial1(end,1)); %last time step in trials
    else
        tStart = CP1(i-1,1);            
        tEnd = CP1(i,1);
    end    
    segments1{i} = trial1(tStart:tEnd,:);
end

segments2 ={};
for i = 1:length(CP2(:,1))+1    
    if i ==1
        tStart = 1;            
        tEnd = CP2(i,1);
    elseif i == length(CP2(:,1))+1
        tStart = CP2(i,1); % last changepoint
        tEnd = length(trial1(end,1)); %last time step in trials
    else
        tStart = CP2(i-1,1);            
        tEnd = CP2(i,1);
    end    
    segments2{i} = trial2(tStart:tEnd,:);
end

%  consider using relative segments
%% Perform DTW across changepoints as discrete timesteps


end

