function [Ks]=spca(a, b)
% Krzanowski-similarity between a and b hyperplanes
% Created by Zolt�n Bank�, 2006
Ks =trace(a'*b*b'*a)/size(a,2);
