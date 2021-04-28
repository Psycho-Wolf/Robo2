clear all
close all
clc

syms x y psi thetaR thetaL
syms dotthetaR dotthetaL
syms rR rL b h

syms mC mR mL
syms rcmCx rcmCy rcmCz
syms rcmLx rcmLy rcmLz
syms rcmRx rcmRy rcmRz
syms JCCxx JCCyy JCCzz JCCxy JCCxz JCCyz
syms JRRxx JRRyy JRRzz JRRxy JRRxz JRRyz
syms JLLxx JLLyy JLLzz JLLxy JLLxz JLLyz

%--b=wheel base
%--h=height of body fixed frame (axle)

% %--General Mass Parameters:
% GamC=[rcmCx;rcmCy;rcmCz]*mC;
% GamR=[rcmRx;rcmRy;rcmRz]*mR;
% GamL=[rcmLx;rcmLy;rcmLz]*mL;
% JCC=[JCCxx JCCxy JCCxz;...
%    JCCxy JCCyy JCCyz;...
%    JCCxz JCCyz JCCzz];
% JRR=[JRRxx JRRxy JRRxz;...
%     JRRxy JRRyy JRRyz;...
%     JRRxz JRRyz JRRzz];
% JLL=[JLLxx JLLxy JLLxz;...
%     JLLxy JLLyy JLLyz;...
%     JLLxz JLLyz JLLzz];


%--Simplified parameters---
syms r  %assume same wheel radii
rR=r;
rL=r;

syms mW  %assume same wheel mass
mR=mW;
mL=mW;

GamC=[rcmCx;rcmCy;rcmCz]*mC;
%GamC=[0*rcmCx;0*rcmCy;rcmCz]*mC;  %frame C is above or below CM

syms rcmWy  %assume same wheel center of mass
GamR=[0;rcmWy;0]*mW;        
GamL=[0;rcmWy;0]*mW;

syms JWWxx JWWyy   %assume same wheel moments of inertia (about x and z)
JRR=[JWWxx 0 0;...  
    0 JWWyy 0;...
    0 0 JWWxx];

JLL=[JWWxx 0 0;...
    0 JWWyy 0;...
    0 0 JWWxx];

JCC=[JCCxx JCCxy JCCxz;...
    JCCxy JCCyy JCCyz;...
    JCCxz JCCyz JCCzz];


gamma=[x;y;psi;thetaR;thetaL];
u=[dotthetaR;dotthetaL];

f=[rR*cos(psi)/2 rL*cos(psi)/2;...
   rR*sin(psi)/2 rL*sin(psi)/2;...
   rR/b -rL/b;...
   1 0;
   0 1]*u;
dotgamma=f;


TC=purerotz(psi);
TL=TC*pureroty(thetaL);
TR=TC*pureroty(thetaR);

rC=[x;y;h];
rL=rC+TC*[0;b/2;0];
rR=rC+TC*[0;-b/2;0];

JC=[TC(:,3).'*jacobian(TC(:,2),gamma);...
    TC(:,1).'*jacobian(TC(:,3),gamma);...
    TC(:,2).'*jacobian(TC(:,1),gamma);
    jacobian(rC,gamma)];

JL=[TL(:,3).'*jacobian(TL(:,2),gamma);...
    TL(:,1).'*jacobian(TL(:,3),gamma);...
    TL(:,2).'*jacobian(TL(:,1),gamma);
    jacobian(rL,gamma)];

JR=[TR(:,3).'*jacobian(TR(:,2),gamma);...
    TR(:,1).'*jacobian(TR(:,3),gamma);...
    TR(:,2).'*jacobian(TR(:,1),gamma);
    jacobian(rR,gamma)];

temp=JC*dotgamma;
wC=temp(1:3);
temp=JL*dotgamma;
wL=temp(1:3);
temp=JR*dotgamma;
wR=temp(1:3);

dotJC=[jacobian(JC(:,1),gamma)*dotgamma,jacobian(JC(:,2),gamma)*dotgamma,jacobian(JC(:,3),gamma)*dotgamma,jacobian(JC(:,4),gamma)*dotgamma,jacobian(JC(:,5),gamma)*dotgamma];
dotJR=[jacobian(JR(:,1),gamma)*dotgamma,jacobian(JR(:,2),gamma)*dotgamma,jacobian(JR(:,3),gamma)*dotgamma,jacobian(JR(:,4),gamma)*dotgamma,jacobian(JR(:,5),gamma)*dotgamma];
dotJL=[jacobian(JL(:,1),gamma)*dotgamma,jacobian(JL(:,2),gamma)*dotgamma,jacobian(JL(:,3),gamma)*dotgamma,jacobian(JL(:,4),gamma)*dotgamma,jacobian(JL(:,5),gamma)*dotgamma];

dotf=jacobian(f(:,1),gamma)*dotgamma;
delf_u=jacobian(f,u);
delf_gamma=jacobian(f,gamma);


NEC=[JCC skew(GamC)*TC.';TC*skew(GamC).' mC*eye(3)];
NER=[JRR skew(GamR)*TR.';TR*skew(GamR).' mR*eye(3)];
NEL=[JLL skew(GamL)*TL.';TL*skew(GamL).' mL*eye(3)];


M=delf_u.'*JC.'*NEC*JC*delf_u +...
  delf_u.'*JR.'*NER*JR*delf_u + ...
  delf_u.'*JL.'*NEL*JL*delf_u;

n=delf_u.'*JC.'*(NEC*(JC*delf_gamma*f + dotJC*f) + [cross(wC,JCC*wC);TC*cross(wC,cross(wC,GamC))]) + ...
  delf_u.'*JR.'*(NER*(JR*delf_gamma*f + dotJR*f) + [cross(wR,JRR*wR);TR*cross(wR,cross(wR,GamR))]) + ...
  delf_u.'*JL.'*(NEL*(JL*delf_gamma*f + dotJL*f) + [cross(wL,JLL*wL);TL*cross(wL,cross(wL,GamL))]);

