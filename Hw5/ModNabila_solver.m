%Nabila_solver
clear all
close all
clc
h=0.001; %simulation time step
t=0:h:5; %time array
b=zeros(6,length(t)); %initialize state vector
V=zeros(3,length(t)); %initialize generalized force vector
b(:,1)=[0;... %initial theta1
 0;... %initial theta2
 0;...%initial theta3
 0;... %initial dottheta1
 0;... %initial dottheta2
 0];%initial dottheta3

V(1,:)=12*ones(1,length(t)); %0.01 nm torque applied to link 1
V(2,:)=12*ones(1,length(t)); %0.005 nm torque applied to link 2
V(3,:)=12*ones(1,length(t));

%---Solve Equations of Motion---
for i=1:length(t)-1
 k1=Nabila_Motor_woL(b(:,i),V(:,i));
 k2=Nabila_Motor_woL(b(:,i)+k1*h/2,V(:,i));
 k3=Nabila_Motor_woL(b(:,i)+k2*h/2,V(:,i));
 k4=Nabila_Motor_woL(b(:,i)+k3*h,V(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end
%---Data Plotting---
figure
subplot(3,1,1)
plot(t,b(1,:))
xlabel('t (s)')
ylabel('\theta_1 (rad)')
subplot(3,1,2)
plot(t,b(2,:))
xlabel('t (s)')
ylabel('\theta_2 (rad)')
subplot(3,1,3)
plot(t,b(3,:))
xlabel('t (s)')
ylabel('\theta_3 (rad)')
%---Animation---
figure
v=VideoWriter('Nabila.avi'); %create a video object – this will be stored as dri_planar.avi
set(v,'FrameRate',20); %set the frame rate to 20 FPS
open(v); %open the video
for i=1:round(1/(20*h)):length(t) %20 frames per second
 Nabila_3DoF_draw(b(:,i));
 drawnow
 frame=getframe(gcf); %store the current figure window as a frame
 writeVideo(v,frame); %write that frame to the video
    if i ~= length(t)
        cla(gca)
    end 
end

close(v); %close the video