function [M,n,G,JER,JEdotR,JEL,JEdotL,delf,gammadot] = mm_2021_prop(b)

%% B    

    phi = b(3);
    thetaRW = b(4);
    thetaLW = b(5);
    theta1 = b(6);
    thetaR2 = b(7);
    thetaR3 = b(8);
    thetaR4 = b(9);
    thetaR5 = b(10);
    thetaR6 = b(11);
    thetaL2 = b(12);
    thetaL3 = b(13);
    thetaL4 = b(14);
    thetaL5 = b(15);
    thetaL6 = b(16);
    gamma = zeros(16,1);
    gamma(1:16) = b(1:16);
%% Bdot    
     thetaRWdot = b(17);
     thetaLWdot = b(18);
%     theta1dot = b(19);
%     thetaR2dot = b(20);
%     thetaR3dot = b(21);
%     thetaR4dot = b(22);
%     thetaR5dot = b(23);
%     thetaR6dot = b(24);
%     thetaL2dot = b(25);
%     thetaL3dot = b(26);
%     thetaL4dot = b(27);
%     thetaL5dot = b(28);
%     thetaL6dot = b(29);


    u = zeros(13,1);
    u(1:13) = b(17:29);
    
    l = 2*.3810;
    r = .3048/2;
    gammadot = zeros(16,1);
    gammadot(1:3) = [r/2*cos(phi)*thetaRWdot+r/2*cos(phi)*thetaLWdot;...
                r/2*sin(phi)*thetaRWdot+r/2*sin(phi)*thetaLWdot;...
                r/l*thetaRWdot-r/l*thetaLWdot];
    gammadot(4:16) = u;
    
    mC = 5.73993897;
    ccrcm = [-0.15125527; 0.00114110; 0.02044990];
    ccJ = [0.21072042 0.00112610 0.01755761;...
           0.00112610 0.35520870 -0.00015225;...
           0.01755761 -0.00015225 0.47082310];...
    cgam = mC*ccrcm;
       
    mR = 3.43497773;
    Rrcm = [0.00000000; 0.00101881; 0.00000000];
    RRJ = [0.02780319 0.00000000 0.00000000;...
           0.00000000 0.05338030 0.00000000;...
           0.00000000 0.00000000 0.02780319];...
    Rgam = mR*Rrcm;
           
    mL = mR;
    Lrcm = -Rrcm;
    LLJ = RRJ;
    Lgam = mR*Lrcm;
   
    m1 = 0.96821600;
    onercm = [0.00000000; 0.00000000; 0.07074779];
    oneJ = [0.01739000 0.00000000 0.00000000;...
            0.00000000 0.00538178 0.00000000;...
            0.00000000 0.00000000 0.01232105];
    onegam = m1*onercm;
            
    mR2 = 0.32122492;
    R2rcm =[0.01992928; -0.05938485; 0.00000000];
    R2J = [0.00139985 0.00048233 0.00000000;...
           0.00048233 0.00043426 0.00000000;...
           0.00000000 0.00000000 0.00172741];
    R2gam = mR2*R2rcm;
    
    mL2 = mR2;
    L2rcm = [0.01992928; 0.05938485; 0.00000000];
    L2J = [0.00139985 -0.00048233 0.00000000;...
           -0.00048233 0.00043426 0.00000000;...
           0.00000000 0.00000000 0.00172741];
    L2gam = mL2*L2rcm;
           
    mR3=0.53126936;
    R3rcm = [0.12556172; 0.00545976; 0.00000000];
    R3J = [0.00027263 -0.00058392 0.00000000;...
           -0.00058392 0.01081142 0.00000000;...
           0.00000000 0.00000000 0.01090959];
    R3gam = mR3*R3rcm; 
           
    mL3 = mR3;
    L3rcm = [0.12556172; -0.00545976; 0.00000000];
    L3J = [0.00027263 0.00058392 0.00000000;...
           0.00058392 0.01081142 0.00000000;...
           0.00000000 0.00000000 0.01090959];
    L3gam = mL3*L3rcm;
    
    mR4 = 0.68159286;
    R4rcm = [0.11650147; 0.04372769; 0.00000000];
    R4J = [0.00164808 -0.00340665 0.00000000;...
           -0.00340665 0.01432027 0.00000000;...
           0.00000000 0.00000000 0.01574865];
    R4gam = mR4*R4rcm; 
           
    mL4 = 0.68159286;
    L4rcm = [0.11650147; -0.04372769; 0.00000000];
    L4J = [0.00164808 0.00340665 0.00000000;...
           0.00340665 0.01432027 0.00000000;...
           0.00000000 0.00000000 0.01574865];
    L4gam = mL4*L4rcm;
    
    mR5 = 0.52405953;
    R5rcm = [0.07810882; -0.04160174; 0.00000000];
    R5J = [0.00119073 0.00166130 0.00000000;...
           0.00166130 0.00523181 0.00000000;...
           0.00000000 0.00000000 0.00625366];
    R5gam = mR5*R5rcm;
           
    mL5 = 0.52405953;
    L5rcm = [0.07810882; 0.04160174; 0.00000000];
    L5J = [0.00119073 -0.00166130 0.00000000;...
           -0.00166130 0.00523181 0.00000000;...
           0.00000000 0.00000000 0.00625366];  
    L5gam = mL5*L5rcm;
           
    mR6=0.44800661;
    R6rcm = [0.06557409; 0.04616442; 0.00000000];
    R6J = [0.00115148 -0.00149053 0.00000000;...
           -0.00149053 0.00344884 0.00000000;...
           0.00000000 0.00000000 0.00445655];
    R6gam = mR6*R6rcm; 
           
    mL6=0.44800661;
    L6rcm = [0.06557409; -0.04616442; 0.00000000];
    L6J = [0.00115148 0.00149053 0.00000000;...
           0.00149053 0.00344884 0.00000000;...
           0.00000000 0.00000000 0.00445655];
    L6gam = mL6*L6rcm; 
    
    %FORWARD KINEMATICS START
%     CTI = rotzRad(phi);
%     pos = [x;y;0];
%     IIrR = pos + CTI*[0;-.3810;0];
%     IIrL = pos + CTI*[0;.3810;0];
%     IIr1 = pos + CTI*[-.1778000;.00129706;.2794];
    
    oneonerR2 = [0;-.2032;.0762];
    oneonerL2 = [0;.2032;.0762];
    
    R2R2rR3 = [.0762;-.0762;0];
    L2L2rL3 = [.0762;.0762;0]; 
    
    R3R3rR4 = [.2032;.0508;0];
    L3L3rL4 = [.2032;-.0508;0];
    
    R4R4rR5 = [.2286;0;0];
    L4L4rL5 = [.2286;0;0];
    
    R5R5rR6 = [.1524;0;0];
    L5L5rL6 = [.1524;0;0];
    
    R6R6rE = [.1778;.0508;0]; 
    L6L6rE = [.1778;-.0508;0]; %UN
    
    ITC = rotzRad(phi);
%     ITRW = ITC*rotyRad(thetaRW);
%     ITLW = ITC*rotyRad(thetaLW);
    
%     IT1 = ITC*rotzRad(theta1);
    oneTR2 = rotyRad(thetaR2);
    R2TR3 = rotxRad(thetaR3);
    R3TR4 = rotyRad(thetaR4);
    R4TR5 = rotyRad(thetaR5);
    R5TR6 = rotyRad(thetaR6);
    
    oneTL2 = rotyRad(thetaL2);
    L2TL3 = rotxRad(thetaL3);
    L3TL4 = rotyRad(thetaL4);
    L4TL5 = rotyRad(thetaL5);
    L5TL6 = rotyRad(thetaL6);
%     %RIGHT LINK DCM BACK TO I
%     ITR2 = IT1*oneTR2;
%     ITR3 = ITR2*R2TR3;
%     ITR4 = ITR3*R3TR4;
%     ITR5 = ITR4*R4TR5;
%     ITR6 = ITR5*R5TR6;
%     %LEFT LINK DCM BACK TO I
%     ITL2 = IT1*oneTL2;
%     ITL3 = ITL2*L2TL3;
%     ITL4 = ITL3*L3TL4;
%     ITL5 = ITL4*L4TL5;
%     ITL6 = ITL5*L5TL6;    
    
    
    CwI = [0 0 gammadot(3)]';
    geoC = zeros(6,16);
    geoC(3,3) = 1;
    geodotC = zeros(6,16);
    in = zeros(3,16);
    
    Ih1 = zeros(3,16);
    Ih1(3,6) = 1;
    Ih2 = zeros(3,16);
    Ih2(2,7) = 1;
    Ih3 = zeros(3,16);
    Ih3(1,8) = 1;
    Ih4 = zeros(3,16);
    Ih4(2,9) = 1;
    Ih5 = zeros(3,16);
    Ih5(2,10) = 1;
    Ih6 = zeros(3,16);
    Ih6(2,11) = 1;
    Ihl2 = zeros(3,16);
    Ihl2(2,12) = 1;
    Ihl3 = zeros(3,16);
    Ihl3(1,13) = 1;
    Ihl4 = zeros(3,16);
    Ihl4(2,14) = 1;
    Ihl5 = zeros(3,16);
    Ihl5(2,15) = 1;
    Ihl6 = zeros(3,16);
    Ihl6(2,16) = 1;
    IhRW = zeros(3,16);
    IhRW(2,4) = 1;
    IhLW = zeros(3,16);
    IhLW(2,5) = 1;
    
    % LINK ONE
    [IT1,onewI,~,J1,Jd1] = recursive_kinematics(ITC,CwI,geoC,geodotC,rotzRad(theta1),[-.1778000;.00129706;.2794],Ih1,in,gammadot);
    % RECURSIVE RIGHT
    [ITR2,R2wI,~,JR2,JdR2] = recursive_kinematics  (IT1,onewI,J1,Jd1,oneTR2,oneonerR2,Ih2,in,gammadot);
    [ITR3,R3wI,~,JR3,JdR3] = recursive_kinematics(ITR2,R2wI,JR2,JdR2,R2TR3,R2R2rR3,Ih3,in,gammadot);
    [ITR4,R4wI,~,JR4,JdR4] = recursive_kinematics(ITR3,R3wI,JR3,JdR3,R3TR4,R3R3rR4,Ih4,in,gammadot);
    [ITR5,R5wI,~,JR5,JdR5] = recursive_kinematics(ITR4,R4wI,JR4,JdR4,R4TR5,R4R4rR5,Ih5,in,gammadot);
    [ITR6,R6wI,~,JR6,JdR6] = recursive_kinematics(ITR5,R5wI,JR5,JdR5,R5TR6,R5R5rR6,Ih6,in,gammadot);
    [~,~,~,JRE,JdRE] = recursive_kinematics(ITR6,R6wI,JR6,JdR6,eye(3),R6R6rE,Ih6,in,gammadot);
    JER = JRE;
    JEdotR = JdRE;
    % RECURSIVE LEFT
    [ITL2,L2wI,~,JL2,JdL2] = recursive_kinematics(IT1,onewI,J1,Jd1,oneTL2,oneonerL2,Ihl2,in,gammadot);
    [ITL3,L3wI,~,JL3,JdL3] = recursive_kinematics(ITL2,L2wI,JL2,JdL2,L2TL3,L2L2rL3,Ihl3,in,gammadot);
    [ITL4,L4wI,~,JL4,JdL4] = recursive_kinematics(ITL3,L3wI,JL3,JdL3,L3TL4,L3L3rL4,Ihl4,in,gammadot);
    [ITL5,L5wI,~,JL5,JdL5] = recursive_kinematics(ITL4,L4wI,JL4,JdL4,L4TL5,L4L4rL5,Ihl5,in,gammadot);
    [ITL6,L6wI,~,JL6,JdL6] = recursive_kinematics(ITL5,L5wI,JL5,JdL5,L5TL6,L5L5rL6,Ihl6,in,gammadot);
    [~,~,~,JLE,JdLE] = recursive_kinematics(ITL6,L6wI,JL6,JdL6,eye(3),L6L6rE,Ihl6,in,gammadot);
    JEL = JLE;
    JEdotL = JdLE;
    % WHEELS
    [ITRW,RWwI,~,JRW,JdRW] = recursive_kinematics(ITC,CwI,geoC,geodotC,rotyRad(thetaRW),[0;-.3810;0],IhRW,in,gammadot);
    [ITLW,LWwI,~,JLW,JdLW] = recursive_kinematics(ITC,CwI,geoC,geodotC,rotyRad(thetaLW),[0;.3810;0],IhLW,in,gammadot);
   
    delf = [(381*cos(phi))/5000, (381*cos(phi))/5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            (381*sin(phi))/5000, (381*sin(phi))/5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                            1/5,                -1/5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                              1,                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0;...
                              0,                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
                          
    delg = [0, 0, - (381*thetaLWdot*sin(phi))/5000 - (381*thetaRWdot*sin(phi))/5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,   (381*thetaLWdot*cos(phi))/5000 + (381*thetaRWdot*cos(phi))/5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;...
            0, 0,                                                                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
 

    
     M = delf'*geoC'*[ccJ skew(cgam)*ITC'; ITC*skew(cgam)' eye(3)*mC]*geoC*delf +... %CHASSIS
         delf'*JRW'*[RRJ skew(Rgam)*ITRW'; ITRW*skew(Rgam)' eye(3)*mR]*JRW*delf +... %RIGHT WHEEL
         delf'*JLW'*[LLJ skew(Lgam)*ITLW'; ITLW*skew(Lgam)' eye(3)*mL]*JLW*delf +... %LEFT WHEEL
         delf'*J1'*[oneJ skew(onegam)*IT1'; IT1*skew(onegam)' eye(3)*m1]*J1*delf +... %LINK 1
         delf'*JR2'*[R2J skew(R2gam)*ITR2'; ITR2*skew(R2gam)' eye(3)*mR2]*JR2*delf +... %RIGHT LINK 2
         delf'*JR3'*[R3J skew(R3gam)*ITR3'; ITR3*skew(R3gam)' eye(3)*mR3]*JR3*delf +... %RIGHT LINK 3
         delf'*JR4'*[R4J skew(R4gam)*ITR4'; ITR4*skew(R4gam)' eye(3)*mR4]*JR4*delf +... %RIGHT LINK 4
         delf'*JR5'*[R5J skew(R5gam)*ITR5'; ITR5*skew(R5gam)' eye(3)*mR5]*JR5*delf +... %RIGHT LINK 5
         delf'*JR6'*[R6J skew(R6gam)*ITR6'; ITR6*skew(R6gam)' eye(3)*mR6]*JR6*delf +... %RIGHT LINK 6
         delf'*JL2'*[L2J skew(L2gam)*ITL2'; ITL2*skew(L2gam)' eye(3)*mL2]*JL2*delf +... %LEFT LINK 2
         delf'*JL3'*[L3J skew(L3gam)*ITL3'; ITL3*skew(L3gam)' eye(3)*mL3]*JL3*delf +... %LEFT LINK 3
         delf'*JL4'*[L4J skew(L4gam)*ITL4'; ITL4*skew(L4gam)' eye(3)*mL4]*JL4*delf +... %LEFT LINK 4
         delf'*JL5'*[L5J skew(L5gam)*ITL5'; ITL5*skew(L5gam)' eye(3)*mL5]*JL5*delf +... %LEFT LINK 5
         delf'*JL6'*[L6J skew(L6gam)*ITL6'; ITL6*skew(L6gam)' eye(3)*mL6]*JL6*delf; %LEFT LINK 6
    
     n = delf'*geoC'*[ccJ skew(cgam)*ITC'; ITC*skew(cgam)' eye(3)*mC]*(geodotC*gammadot + geoC*delg*gammadot) + delf'*geoC'*[cross(CwI,ccJ*CwI); ITC*cross(CwI,cross(CwI,cgam))] +... %CHASSIS
         delf'*JRW'*[RRJ skew(Rgam)*ITRW'; ITRW*skew(Rgam)' eye(3)*mR]*(JdRW*gammadot + JRW*delg*gammadot) + delf'*JRW'*[cross(RWwI,RRJ*RWwI); ITRW*cross(RWwI,cross(RWwI,Rgam))] +... %RIGHT WHEEL
         delf'*JLW'*[LLJ skew(Lgam)*ITLW'; ITLW*skew(Lgam)' eye(3)*mL]*(JdLW*gammadot + JLW*delg*gammadot) + delf'*JLW'*[cross(LWwI,LLJ*LWwI); ITLW*cross(LWwI,cross(LWwI,Lgam))] +... %LEFT WHEEL
         delf'*J1'*[oneJ skew(onegam)*IT1'; IT1*skew(onegam)' eye(3)*m1]*(Jd1*gammadot + J1*delg*gammadot) + delf'*J1'*[cross(onewI,oneJ*onewI); IT1*cross(onewI,cross(onewI,onegam))] +... %LINK 1
         delf'*JR2'*[R2J skew(R2gam)*ITR2'; ITR2*skew(R2gam)' eye(3)*mR2]*(JdR2*gammadot + JR2*delg*gammadot) + delf'*JR2'*[cross(R2wI,R2J*R2wI); ITR2*cross(R2wI,cross(R2wI,R2gam))] +... %RIGHT LINK 2
         delf'*JR3'*[R3J skew(R3gam)*ITR3'; ITR3*skew(R3gam)' eye(3)*mR3]*(JdR3*gammadot + JR3*delg*gammadot) + delf'*JR3'*[cross(R3wI,R3J*R3wI); ITR3*cross(R3wI,cross(R3wI,R3gam))] +... %RIGHT LINK 3
         delf'*JR4'*[R4J skew(R4gam)*ITR4'; ITR4*skew(R4gam)' eye(3)*mR4]*(JdR4*gammadot + JR4*delg*gammadot) + delf'*JR4'*[cross(R4wI,R4J*R4wI); ITR4*cross(R4wI,cross(R4wI,R4gam))] +... %RIGHT LINK 4
         delf'*JR5'*[R5J skew(R5gam)*ITR5'; ITR5*skew(R5gam)' eye(3)*mR5]*(JdR5*gammadot + JR5*delg*gammadot) + delf'*JR5'*[cross(R5wI,R5J*R5wI); ITR5*cross(R5wI,cross(R5wI,R5gam))] +... %RIGHT LINK 5
         delf'*JR6'*[R6J skew(R6gam)*ITR6'; ITR6*skew(R6gam)' eye(3)*mR6]*(JdR6*gammadot + JR6*delg*gammadot) + delf'*JR6'*[cross(R6wI,R6J*R6wI); ITR6*cross(R6wI,cross(R6wI,R6gam))] +... %RIGHT LINK 6
         delf'*JL2'*[L2J skew(L2gam)*ITL2'; ITL2*skew(L2gam)' eye(3)*mL2]*(JdL2*gammadot + JL2*delg*gammadot) + delf'*JL2'*[cross(L2wI,L2J*L2wI); ITL2*cross(L2wI,cross(L2wI,L2gam))] +... %LEFT LINK 2
         delf'*JL3'*[L3J skew(L3gam)*ITL3'; ITL3*skew(L3gam)' eye(3)*mL3]*(JdL3*gammadot + JL3*delg*gammadot) + delf'*JL3'*[cross(L3wI,L3J*L3wI); ITL3*cross(L3wI,cross(L3wI,L3gam))] + ... %LEFT LINK 3
         delf'*JL4'*[L4J skew(L4gam)*ITL4'; ITL4*skew(L4gam)' eye(3)*mL4]*(JdL4*gammadot + JL4*delg*gammadot) + delf'*JL4'*[cross(L4wI,L4J*L4wI); ITL4*cross(L4wI,cross(L4wI,L4gam))] +... %LEFT LINK 4
         delf'*JL5'*[L5J skew(L5gam)*ITL5'; ITL5*skew(L5gam)' eye(3)*mL5]*(JdL5*gammadot + JL5*delg*gammadot) + delf'*JL5'*[cross(L5wI,L5J*L5wI); ITL5*cross(L5wI,cross(L5wI,L5gam))] +... %LEFT LINK 5
         delf'*JL6'*[L6J skew(L6gam)*ITL6'; ITL6*skew(L6gam)' eye(3)*mL6]*(JdL6*gammadot + JL6*delg*gammadot) + delf'*JL6'*[cross(L6wI,L6J*L6wI); ITL6*cross(L6wI,cross(L6wI,L6gam))];     %LEFT LINK 6
     
      G = delf'*geoC'*[cross(cgam,ITC'*[0;0;-9.8]);[0;0;-9.8]*mC];
      G = G + delf'*JRW'*[cross(Rgam,ITRW'*[0;0;-9.8]);[0;0;-9.8]*mR];
      G = G + delf'*JLW'*[cross(Lgam,ITLW'*[0;0;-9.8]);[0;0;-9.8]*mL];
      
      G = G + delf'*J1'*[cross(onegam,IT1'*[0;0;-9.8]);[0;0;-9.8]*m1];
      G = G + delf'*JR2'*[cross(R2gam,ITR2'*[0;0;-9.8]);[0;0;-9.8]*mR2];
      G = G + delf'*JR3'*[cross(R3gam,ITR3'*[0;0;-9.8]);[0;0;-9.8]*mR3];
      G = G + delf'*JR4'*[cross(R4gam,ITR4'*[0;0;-9.8]);[0;0;-9.8]*mR4];
      G = G + delf'*JR5'*[cross(R5gam,ITR5'*[0;0;-9.8]);[0;0;-9.8]*mR5];
      G = G + delf'*JR6'*[cross(R6gam,ITR6'*[0;0;-9.8]);[0;0;-9.8]*mR6];
      G = G + delf'*JL2'*[cross(L2gam,ITL2'*[0;0;-9.8]);[0;0;-9.8]*mL2];
      G = G + delf'*JL3'*[cross(L3gam,ITL3'*[0;0;-9.8]);[0;0;-9.8]*mL3];
      G = G + delf'*JL4'*[cross(L4gam,ITL4'*[0;0;-9.8]);[0;0;-9.8]*mL4];
      G = G + delf'*JL5'*[cross(L5gam,ITL5'*[0;0;-9.8]);[0;0;-9.8]*mL5];
      G = G + delf'*JL6'*[cross(L6gam,ITL6'*[0;0;-9.8]);[0;0;-9.8]*mL6];

end