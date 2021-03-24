function bdot = ModNabila(b,F)

bdot = zeros(6,1);
theta1 = b(1);
theta2 = b(2);
theta3 = b(3);
dottheta1 = b(4);
dottheta2 = b(5);
dottheta3 = b(6);
H =[0.3554*cos(2*theta2) - 1.0000e-07*sin(2*theta2) + 0.1293*cos(theta3) + 0.1293*cos(2*theta2 - 1*theta3) + 0.0260*cos(2*theta2 - 2*theta3) + 0.4649*cos(theta2)^2 + 0.6690, 0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3), 1.8326e-05*sin(theta2 - 1*theta3);...
                                                                                                                  0.2935*sin(theta2) - 1.8326e-05*sin(theta2 - 1*theta3),                            0.2586*cos(theta3) + 1.2454,     - 0.1293*cos(theta3) - 0.0552;...
                                                                                                                                       1.8326e-05*sin(theta2 - 1*theta3),                          - 0.1293*cos(theta3) - 0.0552,                            0.0552];                                                                                                                                   
d = [0.2935*dottheta2^2*cos(theta2) - 1.8326e-05*dottheta3^2*cos(theta2 - theta3) - 1.8326e-05*dottheta2^2*cos(theta2 - theta3) - 0.1293*dottheta1*dottheta3*sin(theta3) + 3.6653e-05*dottheta2*dottheta3*cos(theta2 - theta3) - 2.0000e-07*dottheta1*dottheta2*cos(2*theta2) - 1.1757*dottheta1*dottheta2*sin(2*theta2) - 0.2586*dottheta1*dottheta2*sin(2*theta2 - theta3) - 0.0519*dottheta1*dottheta2*sin(2*theta2 - 2*theta3) + 0.1293*dottheta1*dottheta3*sin(2*theta2 - theta3) + 0.0519*dottheta1*dottheta3*sin(2*theta2 - 2*theta3);...
                                                                                                                                                                                                                                                                                            0.1293*dottheta3^2*sin(theta3) + 1.0000e-07*dottheta1^2*cos(2*theta2) + 0.5879*dottheta1^2*sin(2*theta2) + 0.1293*dottheta1^2*sin(2*theta2 - theta3) + 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3) - 0.2586*dottheta2*dottheta3*sin(theta3);...
                                                                                                                                                                                                                                                                                                                                                                              0.0647*dottheta1^2*sin(theta3) + 0.1293*dottheta2^2*sin(theta3) - 0.0647*dottheta1^2*sin(2*theta2 - theta3) - 0.0260*dottheta1^2*sin(2*theta2 - 2*theta3)];
G = [0;- 2.5889*cos(theta2 - 1*theta3) - 27.9322*cos(theta2);2.5889*cos(theta2 - 1*theta3)];

bdot(1:3)=b(4:6);
bdot(4:6) = H\(F-d-G);
end
 