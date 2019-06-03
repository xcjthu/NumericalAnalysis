## chapter3

#### 计63 肖朝军 2016011302



### 第6题

* **解题思路**：该题主要需要利用 `cholesky` 算法对 `Hilbert`矩阵进行分解，再利用分解结果来求解方程，并计算求解结果的残差及误差。

* **代码**：

  ```matlab
  function ans = cholesky(n, x)
  	% 生成参数
  	H = hilb(n);
  	b = H * x;
  	A = H;
  	
  	% cholesky分解主体
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
  	
  	% 将上三角部分清零
  	for i = 1:n
  		for j = i+1:n
  			L(i,j) = 0;
  		end
  	end
  	
  	% 求解方程
  	y = L\b;
  	x_ = L.'\y; 
  
  	% 计算残差
  	r = b - H * x_;
  
  	% 计算误差
  	deltx = x_ - x;
  
  	rnorm = norm(r, inf);
  	xnorm = norm(deltx, inf);
  
  	fprintf('the value of residual is %f\n\n', rnorm);
  	fprintf('the value of error is %f\n\n', xnorm);
  
  	ans = [rnorm, xnorm]
  end
  
  ```

* **问题回答**：
  $$
  (1) n = 10时, ||\mathbf{r}||_{\infin} = 4.4409 \times 10^{-16}，
  		||\mathbf{\Delta x}||_{\infin} = 4.05 \times 10^{-4}  
  \\
  (2) 在右端项加上扰动之后，||\mathbf{r}||_{\infin} = 4.4409 \times 10^{-16}，
  		||\mathbf{\Delta x}||_{\infin} = 5.875 \times 10^{-4}
  \\
  (3) n = 8时，||\mathbf{r}||_{\infin} = 4.4409 \times 10^{-16}，
  		||\mathbf{\Delta x}||_{\infin} = 7.013 \times 10^{-6}；
  \\
  n = 12时，||\mathbf{r}||_{\infin} = 4.4409 \times 10^{-16}，
  		||\mathbf{\Delta x}||_{\infin} = 5.5272 \times 10^{-2}
  $$
  可以看到，当右端项扰动1e-7时，残差无太大变化，误差略有增大；残差对于n的取值不敏感，误差对于n的取值非常敏感，当n小时，误差小，n大时，误差增大。这个实验进一步说明了 `Hilbert` 矩阵的病态性，阶数大，矩阵条件数大。



