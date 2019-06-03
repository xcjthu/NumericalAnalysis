function ans = cholesky(n, x)
	H = hilb(n);
	b = H * x;
	A = H;

	for j = 1:n
		for k = 1:j-1
			A(j, j) = A(j, j) - A(j, k)^2;
		end
		A(j, j) = sqrt(A(j, j));

		for i = j+1:n
			for k = 1:j-1
				A(i, j) = A(i, j) - A(i, k) * A(j, k);
			end
			A(i, j) = A(i, j)/A(j, j);
		end
	end
	L = A;

	for i = 1:n
		for j = i+1:n
			L(i,j) = 0;
		end
	end

	y = L\b;
	x_ = L.'\y; 

	% 计算残差
	r = b - H * x_;

	% 计算误差
	deltx = x_ - x;

	rnorm = norm(r, inf);
	xnorm = norm(deltx, inf);

	fprintf('the value of residual is %1.20f\n\n', rnorm);
	fprintf('the value of error is %f\n\n', xnorm);

	ans = [rnorm, xnorm]
end
