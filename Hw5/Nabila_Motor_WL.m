function bdot = Nabila_Motor_WL(b,V)

    bdot = zeros(9,1);
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    dottheta1 = b(4);
    dottheta2 = b(5);
    dottheta3 = b(6);
    i1 = b(7);
    i2 = b(8);
    i3 = b(9);
    
    B = 1.5;
    C = 2.3;
    
    H =[0.3554*cos(2*theta2) - 1.0000e-07*sin(2*theta2) + 0.1293*cos(theta3) + 0.1293*cos(2*theta2 - 1*theta3) + 0.0260*cos(2*theta2 - 2*theta3) + 0.4649*cos(theta2)^2 + 0.6690, 0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3), 1.8326e-05*sin(theta2 - 1*theta3);...
                                                                                                                      0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3),                            0.2586*cos(theta3) + 1.2454,     - 0.1293*cos(theta3) - 0.0552;...
                                                                                                                                           1.8326e-05*sin(theta2 - 1*theta3),                          - 0.1293*cos(theta3) - 0.0552,                            0.0552];                                                                                                                                   
    d = [0.2935*dottheta2^2*cos(theta2) - 1.8326e-05*dottheta3^2*cos(theta2 - theta3) - 1.8326e-05*dottheta2^2*cos(theta2 - theta3) - 0.1293*dottheta1*dottheta3*sin(theta3) + 3.6653e-05*dottheta2*dottheta3*cos(theta2 - theta3) - 2.0000e-07*dottheta1*dottheta2*cos(2*theta2) - 1.1757*dottheta1*dottheta2*sin(2*theta2) - 0.2586*dottheta1*dottheta2*sin(2*theta2 - theta3) - 0.0519*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + 0.1293*dottheta1*dottheta3*sin(2*theta2 - theta3) + 0.0519*dottheta1*dottheta3*sin(2*theta2 - 2*theta3);...
                                                                                                                                                                                                                                                                                                0.1293*dottheta3^2*sin(theta3) + 1.0000e-07*dottheta1^2*cos(2*theta2) + 0.5879*dottheta1^2*sin(2*theta2) + 0.1293*dottheta1^2*sin(2*theta2 - theta3) + 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3) - 0.2586*dottheta2*dottheta3*sin(theta3);...
                                                                                                                                                                                                                                                                                                                                                                                  0.0647*dottheta1^2*sin(theta3) + 0.1293*dottheta2^2*sin(theta3) - 0.0647*dottheta1^2*sin(2*theta2 - theta3) - 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3)];
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];

    N = [24;75;24];
    eata = [.81;.73;.81];
    K = diag([.0232; .0234; .0196].*N); 
    Ra = diag([1.26; 1.63; 2.99]);
    Ja = [(4.2*(10^-6));(3.2*(10^-6));(1.9*(10^-6))];
    L = diag([1.0;1.3;1.8]);
    
    
    
    Ki = diag([.0232; .0234; .0196]);
    Ri = diag(1./(eata.*N));
    Ji = diag(Ja.*N);
    Bi = diag(B.*N);
    Ci = diag(C);
    
    
    bdot(1:3)=b(4:6);
    bdot(4:6) = (Ji+Ri*H)\(Ki*bdot(7:9) - Ri*d - Ri*G - (Bi+Ri*B)*bdot(1:3) - (Ci + Ri*C)*sign(bdot(1:3)));
    bdot(7:9) = L\(V - Ra*bdot(7:9) - K*bdot(1:3));

end