%VP_6242_solver
clear all
close all
clc
h=0.001; %simulation time step
t=0:h:2.5; %time array
b=zeros(12,length(t)); %initialize state vector
F=zeros(6,length(t)); %initialize generalized force vector
b(:,1)=[0;... %initial theta1
 0;... %initial theta2
 0;...%initial theta3
 0;... %initial theta4
 0;... %initial theta5
 0;...%initial theta6
 0;... %initial dottheta1
 0;... %initial dottheta2
 0;...%initial dottheta3
 0;... %initial dottheta4
 0;... %initial dottheta5
 0];%initial dottheta6

F(1,:)=.01*ones(1,length(t)); %0.01 nm torque applied to link 1
F(2,:)=.005*ones(1,length(t)); %0.005 nm torque applied to link 2
F(3,:)=.005*ones(1,length(t));
F(4,:)=.01*ones(1,length(t));
F(5,:)=.005*ones(1,length(t));
F(6,:)=.005*ones(1,length(t));

%---Solve Equations of Motion---
for i=1:length(t)-1
 k1=VP_6242(b(:,i),F(:,i));
 k2=VP_6242(b(:,i)+k1*h/2,F(:,i));
 k3=VP_6242(b(:,i)+k2*h/2,F(:,i));
 k4=VP_6242(b(:,i)+k3*h,F(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

%---Data Plotting---
figure
subplot(6,1,1)
plot(t,b(1,:))
xlabel('t (s)')
ylabel('\theta_1 (rad)')
subplot(6,1,2)
plot(t,b(2,:))
xlabel('t (s)')
ylabel('\theta_2 (rad)')
subplot(6,1,3)
plot(t,b(3,:))
xlabel('t (s)')
ylabel('\theta_3 (rad)')
subplot(6,1,4)
plot(t,b(4,:))
xlabel('t (s)')
ylabel('\theta_4 (rad)')
subplot(6,1,5)
plot(t,b(5,:))
xlabel('t (s)')
ylabel('\theta_5 (rad)')
subplot(6,1,6)
plot(t,b(6,:))
xlabel('t (s)')
ylabel('\theta_6 (rad)')

%---Animation---
figure
v=VideoWriter('VP_6242.avi'); %create a video object – this will be stored as dri_planar.avi
set(v,'FrameRate',20); %set the frame rate to 20 FPS
open(v); %open the video
for i=1:round(1/(20*h)):length(t) %20 frames per second
 denso_vp_6242_draw(b(:,i));
 drawnow
 frame=getframe(gcf); %store the current figure window as a frame
 writeVideo(v,frame); %write that frame to the video
    if i ~= length(t)
        cla(gca)
    end 
end

close(v); %close the video