clear all
close all
clc

h=0.001;
t=0:h:5;

b = zeros(6,length(t)); 
V = zeros(3,length(t));
F = zeros(3,length(t));

b(:,1)=[ 0;...  
         0;...  
         0;...  
         0;...  
         0;...  
         0];
V(1,:)=12*ones(1,length(t)); 
V(2,:)=12*ones(1,length(t));
V(3,:)=12*ones(1,length(t));


for i=1:length(t)-1
 k1=spherical_robot(b(:,i),V(:,i),F(:,i));
 k2=spherical_robot(b(:,i)+k1*h/2,V(:,i),F(:,i));
 k3=spherical_robot(b(:,i)+k2*h/2,V(:,i),F(:,i));
 k4=spherical_robot(b(:,i)+k3*h,V(:,i),F(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end


figure
subplot(3,2,1)
plot(t,b(1,:),'r')
subplot(3,2,2)
plot(t,c(1,:),'k')
xlabel('t (s)')
ylabel('\theta_1 (rad)')

subplot(3,2,3)
plot(t,b(2,:),'r')
subplot(3,2,4)
plot(t,c(2,:),'k')
xlabel('t (s)')
ylabel('\theta_2 (rad)')

subplot(3,2,5)
plot(t,b(3,:),'r')
subplot(3,2,6)
plot(t,c(3,:),'k')
xlabel('t (s)')
ylabel('\theta_3 (rad)')

figure
subplot(3,1,1)
plot(t,c(7,:))

subplot(3,1,2)
plot(t,c(8,:))

subplot(3,1,3)
plot(t,c(9,:))

% figure
% v=VideoWriter('Nabila_HW6.avi');
% set(v,'FrameRate',20); 
% open(v);
% for i=1:round(1/(20*h)):length(t)
%  Nabila_3DoF_draw(b(:,i));
%  drawnow
%  frame=getframe(gcf);
%  writeVideo(v,frame);
%     if i ~= length(t)
%         cla(gca)
%     end 
% end
% 
% close(v);