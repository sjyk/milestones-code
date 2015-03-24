% Author: Animesh Garg
% Date: mar 23, 2014

clear
%% Load all the annotations

annotationDir = ['..' filesep 'videoAnnotation' filesep 'data' filesep 'features'];
annotationNames = dir(fullfile(annotationDir,'*.mat'));
annotationNames = {annotationNames.name}';
%create a Nested cell array to store data
trial = {};
for l = 1: length(annotationNames) 
feat = load (fullfile(annotationDir,annotationNames{l}));    
trial{l}{1} = feat.features;
end


%% Load all the kinematics data
kinematicsDir = ['..' filesep 'data' filesep 'SU-kinematics' filesep...
    'kinematics' filesep 'AllGestures'];
kinematicsNames = dir(fullfile(kinematicsDir,'*.txt'));
kinematicsNames = {kinematicsNames.name}';

for l = 1: length(kinematicsNames) 
kinematics = readKinematics(fullfile(kinematicsDir,kinematicsNames{l}));    
trial_kinematics{l} = kinematics;
end

%% get indices for which annotations are present
idX = [];
for l = 1: length(kinematicsNames) 
    temp = strsplit(kinematicsNames{l}, '.');
%     idX{l} = cell2mat(strfind (lower(annotationNames), lower(temp{1})));
    temp = cell2mat(strfind (lower(annotationNames), lower(temp{1})));
    if ~isempty(temp)
        idX = [idX; l];        
    end
end
if length(idX)~=length(annotationNames)
    fprintf('Annotation index not matching kinematics data..\n')
    return
end

% add robot data to annotations
for l = 1: length(annotationNames)
    trial{l}{2} = trial_kinematics{idX(l)};
    % Since video is longer than kinematics, drop the last frames to align
    if size(trial{l}{2},1)<= size(trial{l}{1},1)
        temp = trial{l}{1};
        trial{l}{1} = temp (1:size(trial{l}{2},1),:);
    else
        temp = trial{l}{2};
        trial{l}{2} = temp (1:size(trial{l}{1},1),:);
    end
end

%% Cluster only visual features, then cluster in time



%% Cluster only time, then cluster in visual features



%% Cluster only visual features+robot positions , then cluster in time


%% Cluster only time, then cluster in visual features+robot positions 


% Plotting
%% [X, labels] = generate_data('helix', 2000);
% 	figure, scatter3(X(:,1), X(:,2), X(:,3), 5, labels); title('Original dataset'), drawnow
% 	no_dims = round(intrinsic_dim(X, 'MLE'));
% 	disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
% 	[mappedX, mapping] = compute_mapping(X, 'PCA', no_dims);	
% 	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels); title('Result of PCA');
%   [mappedX, mapping] = compute_mapping(X, 'Laplacian', no_dims, 7);	
% 	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); title('Result of Laplacian Eigenmaps'); drawnow


