function denso_vp_6242_draw(gamma)

theta1 = gamma(1);
theta2 = gamma(2);
theta3 = gamma(3);
theta4 = gamma(4);
theta5 = gamma(5);
theta6 = gamma(6);

h = clf(gcf);

Floor_v = [-1 1 0;...
    1 1 0;...
    -1 -1 0;...
    1 -1 0];
Floor_f = [1 2 4 3];

patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor',[0 0 .8],'FaceAlpha',.5);
hold on
set(gcf,'Position',[50, 50, 950, 900])

[Base,Base_f,n,c,stltitle]   = stlread('Denso_6242_Base.stl');
[Link1,Link1_f,n,c,stltitle] = stlread('Denso_6242_Link1.stl');
[Link2,Link2_f,n,c,stltitle] = stlread('Denso_6242_Link2.stl');
[Link3,Link3_f,n,c,stltitle] = stlread('Denso_6242_Link3.stl');
[Link4,Link4_f,n,c,stltitle] = stlread('Denso_6242_Link4.stl');
[Link5,Link5_f,n,c,stltitle] = stlread('Denso_6242_Link5.stl');
[Gripper,Gripper_f,n,c,stltitle] = stlread('VP_6242_Gripper.stl');

rBfromI = [0;0;0];
r1fromB = [0;0;155];
r2from1 = [0;0;123.5];
r3from2 = [0;0;210];
r4from3 = [-75;0;86];
r5from4 = [125;0;0];
rEfrom5 = [70;0;0];
rGfromE = [0;0;0];

T1 = rotzRad(theta1);
T2=T1*rotyRad(theta2);
T3=T2*rotyRad(theta3);
T4=T3*rotyRad(-pi/2)*rotxRad(theta4);
T5=T4*rotyRad(theta5);
TE=T5*rotxRad(theta6);
TG = TE;

rB=rBfromI;
r1=rB+r1fromB;
r2=r1+T1*r2from1;
r3=r2+T2*r3from2;
r4=r3+T3*r4from3;
r5=r4+T4*r5from4;
rE=r5+T5*rEfrom5;
rG=rE+TE*rGfromE;

Base_v=repmat(rB,1,length(Base))+Base';
Link1_v=repmat(r1,1,length(Link1))+T1*Link1';
Link2_v=repmat(r2,1,length(Link2))+T2*Link2';
Link3_v=repmat(r3,1,length(Link3))+T3*Link3';
Link4_v=repmat(r4,1,length(Link4))+T4*Link4';
Link5_v=repmat(r5,1,length(Link5))+T5*Link5';
Gripper_v=repmat(rG,1,length(Gripper))+TG*Gripper';

patch('Faces',Base_f,'Vertices',Base_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link1_f,'Vertices',Link1_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link2_f,'Vertices',Link2_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link3_f,'Vertices',Link3_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link4_f,'Vertices',Link4_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link5_f,'Vertices',Link5_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Gripper_f,'Vertices',Gripper_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

axis equal
camlight left
set(gca,'projection','perspective')
view([1;1;.5])
axis([-500 500 -500 500 0 1000]);
hold off;