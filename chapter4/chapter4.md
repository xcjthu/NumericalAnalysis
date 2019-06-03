## chapter4

#### 计63 肖朝军 2016011302



#### 第2题

* **解题思路**：该题需要实现雅可比迭代、G-S迭代、SOR迭代法，其中求解的方程如下
  $$
  Ay = b
  \\
  b = \begin{bmatrix}
  	ah^2 & ah^2 & ... & ah^2 & ah^2 - (\epsilon + h)
  	\end{bmatrix}
  $$

* **代码**：

  Jacobi 迭代法

  ```matlab
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
  	end
  	
  	steps = steps + 1;
  	errs = norm(A * yj - b, inf);
  end
  ```

  高斯赛德尔迭代法

  ```matlab
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
  ```

  SOR迭代法

  ```matlab
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
  
  		ys(i) = (1 - omega) * ys(i) + omega * tmptmp;
  	end
  
  steps = steps + 1;
  	errs  = norm(A * ys - b, inf);
  end
  ```

* **运行结果**：在 `n = 100, epsilon = 1, a = 1/2`时，运行结果如下，其中误差计算取得是误差的无穷范数，其中精确解是利用书上公式进行的计算。

  ```
  Jacobi:
  	error: delta x = 0.047435
  	iteration steps: 5449
  G-S:
  	error: delta x = 0.098221
  	iteration steps: 2031
  SOR:
  	error: delta x = 0.098779
  	iteration steps: 4436
  ```

  可以发现，在该问题上，G-S算法拥有最快的收敛速度。

* **结果2**：

  | ε      | jacobi   | G-S      | SOR      |
  | ------ | -------- | -------- | -------- |
  | 1      | 0.047435 | 0.098221 | 0.098779 |
  | 0.1    | 0.153878 | 0.378083 | 0.408465 |
  | 0.01   | 0.103146 | 0.128974 | 0.162035 |
  | 0.0001 | 0.008898 | 0.008922 | 0.025283 |

  可以看到，当ε越小时，其误差越小。

  