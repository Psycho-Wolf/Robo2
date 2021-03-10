clear all;
close all;
clc

h = .01;
t = 0:h:10;

b=zeros(6,length(t));
F = zeros(3,length(t));
b(:,1) =   [0;...
            0;...
            0;...
            0;...
            0;...
            0];

 F(1,:) = 0*ones(1,length(t));
 F(2,:) = 0*ones(1,length(t));
 F(3,:) = 0*ones(1,length(t));

 for i = 1:length(t) - 1
     k1=Nabila(b(:,i),F(:,i));
     k2=Nabila(b(:,i)+k1*h/2,F(:,i));
     k3=Nabila(b(:,i)+k2*h/2,F(:,i));    
     k4=Nabila(b(:,i)+k3*h,F(:,i));
     b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6).';
 end
 
 figure
 subplot(2,1,1)
 plot(t,b(1,:))
 xlabel('t (s)')
 ylabel('\theta_1 (rad)')
 subplot(2,1,2)
 plot(t,b(2,:))
 xlabel('t (s)')
 ylabel('\theta_2 (rad)')
 
 figure
 v=VideoWriter('Nabila.avi');
 set(v,'FrameRate',20);
 open(v);
 for i=1:round(1/(20*h)):length(t)
     Nabila_3DoF_draw(b(:,i));
     drawnow;
     frame=getframe(gcf);
     writeVideo(v,frame);
 end
 close(v);