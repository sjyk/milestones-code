function [ d ] = dist_kinematics( X, Y, varargin)
%DISTXY Custom Distance metric for the JHU kinematics data
% 1-3    (3) : tooltip xyz                    
% 4-12   (9) : tooltip R    
% 13-15  (3) : tooltip trans vel x', y', z'   
% 16-18  (3) : tooltip rot_vel                
% 19     (1) : gripper angle   
% We use the scale dependent left-invariant metric from 
% "Distance Metrics on the Rigid Body Rotations with Applications 
% to Mechanism Design "

if nargin <3
    w = [1, 2, 1, 2, 2]; %this works under appropriate scaling of positions
else 
    w = varargin{1};
end
    
% euclidiean distance
d_trans = norm(X(1:3)- Y(1:3),2); 

% rotation matrix similarity
R1 = reshape(X(4:12),[3,3]);
R2 = reshape(Y(4:12),[3,3]);
d_rot = 0.5*trace(log(R'*R))'*(log(R'*R));

%quaternion Distance
% qx = dcm2quat(R1);
% qy = dcm2quat(R2);
% 
% d_quat = 1 - abs(qx.*qy); %[0,1] measure of similarity

%difference in velocities
d_linVel = norm(X(13:15)- Y(13:15),2);

%difference in rotational vel
d_rotVel = norm( X(16:18)- Y(16:18),2); %radians/sec

% gripper angle difference
d_grip = abs(X(19)- Y(19));

d = w(1)*d_trans + w(2)*d_rot + w(3)* d_linVel + w(4)*d_rotVel + w(5)*d_grip;

end

