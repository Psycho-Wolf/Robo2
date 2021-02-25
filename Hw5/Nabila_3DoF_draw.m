function Nabila_3DoF_draw(gamma)

theta1 = gamma(1);
theta2 = gamma(2);
theta3 = gamma(3);

h = clf(gcf);

Floor_v = [-1 1 0;...
    1 1 0;...
    -1 -1 0;...
    1 -1 0];
Floor_f = [1 2 4 3];

patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor',[0 0 .8],'FaceAlpha',.5);
hold on
set(gcf,'Position',[50, 50, 950, 900])

[Base,Base_f,n,c,stltitle]   = stlread('Nabila_3DoF_Base.stl');
[Link1,Link1_f,n,c,stltitle] = stlread('Nabila_3DoF_Link1.stl');
[Link2,Link2_f,n,c,stltitle] = stlread('Nabila_3DoF_Link2.stl');
[Link3,Link3_f,n,c,stltitle] = stlread('Nabila_3DoF_Link3.stl');

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

Base_v=repmat(rB,1,length(Base))+Base';
Link1_v=repmat(r1,1,length(Link1))+T1*Link1';
Link2_v=repmat(r2,1,length(Link2))+T2*Link2';
Link3_v=repmat(r3,1,length(Link3))+T3*Link3';

patch('Faces',Base_f,'Vertices',Base_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link1_f,'Vertices',Link1_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link2_f,'Vertices',Link2_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link3_f,'Vertices',Link3_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

axis equal
camlight left
set(gca,'projection','perspective')
view([1;1;.5])
axis([-1 1 -1 1 0 1]);
hold off;