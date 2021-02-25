clear
clc

addpath('D:\GitHUB\Robo2Lab\UsefulFNs');

syms theta1 theta2 theta3 dottheta1 dottheta2 dottheta3
syms m1 m2 m3 Gam1x Gam1y Gam1z Gam2x Gam2y Gam2z Gam3x Gam3y Gam3z
syms J1xx J1xy J1xz J1yy J1yz J1zz J2xx J2xy J2xz J2yy J2yz J2zz J3xx J3xy J3xz J3yy J3yz J3zz
syms bx by bz L1y L1z L2y L2z

gamma=[theta1;theta2];
dotgamma=[dottheta1;dottheta2];
Gam1=[Gam1x;Gam1y;Gam1z];
Gam2=[Gam2x;Gam2y;Gam2z];
Gam3=[Gam3x;Gam3y;Gam3z];
J1=[J1xx J1xy J1xz;J1xy J1yy J1yz;J1xz J1yz J1zz];
J2=[J2xx J2xy J2xz;J2xy J2yy J2yz;J2xz J2yz J2zz];
J3=[J3xx J3xy J3xz;J3xy J3yy J3yz;J3xz J3yz J3zz];

%Define orientation and rate of change of each frame
T1 = rotzRad(theta1);
T2=T1*rotzRad(-pi/2)*rotyRad(-pi/2)*rotzRad(theta2);
T3=T2*rotyRad(pi)*rotzRad(theta3);

dotT1=[jacobian(T1(:,1),gamma)*dotgamma,jacobian(T1(:,2),gamma)*dotgamma,jacobian(T1(:,3),gamma)*dotgamma];
dotT2=[jacobian(T2(:,1),gamma)*dotgamma,jacobian(T2(:,2),gamma)*dotgamma,jacobian(T2(:,3),gamma)*dotgamma];
dotT3=[jacobian(T3(:,1),gamma)*dotgamma,jacobian(T3(:,2),gamma)*dotgamma,jacobian(T3(:,3),gamma)*dotgamma];

S=T1.'*dotT1;
w1=[S(3,2);S(1,3);S(2,1)];
S=T2.'*dotT2;
w2=[S(3,2);S(1,3);S(2,1)];
S=T3.'*dotT3;
w3=[S(3,2);S(1,3);S(2,1)];

% r1=[bx;by;bz];
% r2=r1+T1*[0;L1y;L1z];
% r3=r2+T2*[0;L2y;L2z];
rBfromI = [0;0;0];
r1fromB = [0;0;0.17];
r2from1 = [0;0.11;.13];
r3from2 = [0;0.49;.02];

% T1 = rotzRad(theta1);
% T2=T1*rotzRad(-pi/2)*rotyRad(-pi/2)*rotzRad(theta2);
% T3=T2*rotyRad(pi)*rotzRad(theta3);

rB=rBfromI;
r1=rB+r1fromB;
r2=r1+T1*r2from1;
r3=r2+T2*r3from2;

dotr1=jacobian(r1,gamma)*dotgamma;
dotr2=jacobian(r2,gamma)*dotgamma;
dotr3=jacobian(r3,gamma)*dotgamma;


K1=(1/2)*m1*dotr1.'*dotr1 + dotr1.'*T1*cross(w1,Gam1) + (1/2)*w1.'*J1*w1;
K2=(1/2)*m2*dotr2.'*dotr2 + dotr2.'*T2*cross(w2,Gam2) + (1/2)*w2.'*J2*w2;
K3=(1/2)*m3*dotr3.'*dotr3 + dotr3.'*T3*cross(w3,Gam3) + (1/2)*w3.'*J3*w3;
K=K1+K2+K3;

H=jacobian(jacobian(K,dotgamma).',dotgamma);
d=jacobian(jacobian(K,dotgamma).',gamma)*dotgamma - jacobian(K,gamma).';

% H=simplify(H)
% d=simplify(d)