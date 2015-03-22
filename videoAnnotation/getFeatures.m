function features = getFeatures(inputFileName, varargin )
% This function reads the inputFileName mat file saved from the cascadeTrainer 
% annotation tool. Output: a set of features derived from the bounding 
% boxes in the images.
%% Animesh Garg
% Mar 18, 2015

% input: inputFileName, outputFileName, originalFramerate, interpolate (binary), targetFramerate (only if interpolate)
% if saving not needed pass outputfilename = NaN
    
if nargin>5
    fprintf ('If interpolate turned on, must supply targetFramerate \n')
    fprintf('Usage: input: [inputFileName, originalFramerate, interpolate (binary), targetFramerate (only if interpolate)]\n')
    return

elseif nargin==5
    outputFileName = varargin{1};
    outputFlag = 1;
    originalFramerate = varargin{2};
    interpolate = varargin{3};
    targetFramerate = varargin{4};
    
elseif nargin ==4
    outputFileName = varargin{1};
    outputFlag = 1;
    interpolate = varargin{2};
    targetFramerate = varargin{3};
    originalFramerate = 30;
    
elseif nargin ==3
    fprintf ('Second argunment interpreted as originalFramerate (>0)\n')
    outputFileName = varargin{1};
    outputFlag = 1;
    originalFramerate = varargin{2};
    interpolate = 0;
    
elseif nargin ==2
    fprintf ('Setting originalFramerate as 30\n')
    outputFileName = varargin{1};
    outputFlag = 1;
    originalFramerate = 30;
    interpolate = 0;    

elseif nargin ==1
    fprintf ('No output file specifed.\n')
    outputFlag = 0;
    
elseif nargin <1
    fprintf ('Need atleast one input file\n')
    return
end
    
%% read the bounding boxes
% inputFileName = 'labels-needle-bbox/suturing_G004_capture1.mat';%debug
load(inputFileName);%loads a structure called annotations

% for i = 1:length(data)
%    images =  
% end
%% sort using natural sort (might not be required always)
datafields = fieldnames(annotations);
dataCell = struct2cell(annotations);
dataSz = size(dataCell); %mxn struct with p fields results in pxmxn cell

dataCell = reshape (dataCell, dataSz(1), []); %Px(MxN)
dataCell = dataCell'; %(MxN)XP
dataCell = sortrows(dataCell, 1); %sort by imageFilename

[sortedNames, idx] = sort_nat(dataCell(:,1));%this is only for testing

%% add time stamps acc to file names
t = [];
for i = 1:length(dataCell(:,1))
   temp = strsplit(dataCell{i,1},'.') ;
   temp = strsplit (temp{1}, filesep);
   t(i) = str2num(temp{end});
end

%all the bbox data
bbox = cell2mat(dataCell(:,2));

features = [];
%% interpolate if required
if interpolate        
    currRate = t(2)-t(1);%sampling with interveaved frames
    dataSamplingRate = floor(originalFramerate/currRate);
    if dataSamplingRate <1
        fprintf('it seems the current sampling rate is more than ...original frame rate!! (not possible)\n')
        return
    end
    % Preferred dataSamplingRate :{1, 2,4,6,..} otherwise there would be
    % many boundary conditions to be handled for conversion to
    % targetFrameRate
    samplingRate = targetFramerate/dataSamplingRate;
    for i = 1:length(t)
        if i<length(t)
        t_interp = linspace (t(i),t(i+1), samplingRate+1);
        [xmin_interp, y_min_interp]= fillline (bbox(i,1:2),...
            bbox(i+1,1:2), samplingRate+1);
        width_interp = linspace (bbox(i,3), bbox(i+1,3),...
            samplingRate+1);
        height_interp = linspace (bbox(i,4), bbox(i+1,4),...
            samplingRate+1);
        features = vertcat(features, ...
            [(t_interp(1:end-1)./originalFramerate)',...
            xmin_interp((1:end-1))', y_min_interp(1:end-1)',...
            width_interp(1:end-1)',height_interp(1:end-1)']);        
        
        %boundary condition (extrapolation only required for last time step)        
        elseif i == length(t)
            t_interp = linspace (t(i),t(i)+currRate, samplingRate+1);
            [xmin_interp, y_min_interp]= fillline (bbox(i,1:2),...
                    bbox(i,1:2), samplingRate+1);
            width_interp = linspace (bbox(i,3), bbox(i,3),...
                samplingRate+1);
            height_interp = linspace (bbox(i,4), bbox(i,4),...
                samplingRate+1);
            features = vertcat(features, ...
            [(t_interp(1:end-1)./originalFramerate)',...
            xmin_interp((1:end-1))', y_min_interp(1:end-1)',...
            width_interp(1:end-1)',height_interp(1:end-1)']);                    
        end
    end        
    
else
    features = [(t./originalFramerate)', bbox];

end
% save the features as mat file
if outputFlag && ~isnan(outputFileName(1)) 
    save (outputFileName, 'features');
end


end

function [xx,yy]=fillline(startp,endp,pts)
        m=(endp(2)-startp(2))/(endp(1)-startp(1)); %gradient 

        if m==Inf %vertical line
            xx(1:pts)=startp(1);
            yy(1:pts)=linspace(startp(2),endp(2),pts);
        elseif (m==0) || (abs(endp(1)-startp(1))<1e-6) %horizontal line
            xx(1:pts)=linspace(startp(1),endp(1),pts);
            yy(1:pts)=startp(2);
        else %if (endp(1)-startp(1))~=0
            xx=linspace(startp(1),endp(1),pts);
            yy=m*(xx-startp(1))+startp(2);
        end
end