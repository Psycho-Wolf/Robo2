function V = PD_nabila(e,edot)
%     Kp = diag([200;100;150]);
%     Kd = diag([0;0;0]);
    
    Kp = 80*eye(3);
    Kd = 10*eye(3);

V = Kp*e + Kd*edot;