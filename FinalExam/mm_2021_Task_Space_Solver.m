%mm_2021_solver
clear all
close all
clc
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
F(1,:)=.01*ones(1,length(t));
F(2,:)=.01*ones(1,length(t));
F(3,:)=.01*ones(1,length(t));
F(4,:)=.01*ones(1,length(t));
F(5,:)=.01*ones(1,length(t));
F(6,:)=.01*ones(1,length(t));
F(7,:)=.01*ones(1,length(t));
F(8,:)=.01*ones(1,length(t));
F(9,:)=.01*ones(1,length(t));
F(10,:)=.01*ones(1,length(t));
F(11,:)=.01*ones(1,length(t));
F(12,:)=.01*ones(1,length(t));
F(13,:)=.01*ones(1,length(t));

%% RK Loop
for i=1:length(t)-1
 k1=mm_2021(b(:,i),F(:,i));
 k2=mm_2021(b(:,i)+k1*h/2,F(:,i));
 k3=mm_2021(b(:,i)+k2*h/2,F(:,i));
 k4=mm_2021(b(:,i)+k3*h,F(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

%% Data Plotting

figure
subplot(5,1,1)
plot(t,b(1,:))
xlabel('t (s)')
ylabel('x ')

subplot(5,1,2)
plot(t,b(2,:))
xlabel('t (s)')
ylabel('y)')

subplot(5,1,3)
plot(t,b(3,:))
xlabel('t (s)')
ylabel('z')

subplot(5,1,4)
plot(t,b(4,:))
xlabel('t (s)')
ylabel('r6')

subplot(5,1,5)
plot(t,b(5,:))
xlabel('t (s)')
ylabel('l6')

%% ---Animation---
figure
v=VideoWriter('mm_2021.avi'); %create a video object – this will be stored as dri_planar.avi
set(v,'FrameRate',20); %set the frame rate to 20 FPS
open(v); %open the video
for i=1:round(1/(20*h)):length(t) %20 frames per second
 mm_2021_draw(b(:,i));
 drawnow
 frame=getframe(gcf); %store the current figure window as a frame
 writeVideo(v,frame); %write that frame to the video
    if i ~= length(t)
        cla(gca)
    end 
end




