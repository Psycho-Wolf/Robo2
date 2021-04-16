function bdot = neEqQuat(b,TF)

bdot = zeros(13,1);

w = [b(1);b(2);b(3)];
rdot = [b(4);b(5);b(6);];
q = [b(7);b(8);b(9);b(10)];
r = [b(11);b(12);b(13)];

mB = 615.66;

r_cm = [-0.00875121;0.00000641;0.00674643];

bbGAMMA = r_cm*mB;

BBJ = [87.30380148 -.00035561 0.02089469;...
        -0.00035561 142.84321696 0.00111065;...
        0.02089469 0.00111065 75.70508856];
    
T = rotq(q);

bdot = [        [BBJ skew(bbGAMMA)*T';...
        T*skew(bbGAMMA)' mB*eye(3)]\(TF - [cross(w,BBJ*w);...
        T*(cross(w,cross(w,bbGAMMA)))]);...
            (1/2)*[ 0 -w(1) -w(2) -w(3);...
            w(1) 0 w(3) -w(2);...
            w(2) -w(3) 0 w(1);...
            w(3) w(2) -w(1) 0]*q;....
            rdot];
end