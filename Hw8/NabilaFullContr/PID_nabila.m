function V = PID_nabila(e,edot,eint)

    K = 300;
    
    Kp = (K*.6)*eye(3);
    Kd = (K*.075)*eye(3);
    Ki = (K*1.2)*eye(3);
    
V = Kp*e + Kd*edot + Ki*eint;