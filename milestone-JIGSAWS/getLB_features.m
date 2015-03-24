function [ output_args ] = getLB_features( V )
% To Fix
%Use Labplacian-Beltrami on the features 
% This should in principle immengsely improve clustering performance. 
% This uses the solution to Laplace-Beltrami operator for extrating the 
% eigenvalues and eigenfunctions of the shapes.
% Author: Animesh Garg
% Date: Mar 23, 2015

% Using: 
% Stephane Lafon, ?Diffusion maps and geometric harmonics?,
% Ph.D. dissertation, Yale University (May 2004)

% clear
% d = dir('test/*.jpg');
% ntotal = size(d,1);
% for i=1:ntotal
%     d(i).name
% end

Img = imread(['test/' d(1).name]);
s=size(Img,1);
w=size(Img,2);
hd=size(Img,3);
swhd=s*w*hd;

%reshape these images into one vector each
for ii=1:ntotal
    Img = imread(['test/' d(ii).name]);
    b1(:,ii) = double(reshape(Img, swhd,1));
end

% Compressed sensing part
%sa=randn(20,swhd);
%b=sa*b1;
b=b1;

for i=1:ntotal
    for j=1:ntotal
        D1(i,j)=norm(b(:,i)-b(:,j),2);%USE better norm
        log (1+exp(-a*u))
    end
end

n1=ntotal;
D_sum=0;
for l = 1:n1;
    D_sum = D_sum + min(nonzeros(D1(l,:)));
end;
epsilon = D_sum/n1/10; %
%
% Step 1
%
kernel_1 = exp(-(D1./epsilon).^1);
%
% Step 2
%
one_V = ones(1,n1);
%
% Step 3
%
p = kernel_1*one_V';
kernel_2 = kernel_1./((p*p').^1);
%
% Step 4
%
v = sqrt(kernel_2*one_V');
%
% Step 5
%
K = kernel_2./(v*v');
%
% Step 6
%
%% Singular Value Decomposition
[U S V] = svd(K);
% Normalization
for i=1:ntotal-1
phi(:,i) = U(:,i)./U(:,1); %
end

% choose top k eigenvectors
k = 5;
eig_funct = phi(:,1:k);

%
% The eigenvalues of \delta are approximated by those of K, and its
% eigenfunctions ?i are approximated by phi(:,i) = U(:; i):=U(:; 1)
%
vv=eig(K);

% Initial order of Buzz images
figure(1)
for i=1:ntotal
subplot(3,4,i)
imshow(['test/' d(i).name])
end

X = vv(ntotal-1).*phi(:,2);
% sorting the Buzz images using the first
% eigenfunctions the Laplace Beltrami operator
[Y,I] = sort(X);
% d(I).name
%
figure(2)
for i=1:ntotal
subplot(3,4,i)
imshow(['test/' d(I(i)).name])
end
%
figure(3)
plot(vv(ntotal-1).*phi(:,2),'.')
title(' Buzz Lightyear')
xlabel('Index')
ylabel('Lambda_1 phi_1')
%%
figure(4)
plot(vv(ntotal-1).*phi(:,2),vv(ntotal-2).*phi(:,3),'.')
title(' Buzz Lightyear')
xlabel('Lambda_1 phi_1')
ylabel('Lambda_2 phi_2')
%%
figure(5)
plot(eig(K),'*')
xlabel('Index of eigenvalue')
ylabel('Value of eigenvalue')
title(' Eingenvalues of K')
vv=eig(K);
%

end

