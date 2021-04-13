clear all
close all
clc
h=0.001; %simulation time step 
t=0:h:5; %time array

b=zeros(6,length(t)); %initialize state vector 
F=zeros(3,length(t)); %initialize generalized force vector 
b(:,1)=[pi/3;... %initial theta1
            pi/3;... %initial theta2 
            pi/3;... %initial theta3 
            0;... %initial dottheta1
            0;... %initial dottheta2 
            0]; %initial dottheta3
F(1,:)=0*ones(1,length(t)); %0.01 nm torque applied to link 1 
F(2,:)=0*ones(1,length(t)); %0.005 nm torque applied to link 2
F(3,:)=0*ones(1,length(t)); %0.001 nm torque applied to link 3

 %% Transposed Jacobian + Gravity

IIrED = [0.2;0.5;0.2];

Kp=350; %proportional gain
Kd=50; %derivative gain
IIrE=zeros(3,length(t));

e_last=[0;0;0]; %initialize so that derivative can be computed on first iteration of loop
eint=[0;0;0]; %initialize so that integral can be computed on first iteration of loop
Ts=0.005; %controller sampling time
T_last=-Ts;

for i=1:length(t)-1
        IIrE(1:3,i)=Nabila_FK(b(1:3,i));
if t(i)-T_last>=Ts
%    IIrE(1:3,i)=Nabila_FK(b(1:3,i));
    [H,d,G,JE,JE_dot]=NabilaHW9(b(:,i));

    dotIIrE = JE(4:6,1:3) * b(4:6,i);

    F=JE.'*(Kp*[0;0;0;IIrED - IIrE(1:3,i)] + Kd*[0;0;0; -dotIIrE]) + G;

  T_last=t(i);
end    
f(:,i)=F;

k1=Nabila(b(:,i),f(:,i));
k2=Nabila(b(:,i)+k1*h/2,f(:,i));
k3=Nabila(b(:,i)+k2*h/2,f(:,i));
k4=Nabila(b(:,i)+k3*h,f(:,i));
b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

% figure
% subplot(3,1,1)
% plot(t,IIrE(1,:))
% title('Transposed Jacobian + Gravity')
% xlabel('t (s)')
% ylabel('x (m)')
% subplot(3,1,2)
% plot(t,IIrE(2,:))
% xlabel('t (s)')
% ylabel('y (m)')
% subplot(3,1,3)
% plot(t,IIrE(3,:))
% xlabel('t (s)')
% ylabel('z (m)')

%% Inverse Jacobian + Gravity

IIrED = [0.2;0.5;0.2];

Kp=120; %proportional gain
Kd=10; %derivative gain
IIrE=zeros(3,length(t));

e_last=[0;0;0]; %initialize so that derivative can be computed on first iteration of loop
eint=[0;0;0]; %initialize so that integral can be computed on first iteration of loop
Ts=0.005; %controller sampling time
T_last=-Ts;

for i=1:length(t)-1
        IIrE(1:3,i)=Nabila_FK(b(1:3,i));
if t(i)-T_last>=Ts
%     IIrE(1:3,i)=Nabila_FK(b(1:3,i));
    [H,d,G,JE,JE_dot]=NabilaHW9(b(:,i));

    dotIIrE = JE(4:6,1:3) * b(4:6,i);

    F=Kp*pinv(JE)*[0;0;0;IIrED - IIrE(1:3,i)] - Kd*(b(4:6,i)) + G;

  T_last=t(i);
end    
f(:,i)=F;

k1=Nabila(b(:,i),f(:,i));
k2=Nabila(b(:,i)+k1*h/2,f(:,i));
k3=Nabila(b(:,i)+k2*h/2,f(:,i));
k4=Nabila(b(:,i)+k3*h,f(:,i));
b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

% figure
% subplot(3,1,1)
% plot(t,IIrE(1,:))
% title('Inverse Jacobian + Gravity')
% xlabel('t (s)')
% ylabel('x (m)')
% subplot(3,1,2)
% plot(t,IIrE(2,:))
% xlabel('t (s)')
% ylabel('y (m)')
% subplot(3,1,3)
% plot(t,IIrE(3,:))
% xlabel('t (s)')
% ylabel('z (m)')

%% Computed-Torque Task Space

 IIrED = [0.2;0.5;0.2];

Kp=100; %proportional gain 100
Kd=75; %derivative gain 30
IIrE=zeros(3,length(t));

e_last=[0;0;0]; %initialize so that derivative can be computed on first iteration of loop
eint=[0;0;0]; %initialize so that integral can be computed on first iteration of loop
Ts=0.005; %controller sampling time
T_last=-Ts;

for i=1:length(t)-1
    IIrE(1:3,i)=Nabila_FK(b(1:3,i));
    if t(i)-T_last>=Ts
%         IIrE(1:3,i)=Nabila_FK(b(1:3,i));
        [H,d,G,JE,JEdot]=NabilaHW9(b(:,i));

        dotIIrE = JE(4:6,1:3) * b(4:6,i);

        F=H*pinv(JE)*(Kp*[0;0;0;IIrED - IIrE(1:3,i)] - Kd*[0;0;0; dotIIrE] - JEdot*b(4:6,i)) + d + G;

      T_last=t(i);
    end    
    f(:,i)=F;

    k1=Nabila(b(:,i),f(:,i));
    k2=Nabila(b(:,i)+k1*h/2,f(:,i));
    k3=Nabila(b(:,i)+k2*h/2,f(:,i));
    k4=Nabila(b(:,i)+k3*h,f(:,i));
    b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

% figure
% subplot(3,1,1)
% plot(t,IIrE(1,:))
% title('Computed-Torque')
% xlabel('t (s)')
% ylabel('x (m)')
% subplot(3,1,2)
% plot(t,IIrE(2,:))
% xlabel('t (s)')
% ylabel('y (m)')
% subplot(3,1,3)
% plot(t,IIrE(3,:))
% xlabel('t (s)')
% ylabel('z (m)')

%% Joint-Space Trajectory Problem

gam = [cos(2*pi*0.2*t); cos(2*pi*0.3*t); cos(2*pi*0.5*t)];
gamd = [-(2*pi*sin((2*pi*t)/5))/5;   -(3*pi*sin((3*pi*t)/5))/5;    -pi*sin(pi*t)];
gamdd = [-(4*pi^2*cos((2*pi*t)/5))/25; -(9*pi^2*cos((3*pi*t)/5))/25; -pi^2*cos(pi*t)]; 

IIrE=zeros(3,length(t));
omega = 150; 
zeta = .5;

Ts=0.005; %controller sampling time
T_last=-Ts;

for i=1:length(t)-1
    if t(i)-T_last>=Ts
        IIrE(1:3,i)=Nabila_FK(b(1:3,i));
        [H,d,G,JE,JE_dot]=NabilaHW9(b(:,i));

        dotIIrE = JE(4:6,1:3) * b(4:6,i);

        F=H*(omega^2 * (gam(:,i)-b(1:3,i)) + 2*zeta*omega*(gamd(:,i) - b(4:6,i) + gamdd(:,i))) + d + G;

      T_last=t(i);
    end    
    f(:,i)=F;

    k1=Nabila(b(:,i),f(:,i));
    k2=Nabila(b(:,i)+k1*h/2,f(:,i));
    k3=Nabila(b(:,i)+k2*h/2,f(:,i));
    k4=Nabila(b(:,i)+k3*h,f(:,i));
    b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

% figure
% subplot(3,1,1)
% hold on;
% plot(t,b(1,:))
% plot(t,gam(1,:),'--')
% title('Joint Space')
% xlabel('t (s)')
% ylabel('\theta_1 (rad)')
% hold off;
% 
% subplot(3,1,2)
% hold on;
% plot(t,b(2,:))
% plot(t,gam(2,:),'--')
% xlabel('t (s)')
% ylabel('\theta_2 (rad)')
% hold off;
% 
% subplot(3,1,3)
% hold on;
% plot(t,b(3,:))
% plot(t,gam(3,:),'--')
% xlabel('t (s)')
% ylabel('\theta_3 (rad)')
% hold off;

%% Task-Space Trajectory
h=0.001; %simulation time step 
t=0:h:5; %time array

IIrD = [0.2+0.1*cos(2*pi*0.2*t);      0.5+0.1*sin(2*pi*0.2*t);        0.3+(t*0)];

dotIIrD = [-pi*sin((2*pi*t)/5)/25;         pi*cos((2*pi*t)/5)/25;         0+(t*0)];

ddotIIrD = [-2*pi^2*cos((2*pi*t)/5)/125;          -2*pi^2*sin((2*pi*t)/5)/125;        0+(t*0)];

IIrE=zeros(3,length(t));
omega = 150;
zeta = .5;

Ts=0.005; %controller sampling time
T_last=-Ts;

for i=1:length(t)-1
            IIrE(1:3,i)=Nabila_FK(b(1:3,i));
    if t(i)-T_last>=Ts

        [H,d,G,JE,JE_dot]=NabilaHW9(b(:,i));

        dotIIrE = JE(4:6,1:3) * b(4:6,i);

        F=H*(JE\(omega^2 * ([0;0;0;IIrD(:,i) - IIrE(1:3,i)]) + 2*zeta*omega*[0;0;0;dotIIrD(:,i) - dotIIrE] + [0;0;0;ddotIIrD(:,i)] - JE_dot * b(4:6,i))) + d + G;

      T_last=t(i);
    end    
    f(:,i)=F;

    k1=Nabila(b(:,i),f(:,i));
    k2=Nabila(b(:,i)+k1*h/2,f(:,i));
    k3=Nabila(b(:,i)+k2*h/2,f(:,i));
    k4=Nabila(b(:,i)+k3*h,f(:,i));
    b(:,i+1)=b(:,i)+h*(k1/6+k2/3+k3/3+k4/6);
end

figure
subplot(3,1,1)
hold on;
plot(t,IIrE(1,:))
plot(t,IIrD(1,:),'--')
title('Task Space')
xlabel('t (s)')
ylabel('\theta_1 (rad)')

subplot(3,1,2)
hold on;
plot(t,IIrE(2,:))
plot(t,IIrD(2,:),'--')
xlabel('t (s)')
ylabel('\theta_2 (rad)')

subplot(3,1,3)
hold on;
plot(t,IIrE(3,:))
plot(t,IIrD(3,:),'--')
xlabel('t (s)')
ylabel('\theta_3 (rad)')