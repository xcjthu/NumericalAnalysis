
function ans = NewtonIteration(err, lambda)
	iter_step = 0;
	x = 0.6;
	while abs(poly1(x)) > err
		s = poly1(x) / poly1_(x);
		l = lambda;
		xk = x - l * s;
		i = 0;
		while (abs(poly1(xk)) >= abs(poly1(x)))
			l = l / 2;
			xk = x - l * s;
			i = i + 1;
		end 
		fprintf('in iteration step %d, lambda = %f, x = %f, f(x) = %f\n', iter_step, l, xk, poly1(xk));
		iter_step = iter_step + 1;
		x = xk;
	end
	ans = x;
end


function [outputs] = poly1(x)
	outputs = x^3 - x - 1;
end


function [outputs] = poly1_(x)
	outputs = 3 * x^2 - 1;
end


function [outputs] = poly2(x)
	outputs = -x^3 + 5 * x;
end


function [outputs] = poly2_(x)
	outputs = -3 * x^2 + 5;
end




