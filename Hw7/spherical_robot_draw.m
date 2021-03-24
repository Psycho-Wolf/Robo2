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

    [Base,Base_f,n,c,stltitle]   = stlread('Isenberg_Robot_Base.stl');
    [Link1,Link1_f,n,c,stltitle] = stlread('Isenberg_Robot_Link1.stl');
    [Link2,Link2_f,n,c,stltitle] = stlread('Isenberg_Robot_Link2.stl');
    
    rBfromI
    r1fromB
    r2from1

end
