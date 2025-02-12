function prod = quatProd(a,b)

q1Mat = [a(1) -a(2) -a(3) -a(4);...
        a(2) a(1) -a(4) a(3);...
        a(3) a(4) a(1) -a(2);...
        a(4) -a(3) a(2) a(1)];
q2Mat = [b(1);b(2);b(3);b(4)];
prod = q1Mat*q2Mat;