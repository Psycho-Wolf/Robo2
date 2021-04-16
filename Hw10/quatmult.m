%Question 9
function new_mat = quatmult(qa,qb)

qa0=qa(1);
qa1=qa(2);
qa2=qa(3);
qa3=qa(4);
qb0=qb(1);
qb1=qb(2);
qb2=qb(3);
qb3=qb(4);

qa=qa/norm(qa);
qb=qb/norm(qb);

    new_mat = [qa0 -qa1 -qa2 -qa3; qa1 qa0 -qa3 -qa2; qa2 qa3 qa0 -qa1;
        qa3 -qa2 qa1 qa0]*[qb0;qb1;qb2;qb3];