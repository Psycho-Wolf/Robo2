function [ITN,NwI,IrdotN,JN,JdotN] = recursive_kinematics(ITN1, N1wI, JN1, JdotN1, N1TN, N1rN, IhatN, ItildeN, gammadot)

ITN = ITN1*N1TN;
JN = [N1TN' zeros(3); ITN1*skew(N1rN)' eye(3)]*JN1 + [IhatN; ITN1*ItildeN];

temp = JN*gammadot;
NwI = temp(1:3,:);
IrdotN = temp(4:6,:);
% NwI = JN(1:3,:)*gammadot;
% IrdotN = JN(4:6,:)*gammadot;


JdotN = [skew(IhatN*gammadot)'*(N1TN'), zeros(3); -ITN1*skew(N1wI)*skew(N1rN) - ITN1*skew(ItildeN*gammadot), zeros(3)]*JN1 +...
    [(N1TN'), zeros(3); -ITN1*skew(N1rN), eye(3)]*JdotN1 + [zeros(3,6); ITN1*skew(N1wI)*ItildeN];
    
end