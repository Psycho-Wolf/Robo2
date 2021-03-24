function spherical_robot_draw(gamma)

    theta1 = gamma(1);
    theta2 = gamma(2);
    d = gamma(3);
    
    h = clf(gcf);

    Floor_v = [-1 1 0;...
    1 1 0;...
    -1 -1 0;...
    1 -1 0];
    Floor_f = [1 2 4 3];
    
    patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor',[0 0 .8],'FaceAlpha',.5);
    hold on
    set(gcf,'Position',[50, 50, 950, 900])

    [Base,Base_f,n,c,stltitle]   = stlread('Spherical_Robot_Base.stl');
    [Turret,Turret_f,n,c,stltitle] = stlread('Spherical_Robot_Turret.stl');
    [Link2,Link2_f,n,c,stltitle] = stlread('Spherical_Robot_Link2.stl');
    [Link3,Link3_f,n,c,stltitle] = stlread('Spherical_Robot_Link3.stl');

    
    rBfromI = [0;0;0];
    r1fromB = [0;0;.2];
    r2from1 = [0;0;0.08154018];
    r3from2 = [d;0;0];
    
    T1 = rotzRad(theta1);
    T2=T1*rotyRad(theta2);
    T3 = T2;
    
    rB = rBfromI;
    r1 = rB + r1fromB;
    r2 = r1 + T1*r2from1;
    r3 = r2 + T2*r3from2;
    
    Base_v=repmat(rB,1,length(Base))+Base';
    Turret_v=repmat(r1,1,length(Turret))+T1*Turret';
    Link2_v=repmat(r2,1,length(Link2))+T2*Link2';
    Link3_v=repmat(r3,1,length(Link3))+T3*Link3';

    patch('Faces',Base_f,'Vertices',Base_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
    patch('Faces',Turret_f,'Vertices',Turret_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
    patch('Faces',Link2_f,'Vertices',Link2_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
    patch('Faces',Link3_f,'Vertices',Link3_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

    axis equal
    camlight left
    set(gca,'projection','perspective')
    view([1;1;.5])
    axis([-1 1 -1 1 0 1]);
    hold off;
end
