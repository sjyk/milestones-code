function [ output_with_metadata] = loadTrial(index,data)
%GETCANDIDATEPOINTS Summary of this function goes here
%   Detailed explanation goes here
onearm = data{2};
[n p] =size(onearm);
output_with_metadata = [(1:1:n)' ones(n,1)*index onearm];

end

