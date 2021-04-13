function [pos,ori] = Nabila_FK(b)
    
    theta1 = b(1);
    theta2 = b(2);
    theta3 = b(3);
    
IIr1 = [0;0;0.17];
oneoner2 = [0;.11;.13];
twotwor3 = [0;0.49;0.02];

IT1 = rotzRad(theta1);
oneT2 = rotyRad(-pi/2)*rotxRad(-pi/2)*rotzRad(theta2);
IT2 = IT1*oneT2;
twoT3 = rotyRad(pi)*rotzRad(theta3);
IT3 = IT2*twoT3;

IIr2 = IIr1+IT1*oneoner2;
IIr3 = IIr2+IT2*twotwor3;
IIrE = IIr3+IT3*[0;0.32;0.13];
    
    pos = IIrE;
    ori = IT3;
end