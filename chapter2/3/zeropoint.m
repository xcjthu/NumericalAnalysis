xs = -50:0.1:50;
plot(xs, bessel(xs));
range = [0, 3.8, 7.1, 10.4, 13.5, 16.8, 20, 23, 26.2, 29.3, 32];
ans = zeros(10, 1);
hold on;
for i = 1:10
    x = range(i:i+1);
    ans(i) = fzerotx(@bessel, x);
    scatter(ans(i), 0);
end
disp(ans);

%% bessel:xnction description
function [outputs] = bessel(x)
	outputs = besselj(0, x);
end