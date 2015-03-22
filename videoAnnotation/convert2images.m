% this file converts videos to a sequence of images
function [] = convert2images()
%input
workingDir = '.';
% dataDir = ['..' filesep 'data' filesep ];
dataDir = ['data' ];
videoDir = 'SU-video-mp4';
% videoDir = 'NP-video-mp4';
% videoDir = 'KT-video-mp4';
targetFramerate = 1; %frames per second

% mkdir(workingDir)
mkdir(dataDir,'images')
imgDir = fullfile(dataDir,'images');

%get the names of all video files [We only read mp4 for now]
videoNames = dir(fullfile(dataDir,videoDir,'*_capture1.mp4'));
videoNames = {videoNames.name}';

% Uncomment if using stereo videos
% we are not handling stereo videos now. but can do that as well. 
% videoNames2 = dir(fullfile(dataDir,videoDir,'*_capture2.mp4'));
% videoNames = {videoNames.name videoNames2.name}';

%% loop through the videos and save images
% parfor l = 1: length(videoNames)
parfor l = 1: length(videoNames)
    %read the relevant video
%     inputVideo = VideoReader([videoDir filesep videoNames{l}]);
    inputVideo = VideoReader([dataDir filesep videoDir filesep videoNames{l}]);
    
    %make a new directory for putitng the images usinf the filenames
    tempDir = strsplit(videoNames{l}, '.');
    mkdir(imgDir,tempDir{1});
    
%     ii = 1;
%     while hasFrame(inputVideo)       
% %        img = readFrame(inputVideo);
%        %save every few frames per second
%        if mod(ii,floor(inputVideo.frameRate/targetFramerate))==0   
%            img = read(inputVideo,ii);
%            filename = [sprintf('%05d',ii) '.jpg'];
%            fullname = fullfile('images',tempDir{1}, filename);
%            %fullname = fullfile(workingDir,'images',videoNames{l}, filename);
%            imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%        end
%        ii = ii+1;
%     end

%     For awkward frame rate conversion, floating point errors may result
%     in 1:29:end. so handle those explicitly
%     for ii = 1: ceil(inputVideo.frameRate/targetFramerate) :numFrames

    numFrames =  uint32(floor(inputVideo.duration)*inputVideo.framerate);
    for ii = 1: floor(inputVideo.frameRate/targetFramerate) :numFrames
        img = read(inputVideo,ii);
        filename = [sprintf('%05d',ii) '.jpg'];
        fullname = fullfile(imgDir, tempDir{1}, filename);
        %fullname = fullfile(workingDir,'images',videoNames{l}, filename);
        imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
    end
        
end
