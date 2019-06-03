
function ans = NewtonIteration(err, lambda, no, zuni)
	iter_step = 0;
	

	if no == 1
		func = @poly1;
		derive = @poly1_;
		x = 0.6;
	else
		func = @poly2;
		derive = @poly2_;
		x = 1.35;
	end

	fprintf('result of fzero: %f\n\n', fzero(func,x));

	while abs(func(x)) > err
		s = func(x) / derive(x);
		l = lambda;
		xk = x - l * s;
		if zuni
			i = 0;
			while (abs(func(xk)) >= abs(func(x)))
				l = l / 2;
				xk = x - l * s;
				i = i + 1;
			end 
		end
		fprintf('in iteration step %d, lambda = %f, x = %f, f(x) = %f\n', iter_step, l, xk, func(xk));
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




