function V = PIDG_nabila(e,edot,eint,b)
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];
    K = 75;
    
    Kp = (K*.6)*eye(3);
    Kd = (K*.075)*eye(3);
    Ki = (K*1.2)*eye(3);
    
V = Kp*e + Kd*edot + Ki*eint + G;
% V = K*e + 0*edot + 0*eint + G;