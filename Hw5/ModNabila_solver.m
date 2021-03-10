clear all
close all
clc

h=0.001;
t=0:h:5;

b=zeros(9,length(t)); 
V=zeros(3,length(t));
b(:,1)=[ 0;...  
         0;...  
         0;...  
         0;...  
         0;...  
         0;...  
         0.1;...  
         0.1;...  
         0.1];    

V(1,:)=12*ones(1,length(t)); 
V(2,:)=12*ones(1,length(t));
V(3,:)=12*ones(1,length(t));


for i=1:length(t)-1
 k1=Nabila_Motor_WL(b(:,i),V(:,i));
 k2=Nabila_Motor_WL(b(:,i)+k1*h/2,V(:,i));
 k3=Nabila_Motor_WL(b(:,i)+k2*h/2,V(:,i));
 k4=Nabila_Motor_WL(b(:,i)+k3*h,V(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

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

figure
v=VideoWriter('Nabila.avi');
set(v,'FrameRate',20); 
open(v);
for i=1:round(1/(20*h)):length(t)
 Nabila_3DoF_draw(b(:,i));
 drawnow
 frame=getframe(gcf);
 writeVideo(v,frame);
    if i ~= length(t)
        cla(gca)
    end 
end

close(v);