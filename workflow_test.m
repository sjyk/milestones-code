
%% Step 1 Candidate Change Points (two trajectories)
data = [trial2{2}(:,1:3)];
times = [trial2{2}(:,8)]-trial2{2}(1,8);
[phi1 itimes1 rtimes1] = trajectory_to_phi(data, times );
trajs = [ones(length(itimes1),1)];

data = [trial3{2}(:,1:3)];
times = [trial3{2}(:,8)]-trial3{2}(1,8);
[phi2 itimes2 rtimes2] = trajectory_to_phi(data, times );
trajs = [trajs;2*ones(length(itimes2),1)];

thresh = 4;
[ ichangepts, rchangepts, trajmap] = changepoint_detection( [phi1;phi2], trajs, [itimes1';itimes2'], thresh, [rtimes1;rtimes2]);

figure;
hold on;
title('Candidate Change Points');
fulldata = [trial2{2}(:,1:3);trial3{2}(:,1:3)];
plot3(fulldata(:,1), fulldata(:,2), fulldata(:,3),'k')
scatter3(fulldata(ichangepts,1), fulldata(ichangepts,2), fulldata(ichangepts,3),'ro','filled')

%% Step 2 Heirarchical Clustering (w KMeans)

%cluster over time
iters = 15;
totalcluster = 6;
[clusters c] = kmeans( fulldata(ichangepts,:),totalcluster);
timeclusters = clusters;

figure;
hold on;
title('Milestones');
scatter3(c(:,1),c(:,2),c(:,3))

