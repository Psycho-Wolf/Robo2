function bdot = VP_6242(b)

gamma = b(1:6);
gammadot = (7:12);
theta1 = gamma(1);
theta2 = gamma(2);
theta3 = gamma(3);
theta4 = gamma(4);
theta5 = gamma(5);
theta6 = gamma(6);

% V Need T_N1_N, r_N1_N, IhatN, ItildeN

%% constants
% Rot Mats
ITB = zeros(3);
TB1 = rotzRad(theta1);
T12 = rotyRad(theta2);
T23 = rotyRad(theta3);
T34 = rotyRad(-pi/2)*rotxRad(theta4);
T45 = rotyRad(theta5);
T5E = rotxRad(theta6);

% Pos vectors
rb1 = [0;0;.155];
r12 = [0;0;.1235];
r23 = [0;0;.21];
r34 = [-.075;0;.086];
r45 = [.125;0;0];
r5E = [.1325;0;0];


% Masses
m1 = 1.67711788;
m2 = 2.18012904;
m3 = 1.98159082;

% Gamma

% Inetria Matricies
JB = zeros(3);
J1 = [  .01385583, -0.00000008, 0.00000007;
        -0.00000008, 0.01366144, 0.00000002;
        0.00000007, 0.00000002, 0.00342620;];
    
J2 = [  0.03147084, 0.00000021, -0.00067801;
        0.00000021, 0.02569684, -0.00004077;
        -0.00067801, -0.00004077, 0.00840044];

J3 = [  0.00000000 0.00000024 0.00000270;
        0.00000024 0.00632418 -0.00000000;
        0.00000270 -0.00000000 0.00632418];
 
J4 = [  0.00175468 -0.00004164 -0.00000141;
        -0.00004164 0.00521944 -0.00000199;
        -0.00000141 -0.00000199 0.00585960];

J5 = [  0.00037655 -0.00000128 0.00000000;
        -0.00000128 0.00066690 -0.00000000;
        0.00000000 -0.00000000 0.00065165];
    
Ihat1 = [0 0 0 0 0 0; 0 0 0 0 0 0; 1 0 0 0 0 0];
Ihat2 = [0 0 0 0 0 0; 0 1 0 0 0 0; 0 0 0 0 0 0];
Ihat3 = [0 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 0 0];
Ihat4 = [0 0 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0];
Ihat5 = [0 0 0 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 0];
IhatE = [0 0 0 0 0 1; 0 0 0 0 0 0; 0 0 0 0 0 0];

Itilde = zeros(3,6);
Itilde1 = Itilde;
Itilde2 = Itilde;
Itilde3 = Itilde;
Itilde4 = Itilde;
Itilde5 = Itilde;
ItildeE = Itilde;

wBI = [0;0;0];
JdotB = zeros(3);

%% Recursive Kinematics
[IT1,w1I,Irdot1,J1,Jdot1] = recursive_kinematics(ITB, wBI, JB, JdotB, TB1, rb1, Ihat1, Itilde1, gamma, gammadot);
[IT2,w2I,Irdot2,J2,Jdot2] = recursive_kinematics(IT1, w1I, J1, Jdot1, T12, r12, Ihat2, Itilde2, gamma, gammadot);
[IT3,w3I,Irdot3,J3,Jdot3] = recursive_kinematics(IT2, w2I, J2, Jdot2, T23, r23, Ihat3, Itilde3, gamma, gammadot);
[IT4,w4I,Irdot4,J4,Jdot4] = recursive_kinematics(IT3, w3I, J3, Jdot3, T34, r34, Ihat4, Itilde4, gamma, gammadot);
[IT5,w5I,Irdot5,J5,Jdot5] = recursive_kinematics(IT4, w4I, J4, Jdot4, T45, r45, Ihat5, Itilde5, gamma, gammadot);
[ITE,wEI,IrdotE,JE,JdotE] = recursive_kinematics(IT5, w5I, J5, Jdot5, T5E, r5E, IhatE, ItildeE, gamma, gammadot);




bdot =  0;