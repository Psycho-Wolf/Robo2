function V = CT_PD_nabila(e,edot,b)

    b = zeros(6,1);
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    dottheta1 = b(4);
    dottheta2 = b(5);
    dottheta3 = b(6);
    dotgamma = b(4:6);

    k1 = .0182; k2 = .0188; k3 = .0156;
    R1 = .830; R2 = 1.08; R3 = 1.93;
    J1 = .0000042; J2 = .0000042; J3 = .0000019;
    n1 = .81; n2 = .73; n3 = n1;
    N1 = 24; N2 = 75; N3 = N1;
    B1 = .0000026; B2 = .0000023; B3 = .0000018;
    C1 = .0042; C2 = .0042; C3 = .0035;

    Jm = diag([R1*J1*N1/k1,R2*J2*N2/k2,R3*J3*N3/k3]);
    Bm = diag([(R1*B1 + k1^2)*N1/k1,(R2*B2 + k2^2)*N2/k2,(R3*B3 + k3^2)*N3/k3])*dotgamma;
    Cm = diag([R1*C1/k1,R2*C2/k2,R3*C3/k3])*sign(dotgamma);
    Rm = diag([R1/(k1*n1*N1),R2/(k2*n2*N2),R3/(k3*n3*N3)]);
    
    H =[0.3554*cos(2*theta2) - 1.0000e-07*sin(2*theta2) + 0.1293*cos(theta3) + 0.1293*cos(2*theta2 - 1*theta3) + 0.0260*cos(2*theta2 - 2*theta3) + 0.4649*cos(theta2)^2 + 0.6690, 0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3), 1.8326e-05*sin(theta2 - 1*theta3);...
                                                                                                                      0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3),                            0.2586*cos(theta3) + 1.2454,     - 0.1293*cos(theta3) - 0.0552;...
                                                                                                                                           1.8326e-05*sin(theta2 - 1*theta3),                          - 0.1293*cos(theta3) - 0.0552,                            0.0552];                                                                                                                                   
    d = [0.2935*dottheta2^2*cos(theta2) - 1.8326e-05*dottheta3^2*cos(theta2 - theta3) - 0.8326e-05*dottheta2^2*cos(theta2 - theta3) - 0.1293*dottheta1*dottheta3*sin(theta3) + 3.6653e-05*dottheta2*dottheta3*cos(theta2 - theta3) - 2.0000e-07*dottheta1*dottheta2*cos(2*theta2) - 1.1757*dottheta1*dottheta2*sin(2*theta2) - 0.2586*dottheta1*dottheta2*sin(2*theta2 - theta3) - 0.0519*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + 0.1293*dottheta1*dottheta3*sin(2*theta2 - theta3) + 0.0519*dottheta1*dottheta3*sin(2*theta2 - 2*theta3);...
                                                                                                                                                                                                                                                                                                0.1293*dottheta3^2*sin(theta3) + 1.0000e-07*dottheta1^2*cos(2*theta2) + 0.5879*dottheta1^2*sin(2*theta2) + 0.1293*dottheta1^2*sin(2*theta2 - theta3) + 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3) - 0.2586*dottheta2*dottheta3*sin(theta3);...
                                                                                                                                                                                                                                                                                                                                                                                  0.0647*dottheta1^2*sin(theta3) + 0.1293*dottheta2^2*sin(theta3) - 0.0647*dottheta1^2*sin(2*theta2 - theta3) - 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3)];
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];

    K = 350;
    
    Kp = (K*.8)*eye(3);
    Kd = (K*.1)*eye(3);
    
    C =[23*sign(dottheta1)/10;23*sign(dottheta2)/10;23*sign(dottheta3)/10];
    B =[3*dottheta1/2;3*dottheta2/2;3*dottheta3/2];

% V = H*(K*e + 0*edot) + d + G;
V = (Jm + Rm*H)*(Kp*e + Kd*edot) + Rm*d +Rm*G + (Bm +Rm*B) + (Cm + Rm*C);
