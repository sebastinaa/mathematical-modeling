
m = size(A, 1);
mean = sum(A) / m;

Sigma = sqrt(sum(((A - mean).*(A - mean)))/m);

Sigma