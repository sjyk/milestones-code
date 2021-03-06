data = [];

%generate environment vector
[n p] = size(trial2{2});
f1 = reshape(getPenetrationGrid(trial2{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial2{2},n,0.0,0.2,0.1), 201*101,1);
%data =[data f1 f2];
%data = [f1 f2];

[n p] = size(trial3{2});
f1 = reshape(getPenetrationGrid(trial3{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial3{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];
%data = [f1 f2];

[n p] = size(trial4{2});
f1 = reshape(getPenetrationGrid(trial4{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial4{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

[n p] = size(trial5{2});
f1 = reshape(getPenetrationGrid(trial5{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial5{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

[n p] = size(trial6{2});
f1 = reshape(getPenetrationGrid(trial6{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial6{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

[n p] = size(trial8{2});
f1 = reshape(getPenetrationGrid(trial8{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial8{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

[n p] = size(trial9{2});
f1 = reshape(getPenetrationGrid(trial9{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial9{2},n,0.0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

[n p] = size(trial0{2});
f1 = reshape(getPenetrationGrid(trial0{2},n,-.1355,0.2,0.1), 201*101,1);
f2 = reshape(getCutVGrid(trial0{2},n,0,0.2,0.1), 201*101,1);
data =[data f1 f2];
%data = data + [f1 f2];

%get non-zero features
non_zero_indices = find(sum(data'));

%normalize features
data = data ./ repmat(max(data),201*101,1);

%cluster and rebuild feature grid
[k c] = kmeans(data(non_zero_indices,:),4,'Start','cluster','Replicates',50);
grid = zeros(201*101,1);
for i=1:1:length(non_zero_indices)
    grid(non_zero_indices(i)) = k(i);
end
reconstructedgrid = reshape(grid,201,101);

%get change points
changepoints = [];
%out = getChangePoints(trial2{2},reconstructedgrid,1000);
%changepoints =[changepoints; out];
out = getChangePoints(trial3{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial4{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial5{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial6{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial8{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial9{2},reconstructedgrid,1000);
changepoints =[changepoints; out];
out = getChangePoints(trial0{2},reconstructedgrid,1000);
changepoints =[changepoints; out];

%show change points
hold on;
scatter(changepoints(:,2),changepoints(:,3),'rx')

%show milestones
[k c] = kmeans(changepoints(:,2:4),6,'Start','cluster','Replicates',50);
scatter(c(:,1),c(:,2),'ko','filled')

