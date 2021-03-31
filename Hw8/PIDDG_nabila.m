function V = PIDDG_nabila(e,edot,eint,b)
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    dottheta1 = b(4);
    dottheta2 = b(5);
    dottheta3 = b(6);
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];
        d = [0.2935*dottheta2^2*cos(theta2) - 1.8326e-05*dottheta3^2*cos(theta2 - theta3) - 0.8326e-05*dottheta2^2*cos(theta2 - theta3) - 0.1293*dottheta1*dottheta3*sin(theta3) + 3.6653e-05*dottheta2*dottheta3*cos(theta2 - theta3) - 2.0000e-07*dottheta1*dottheta2*cos(2*theta2) - 1.1757*dottheta1*dottheta2*sin(2*theta2) - 0.2586*dottheta1*dottheta2*sin(2*theta2 - theta3) - 0.0519*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + 0.1293*dottheta1*dottheta3*sin(2*theta2 - theta3) + 0.0519*dottheta1*dottheta3*sin(2*theta2 - 2*theta3);...
                                                                                                                                                                                                                                                                                                0.1293*dottheta3^2*sin(theta3) + 1.0000e-07*dottheta1^2*cos(2*theta2) + 0.5879*dottheta1^2*sin(2*theta2) + 0.1293*dottheta1^2*sin(2*theta2 - theta3) + 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3) - 0.2586*dottheta2*dottheta3*sin(theta3);...
                                                                                                                                                                                                                                                                                                                                                                                  0.0647*dottheta1^2*sin(theta3) + 0.1293*dottheta2^2*sin(theta3) - 0.0647*dottheta1^2*sin(2*theta2 - theta3) - 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3)];
    K = 75;
    
    Kp = (K*.6)*eye(3);
    Kd = (K*.075)*eye(3);
    Ki = (K*1.2)*eye(3);
    
V = Kp*e + Kd*edot + Ki*eint + G;
% V = K*e + 0*edot + 0*eint + G;