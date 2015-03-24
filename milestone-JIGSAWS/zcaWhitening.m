function [ X_white, W, mu_X ] = zcaWhitening( X, epsilon )
%ZCA Whitening
% Performs prewhitening of the dataset X. Prewhitening concentrates the main
% variance in the data in a relatively small number of dimensions, and 
% removes all first-order structure from the data. In other words, after
% the prewhitening, the covariance matrix of the data is the identity
% matrix. The function returns the subtracted data mean in mu_X, and the
% applied linear mapping in W.

if ~exist('epsilon','var')
    epsilon = 1e-5;
end

% Compute and apply the ZCA mapping
mu_X = mean(X, 1);
X = bsxfun(@minus, X, mu_X);

% X_white = X / sqrtm(cov(X)); %numerically unstable

A = cov(X); 
% A = X'*X/size(X,2);%this should be the same
[U,D,~] = svd(A);

X_white = U * diag(1./sqrt(diag(D) + epsilon)) * U' * X;

if nargout > 1
%     W = X \ X_white;%precision errors creeps in!
    W = U * diag(1./sqrt(diag(D) + epsilon)) * U' ;
end   

end

