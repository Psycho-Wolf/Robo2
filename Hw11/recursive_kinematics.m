function [ITN,NwI,IrdotN,JN,JdotN] = recursive_kinematics(ITN1, N1wI, JN1, JdotN1, N1TN, N1rN, IhatN, ItildeN, gamma, gammadot)

ITN = ITN1*N1TN;
NwI = (IhatN*gammadot) + (N1TN')*N1wI;
IrdotN = (JN1(1:3,:) + ITN1*skew(N1rN)'*JN1(4:6,:) + ITN1*IhatN)*gamma;

JN = [N1TN' zeros(3); ITN1*skew(N1rN)' eye(3)]*JN1 + [IhatN; ITN1*ItildeN];

JdotN = [skew(IhatN*gammadot)'*(N1TN'), zeros(3); -ITN1*skew(N1wI)*skew(N1rN) - ITN1*skew(ItildeN*gammadot), zeros(3)]*JN1 +...
    [(N1TN'), zeros(3); -ITN1*skew(N1rN), eye(3)]*JdotN1 + [zeros(3,6); ITN1*skew(N1wI)*ItildeN];
    
end