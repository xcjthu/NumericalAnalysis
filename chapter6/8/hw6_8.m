
x = [0.520, 3.1, 8.0, 17.95, 28.65, 39.62, 50.65, 78, 104.6, 156.6, 208.6, 260.7, 312.50, 364.4, 416.3, 468, 494, 507,520].';
y = [5.288, 9.4, 13.84, 20.20, 24.90, 28.44, 31.10, 35, 36.9, 36.6, 34.6, 31.0, 26.34, 20.9, 14.8, 7.8, 3.7, 1.5, 0.2].';

dy0 = 1.86548;
dyn = -0.046115;

n = length(x);
h = zeros(n, 1);
u = zeros(n, 1);
lambda = zeros(n, 1);
d = zeros(n, 1);

for i = 1:n - 1
	h(i) = x(i + 1) - x(i);
end

for i = 2:n - 1
	u(i) = h(i - 1) / (h(i - 1) + h(i));
	lambda(i) = h(i) / (h(i - 1) + h(i));
	d(i) = y(i - 1) / (h(i - 1) * (h(i - 1) + h(i)));
	d(i) = d(i) + y(i + 1) / (h(i) * (h(i - 1) + h(i)));
	d(i) = d(i) - y(i) / (h(i - 1) * h(i));
	d(i) = d(i) * 6;
end

u(n) = 1;
lambda(1) = 1;
d(1)=(6 / h(1)) * ((y(2) - y(1)) / h(1) - dy0);
d(n) = (6 / h(n - 1)) * (dyn - (y(n) - y(n - 1)) / h(n - 1));


% 利用追赶法求解方程
M = zeros(n, 1);
b = zeros(n, 1) + 2;
f = d;
for i = 2:n
	m = u(i) / b(i - 1);
	b(i) = b(i) - m * lambda(i - 1);
	f(i) = f(i) - m * f(i - 1);
end
M(n) = f(n) / b(n);
for i = fliplr(1:n - 1)
	M(i) = (f(i) - lambda(i) * M(i + 1)) / b(i);
end
% 上面已经求到了解

testx = [2, 30, 130, 350, 515];

for p = testx
	fprintf('for x = %d\t', p);
	scope = 0;
	for j = 1:n - 1
		if (x(j) <= p && x(j + 1) >= p)
			scope = j;
			break;
		end
	end
	sx = M(scope) * (x(scope + 1) - p)^3 / (6 * h(scope)) + M(scope + 1) * (p - x(scope))^3 / (6 * h(scope)) + (y(scope) - M(scope) * h(scope)^2 / 6) * (x(scope + 1) - p) / h(scope) + (y(scope + 1) - M(scope + 1) * h(j)^2 / 6) * (p - x(scope)) / h(scope);
	fprintf('S(x) = %f\t\t', sx);

	sx_ = - M(scope) * (x(scope + 1) - p)^2 / (2 * h(scope)) + M(scope + 1) * (p - x(scope))^2 / (2 * h(scope)) + (y(scope + 1) - y(scope)) / h(scope) - (M(scope + 1) - M(scope)) * h(scope) / 6;
	fprintf('S''(x) = %f\t\t', sx_);

	sx__ = M(scope) * (x(scope + 1) - p) / h(scope) + M(scope + 1) * (p - x(scope)) / h(scope);
	fprintf('S''''(x) = %f\n', sx__);
end
