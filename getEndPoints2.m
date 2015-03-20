function [ endpoints ] = getEndPoints2( trial, breakPoints )
data1 = trial{1};
data2 = trial{2};
[n p] = size(data1);
endpoints = [breakPoints'/n data1(breakPoints,1:7) data1(breakPoints,9)/max(data1(:,9)) data2(breakPoints,1:7) data2(breakPoints,9)/max(data2(:,9))];
end

