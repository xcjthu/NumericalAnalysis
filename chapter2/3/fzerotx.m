function b = fzerotx(F, ab, varargin)
a = ab(1);
b = ab(2);
fa = F(a, varargin{:});
fb = F(b, varargin{:});
if sign(fa) == sign(fb)
    error('Function change sign')
end
c = a;
fc = fa;
d = b-c;
e = d;

while fb ~= 0
    %调整abc的值使满足迭代条件
    if sign(fa) == sign(fb)
        a = c;
        fa = fc;
        d = b-c;
        e = d;
    end
    if abs(fa) < abs(fb)
        c = b;
        b = a;
        a = c;
        fc = fb;
        fb = fa;
        fa = fc;
    end
    
    m = 0.5*(a-b);
    tol = 2.0*eps*max(abs(b), 1.0);
    if (abs(m) <= tol) || (fb == 0)
        break
    end
    if ( abs(e) < tol) || (abs(fc) <= abs(fb))
        d = m;
        e = m;
    else
        s = fb/fc;
        if (a==c)
            p = 2.0*m*s;
            q = 1-s;
        else
            q = fc/fa;
            r = fb/fa;
            p = s*(2*m*q*(q-r)-(b-c)*(r-1));
            q = (q-1)*(r-1)*(s-1);
        end
        if p > 0
            q = -q;
        else
            p = -p;
        end
        if (2*p<3*m*q-abs(tol*q)) && (p<abs(0.5*e*q))
            e = d;
            d = p/q;
        else
            d = m;
            e = m;
        end
    end
    
    c = b;
    fc = fb;
    if abs(d) > tol
        b = b+d;
    else
        b = b-sign(b-a)*tol;
    end
    fb = F(b, varargin{:});
end
end


function y = bessel(x)
    y = besselj(0, x);
end
