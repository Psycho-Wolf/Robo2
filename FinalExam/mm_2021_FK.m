function posRL = mm_2021_FK(b)
x = b(1);
y = b(2);
psi = b(3);
theta_R = b(4);
theta_L = b(5);
theta_1 = b(6);
theta_2R = b(7);
theta_3R = b(8);
theta_4R = b(9);
theta_5R = b(10);
theta_6R = b(11);
theta_2L = b(12);
theta_3L = b(13);
theta_4L = b(14);
theta_5L = b(15);
theta_6L = b(16);

%% System vectors
r_C_R = [0;-.381;0];
r_C_L = [0;.381;0];
r_C_1 = [-.1778;.00129706;.2794];
r_1_2R = [0; -.2032; .0762];
r_2R_3R = [.0762;-.0762;0];
r_3R_4R = [.2032; .0508; 0];
r_4R_5R = [.2286;0;0];
r_5R_6R = [.1524;0;0];
r_6R_ER = [.1178;.0508;0];

r_1_2L = [0;.2032;.0762];
r_2L_3L = [.0762;.0762;0];
r_3L_4L = [.2032;-.0508;0];
r_4L_5L = [.2286;0;0];
r_5L_6L = [.1524;0;0];
r_6L_EL = [.1178;-.0508;0];

%% FK DCMs

BTC = rotzRad(psi);

TR = BTC*rotyRad(theta_R);
TL = BTC*rotyRad(theta_L);

T1 = BTC*rotzRad(theta_1);
T2R = T1*rotyRad(theta_2R);
T3R = T2R*rotxRad(theta_3R);
T4R = T3R*rotyRad(theta_4R);
T5R = T4R*rotyRad(theta_5R);
T6R = T5R*rotyRad(theta_6R);

T2L = T1*rotyRad(theta_2L);
T3L = T2L*rotxRad(theta_3L);
T4L = T3L*rotyRad(theta_4L);
T5L = T4L*rotyRad(theta_5L);
T6L = T5L*rotyRad(theta_6L);

%% FK Vectors
r_B_C = [x;y;.3048/2];
r_B_R = r_B_C + TR*r_C_R;
r_B_L = r_B_C + TL*r_C_L;

r_B_1 = r_B_C + BTC*r_C_1;

r_B_2R = r_B_1 + T1*r_1_2R;
r_B_3R = r_B_2R + T2R*r_2R_3R;
r_B_4R = r_B_3R + T3R*r_3R_4R;
r_B_5R = r_B_4R + T4R*r_4R_5R;
r_B_6R = r_B_5R + T5R*r_5R_6R;
r_B_ER = r_B_6R + T6R*r_6R_ER;

r_B_2L = r_B_1 + T1*r_1_2L;
r_B_3L = r_B_2L + T2L*r_2L_3L;
r_B_4L = r_B_3L + T3L*r_3L_4L;
r_B_5L = r_B_4L + T4L*r_4L_5L;
r_B_6L = r_B_5L + T5L*r_5L_6L;
r_B_EL = r_B_6L + T6L*r_6L_EL;

posRL = [r_B_ER;r_B_EL];

