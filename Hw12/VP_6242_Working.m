function bdot = VP_6242(b,F)
%% Initilizations
bdot = zeros(12,1);
gamma=b(1:6);
dotgamma = b(7:12);

%% Body Constants
m1 = 1.67711788;
m2 = 2.18012904;
m3 = 1.98159082;
m4 = 0.97810626;
m5 = 0.50552673;
mE = 0.21423253;

gam1= [0;0;0.06531164]*m1;
gam2 = [0.00319385;0.00002007;0.07568397]*m2;
gam3= [-0.05649308;0.00000216;0.00002412]*m3;
gam4 = [0.05529733;0.00040348;0.00007649]*m4;
gam5= [0.00389038;-0.00058508;0.00000000]*m5;
gamE = [-0.03296238;-0.00037777;0.00003040]*mE;

IIr1 = [0; 0; 155]/1000;
oneoner2 = [0; 0; 123.5]/1000;
twotwor3 = [0; 0; 210]/1000;
threethreer4 = [-75; 0; 86]/1000;
fourfourr5 = [125; 0; 0]/1000;
fivefiverE = [132.5; 0; 0]/1000;

%% Robo Dynamics
IT1 = rotz(b(1));
oneT2 = roty(b(2));
twoT3 = roty(b(3));
threeT4 = roty(-pi/2)*rotx(b(4));
fourT5 = roty(b(5));
fiveTE = rotx(b(6));

Jac1 = [0 0 0 0 0 0;...
          0 0 0 0 0 0;...
          1 0 0 0 0 0;...
          0 0 0 0 0 0;...
          0 0 0 0 0 0;...
          0 0 0 0 0 0];
dot_Jac1 = zeros(6,6);
oneonewI = [0;0;b(7)];

hat_I2 = [0 0 0 0 0 0;...
                 0 1 0 0 0 0;...
                 0 0 0 0 0 0];
hat_I3 = [0 0 0 0 0 0;...
                 0 0 1 0 0 0;...
                 0 0 0 0 0 0];
hat_I4 = [0 0 0 1 0 0;...
                 0 0 0 0 0 0;...
                 0 0 0 0 0 0];
hat_I5 = [0 0 0 0 0 0;...
                 0 0 0 0 1 0;...
                 0 0 0 0 0 0];
hat_IE = [0 0 0 0 0 1;...
                 0 0 0 0 0 0;...
                 0 0 0 0 0 0];
tilda_I = [0 0 0 0 0 0;...
                   0 0 0 0 0 0;...
                   0 0 0 0 0 0];

J1=[0.01385583 -0.00000008 0.00000007;...
        -0.00000008 0.01366144 0.00000002;...
        0.00000007 0.00000002 0.00342620];
    
J2 = [0.03147084 0.00000021 -0.00067801;...
          0.00000021 0.02569684 -0.00004077;...
          -0.00067801 -0.00004077 0.00840044];
      
J3=[0.00000000 0.00000024 0.00000270;...
        0.00000024 0.00632418 -0.00000000;...
        0.00000270 -0.00000000 0.00632418];
    
J4 = [0.00175468 -0.00004164 -0.00000141;...
          -0.00004164 0.00521944 -0.00000199;...
          -0.00000141 -0.00000199 0.00585960];
      
J5=[0.00037655 -0.00000128 -0.00000000;...
        -0.00000128 0.00066690 -0.00000000;...
       -0.00000000 -0.00000000 0.00065165];
   
JE = [0.00004684 -0.00000206 -0.00000030;...
          -0.00000206 0.00033054 -0.00000050;...
          -0.00000030 -0.00000050 0.00033059];
      
Ig = [0;0;9.8];

%% Recursive
[IT2, twotwowI, dot_IIr2, Jac2, dot_Jac2] = recursive_kinematics(IT1, oneonewI, Jac1, dot_Jac1, oneT2, oneoner2, hat_I2, tilda_I, dotgamma);
[IT3, threethreewI, dot_IIr3, Jac3, dot_Jac3] = recursive_kinematics(IT2, twotwowI, Jac2, dot_Jac2, twoT3, twotwor3, hat_I3, tilda_I, dotgamma);
[IT4, fourfourwI, dot_IIr4, Jac4, dot_Jac4] = recursive_kinematics(IT3, threethreewI, Jac3, dot_Jac3, threeT4, threethreer4, hat_I4, tilda_I, dotgamma);
[IT5, fivefivewI, dot_IIr5, Jac5, dot_Jac5] = recursive_kinematics(IT4, fourfourwI, Jac4, dot_Jac4, fourT5, fourfourr5, hat_I5, tilda_I, dotgamma);
[ITE, EEwI, dot_IIrE, JacE, dot_JacE] = recursive_kinematics(IT5,fivefivewI, Jac5, dot_Jac5, fiveTE, fivefiverE, hat_IE, tilda_I, dotgamma);

%% System Properties
H1 = (Jac1.' * [J1,     skew(gam1)*IT1.';  IT1*skew(gam1).',     m1*eye(3)] * Jac1);
H2 = (Jac2.' * [J2,     skew(gam2)*IT2.';  IT2*skew(gam2).',     m2*eye(3)] * Jac2);
H3 = (Jac3.' * [J3,     skew(gam3)*IT3.';  IT3*skew(gam3).',     m3*eye(3)] * Jac3);
H4 = (Jac4.' * [J4,     skew(gam4)*IT4.';  IT4*skew(gam4).',     m4*eye(3)] * Jac4);
H5 = (Jac5.' * [J5,     skew(gam5)*IT5.';  IT5*skew(gam5).',     m5*eye(3)] * Jac5);
HE = (JacE.' * [JE,     skew(gamE)*ITE.';  ITE*skew(gamE).',     mE*eye(3)] * JacE);

Htot = H1 + H2 + H3 + H3 + H4 + H5 + HE;

d1 = Jac1.' * [J1,      skew(gam1)*IT1.';  IT1*skew(gam1).',     m1*eye(3)] * dot_Jac1 * dotgamma + Jac1.' * [cross(oneonewI, (J1 * oneonewI));  IT1 * cross(oneonewI, cross(oneonewI,gam1))];
d2 = Jac2.' * [J2,      skew(gam2)*IT2.';  IT2*skew(gam2).',     m2*eye(3)] * dot_Jac2 * dotgamma+ Jac2.' * [cross(twotwowI, (J2 * twotwowI));  IT2 * cross(twotwowI, cross(twotwowI,gam2))];
d3 = Jac3.' * [J3,      skew(gam3)*IT3.';  IT3*skew(gam3).',     m3*eye(3)] * dot_Jac3 * dotgamma+ Jac3.' * [cross(threethreewI, (J3 * threethreewI));  IT3 * cross(threethreewI, cross(threethreewI,gam3))];
d4 = Jac4.' * [J4,      skew(gam4)*IT4.';  IT4*skew(gam4).',     m4*eye(3)] * dot_Jac4 * dotgamma+ Jac4.' * [cross(fourfourwI, (J4 * fourfourwI));  IT4 * cross(fourfourwI, cross(fourfourwI,gam4))];
d5 = Jac5.' * [J5,      skew(gam5)*IT5.';  IT5*skew(gam5).',     m5*eye(3)] * dot_Jac5 * dotgamma+ Jac5.' * [cross(fivefivewI, (J5 * fivefivewI));  IT5 * cross(fivefivewI, cross(fivefivewI,gam5))];
dE = JacE.' * [JE,      skew(gamE)*ITE.';  ITE*skew(gamE).',     mE*eye(3)] * dot_JacE * dotgamma+ JacE.' * [cross(EEwI, (JE * EEwI));  ITE * cross(EEwI, cross(EEwI,gamE))];

dtot = d1 + d2 + d3 + d4 + d5 + dE;

G1 = Jac1.' * [cross(gam1, (IT1.' * Ig)); Ig * m1];
G2 = Jac2.' * [cross(gam2, (IT2.' * Ig)); Ig * m2];
G3 = Jac3.' * [cross(gam3, (IT3.' * Ig)); Ig * m3];
G4 = Jac4.' * [cross(gam4, (IT4.' * Ig)); Ig * m4];
G5 = Jac5.' * [cross(gam5, (IT5.' * Ig)); Ig * m5];
GE = JacE.' * [cross(gamE, (ITE.' * Ig)); Ig * mE];

Gtot = G1 + G2 + G3 + G4 + G5 + GE;

middleMatrix = F;

%% State vectors
bdot(1:6) = b(7:12);
bdot(7:12) = Htot \ (middleMatrix - dtot - Gtot);