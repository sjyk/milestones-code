function [ ichangepts, rchangepts, trajmap] = changepoint_detection( object_change_tuples, trajs, itimes, k, rtimes)
%CHANGEPOINT_DETECTION This function detects change points in trajectories
%   object_change_tuples: N x d matrix
%   trajs: N x 1 matrix where each entry is a number of which trajectory
%   that example is from starting from 1
%   times: N x 1 matrix time index of the trajectory
%   k: Number of change points

% Returns ichangepts: logical time of the change points
% rchangepts: real time of the change points
% trajmap: trajectories

[labels model llh] = emgm(object_change_tuples',k);
num_traj = max(trajs);

ichangepts = [];
rchangepts = [];
trajmap = [];

for i=1:1:num_traj
    regimes = labels(find(trajs == i)); %find the dynamical regimes
    timesteps = itimes(find(trajs == i)); 
    [values indices] = sort(timesteps);
    regimes = regimes(indices); %reorder by time
    changes = find(regimes(2:end)-regimes(1:end-1) ~= 0);
    changes = [changes length(indices)];
    ichangepts = [ichangepts changes];
    trajmap = [trajmap i*ones(1,length(changes))];
end

rchangepts = rtimes(ichangepts);
end

