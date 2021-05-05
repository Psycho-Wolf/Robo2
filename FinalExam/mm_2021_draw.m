function mm_2021_draw(gamma)

% NOTATION INFORMATION
% Vectors are defined as r_a_b
% where a is the starting frame of the vector
% and b is the ending from of the vector.
% All variables are definied with respect to the link number first
% then whether it is refeing to the left or right portion of the robot

% If on desktop:
addpath('D:\GitHub\Robo2\FinalExam\mm_2021');
addpath('D:\GitHUB\Robo2Lab\UsefulFNs');
% If on surface:
% addpath('C:\GitHUB\Robo2Lab\UsefulFNs');
% addpath('C:\GitHub\Robo2\FinalExam\mm_2021');

%% Gamma
x = gamma(1);
y = gamma(2);
psi = gamma(3);
theta_R = gamma(4);
theta_L = gamma(5);
theta_1 = gamma(6);
theta_2R = gamma(7);
theta_3R = gamma(8);
theta_4R = gamma(9);
theta_5R = gamma(10);
theta_6R = gamma(11);
theta_2L = gamma(12);
theta_3L = gamma(13);
theta_4L = gamma(14);
theta_5L = gamma(15);
theta_6L = gamma(16);

%% Floor definition
% Floor_v = [-3 3 0;...
%     3 3 0;...
%     -3 -3 0;...
%     3 -3 0];
% Floor_f = [1 2 4 3];
% 
% patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor',[0 0 .8],'FaceAlpha',.5);
% hold on
% set(gcf,'Position',[50, 50, 950, 900])

%% Import of STLs
[Chassis,Chassis_f,n,c]   = stlread('mm_2021_chassis.STL');
[WheelR,WheelR_f,n,c] = stlread('mm_2021_right_wheel.STL');
[WheelL,WheelL_f,n,c] = stlread('mm_2021_left_wheel.STL');
[Link1,Link1_f,n,c] = stlread('mm_2021_Link_1.STL');
[Link2R,Link2R_f,n,c] = stlread('mm_2021_right_Link_2.STL');
[Link3R,Link3R_f,n,c] = stlread('mm_2021_right_Link_3.STL');
[Link4R,Link4R_f,n,c] = stlread('mm_2021_right_Link_4.STL');
[Link5R,Link5R_f,n,c] = stlread('mm_2021_right_Link_5.STL');
[Link6R,Link6R_f,n,c] = stlread('mm_2021_right_Link_6.STL');
[Link2L,Link2L_f,n,c] = stlread('mm_2021_left_Link_2.STL');
[Link3L,Link3L_f,n,c] = stlread('mm_2021_left_Link_3.STL');
[Link4L,Link4L_f,n,c] = stlread('mm_2021_left_Link_4.STL');
[Link5L,Link5L_f,n,c] = stlread('mm_2021_left_Link_5.STL');
[Link6L,Link6L_f,n,c] = stlread('mm_2021_left_Link_6.STL');

%% System vectors
r_C_R = [0;-.381;0];
r_C_L = [0;.381;0];
r_C_1 = [-.1778;.00129706;.2794];
r_1_2R = [0; -.2032; .0762];
r_2R_3R = [.0762;-.0762;0];
r_3R_4R = [.2032; .0508; 0];
r_4R_5R = [.2286;0;0];
r_5R_6R = [.1524;0;0];
r_6R_ER = [.1178;.0508;0];

r_1_2L = [0;.2032;.0762];
r_2L_3L = [.0762;.0762;0];
r_3L_4L = [.2032;-.0508;0];
r_4L_5L = [.2286;0;0];
r_5L_6L = [.1524;0;0];
r_6L_EL = [.1178;-.0508;0];

%% FK DCMs

BTC = rotzRad(psi);

TR = BTC*rotyRad(theta_R);
TL = BTC*rotyRad(theta_L);

T1 = BTC*rotzRad(theta_1);
T2R = T1*rotyRad(theta_2R);
T3R = T2R*rotxRad(theta_3R);
T4R = T3R*rotyRad(theta_4R);
T5R = T4R*rotyRad(theta_5R);
T6R = T5R*rotyRad(theta_6R);

T2L = T1*rotyRad(theta_2L);
T3L = T2L*rotxRad(theta_3L);
T4L = T3L*rotyRad(theta_4L);
T5L = T4L*rotyRad(theta_5L);
T6L = T5L*rotyRad(theta_6L);

%% FK Vectors
r_B_C = [x;y;.3048/2];
r_B_R = r_B_C + TR*r_C_R;
r_B_L = r_B_C + TL*r_C_L;

r_B_1 = r_B_C + BTC*r_C_1;

r_B_2R = r_B_1 + T1*r_1_2R;
r_B_3R = r_B_2R + T2R*r_2R_3R;
r_B_4R = r_B_3R + T3R*r_3R_4R;
r_B_5R = r_B_4R + T4R*r_4R_5R;
r_B_6R = r_B_5R + T5R*r_5R_6R;

r_B_2L = r_B_1 + T1*r_1_2L;
r_B_3L = r_B_2L + T2L*r_2L_3L;
r_B_4L = r_B_3L + T3L*r_3L_4L;
r_B_5L = r_B_4L + T4L*r_4L_5L;
r_B_6L = r_B_5L + T5L*r_5L_6L;

%% STL building of the robot
Chassis_v=repmat(r_B_C,1,length(Chassis))+BTC*Chassis';
WheelR_v=repmat(r_B_R,1,length(WheelR))+TR*WheelR';
WheelL_v=repmat(r_B_L,1,length(WheelL))+TL*WheelL';

Link1_v=repmat(r_B_1,1,length(Link1))+T1*Link1';

Link2R_v=repmat(r_B_2R,1,length(Link2R))+T2R*Link2R';
Link3R_v=repmat(r_B_3R,1,length(Link3R))+T3R*Link3R';
Link4R_v=repmat(r_B_4R,1,length(Link4R))+T4R*Link4R';
Link5R_v=repmat(r_B_5R,1,length(Link5R))+T5R*Link5R';
Link6R_v=repmat(r_B_6R,1,length(Link6R))+T6R*Link6R';

Link2L_v=repmat(r_B_2L,1,length(Link2L))+T2L*Link2L';
Link3L_v=repmat(r_B_3L,1,length(Link3L))+T3L*Link3L';
Link4L_v=repmat(r_B_4L,1,length(Link4L))+T4L*Link4L';
Link5L_v=repmat(r_B_5L,1,length(Link5L))+T5L*Link5L';
Link6L_v=repmat(r_B_6L,1,length(Link6L))+T6L*Link6L';

%% Patching the STL files
patch('Faces',Chassis_f,'Vertices',Chassis_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',WheelR_f,'Vertices',WheelR_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',WheelL_f,'Vertices',WheelL_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

patch('Faces',Link1_f,'Vertices',Link1_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

patch('Faces',Link2R_f,'Vertices',Link2R_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link3R_f,'Vertices',Link3R_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link4R_f,'Vertices',Link4R_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link5R_f,'Vertices',Link5R_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link6R_f,'Vertices',Link6R_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

patch('Faces',Link2L_f,'Vertices',Link2L_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link3L_f,'Vertices',Link3L_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link4L_f,'Vertices',Link4L_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link5L_f,'Vertices',Link5L_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);
patch('Faces',Link6L_f,'Vertices',Link6L_v','EdgeColor','None','FaceColor',[.792157 .819608 .933333]);

%% Drawing the robot
axis equal
camlight left
set(gca,'projection','perspective')
view([1;1;.5])
% view([0;0;1])
axis([-1.5 1.5 -1.5 1.5 0 1.5]);
hold off;