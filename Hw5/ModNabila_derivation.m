syms theta1 theta2 dottheta1 dottheta2 theta3 dottheta3


gamma = [theta1;theta2;theta3];
dotgamma = [dottheta1;dottheta2;dottheta3];
m1 = 3.62564899;
oneonercm = [0;.01906083;.09908556];
m2 = 7.28910514; 
twotworcm = [0;.19160707;.07507103];
m3 = 2.96056704;
threethreercm = [0;.08913956;.10830011];
g = [0;0;9.81].';
Gam1 = oneonercm*m1;
Gam2 = twotworcm*m2; 
Gam3 = threethreercm*m3;
J1 = [0.05480945,-0.00000000,-0.00000000;-0.000000000,.05032975,-0.00906068;-0.00000000,-0.009060680, .01339125];
J2 = [0.521738340 .00000010 -0.000000050; .000000100 .05685904 -0.10835509; 0.00000005 -0.108355090 .47943980];
J3 = [0.09409322 -0.00000000 -0.00000000; -0.000000000 .04215810 -0.03432580; -0.00000000 -0.034325800 .05516869];

T1 = rotz(gamma(1));
oneT2 = roty(-sym(pi)/2)*rotx(-sym(pi)/2)*rotz(gamma(2));
T2 = T1*oneT2;
twoT3 = roty(sym(pi))*rotz(gamma(3));
T3 = T2*twoT3;
dotT1 = [jacobian(T1(:,1),gamma)*dotgamma,jacobian(T1(:,2),gamma)*dotgamma,jacobian(T1(:,3),gamma)*dotgamma];
dotT2 = [jacobian(T2(:,1),gamma)*dotgamma,jacobian(T2(:,2),gamma)*dotgamma,jacobian(T2(:,3),gamma)*dotgamma];
dotT3 = [jacobian(T3(:,1),gamma)*dotgamma,jacobian(T3(:,2),gamma)*dotgamma,jacobian(T3(:,3),gamma)*dotgamma];
S = T1.'*dotT1;
w1 = [S(3,2);S(1,3);S(2,1)];
S = T2.'*dotT2;
w2 = [S(3,2);S(1,3);S(2,1)];
S = T3.'*dotT3;
w3 = [S(3,2);S(1,3);S(2,1)];
r1 = [0;0;.17];
oneoner2 = [0;.11;.13];
r2 = r1+T1*oneoner2;
twotwor3 = [0;.49;.02];
r3 = r2+T2*twotwor3;

dotr1 = jacobian(r1,gamma)*dotgamma;
dotr2 = jacobian(r2,gamma)*dotgamma;
dotr3 = jacobian(r3,gamma)*dotgamma;

K1 = simplify((1/2)*m1*dotr1.'*dotr1+dotr1.'*T1*cross(w1,Gam1)+(1/2)*w1.'*J1*w1);
K2 = simplify((1/2)*m2*dotr2.'*dotr2+dotr2.'*T2*cross(w2,Gam2)+(1/2)*w2.'*J2*w2);
K3 = simplify((1/2)*m3*dotr3.'*dotr3+dotr3.'*T3*cross(w3,Gam3)+(1/2)*w3.'*J3*w3);
U1 = g*(m1*r1+T1*Gam1);
U2 = g*(m2*r2+T2*Gam2);
U3 = g*(m3*r3+T3*Gam3);
K = K1+K2+K3;
U = simplify(U1+U2+U3);

H = simplify(jacobian(jacobian(K,dotgamma).',dotgamma));
d = simplify(jacobian(jacobian(K,dotgamma).',gamma)*dotgamma-jacobian(K,gamma).');
G = simplify(jacobian(U,gamma).');
H=simplify(H);
d= simplify(d);
H= vpa(H,10);
G = vpa(G,10);