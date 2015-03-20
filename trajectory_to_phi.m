function [ phi, itimes, rtimes ] = trajectory_to_phi( trajectory, times )
%TRAJECTORY_TO_PHI This function translates an
%object space trajectory to phi (o_t, o_{t-1}).
phi = [trajectory(2:end,:) trajectory(1:end-1,:)];
itimes = 2:1:length(trajectory(:,1));
rtimes = times(itimes);

end

