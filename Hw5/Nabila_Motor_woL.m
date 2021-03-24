function bdot = Nabila_Motor_woL(b,V)

    bdot = zeros(6,1);
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    dottheta1 = b(4);
    dottheta2 = b(5);
    dottheta3 = b(6);
    
    B = 1.5;
    C = 2.3;
    
    H =[0.3554*cos(2*theta2) - 1.0000e-07*sin(2*theta2) + 0.1293*cos(theta3) + 0.1293*cos(2*theta2 - 1*theta3) + 0.0260*cos(2*theta2 - 2*theta3) + 0.4649*cos(theta2)^2 + 0.6690, 0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3), 1.8326e-05*sin(theta2 - 1*theta3);...
                                                                                                                      0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3),                            0.2586*cos(theta3) + 1.2454,     - 0.1293*cos(theta3) - 0.0552;...
                                                                                                                                           1.8326e-05*sin(theta2 - 1*theta3),                          - 0.1293*cos(theta3) - 0.0552,                            0.0552];                                                                                                                                   
    d = [0.2935*dottheta2^2*cos(theta2) - 1.8326e-05*dottheta3^2*cos(theta2 - theta3) - 0.8326e-05*dottheta2^2*cos(theta2 - theta3) - 0.1293*dottheta1*dottheta3*sin(theta3) + 3.6653e-05*dottheta2*dottheta3*cos(theta2 - theta3) - 2.0000e-07*dottheta1*dottheta2*cos(2*theta2) - 1.1757*dottheta1*dottheta2*sin(2*theta2) - 0.2586*dottheta1*dottheta2*sin(2*theta2 - theta3) - 0.0519*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + 0.1293*dottheta1*dottheta3*sin(2*theta2 - theta3) + 0.0519*dottheta1*dottheta3*sin(2*theta2 - 2*theta3);...
                                                                                                                                                                                                                                                                                                0.1293*dottheta3^2*sin(theta3) + 1.0000e-07*dottheta1^2*cos(2*theta2) + 0.5879*dottheta1^2*sin(2*theta2) + 0.1293*dottheta1^2*sin(2*theta2 - theta3) + 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3) - 0.2586*dottheta2*dottheta3*sin(theta3);...
                                                                                                                                                                                                                                                                                                                                                                                  0.0647*dottheta1^2*sin(theta3) + 0.1293*dottheta2^2*sin(theta3) - 0.0647*dottheta1^2*sin(2*theta2 - theta3) - 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3)];
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];

    N = [24;75;24];
    eata = [.81;.73;.81];
    K = [.0232; .0234; .0196];
    Ra = [1.26; 1.63; 2.99];
    Ja = [(4.2*(10^-6));(3.2*(10^-6));(1.9*(10^-6))];
    
    Ba = diag([.039;.034;.028]);
    Ca = diag([.6;.6;.5]);
    
    Rm = diag(Ra./(K.*eata.*N));
    Bm = diag(((Ra.*Ba+K.^2)./K).*N);
    Cm = diag((Ra.*Ca)./K);
    Jm = diag((Ra.*Ja.*N)./K);
    
    bdot(1:3)=b(4:6);
    bdot(4:6) = (Jm+Rm*H)\(V - (Bm+Rm*B)*bdot(1:3) - (Cm+Rm*C)*sign(bdot(1:3)) + Rm*d + Rm*G);

end