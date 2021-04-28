clear
clc
T2 = rotq([cos(pi/5);sin(pi/5)*ones(3,1)/sqrt(3)]);
w2_I = [1;2;3];
J2 = [1 4 2 3 4 3; 3 3 1 5 2 1; 2 1 4 1 3 3; 5 3 3 1 3 4; 5 4 2 3 4 4; 1 3 2 5 2 3];
J2dot = [4 2 -5 1 8 4; 8 3 -1 -1 11 2; -6 3 13 10 3 4; 4 -1 1 2 -2 -1; 12 8 11 3 -1 -1; -2 -1 -3 5 -3 -2];
T2_3 = rotq([cos(pi/5);sin(pi/5)*ones(3,1)/sqrt(3)]);
r2_3 = [5,-2,-4];
Ihat3 = [ 0 0 1 0 0 0; 0 1 0 0 0 0; 1 0 0 0 0 0];
Itilde3 = [0 0 0 0 0 1; 0 0 0 0 1 0; 0 0 0 1 0 0];
gamma = [1;2;3;4;5;6];
gammadot = [-2; -3; -4; -5; 1; 3];


[ITN,NwI,IrdotN,JN,JdotN] = recursive_kinematics(T2, w2_I, J2, J2dot, T2_3, r2_3, Ihat3, Itilde3, gamma, gammadot)