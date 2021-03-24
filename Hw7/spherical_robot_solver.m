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
V(1,:)=5*ones(1,length(t)); 
V(2,:)=5*ones(1,length(t));
V(3,:)=5*ones(1,length(t));

F(1,:)=10*ones(1,length(t)); 
F(2,:)=10*ones(1,length(t));
F(3,:)=10*ones(1,length(t));

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
xlabel('t (s)')
ylabel('\theta_1 (rad)')

subplot(3,2,3)
plot(t,b(2,:),'r')
xlabel('t (s)')
ylabel('\theta_2 (rad)')

subplot(3,2,5)
plot(t,b(3,:),'r')
xlabel('t (s)')
ylabel('\d (m)')

figure
v=VideoWriter('POS.avi');
set(v,'FrameRate',20); 
open(v);
for i=1:round(1/(20*h)):length(t)
 spherical_robot_draw(b(:,i));
 drawnow
 frame=getframe(gcf);
 writeVideo(v,frame);
    if i ~= length(t)
        cla(gca)
    end 
end

close(v);