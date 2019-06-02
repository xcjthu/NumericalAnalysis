
t = (2:16) * 0.5;
y = [33.4; 79.5; 122.65; 159.05; 189.15; 214.15; 238.65; 252.2; 267.55; 280.50; 296.65; 301.65; 310.40; 318.15; 325.15];

% 用多项式进行拟合，利用法方程方法
A = zeros(length(t), 3);
for i = 1:length(t)
	A(i, 1) = 1;
	A(i, 2) = t(i);
	A(i, 3) = t(i)^2;
end

G = A.' * A;
b = A.' * y;
polyx = G\b;

disp(polyx);

% 用指数函数拟合

% 先对y取对数
y1 = log(y);
A1 = zeros(length(t), 2);
for i = 1:length(t)
	A1(i, 1) = 1;
	A1(i, 2) = t(i);
end

G = A1.' * A1;
b = A1.' * y1;
expx = G\b;
expx(1) = exp(expx(1));

disp(expx);

ezplot('-45.2942 + 94.1943*x + -6.1268 * x^2', 0, 9);
hold on;
ezplot('67.3938 * exp(0.2390*x)', 0, 9);
hold on;
plot(t, y)
