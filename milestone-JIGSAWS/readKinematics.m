function [ kinematics ] = readKinematics( filename, startRow, endRow )

% Initialize variables.
delimiter = ' ';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%READKINEMATICS
temp = repmat('%f',[1,76]);
formatSpec = [temp '%[^\n\r]'];

%% Open the text file.
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
fclose(fileID);

% store as  a double
kinematics = [dataArray{1:end-1}];


end

