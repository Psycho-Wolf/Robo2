clear all
close all
clc

h=0.001;
t=0:h:5;

b=zeros(6,length(t)); 
V=zeros(3,length(t));
b(:,1)=[ 0;...  
         0;...  
         0;...  
         0;...  
         0;...  
         0];

c=zeros(9,length(t)); 
c(:,1)=[ 0;...  
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
 k1=WorkingNabila_Motor_woL(b(:,i),V(:,i));
 k2=WorkingNabila_Motor_woL(b(:,i)+k1*h/2,V(:,i));
 k3=WorkingNabila_Motor_woL(b(:,i)+k2*h/2,V(:,i));
 k4=WorkingNabila_Motor_woL(b(:,i)+k3*h,V(:,i));
 b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

for i=1:length(t)-1
 k1=WorkingNabila_Motor_wL(c(:,i),V(:,i));
 k2=WorkingNabila_Motor_wL(c(:,i)+k1*h/2,V(:,i));
 k3=WorkingNabila_Motor_wL(c(:,i)+k2*h/2,V(:,i));
 k4=WorkingNabila_Motor_wL(c(:,i)+k3*h,V(:,i));
 c(:,i+1)=c(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
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
v=VideoWriter('Nabila_HW6.avi');
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