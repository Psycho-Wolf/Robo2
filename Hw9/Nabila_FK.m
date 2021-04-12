function [pos,ori] = Nabila_FK(b)
    
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    
    rBfromI = [0;0;0];
    r1fromB = [0;0;0.17];
    r2from1 = [0;0.11;.13];
    r3from2 = [0;0.49;.02];

    T1 = rotzRad(theta1);
    T2=T1*rotzRad(-pi/2)*rotyRad(-pi/2)*rotzRad(theta2);
    T3=T2*rotyRad(pi)*rotzRad(theta3);

    rB=rBfromI;
    r1=rB+r1fromB;
    r2=r1+T1*r2from1;
    r3=r2+T2*r3from2;
    
    pos = r3;
    ori = T3;
end