function bdot = Nabila(b,F)

%b vector definitions
theta1=b(1);
theta2=b(2);
theta3 = b(3);
dottheta1=b(4);
dottheta2=b(5);
dottheta3=b(6);

% Constants
m1 = 3.62564899;
m2 = 7.28910514;
m3 = 2.96056704;
L1y = 0.01906083; L1z = 0.09908556;
L2y = 0.19160707; L2z = 0.07507103;

J1zz = 0.01339125;
J2xx = 0.52173834; J2yy = 0.05685904; J2zz = 0.47943980; J2xy = 0; J2xz = 0; J2yz = -0.10835509;
J3xx = 0.09409322; J3yy = 0.04215810; J3zz = 0.05516869; J3xy = 0; J3xz = 0; J3yz = -0.03432580;

Gam2x = m2*0;
Gam2y = m2*0.19160707;
Gam2z = m2*0.07507103;
Gam3x = m3*0;
Gam3y = m3*0.08913956;
Gam3z = m3*0.10830011;

H= [J2xx/2 + J3xx/2 + J2yy/2 + J3yy/2 + J1zz + (J3xx*cos(2*theta2 - 2*theta3))/2 - (J3yy*cos(2*theta2 - 2*theta3))/2 + J3xy*sin(2*theta2 - 2*theta3) + L1y^2*m2 + L1y^2*m3 + (L2y^2*m3)/2 + L2z^2*m3 + (J2xx*cos(2*theta2))/2 - (J2yy*cos(2*theta2))/2 - J2xy*sin(2*theta2) + 2*Gam2z*L1y - 2*Gam3z*L1y - 2*Gam3z*L2z + Gam3y*L2y*cos(2*theta2 - theta3) + 2*L1y*L2z*m3 - Gam3x*L2y*sin(2*theta2 - theta3) + (L2y^2*m3*cos(2*theta2))/2 + Gam3y*L2y*cos(theta3) + Gam3x*L2y*sin(theta3), J2xz*cos(theta2) - J2yz*sin(theta2) + J3xz*cos(theta2 - theta3) + J3yz*sin(theta2 - theta3) + Gam3y*L1y*sin(theta2 - theta3) + Gam3y*L2z*sin(theta2 - theta3) - Gam2x*L1y*cos(theta2) + Gam2y*L1y*sin(theta2) - Gam3z*L2y*sin(theta2) + Gam3x*L1y*cos(theta2 - theta3) + Gam3x*L2z*cos(theta2 - theta3) + L1y*L2y*m3*sin(theta2) + L2y*L2z*m3*sin(theta2), - J3xz*cos(theta2 - theta3) - J3yz*sin(theta2 - theta3) - Gam3y*L1y*sin(theta2 - theta3) - Gam3y*L2z*sin(theta2 - theta3) - Gam3x*L1y*cos(theta2 - theta3) - Gam3x*L2z*cos(theta2 - theta3);
                                                                                                                          J2xz*cos(theta2) - J2yz*sin(theta2) + J3xz*cos(theta2 - theta3) + J3yz*sin(theta2 - theta3) + Gam3y*L1y*sin(theta2 - theta3) + Gam3y*L2z*sin(theta2 - theta3) - Gam2x*L1y*cos(theta2) + Gam2y*L1y*sin(theta2) - Gam3z*L2y*sin(theta2) + Gam3x*L1y*cos(theta2 - theta3) + Gam3x*L2z*cos(theta2 - theta3) + L1y*L2y*m3*sin(theta2) + L2y*L2z*m3*sin(theta2),                                                                                                                                                                                                                                                                                J2zz + J3zz + L2y^2*m3 + 2*Gam3y*L2y*cos(theta3) + 2*Gam3x*L2y*sin(theta3),                                                                                                                                      - J3zz - Gam3y*L2y*cos(theta3) - Gam3x*L2y*sin(theta3);
                                                                                                                                                                                                                                                                                        - J3xz*cos(theta2 - theta3) - J3yz*sin(theta2 - theta3) - Gam3y*L1y*sin(theta2 - theta3) - Gam3y*L2z*sin(theta2 - theta3) - Gam3x*L1y*cos(theta2 - theta3) - Gam3x*L2z*cos(theta2 - theta3),                                                                                                                                                                                                                                                                                                    - J3zz - Gam3y*L2y*cos(theta3) - Gam3x*L2y*sin(theta3),                                                                                                                                                                                        J3zz];
d = [J3yz*dottheta2^2*cos(theta2 - theta3) - J2xz*dottheta2^2*sin(theta2) - J2yz*dottheta2^2*cos(theta2) + J3yz*dottheta3^2*cos(theta2 - theta3) - J3xz*dottheta2^2*sin(theta2 - theta3) - J3xz*dottheta3^2*sin(theta2 - theta3) - 2*J3yz*dottheta2*dottheta3*cos(theta2 - theta3) + 2*J3xz*dottheta2*dottheta3*sin(theta2 - theta3) + Gam2y*L1y*dottheta2^2*cos(theta2) - Gam3z*L2y*dottheta2^2*cos(theta2) + Gam2x*L1y*dottheta2^2*sin(theta2) - 2*J2xy*dottheta1*dottheta2*cos(2*theta2) - J2xx*dottheta1*dottheta2*sin(2*theta2) + J2yy*dottheta1*dottheta2*sin(2*theta2) + Gam3y*L1y*dottheta2^2*cos(theta2 - theta3) + Gam3y*L1y*dottheta3^2*cos(theta2 - theta3) + Gam3y*L2z*dottheta2^2*cos(theta2 - theta3) + Gam3y*L2z*dottheta3^2*cos(theta2 - theta3) - Gam3x*L1y*dottheta2^2*sin(theta2 - theta3) - Gam3x*L1y*dottheta3^2*sin(theta2 - theta3) - Gam3x*L2z*dottheta2^2*sin(theta2 - theta3) - Gam3x*L2z*dottheta3^2*sin(theta2 - theta3) + 2*J3xy*dottheta1*dottheta2*cos(2*theta2 - 2*theta3) - 2*J3xy*dottheta1*dottheta3*cos(2*theta2 - 2*theta3) - J3xx*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + J3xx*dottheta1*dottheta3*sin(2*theta2 - 2*theta3) + J3yy*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) - J3yy*dottheta1*dottheta3*sin(2*theta2 - 2*theta3) + L1y*L2y*dottheta2^2*m3*cos(theta2) + L2y*L2z*dottheta2^2*m3*cos(theta2) - 2*Gam3x*L2y*dottheta1*dottheta2*cos(2*theta2 - theta3) + Gam3x*L2y*dottheta1*dottheta3*cos(2*theta2 - theta3) - 2*Gam3y*L2y*dottheta1*dottheta2*sin(2*theta2 - theta3) + Gam3y*L2y*dottheta1*dottheta3*sin(2*theta2 - theta3) - L2y^2*dottheta1*dottheta2*m3*sin(2*theta2) + Gam3x*L2y*dottheta1*dottheta3*cos(theta3) - Gam3y*L2y*dottheta1*dottheta3*sin(theta3) - 2*Gam3y*L1y*dottheta2*dottheta3*cos(theta2 - theta3) - 2*Gam3y*L2z*dottheta2*dottheta3*cos(theta2 - theta3) + 2*Gam3x*L1y*dottheta2*dottheta3*sin(theta2 - theta3) + 2*Gam3x*L2z*dottheta2*dottheta3*sin(theta2 - theta3);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        J2xy*dottheta1^2*cos(2*theta2) + (J2xx*dottheta1^2*sin(2*theta2))/2 - (J2yy*dottheta1^2*sin(2*theta2))/2 - J3xy*dottheta1^2*cos(2*theta2 - 2*theta3) + (J3xx*dottheta1^2*sin(2*theta2 - 2*theta3))/2 - (J3yy*dottheta1^2*sin(2*theta2 - 2*theta3))/2 + Gam3x*L2y*dottheta1^2*cos(2*theta2 - theta3) + Gam3y*L2y*dottheta1^2*sin(2*theta2 - theta3) + (L2y^2*dottheta1^2*m3*sin(2*theta2))/2 - Gam3x*L2y*dottheta3^2*cos(theta3) + Gam3y*L2y*dottheta3^2*sin(theta3) + 2*Gam3x*L2y*dottheta2*dottheta3*cos(theta3) - 2*Gam3y*L2y*dottheta2*dottheta3*sin(theta3);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                J3xy*dottheta1^2*cos(2*theta2 - 2*theta3) - (J3xx*dottheta1^2*sin(2*theta2 - 2*theta3))/2 + (J3yy*dottheta1^2*sin(2*theta2 - 2*theta3))/2 - (Gam3x*L2y*dottheta1^2*cos(2*theta2 - theta3))/2 - (Gam3y*L2y*dottheta1^2*sin(2*theta2 - theta3))/2 - (Gam3x*L2y*dottheta1^2*cos(theta3))/2 - Gam3x*L2y*dottheta2^2*cos(theta3) + (Gam3y*L2y*dottheta1^2*sin(theta3))/2 + Gam3y*L2y*dottheta2^2*sin(theta3)];
 
G = [                                                                                                                                                                     0;
(981*Gam3x*sin(theta2 - theta3))/100 - (981*Gam2x*sin(theta2))/100 - (981*Gam3y*cos(theta2 - theta3))/100 - (981*Gam2y*cos(theta2))/100 - (981*L2y*m3*cos(theta2))/100;
                                                                                           (981*Gam3y*cos(theta2 - theta3))/100 - (981*Gam3x*sin(theta2 - theta3))/100];
 


                                                                                       
                                                                                       
Cf = 5;
Cmat = Cf*eyes(3)
C = 
Bf = 10;
B

bdot(1:3)=b(4:6);
bdot(4:6)=H\(F-d-G); 
end