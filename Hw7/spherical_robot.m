function bdot = spherical_robot(b,V,F)
    bdot = zeros(6,1);
    
    theta1 = b(1);
    theta2 = b(2);
    d3 = b(3);
    dottheta1 = b(4);
    dottheta2 = b(5);
    d3dot = b(6);
    
%     dotgamma = b(4:6);
    
    m1 = 1.37080227;
    r1cm = [0;-0.02570462;0.05114915];
    m2 = 0.76240603;
    r2cm = [-0.05449109;.02681265;0];
    m3 = .77189259;
    r3cm = [0.00001023;0.00115005;0.00081791];
    
    r3E = [.375 0 0].';
    Gam1x = m1*r1cm(1); Gam1y = m1*r1cm(2); Gam1z = m1*r1cm(3);
    Gam2x = m2*r2cm(1); Gam2y = m2*r2cm(2); Gam2z = m2*r2cm(3);
    Gam3x = m3*r3cm(1); Gam3y = m3*r3cm(2); Gam3z = m3*r3cm(3);

    J1zz = .00756783; 
    J2zz = .01080444;   J2xz = 0;           J2xx = .00263900;   J2yz = 0;           J2xy = .00278041;   J2yy = .00881903;
    J3zz = .03770812;   J3xz = -.00000003;  J3xx = .00048237;   J3yz = -.00000662;  J3xy = -.00000017;  J3yy = .03770995;

    geoJ3 = [   -sin(theta2)                0                           0;
                0                           1                           0;
                cos(theta2)                 0                           0;
                -d3*cos(theta2)*sin(theta1)  -d3*cos(theta1)*sin(theta2)  cos(theta1)*cos(theta2);
                d3*cos(theta1)*cos(theta2)   -d3*sin(theta1)*sin(theta2)  cos(theta2)*sin(theta1);
                0                           -d3*cos(theta2)              -sin(theta2)          ];

    IT3 = [ cos(theta1)*cos(theta2) -sin(theta1)    cos(theta1)*sin(theta2);
            cos(theta2)*sin(theta1) cos(theta1)     sin(theta1)*sin(theta2);
            -sin(theta2)            0               cos(theta2)           ];

    H = [ J1zz + J2zz*cos(theta2)^2 + J3zz*cos(theta2)^2 - J2xz*sin(2*theta2) - J3xz*sin(2*theta2) + J2xx*sin(theta2)^2 + J3xx*sin(theta2)^2 + 2*Gam3x*d3*cos(theta2)^2 + Gam3z*d3*sin(2*theta2) + d3^2*m3*cos(theta2)^2, J2yz*cos(theta2) + J3yz*cos(theta2) - J2xy*sin(theta2) - J3xy*sin(theta2) + Gam3y*d3*sin(theta2), -Gam3y*cos(theta2);
                                                                                                               J2yz*cos(theta2) + J3yz*cos(theta2) - J2xy*sin(theta2) - J3xy*sin(theta2) + Gam3y*d3*sin(theta2),                                                               m3*d3^2 + 2*Gam3x*d3 + J2yy + J3yy,              Gam3z;
                                                                                                                                                                                             -Gam3y*cos(theta2),                                                                                            Gam3z,                 m3];
    d =  [Gam3x*d3dot*dottheta1 - J3xy*dottheta2^2*cos(theta2) - J2yz*dottheta2^2*sin(theta2) - J3yz*dottheta2^2*sin(theta2) - J2xy*dottheta2^2*cos(theta2) + 2*Gam3y*d3dot*dottheta2*sin(theta2) + Gam3x*d3dot*dottheta1*cos(2*theta2) + Gam3y*d3*dottheta2^2*cos(theta2) - 2*J2xz*dottheta1*dottheta2*cos(2*theta2) - 2*J3xz*dottheta1*dottheta2*cos(2*theta2) + Gam3z*d3dot*dottheta1*sin(2*theta2) + J2xx*dottheta1*dottheta2*sin(2*theta2) + J3xx*dottheta1*dottheta2*sin(2*theta2) - J2zz*dottheta1*dottheta2*sin(2*theta2) - J3zz*dottheta1*dottheta2*sin(2*theta2) + d3*d3dot*dottheta1*m3 + 2*Gam3z*d3*dottheta1*dottheta2*cos(2*theta2) - 2*Gam3x*d3*dottheta1*dottheta2*sin(2*theta2) + d3*d3dot*dottheta1*m3*cos(2*theta2) - d3^2*dottheta1*dottheta2*m3*sin(2*theta2);
                                                                                                                                                                                                                                                                                                                                                                                2*Gam3x*d3dot*dottheta2 + J2xz*dottheta1^2*cos(2*theta2) + J3xz*dottheta1^2*cos(2*theta2) - (J2xx*dottheta1^2*sin(2*theta2))/2 - (J3xx*dottheta1^2*sin(2*theta2))/2 + (J2zz*dottheta1^2*sin(2*theta2))/2 + (J3zz*dottheta1^2*sin(2*theta2))/2 - Gam3z*d3*dottheta1^2*cos(2*theta2) + Gam3x*d3*dottheta1^2*sin(2*theta2) + (d3^2*dottheta1^2*m3*sin(2*theta2))/2 + 2*d3*d3dot*dottheta2*m3;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                - (Gam3x*dottheta1^2)/2 - Gam3x*dottheta2^2 - (Gam3x*dottheta1^2*cos(2*theta2))/2 - (Gam3z*dottheta1^2*sin(2*theta2))/2 - (d3*dottheta1^2*m3)/2 - d3*dottheta2^2*m3 - (d3*dottheta1^2*m3*cos(2*theta2))/2];

    G =   [                                                                                                                                           0;
 - (981*Gam2x*cos(theta2))/100 - (981*Gam3x*cos(theta2))/100 - (981*Gam2z*sin(theta2))/100 - (981*Gam3z*sin(theta2))/100 - (981*d3*m3*cos(theta2))/100;
                                                                                                                             -(981*m3*sin(theta2))/100];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    N = [75;75;75*20];
    
    n = [.73;.73;.73];
    K = [.0182; .0182; .0182];
    Ra = [0.830; 0.830; 0.830];
    Ja = [(4.2*(10^-6));(4.2*(10^-6));(4.2*(10^-6))];
    
    Ba = diag([2.6*(10^-6);2.6*(10^-6);2.6*(10^-6)]);
    Ca = diag([.0042;.0042;.0042]);
    
    Rm = diag([(Ra(1)/((K(1)*n(1)*N(1))));
                (Ra(2)/((K(2)*n(2)*N(2))));
                (Ra(3)/((K(3)*n(3)*N(3))))]);
    Bm = diag([((Ra(1)*Ba(1)+K(1)^2)/K(1))*N(1);
        ((Ra(2)*Ba(2)+K(2)^2)/K(2))*N(2);
        ((Ra(3)*Ba(3)+K(3)^3)/K(3))*N(3)]);
    Cm = diag([(Ra(1)*Ca(1))/K(1);
                (Ra(2)*Ca(2))/K(2);
                (Ra(3)*Ca(3))/K(3)]);
    Jm = diag([(Ra(1)*Ja(1)*N(1))/K(1);
                (Ra(2)*Ja(2)*N(2))/K(2)
                (Ra(3)*Ja(3)*N(3))/K(3)]);
    
    B = diag([0.1; 0.1; 20]);
    C = diag([0.8; 0.8; 5]);
    
bdot(1:3)=b(4:6);
bdot(4:6) =(Rm*H+Jm)\(V -Rm*d - Rm*G - (Bm+Rm*B)*b(4:6) -(Cm+Rm*C)*sign(b(4:6)) + Rm*geoJ3.'*[cross(r3E,IT3.'*F);F]);