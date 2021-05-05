%Nabila_solver
clear
close
clc
h=0.001; %simulation time step
t=0:h:15; %time array
b=zeros(29,length(t)); %initialize state vector
Fu=zeros(13,length(t)); %initialize generalized force vector
b(:,1)=zeros(29,1);
b1=zeros(29,length(t));
 
%CAHNGE THESE TO REFLECT A SPECIFIC GAMMA VECTOR IN YOUR DRAW FUNCTION
%MAKE SURE THAT THE FIRST FIVE ENTRIES INTO GAMMA ARE ZERO!!!
% IIrr6d = [-0.2257; 0.0326; 0.1961];
% IIrl6d = [-0.6979 0.1292 0.1081]';

IIrr6d = [-0.0516; -0.2011; 0.9088];
IIrl6d = [.1701 0.3443 1.0104]';

Kp = diag([0,0,0,23,45,22]);
Kd = diag(3*[10,10,10,15,15,20]);
Kpl = diag([0,0,0,20,43,46]);
Kdl = diag(3*[10,10,10,10,20,22]);
% Kpl = 20;
% Kdl = 50;
IIrr6 = zeros(3,length(t));
IIrl6 = zeros(3,length(t));
Ts=0.005; %controller sampling time –> this should be larger than the simulation sampling time.
T_last=-Ts;
for i=1:length(t)-1
 
 [IIrr6(:,i),IIrl6(:,i)] = mm_2021_FK(b(1:16,i));
 [Jer6,Jel6,M,N,G,JDOTl6,JDOTr6,IIrDr6,IIrDl6,gammadot,delf] = mm_2021_J(b(:,i));
 
 if mod(i,2) == 1
    F=M*((delf.'*Jer6.')*(Kpl*[0;0;0;IIrr6d - IIrr6(:,i)]+Kdl*[0;0;0;-IIrDr6]-JDOTr6*gammadot))-G+N;
 else
    F = M*((delf.'*Jel6.')*(Kp*[0;0;0;IIrl6d - IIrl6(:,i)]+Kd*[0;0;0;-IIrDl6]-JDOTl6*gammadot))-G+N;
 
 
 T_last=t(i);
 end
%keep using the old voltage until a new one is computed
%   Fu(9:13,i) = FL(9:13,1);
%---Solve Equations of Motion---
 k1=mm_2021(b(:,i),F);
 k2=mm_2021(b(:,i)+k1*h/2,F);
 k3=mm_2021(b(:,i)+k2*h/2,F);
 k4=mm_2021(b(:,i)+k3*h,F);
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
 
 end
 
for i = 1:length(t)
    [IIrr6(:,i),IIrl6(:,i)] = mm_2021_FK(b(:,i));
end 
% ---Data Plotting---
figure
subplot(3,1,1)
plot(t,IIrr6(1,:),t,IIrr6d(1)*ones(1,length(t)))
title('Computed Torque Jacobian controller right side')
xlabel('t (s)')
ylabel('x (m)')
subplot(3,1,2)
plot(t,IIrr6(2,:),t,IIrr6d(2)*ones(1,length(t)))
xlabel('t (s)')
ylabel('Y (m)')
subplot(3,1,3)
plot(t,IIrr6(3,:),t,IIrr6d(3)*ones(1,length(t)))
xlabel('t (s)')
ylabel('Z (m)')

figure
subplot(3,1,1)
plot(t,IIrl6(1,:),t,IIrl6d(1)*ones(1,length(t)))
title('Computed Torque Jacobian controller left side')
xlabel('t (s)')
ylabel('x (m)')
subplot(3,1,2)
plot(t,IIrl6(2,:),t,IIrl6d(2)*ones(1,length(t)))
xlabel('t (s)')
ylabel('Y (m)')
subplot(3,1,3)
plot(t,IIrl6(3,:),t,IIrl6d(3)*ones(1,length(t)))
xlabel('t (s)')
ylabel('Z (m)')

% ---Animation---
figure
v=VideoWriter('mm_2021_controller.avi'); %create a video object – this will be stored as dri_planar.avi
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

close(v); %close the video
