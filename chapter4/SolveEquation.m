
function [outputs] = SolveEquation(elp, a, n0)
	h = 1 / n0;
	n = n0 - 1;

	b = zeros(n, 1) + a * h^2;
	
	realy = zeros(n, 1);
	for i = 1:n
		realy(i) = (1 - a) * (1 - exp(-i / (n0 * elp))) / (1 - exp(-1 / elp)) + a * i / n0;
	end
	fprintf('real y:');
	disp(realy.');

	bigy = norm(realy, inf);

	y0 = zeros(n, 1);
	% Jacobi
	y = y0;
	yj = y0;
	steps = 0;
	errs = 1.1;
	while errs >= 1e-4
		y = yj;
		for i = 1:n
			yj(i) = -(b(i) - elp * y(i) - (elp + h) * y(i)) / (2 * elp + h);
		end
		steps = steps + 1;

		errs = norm(yj - realy, inf) / bigy;
	end

	fprintf('result of jacobi: y =');
	disp(yj.');
	disp('error: delta x = %f', errs);
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

		errs = norm(yg - realy, inf) / bigy;
	end

	fprintf('result of G-S: y =');
	disp(yg.');
	disp('error: delta x = %f', errs);
	fprintf('iteration steps: %d\n', steps);


	% SOR
	ys = y0;
	omega = 0.5;

	steps = 0;
	errs = 1.1;
	while errs >= 1e-4
		tmpy = ys;
		for i = 1:n
			tmp = -(b(i) - elp * tmpy(i) - (elp + h) * tmpy(i)) / (2 * elp + h);
			ys(i) = (1 - omega) * ys(i) + omega * tmp;
		end

		steps = steps + 1;

		errs  = norm(ys - realy, inf) / bigy;
	end

	fprintf('result of SOR: y =');
	disp(ys.');
	disp('error: delta x = %f', errs);
	fprintf('iteration steps: %d\n', steps);

end