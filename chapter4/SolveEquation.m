
function [outputs] = SolveEquation(elp, a, n0)
	h = 1 / n0;
	n = n0 - 1;

	b = zeros(n, 1) + a * h^2;
	
	b(n) = b(n) - (elp + h);
	
	realy = zeros(n, 1);
	for k = 1:n
		i = k;% - 1;
		realy(k) = (1 - a) * (1 - exp(-i / (n0 * elp))) / (1 - exp(-1 / elp)) + a * i / n0;
	end
	% fprintf('realy:');
	% disp(realy.');


	A = zeros(n, n);
	for i = 1:n
		for j = 1:n
			if j == i + 1
				A(i, j) = elp + h;
			end
			if j == i - 1
				A(i, j) = elp;
			end
			if i == j
				A(i, j) = -(2 * elp + h);
			end
		end
	end


	y0 = zeros(n, 1);
	% Jacobi
	y = y0;
	yj = y0;
	steps = 0;
	errs = 1.1;
	while errs >= 1e-4
		y = yj;
		for i = 1:n
			tmp = b(i);
			if i ~= 1
				tmp = tmp - elp * y(i - 1);
			end
			if i ~= n
				tmp = tmp - (elp + h) * y(i + 1);
			end
			yj(i) = - tmp / (2 * elp + h);
			% yj(i) = -(b(i) - elp * y(i - 1) - (elp + h) * y(i + 1)) / (2 * elp + h);
		end
		steps = steps + 1;

		errs = norm(A * yj - b, inf);
	end

	fprintf('result of jacobi: y =');
	% disp(yj.');
	fprintf('error: delta x = %f\n', norm(yj - realy, inf));
	fprintf('iteration steps: %d\n', steps);

	% G-S
	yg = y0;
	steps = 0;
	errs = 1.1;
	while errs >= 1e-4
		for i = 1:n
			tmp = b(i);
			if i ~= 1
				tmp = tmp - elp * yg(i - 1);
			end
			if i ~= n
				tmp = tmp - (elp + h) * yg(i + 1);
			end
			yg(i) = -tmp / (2 * elp + h);
		end

		steps = steps + 1;

		errs = norm(A * yg - b, inf);
	end

	fprintf('result of G-S: y =');
	% disp(yg.');
	fprintf('error: delta x = %f\n', norm(yg - realy, inf));
	fprintf('iteration steps: %d\n', steps);


	% SOR
	ys = y0;
	omega = 0.9;
	steps = 0;
	errs = 1.1;
	while errs >= 1e-4
		tmpy = ys;
		for i = 1:n
			tmp = b(i);
			if i ~= 1
				tmp = tmp - elp * tmpy(i - 1);
			end
			if i ~= n
				tmp = tmp - (elp + h) * tmpy(i + 1);
			end
			tmptmp = - tmp / (2 * elp + h);

			% tmptmp = -(b(i) - elp * tmpy(i) - (elp + h) * tmpy(i)) / (2 * elp + h);
			ys(i) = (1 - omega) * ys(i) + omega * tmptmp;
		end

		steps = steps + 1;

		errs  = norm(A * ys - b, inf);
	end

	fprintf('result of SOR: y =');
	% disp(ys.');
	fprintf('error: delta x = %f\n', norm(ys - realy, inf));
	fprintf('iteration steps: %d\n', steps);

end