function V = PD_nabila(e,edot)
%     Kp = diag([200;100;150]);
%     Kd = diag([0;0;0]);
    
    K = 100;
    
    Kp = (K*.8)*eye(3);
    Kd = (K*.1)*eye(3);

% V = K*e + 0*edot;
V = Kp*e + Kd*edot;