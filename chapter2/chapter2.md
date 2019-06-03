## chapter2

#### 计63 肖朝军 2016011302



### 第2题

* **解题思路**：该题主要需要实现一个`阻尼牛顿迭代法`，并将阻尼牛顿迭代与普通牛顿迭代法进行对比。其中阻尼牛顿迭代法中系数采用逐次折半更新。

* **代码**：我采用了matlab来实现牛顿迭代，其中主体代码如下：

  ```matlab
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
  ```

* **运行结果**：两个方程，统一设置为 $\lambda = 1, \epsilon = 1e-6$

  * 方程一，阻尼牛顿法运行结果

    ```
    result of fzero: 1.324718
    
    in iteration step 0, lambda = 0.031250, x = 1.140625, f(x) = -0.656643
    in iteration step 1, lambda = 1.000000, x = 1.366814, f(x) = 0.186640
    in iteration step 2, lambda = 1.000000, x = 1.326280, f(x) = 0.006670
    in iteration step 3, lambda = 1.000000, x = 1.324720, f(x) = 0.000010
    in iteration step 4, lambda = 1.000000, x = 1.324718, f(x) = 0.000000
    
    ans = 1.3247
    ```

  * 方程一，普通牛顿法运行结果

    ```
    result of fzero: 1.324718
    
    in iteration step 0, lambda = 1.000000, x = 17.900000, f(x) = 5716.439000
    in iteration step 1, lambda = 1.000000, x = 11.946802, f(x) = 1692.173533
    in iteration step 2, lambda = 1.000000, x = 7.985520, f(x) = 500.239416
    in iteration step 3, lambda = 1.000000, x = 5.356909, f(x) = 147.367518
    in iteration step 4, lambda = 1.000000, x = 3.624996, f(x) = 43.009613
    in iteration step 5, lambda = 1.000000, x = 2.505589, f(x) = 12.224443
    in iteration step 6, lambda = 1.000000, x = 1.820129, f(x) = 3.209725
    in iteration step 7, lambda = 1.000000, x = 1.461044, f(x) = 0.657774
    in iteration step 8, lambda = 1.000000, x = 1.339323, f(x) = 0.063137
    in iteration step 9, lambda = 1.000000, x = 1.324913, f(x) = 0.000831
    in iteration step 10, lambda = 1.000000, x = 1.324718, f(x) = 0.000000
    
    ans = 1.3247
    ```

  * 方程二， 阻尼牛顿法运行结果

    ```
    result of fzero: 2.236068
    
    in iteration step 0, lambda = 0.125000, x = 2.496959, f(x) = -3.083249
    in iteration step 1, lambda = 1.000000, x = 2.271976, f(x) = -0.367778
    in iteration step 2, lambda = 1.000000, x = 2.236902, f(x) = -0.008342
    in iteration step 3, lambda = 1.000000, x = 2.236068, f(x) = -0.000005
    in iteration step 4, lambda = 1.000000, x = 2.236068, f(x) = -0.000000
    
    ans = 2.2361
    ```

  * 方程二，普通牛顿法运行结果

    ```
    result of fzero: 2.236068
    
    in iteration step 0, lambda = 1.000000, x = 10.525668, f(x) = -1113.507269
    in iteration step 1, lambda = 1.000000, x = 7.124287, f(x) = -325.975011
    in iteration step 2, lambda = 1.000000, x = 4.910781, f(x) = -93.873337
    in iteration step 3, lambda = 1.000000, x = 3.516911, f(x) = -25.914942
    in iteration step 4, lambda = 1.000000, x = 2.709743, f(x) = -6.348134
    in iteration step 5, lambda = 1.000000, x = 2.336940, f(x) = -1.078004
    in iteration step 6, lambda = 1.000000, x = 2.242244, f(x) = -0.062019
    in iteration step 7, lambda = 1.000000, x = 2.236093, f(x) = -0.000254
    in iteration step 8, lambda = 1.000000, x = 2.236068, f(x) = -0.000000
    
    ans = 2.2361
    ```

* **总结**：可以看到无论是普通牛顿迭代法还是阻尼牛顿迭代法，求得的解的结果与 `fzero` 函数的结果在小数点后4位都是正确的，可以看到两种方法的正确性。同时，对比一些 阻尼牛顿法和普通牛顿法，可以看到这两个方程只有在第一轮迭代时，lambda的值才会不等于1，其余时间均等于1，收敛速度很快。



### 第3题

* **解题思路**：该题主要是要应用书中给出的 `fzerotx `的代码，再画出函数图像，观察图像，给出十个可能的解的区间及初值，调用函数来求解。

* **函数图像**：

  ![](D:\learn\大三下\数值分析\hw\NumericalAnalysis\chapter2\3\bessel.png)

* **零点**：

  ```
  	2.4048
      5.5201
      8.6537
     11.7915
     14.9309
     18.0711
     21.2116
     24.3525
     27.4935
     30.6346
  ```





