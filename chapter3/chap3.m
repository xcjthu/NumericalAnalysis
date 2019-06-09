fprintf('n=%d\n', 10);
% (1)
cholesky(10, ones(10, 1))

%(2)
cholesky(10, ones(10, 1) + 1e-7)

%(3)
fprintf('n=%d\n', 8);
cholesky(8, ones(8, 1))
cholesky(8, ones(8, 1) + 1e-7)

fprintf('n=%d\n', 12);
cholesky(12, ones(12, 1))
cholesky(12, ones(12, 1) + 1e-7)
