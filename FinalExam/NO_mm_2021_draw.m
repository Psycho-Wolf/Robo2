function [IIrE, ITE, IqE] = mm_2021_draw(gamma)
cla(gca)

x = gamma(1);
y = gamma(2);
psi = gamma(3);
theta_rw = gamma(4);
theta_lw = gamma(5);
theta_1 = gamma(6);
theta_r2 = gamma(7);
theta_r3 = gamma(8);
theta_r4 = gamma(9);
theta_r5 = gamma(10);
theta_r6 = gamma(11);
theta_l2 = gamma(12);
theta_l3 = gamma(13);
theta_l4 = gamma(14);
theta_l5 = gamma(15);
theta_l6 = gamma(16);

initial_r = [x;y;0];
ITC = rotzRad(psi);
rwrwrI = initial_r*ITC*[0;-0.381;0];
lwlwrI = initial_r*ITC*[0;0.381;0];
CCr1 = [-0.1778;0.00129706; 0.2794];
oneonerr2 = [0;-0.2032;0.0762];
oneoneTr2 = rotyRad(theta_r2);
oneonerl2 = [0;0.2032;0.0762];
oneoneTl2 - rotyRad(theta_l2);
r2r2rr3 = [0.0762; -0.0762;0];
r2r2Tr3 = rotxRad(theta_r3);
l2l2rl3 = [0.0762; 0.0762;0];
l2l2Tl3 = rotxRad(theta_l3);
r3r3rr4 = [0.2032;0.0508;0];
r3r3Tr4 - rotyRad(theta_r4);
l3l3rl4 = [0.2032;-0.0508;0];
l3l3Rl4 = rotyRad(theta_l4);
r4r4rr5 = [0.2286;0;0];
r4r4Tr5 = rotyRad(theta_r5);
l4l4rl5 = [0.2286;0;0];
l4l4Tl5 = rotyRad(theta_l5);
r5r5rr6 = [0.1524;0;0];
r5r5Tr6 = rotyRad(theta_r6);
l5l5rl6 = [0.1524;0;0];
l5l5Tl6 = rotyRad(theta_l6);
r6r6rrE = [0.1778;0.0508;0];
l6l6rlE = [0.1778;-0.0508;0];


[chassis_vertices_in_C, base_faces, n, c, stltitle] = stlread('mm_2021_chassis.STL');
[rw_vertices_in_rw, rw_faces, n, c, stltitle] = stlread('mm_2021_right_wheel.STL');
[lw_vertices_in_lw, lw_faces, n, c, stltitle] = stlread('mm_2021_left_wheel.STL');
[link1_vertices_in_1, link1_faces, n, c, stltitle] = stlread('mm_2021_Link_1.STL');
[linkr2_vertices_in_2, linkr2_faces, n, c, stltitle] = stlread('mm_2021_right_Link_2.STL');
[linkr3_vertices_in_3, linkr3_faces, n, c, stltitle] = stlread('mm_2021_right_Link_3.STL');
[linkr4_vertices_in_4, linkr4_faces, n, c, stltitle] = stlread('mm_2021_right_Link_4.STL');
[linkr5_vertices_in_5, linkr5_faces, n, c, stltitle] = stlread('mm_2021_right_Link_5.STL');
[linkr6_vertices_in_6, linkr6_faces, n, c, stltitle] = stlread('mm_2021_right_Link_6.STL');
[linkl2_vertices_in_2, linkl2_faces, n, c, stltitle] = stlread('mm_2021_left_Link_2.STL');
[linkl3_vertices_in_3, linkl3_faces, n, c, stltitle] = stlread('mm_2021_left_Link_3.STL');
[linkl4_vertices_in_4, linkl4_faces, n, c, stltitle] = stlread('mm_2021_left_Link_4.STL');
[linkl5_vertices_in_5, linkl5_faces, n, c, stltitle] = stlread('mm_2021_left_Link_5.STL');
[linkl6_vertices_in_6, linkl6_faces, n, c, stltitle] = stlread('mm_2021_left_Link_6.STL');


IIr2=IIr1+IT1*oneoner2;
IT2=IT1*oneT2;
IIr3=IIr2+IT2*twotwor3;
IT3=IT2*twoT3;
IIr4=IIr3+IT3*threethreer4;
IT4=IT3*threeT4;
IIr5=IIr4+IT4*fourfourr5;
IT5=IT4*fourT5;

IIrE=IIr5+IT5*fivefiverE;
ITE=IT5*fiveTE;

link1_vertices_in_I=IIr1+IT1*link1_vertices_in_1';
link2_vertices_in_I=IIr2+IT2*link2_vertices_in_2';
link3_vertices_in_I=IIr3+IT3*link3_vertices_in_3';
link4_vertices_in_I=IIr4+IT4*link4_vertices_in_4';
link5_vertices_in_I=IIr5+IT5*link5_vertices_in_5';
grip_vertices_in_I=IIrE+ITE*grip_vertices_in_6';

p1=patch('Faces',base_faces,'Vertices',chassis_vertices_in_I,'EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p2=patch('Faces',link1_faces,'Vertices',link1_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p3=patch('Faces',link2_faces,'Vertices',link2_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p4=patch('Faces',link3_faces,'Vertices',link3_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p5=patch('Faces',link4_faces,'Vertices',link4_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p6=patch('Faces',link5_faces,'Vertices',link5_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);
p7=patch('Faces',grip_faces,'Vertices',grip_vertices_in_I','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);


axis equal
camlight left
set(gca,'projection','perspective')
view([1;1;.5])
%axis([-1 1 -1 1 -1 1]) 
h=[p1];
xlabel('x')
ylabel('y')
zlabel('z')