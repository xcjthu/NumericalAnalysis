## chapter6

#### 计63 肖朝军 2016011302



### 第3题

* **解题思路**：

  * **第(1)问**：该问主要是需要拟合一个多项式函数，这里我用了法方程方法来拟合这个最小二乘问题，解法相对常规。

  * **第(2)问**：该题需要拟合一个指数函数，先将该函数转化成如下的多项式函数，再同样利用法方程方法来解决即可。
    $$
    y = a e^{bt} \Rightarrow log(y) = log(a) + b \times t
    $$

* **代码**：

  ```matlab
  % 数据
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
  
  % 画图
  xrange = 0:0.1:9;
  polyy = polyx(1) + polyx(2) * xrange + polyx(3) * xrange.^2;
  expy = expx(1) * exp(expx(2) * xrange);
  plot(xrange, polyy);
  hold on;
  plot(xrange, expy);
  hold on;
  plot(t, y);
  ```

* **函数图像**：三条曲线函数图像如下，其中黄线代表原始数据点的连线，蓝线是多项式拟合的曲线，红线是指数函数拟合的曲线。从曲线可以看出，多项式曲线拟合效果要好一些。

  ![](D:\learn\大三下\数值分析\hw\NumericalAnalysis\chapter6\3\gg.png)

* **计算结果**：

  ```
  多项式参数：
  	a = -45.2942;
  	b = 94.1943;
  	c = -6.1268;
  指数参数：
  	a = 67.3938;
  	b = 0.2390;
  ```



### 第8题

* **解题思路**：该题主要考察三次样条插值，给出的条件属于第一种边界条件的三次样条插值，按照公式计算即可求得样条函数值(即求得M)，再按照以下公式求 `S(x)`、`S'(x)`、`S''(x)`
  $$
  S(x) = M_j\frac{(x_{j+1}-x)^3}{6h_j}+M_{j+1}\frac{(x-x_j)^3}{6h_j}+(f_j-\frac{M_jh_j^2}{6})(\frac{x_{j+1}-x}{h_j})+(f_{j+1}-\frac{M_{j+1}h_j^2}{6})(\frac{x-x_j}{h_j})
  \\
  S^{'}(x)=-M_j\frac{(x_{j+1}-x)^2}{2h_j} + M_{j+1}\frac{(x-x_j)^2}{2h_j}+\frac{f_{j+1}-f_j}{h_j}-\frac{M_{j+1}-M_j}{6}h_j
  \\
  S^{''}(x)=M_j\frac{x_{j+1}-x}{h_j}+M_{j+1}\frac{x-x_j}{h_j}
  $$
  

* **代码**：

  ```matlab
  % 数据
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
  
  % 计算 lambda、mui
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
  
  %计算改点
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
  	% 求S(x)
  	sx = M(scope) * (x(scope + 1) - p)^3 / (6 * h(scope)) + M(scope + 1) * (p - x(scope))^3 / (6 * h(scope)) + (y(scope) - M(scope) * h(scope)^2 / 6) * (x(scope + 1) - p) / h(scope) + (y(scope + 1) - M(scope + 1) * h(j)^2 / 6) * (p - x(scope)) / h(scope);
  	fprintf('S(x) = %f\t\t', sx);
  	
  	% 求S'(x)
  	sx_ = - M(scope) * (x(scope + 1) - p)^2 / (2 * h(scope)) + M(scope + 1) * (p - x(scope))^2 / (2 * h(scope)) + (y(scope + 1) - y(scope)) / h(scope) - (M(scope + 1) - M(scope)) * h(scope) / 6;
  	fprintf('S''(x) = %f\t\t', sx_);
  	
  	% 求S''(x)
  	sx__ = M(scope) * (x(scope + 1) - p) / h(scope) + M(scope + 1) * (p - x(scope)) / h(scope);
  	fprintf('S''''(x) = %f\n', sx__);
  	
  end
  
  ```

* **运行结果**：

  ```
  for x = 2		S(x) = 7.825155		S'(x) = 1.556835		S''(x) = -0.221260
  for x = 30		S(x) = 25.386235	S'(x) = 0.354874		S''(x) = -0.007843
  for x = 130		S(x) = 37.213841	S'(x) = -0.010392		S''(x) = -0.001382
  for x = 350		S(x) = 22.475111	S'(x) = -0.107784		S''(x) = -0.000230
  for x = 515		S(x) = 0.542713		S'(x) = -0.089906		S''(x) = 0.008120
  ```

  

