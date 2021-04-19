%% Clears
close all
clear all
clc
%% Inits
h = 0.005;
t = 0:h:10;
Ts = .005;

IqD = [ cos((pi/2)/2);
        0;
        sin((pi/2)/2);
        0];
IIrD = [1;1;1];

b = zeros(13,length(t));
b(:,1) = [0;... % w
          0;...
          0;...
          0;... % rdot
          0;...
          0;...
          1;... % q
          0;...
          0;...
          0;...
          0;... % r
          0;...
          0];
TF = [0*ones(1,length(t));...
      0*ones(1,length(t));...
      0*ones(1,length(t));...
      0*ones(1,length(t));...
      0*ones(1,length(t));...
      0*ones(1,length(t))];
%% Controller & RK  
T_last = -Ts;
for i=1:length(t)-1

    if t(i) - T_last >= Ts
        IqB = [b(7,i);b(8,i);b(9,i);b(10,i)];
        BqD = quatmult([IqB(1);-IqB(2:4)],IqD);
        Forces = PD_AUV(b(:,i),BqD,IIrD);
        T_last = t(i);
    end
    
    TF(:,i) = Forces;
    k1 = neEqQuat(b(:,i),TF(:,i));
    k2 = neEqQuat(b(:,i)+k1*h/2,TF(:,i));
    k3 = neEqQuat(b(:,i)+k2*h/2,TF(:,i));
    k4 = neEqQuat(b(:,i)+k3*h,TF(:,i));
    b(:,i+1) = b(:,i) + h*(k1/6 + k2/3 + k3/3 +k4/6);
end


for i = 1:5:length(b)
    draw_AUV(b(:,i));
    drawnow
end

%% Graphins and Ploting

figure
subplot(4,1,1)
plot(t,b(11,:),'r')
xlabel('t (s)')
ylabel('X Pos')

subplot(4,1,2)
plot(t,b(12,:),'r')
xlabel('t (s)')
ylabel('Y Pos')

subplot(4,1,3)
plot(t,b(13,:),'r')
xlabel('t (s)')
ylabel('Z Pos')

subplot(4,1,4)
plot(t,b(7,:),'r')
xlabel('t (s)')
ylabel('Real Quat')
