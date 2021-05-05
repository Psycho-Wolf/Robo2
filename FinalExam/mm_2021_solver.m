%mm_2021_solver
clear all
close all
clc
fprintf('Initializing\n');
h=0.001; %simulation time step
t=0:h:5; %time array
b=zeros(29,length(t)); %initialize state vector
%% B Vector
b(:,1)=[0;... 
        0;... 
        0;...
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;... 
        0;...
        0;... 
        0;... 
        0;... 
        0;... 
        0];
%% F Vector
F=zeros(13,length(t)); %initialize generalized force vector
F(1,:)=.1*ones(1,length(t));
F(2,:)=.1*ones(1,length(t));
F(3,:)=.1*ones(1,length(t));
F(4,:)=.1*ones(1,length(t));
F(5,:)=.1*ones(1,length(t));
F(6,:)=.1*ones(1,length(t));
F(7,:)=.1*ones(1,length(t));
F(8,:)=.1*ones(1,length(t));
F(9,:)=.1*ones(1,length(t));
F(10,:)=.1*ones(1,length(t));
F(11,:)=.1*ones(1,length(t));
F(12,:)=.1*ones(1,length(t));
F(13,:)=.1*ones(1,length(t));
fprintf('Initializations complete\n');
fprintf('Running RK loop...\n');

%% RK Loop
for i=1:length(t)-1
 k1=mm_2021(b(:,i),F(:,i));
 k2=mm_2021(b(:,i)+k1*h/2,F(:,i));
 k3=mm_2021(b(:,i)+k2*h/2,F(:,i));
 k4=mm_2021(b(:,i)+k3*h,F(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end
fprintf('RK loop over\n');

%% Data Plotting
fprintf('Processing data\n');
for i = 1:length(t)
    
    rIE(:,i) = mm_2021_FK(b(:,i));
end
fprintf('Plotting\n');

figure
title('Mobile Robot X,Y,\Psi')
subplot(3,1,1)
plot(t,b(1,:))
xlabel('t (s)')
ylabel('x ')

subplot(3,1,2)
plot(t,b(2,:))
xlabel('t (s)')
ylabel('y)')

subplot(3,1,3)
plot(t,b(3,:))
xlabel('t (s)')
ylabel('\psi')

figure
title('Left & Right End Effector Positions')

subplot(6,1,1)
plot(t,rIE(1,:))
xlabel('t (s)')
ylabel('xR ')

subplot(6,1,2)
plot(t,rIE(2,:))
xlabel('t (s)')
ylabel('yR)')

subplot(6,1,3)
plot(t,rIE(3,:))
xlabel('t (s)')
ylabel('zR')

subplot(6,1,4)
plot(t,rIE(4,:))
xlabel('t (s)')
ylabel('xL')

subplot(6,1,5)
plot(t,rIE(5,:))
xlabel('t (s)')
ylabel('yL')

subplot(6,1,6)
plot(t,rIE(6,:))
xlabel('t (s)')
ylabel('zR')


%% ---Animation---
% figure
% v=VideoWriter('mm_2021.avi'); %create a video object – this will be stored as dri_planar.avi
% set(v,'FrameRate',20); %set the frame rate to 20 FPS
% open(v); %open the video
% for i=1:round(1/(20*h)):length(t) %20 frames per second
%  mm_2021_draw(b(:,i));
%  drawnow
%  frame=getframe(gcf); %store the current figure window as a frame
%  writeVideo(v,frame); %write that frame to the video
%     if i ~= length(t)
%         cla(gca)
%     end 
% end




