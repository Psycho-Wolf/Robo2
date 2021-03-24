function bdot = spherical_robot(b,V,F)
clear
clc

syms theta1 theta2 d dottheta1 dottheta2 ddot

m1 = 1.37080227;
r1cm = [0;-0.02570462;0.05114915];
m2 = 0.76240603;
r2cm = [-0.05449109;.02681265;0];
m3 = .77189259;
r3cm = [0.00001023;0.00115005;0.00081791];

Gam1x = m1*r1cm(1); Gam1y = m1*r1cm(2); Gam1z = m1*r1cm(3);
Gam2x = m2*r2cm(1); Gam2y = m2*r2cm(2); Gam2z = m2*r2cm(3);
Gam3x = m3*r3cm(1); Gam3y = m3*r3cm(2); Gam3z = m3*r3cm(3);

J1zz = .00756783; 
J2zz = .01080444;   J2xz = 0;           J2xx = .00263900;   J2yz = 0;           J2xy = .00278041;   J2yy = .00881903;
J3zz = .03770812;   J3xz = -.00000003;  J3xx = .00048237;   J3yz = -.00000662;  J3xy = -.00000017;  J3yy = .03770995;

H = [J1zz + J2zz*cos(theta2)^2 + J3zz*cos(theta2)^2 - J2xz*sin(2*theta2) - J3xz*sin(2*theta2) + J2xx*sin(theta2)^2 + J3xx*sin(theta2)^2 + 2*Gam3x*d*cos(theta2)^2 + Gam3z*d*sin(2*theta2) + d^2*m3*cos(theta2)^2, J2yz*cos(theta2) + J3yz*cos(theta2) - J2xy*sin(theta2) - J3xy*sin(theta2) + Gam3y*d*sin(theta2), -Gam3y*cos(theta2);
                                                                                                            J2yz*cos(theta2) + J3yz*cos(theta2) - J2xy*sin(theta2) - J3xy*sin(theta2) + Gam3y*d*sin(theta2),                                                                m3*d^2 + 2*Gam3x*d + J2yy + J3yy,              Gam3z;
                                                                                                                                                                                         -Gam3y*cos(theta2),                                                                                           Gam3z,                 m3];
d = [Gam3x*ddot*dottheta1 - J3xy*dottheta2^2*cos(theta2) - J2yz*dottheta2^2*sin(theta2) - J3yz*dottheta2^2*sin(theta2) - J2xy*dottheta2^2*cos(theta2) + 2*Gam3y*ddot*dottheta2*sin(theta2) + Gam3y*d*dottheta2^2*cos(theta2) + Gam3x*ddot*dottheta1*cos(2*theta2) - 2*J2xz*dottheta1*dottheta2*cos(2*theta2) - 2*J3xz*dottheta1*dottheta2*cos(2*theta2) + Gam3z*ddot*dottheta1*sin(2*theta2) + J2xx*dottheta1*dottheta2*sin(2*theta2) + J3xx*dottheta1*dottheta2*sin(2*theta2) - J2zz*dottheta1*dottheta2*sin(2*theta2) - J3zz*dottheta1*dottheta2*sin(2*theta2) + d*ddot*dottheta1*m3 + 2*Gam3z*d*dottheta1*dottheta2*cos(2*theta2) - 2*Gam3x*d*dottheta1*dottheta2*sin(2*theta2) + d*ddot*dottheta1*m3*cos(2*theta2) - d^2*dottheta1*dottheta2*m3*sin(2*theta2);
                                                                                                                                                                                                                                                                                                                                                                         2*Gam3x*ddot*dottheta2 + J2xz*dottheta1^2*cos(2*theta2) + J3xz*dottheta1^2*cos(2*theta2) - (J2xx*dottheta1^2*sin(2*theta2))/2 - (J3xx*dottheta1^2*sin(2*theta2))/2 + (J2zz*dottheta1^2*sin(2*theta2))/2 + (J3zz*dottheta1^2*sin(2*theta2))/2 - Gam3z*d*dottheta1^2*cos(2*theta2) + Gam3x*d*dottheta1^2*sin(2*theta2) + (d^2*dottheta1^2*m3*sin(2*theta2))/2 + 2*d*ddot*dottheta2*m3;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      - (Gam3x*dottheta1^2)/2 - Gam3x*dottheta2^2 - (Gam3x*dottheta1^2*cos(2*theta2))/2 - (Gam3z*dottheta1^2*sin(2*theta2))/2 - (d*dottheta1^2*m3)/2 - d*dottheta2^2*m3 - (d*dottheta1^2*m3*cos(2*theta2))/2];
G =[                                                                                                                                                0;
- (981*Gam2x*cos(theta2))/100 - (981*Gam3x*cos(theta2))/100 - (981*Gam2z*sin(theta2))/100 - (981*Gam3z*sin(theta2))/100 - (981*d*m3*cos(theta2))/100;
                                                                                                                           -(981*m3*sin(theta2))/100];


end