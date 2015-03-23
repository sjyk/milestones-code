% Animesh Garg
% Mar 18, 2015

% This script runs the getFeature() over all the output annotations from
% the cascadeTrainer and save them in struct in a folder named features.
% Each struct is named 'fileName_features.mat' and contains an array
% 'features' of the form [t, xmin, ymin, width, height
% t is continuous obtained by t/30 with 30 being the original 

%% init params
workingDir = '.';
dataDir = ['data' filesep ];
annotationDir = 'labels-needle-bbox';

% mkdir(workingDir)
mkdir(dataDir,'features');
featureDir = fullfile(dataDir,'features');

annotationNames = dir(fullfile(dataDir,annotationDir,'*_capture1.mat'));
annotationNames = {annotationNames.name}';

originalFramerate = 30;
interpolate = 1; %no need for interpolation here
targetFramerate = 30; %frames per second

%% Read the csv file for times
% filename = 'suturing-times.csv';
% endRow = 39;%no of trials
% formatSpec = '%s%f%f%f%f%f%f%f%f%[^\n\r]';
% 
% fileID = fopen(filename,'r');
% dataArray = textscan(fileID, formatSpec, endRow, 'Delimiter', ',', 'ReturnOnError', false);
% fclose(fileID);
% 
% namedTrails = dataArray{:, 1};
% puncture_times = dataArray(:, 2:9);
% puncture_times = cell2mat (puncture_times);
% 
% % Clear temporary variables
% clearvars filename delimiter endRow formatSpec fileID ans;

%% loop through all the the existing annotations 
for l = 1: length(annotationNames)    
    %save all files
   [~] = getFeatures(fullfile(dataDir, annotationDir, annotationNames{l}),...
       [featureDir filesep 'feat_' annotationNames{l}],...
       originalFramerate, interpolate, targetFramerate  ) ;
end