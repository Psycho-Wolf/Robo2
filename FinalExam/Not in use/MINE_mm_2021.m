function bdot = mm_2021(b,F)

bdot = zeros(16,1);
gamma = b(1,16);
dotgamma = b(17,32);

x = gamma(1);
y = gamma(2);
psi = gamma(3);
theta_R = gamma(4);
theta_L = gamma(5);
theta_1 = gamma(6);
theta_R2 = gamma(7);
theta_R3 = gamma(8);
theta_R4 = gamma(9);
theta_R5 = gamma(10);
theta_R6 = gamma(11);
theta_L2 = gamma(12);   
theta_L3 = gamma(13);
theta_L4 = gamma(14);
theta_L5 = gamma(15);
theta_L6 = gamma(16);

%% Constants of the system

% Chassis
mC = 5.73993897;
r_C_cm = [-0.15125527; 0.00114110; 0.02044990];
JC = [  0.21072042, 0.00112610, 0.01755761; 
        0.00112610, 0.35520870, -0.00015225; 
        0.01755761, -0.00015225, 0.47082310];
GamC = mC*r_C_cm;
r_C_R = [0;-.381;0];
r_C_L = [0;.381;0];
r_C_1 = [-.1778;.00129706;.2794];

% Right Wheel
mR = 3.43497773;
r_R_cm = [0.00000000; 0.00101881;0.00000000];
rrJ = [ 0.02780319, 0.00000000, 0.00000000; 
        0.00000000, 0.05338030, 0.00000000; 
        0.00000000, 0.00000000, 0.02780319];
GamR = mR*r_R_cm;
DR = .3048;
r_R_Cent = [0;.0381;0]; % Vector from the chassis to the center of the wheel

% Left Wheel
mL = mR;
LLrcm = [0.00000000; -0.00101881;0.00000000];
LLJ = rrJ;
GamL = mL*r_L_cm;
DL = DR;
r_L_Cent = [0;-.0381;0]; % Vector from the chassis to the center of the wheel

% Link 1
m1 = 0.96821600;
r_1_cm = [0;0;0.07074779];
J1 = [  0.01739000, 0.00000000, 0.00000000;
        0.00000000, 0.00538178, 0.00000000;
        0.00000000, 0.00000000, 0.01232105];
Gam1 = m1*r_1_cm;
r_1_2R = [0; -.2032; 0762];
r_1_2L = [0;.2032;.0762];


% Link 2 Right
m2R = 0.32122492;
r_2R_cm = [0.01992928; -0.05938485; 0.00000000];
J2R = [ 0.00139985, 0.00048233, 0.00000000;
        0.00048233, 0.00043426, 0.00000000;
        0.00000000, 0.00000000, 0.0017274];
Gam2R = m2R*r_2R_cm;
r_2R_3R = [.0762;-.0762,0];

%Link 2 Left
m2L = m2R;
r_2L_cm = [0.01992928;0.05938485;0.00000000];
J2L = [ 0.00139985, -0.00048233, 0.00000000;
        -0.00048233, 0.00043426, 0.00000000;
        0.00000000, 0.00000000, 0.0017274];
Gam2L = m2L*r_2L_cm;
r_2L_3L = [.0762;-.0762;0];

% Link 3 Right
m3R = 0.53126936;
r_3R_cm = [0.12556172;0.00545976;0.00000000];
J3R = [ 0.00027263, -0.00058392, 0.00000000;
        -0.00058392, 0.01081142, 0.00000000;
        0.00000000, 0.00000000, 0.01090959];
Gam3R = m3R*r_3R_cm;
r_3R_3L = [.2032; .0508; 0];
    
% Link 3 Left
m3L = m3R;
r_3L_cm = [0.12556172;-0.00545976;0.00000000];
J3L = [ 0.00027263 ,0.00058392, 0.00000000;
        0.00058392, 0.01081142, 0.00000000;
        0.00000000, 0.00000000, 0.01090959];
Gam3L = m3L*r_3L_cm;
r_3L_4L = [.2032;-.0508;0];

% Link 4 Right
m4R = 0.68159286;
r_4R_cm =[0.11650147;0.04372769;0.00000000];
J4R = [ 0.00164808, -0.00340665, 0.00000000;
        -0.00340665, 0.01432027, 0.00000000;
        0.00000000, 0.00000000, 0.01574865];
Gam4R = m4R*r_4R_cm;
r_4R_5R = [.2286;0;0];


% Link 4 Left
m4L = m4R;
r_4L_cm = [0.11650147; -0.04372769; 0.00000000];
J4L = [ 0.00164808, 0.00340665, 0.00000000;
        0.00340665, 0.01432027, 0.00000000;
        0.00000000, 0.00000000, 0.01574865];
Gam4L = m4L*r_4L_cm;
r_4L_5L = [.2286;0;0];

% Link 5 Right
m5R = 0.52405953;
r_5R_cm = [0.07810882; -0.04160174; 0.00000000];
J5R = [	0.00119073 0.00166130 0.00000000;
		0.00166130 0.00523181 0.00000000;
		0.00000000 0.00000000 0.00625366];
Gam5R = m5R*r_5R_cm;
r_5R_6R = [.1524;0;0];

% Link 5 Left
m5L = m5R;
r_5L_cm = [0.07810882; 0.04160174; 0.00000000];
J5L = [	0.00119073, -0.00166130, 0.00000000;
		-0.00166130, 0.00523181, 0.00000000;
		0.00000000, 0.00000000, 0.00625366];
Gam5L = m5L*r_5L_cm;
r_5L_6L = [.1524;0;0];

% Link 6 Right
m6R = 0.44800661;
r_6R_cm = [0.06557409; 0.04616442; 0.00000000];
J6R = [ 0.00115148 -0.00149053 0.00000000;
        -0.00149053 0.00344884 0.00000000;
        0.00000000 0.00000000 0.00445655];
Gam6R = m6R*r_6R_cm;
r_6R_ER = [.1178;.0508;0];

% Link 6 Left
m6L = m6R;
r_6L_cm = [0.06557409; -0.04616442; 0.00000000];
J6L = [ 0.00115148 0.00149053 0.00000000;
        0.00149053 0.00344884 0.00000000;
        0.00000000 0.00000000 0.00445655];
Gam6L = m6L*r_6L_cm;
r_6L_EL = [.1178;-.0508;0];

%% Robo Dynamics
BTC = rotzRad(psi);

TR = rotyRad(theta_R);
TL = *rotyRad(theta_L);

T1 = rotzRad(theta_1);
T2R = rotyRad(theta_2R);
T3R = rotxRad(theta_3R);
T4R = rotyRad(theta_4R);
T5R = rotyRad(theta_5R);
T6R = rotyRad(theta_6R);

T2L = rotyRad(theta_2L);
T3L = rotxRad(theta_3L);
T4L = rotyRad(theta_4L);
T5L = rotyRad(theta_5L);
T6L = rotyRad(theta_6L);

%% Recursive

[IT2R, twotwowIR,           dot_IIr2R,  Jac2R, dot_Jac2R] = recursive_kinematics(IT1,   oneonewI,       Jac1,   dot_Jac1,   oneT2R,     oneoner2R,      hat_I2R, tilda_I, dotgamma);
[IT3R, threethreewIR,       dot_IIr3R,  Jac3R, dot_Jac3R] = recursive_kinematics(IT2R,  twotwowIR,      Jac2R,  dot_Jac2R,  twoT3R,     twotwor3R,      hat_I3R, tilda_I, dotgamma);
[IT4R, fourfourwIR,         dot_IIr4R,  Jac4R, dot_Jac4R] = recursive_kinematics(IT3R,  threethreewIR,  Jac3R,  dot_Jac3R,  threeT4R,   threethreer4R,  hat_I4R, tilda_I, dotgamma);
[IT5R, fivefivewIR,         dot_IIr5R,  Jac5R, dot_Jac5R] = recursive_kinematics(IT4R,  fourfourwIR,    Jac4R,  dot_Jac4R,  fourT5R,    fourfourr5R,    hat_I5R, tilda_I, dotgamma);
[IT6R, sixsixwIR,           dot_IIr6R,  Jac6R, dot_Jac6R] = recursive_kinematics(IT5R,  fivefivewIR,    Jac5R,  dot_Jac5R,  fiveT6R,    fivefiver6R,    hat_I6R, tilda_I, dotgamma);
[ITER, EEwIR,               dot_IIrER,  JacER, dot_JacER] = recursive_kinematics(IT5R,  fivefivewIR,    Jac5R,  dot_Jac5R,  fiveTER,    fivefiverER,    hat_IER, tilda_I, dotgamma);



[IT2L, twotwowIL,           dot_IIr2L,  Jac2L, dot_Jac2L] = recursive_kinematics(IT1,   oneonewI,       Jac1,   dot_Jac1,   oneT2L,     oneoner2L,      hat_I2L, tilda_I, dotgamma);
[IT3L, threethreewIL,       dot_IIr3L,  Jac3L, dot_Jac3L] = recursive_kinematics(IT2L,  twotwowIL,      Jac2L,  dot_Jac2L,  twoT3L,     twotwor3L,      hat_I3L, tilda_I, dotgamma);
[IT4L, fourfourwIL,         dot_IIr4L,  Jac4L, dot_Jac4L] = recursive_kinematics(IT3L,  threethreewIL,  Jac3L,  dot_Jac3L,  threeT4L,   threethreer4L,  hat_I4L, tilda_I, dotgamma);
[IT5L, fivefivewIL,         dot_IIr5L,  Jac5L, dot_Jac5L] = recursive_kinematics(IT4L,  fourfourwIL,    Jac4L,  dot_Jac4L,  fourT5L,    fourfourr5L,    hat_I5L, tilda_I, dotgamma);
[IT6L, sixsixwIL,           dot_IIr6L,  Jac6L, dot_Jac6L] = recursive_kinematics(IT5L,  fivefivewIL,    Jac5L,  dot_Jac5L,  fiveT6L,    fivefiver6L,    hat_I6L, tilda_I, dotgamma);
[ITEL, EEwIL,               dot_IIrEL,  JacEL, dot_JacEL] = recursive_kinematics(IT5L,  fivefivewIL,    Jac5L,  dot_Jac5L,  fiveTEL,    fivefiverEL,    hat_IEL, tilda_I, dotgamma);

%% H Calculation

H1 = (Jac1.' *  [J1,    skew(gam1)*IT1.';   IT1*skew(gam1).',       m1*eye(3)] * Jac1);
H2 = (Jac2R.' * [J2R,   skew(gam2)*IT2R.';  IT2*skew(gam2R).',     m2R*eye(3)] * Jac2R);
H3 = (Jac3R.' * [J3R,   skew(gam3)*IT3R.';  IT3*skew(gam3R).',     m3R*eye(3)] * Jac3R);
H4 = (Jac4R.' * [J4R,   skew(gam4)*IT4R.';  IT4*skew(gam4R).',     m4R*eye(3)] * Jac4R);
H5 = (Jac5R.' * [J5R,   skew(gam5)*IT5R.';  IT5*skew(gam5R).',     m5R*eye(3)] * Jac5R);
H6 = (Jac6R.' * [J6R,   skew(gam6)*IT6R.';  IT6*skew(gam6R).',     m6R*eye(3)] * Jac6R);
HE = (JacER.' * [JER,   skew(gamE)*ITER.';  ITE*skew(gamER).',     mER*eye(3)] * JacER);

HRtot = H1R + H2R + H3R + H3R + H4R + H5R + H6R + HER;

H1 = (Jac1.' *  [J1,    skew(gam1)*IT1.';   IT1*skew(gam1).',       m1*eye(3)] * Jac1);
H2 = (Jac2L.' * [J2L,   skew(gam2)*IT2L.';  IT2*skew(gam2L).',     m2L*eye(3)] * Jac2L);
H3 = (Jac3L.' * [J3L,   skew(gam3)*IT3L.';  IT3*skew(gam3L).',     m3L*eye(3)] * Jac3L);
H4 = (Jac4L.' * [J4L,   skew(gam4)*IT4L.';  IT4*skew(gam4L).',     m4L*eye(3)] * Jac4L);
H5 = (Jac5L.' * [J5L,   skew(gam5)*IT5L.';  IT5*skew(gam5L).',     m5L*eye(3)] * Jac5L);
H6 = (Jac6L.' * [J6L,   skew(gam6)*IT6L.';  IT6*skew(gam6L).',     m6L*eye(3)] * Jac6L);
HE = (JacEL.' * [JEL,   skew(gamE)*ITEL.';  ITE*skew(gamEL).',     mEL*eye(3)] * JacEL);

HLtot = H1L + H2L + H3L + H3L + H4L + H5L + H6L + HEL;

%% D Calculation

d1 = Jac1.'     * [J1,  skew(gam1)*IT1.';   IT1*skew(gam1).',   m1*eye(3)]  * dot_Jac1  * dotgamma  + Jac1.'    * [cross(oneonewI,      (J1 * oneonewI));       IT1  * cross(oneonewI,      cross(oneonewI,gam1))];
d2R = Jac2R.'   * [J2R, skew(gam2R)*IT2R.'; IT2R*skew(gam2R).', m2R*eye(3)] * dot_Jac2R * dotgamma  + Jac2R.'   * [cross(twotwowIR,     (J2R * twotwowIR));     IT2R * cross(twotwowIR,     cross(twotwowIR,gam2R))];
d3R = Jac3R.'   * [J3R, skew(gam3R)*IT3R.'; IT3R*skew(gam3R).', m3R*eye(3)] * dot_Jac3R * dotgamma  + Jac3R.'   * [cross(threethreewIR, (J3R * threethreewIR)); IT3R * cross(threethreewIR, cross(threethreewIR,gam3R))];
d4R = Jac4R.'   * [J4R, skew(gam4R)*IT4R.'; IT4R*skew(gam4R).', m4R*eye(3)] * dot_Jac4R * dotgamma  + Jac4R.'   * [cross(fourfourwIR,   (J4R * fourfourwIR));   IT4R * cross(fourfourwIR,   cross(fourfourwIR,gam4R))];
d5R = Jac5R.'   * [J5R, skew(gam5R)*IT5R.'; IT5R*skew(gam5R).', m5R*eye(3)] * dot_Jac5R * dotgamma  + Jac5R.'   * [cross(fivefivewIR,   (J5R * fivefivewIR));   IT5R * cross(fivefivewIR,   cross(fivefivewIR,gam5R))];
dER = JacER.'   * [JER, skew(gamER)*ITER.'; ITER*skew(gamER).', mER*eye(3)] * dot_JacER * dotgamma  + JacER.'   * [cross(EEwIR,         (JER * EEwIR));         ITER * cross(EEwIR,         cross(EEwIR,gamER))];

dtot = d1 + d2 + d3 + d4 + d5 + dE;

