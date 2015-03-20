function [ endpoints ] = getEndPoints( trial, left, breakPoints )
data = trial{left};
[n p] = size(data);
endpoints = [breakPoints'/n data(breakPoints,1:7) data(breakPoints,9)/max(data(:,9))];
end

