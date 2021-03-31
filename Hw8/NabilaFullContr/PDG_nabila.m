function V = PDG_nabila(e,edot,b)
%     Kp = diag([200;100;150]);
%     Kd = diag([0;0;0]);
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    
    G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];
    K = 30;
    
    Kp = (K*.8)*eye(3);
    Kd = (K*.1)*eye(3);

% V = K*e + 0*edot + G;
V = Kp*e + Kd*edot + G;