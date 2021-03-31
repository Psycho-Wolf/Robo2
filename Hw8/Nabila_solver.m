%% Clear and close
clear all
close all
clc

%% Initilizations

h=0.001;
Ts = .005;
t=0:h:5;
e_last = [0;0;0];
eint = [0;0;0];
gammad = [pi/2;pi/2;pi/2];

b=zeros(6,length(t)); 
V=zeros(3,length(t));
b(:,1)=[ 0;...  
         0;...  
         0;...  
         0;...  
         0;...  
         0];

V(1,:)=12*ones(1,length(t)); 
V(2,:)=12*ones(1,length(t));
V(3,:)=12*ones(1,length(t));

%% Controllers Inits
% Kp = 10*eye(3);
% Kd = 0*eye(3);
% Ki = diag([1;1;1]);

%% Controller and RK
T_last = -Ts;
for i=1:length(t)-1
    if t(i) - T_last >= Ts
        e = gammad - b(1:3,i);
        edot = (e-e_last)/Ts;
        eint = eint+e*Ts;
        Volt = PIDG_nabila(e,edot,eint,(gammad-e));
        e_last = e;
        T_last = t(i);
    end
    V(:,i) = Volt;
    k1=Nablia_motor_F(b(:,i),V(:,i));
    k2=Nablia_motor_F(b(:,i)+k1*h/2,V(:,i));
    k3=Nablia_motor_F(b(:,i)+k2*h/2,V(:,i));
    k4=Nablia_motor_F(b(:,i)+k3*h,V(:,i));
    b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

%% Graphins and Ploting

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
ylabel('\theta_3 (rad)')

% figure
% v=VideoWriter('Nabila_HW6.avi');
% set(v,'FrameRate',20); 
% open(v);
% 
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