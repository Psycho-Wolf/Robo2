function TF = PD_AUV(b,BqD,IIrD)

q = [b(1);b(2);b(3);b(4)];
r = [b(5);b(6);b(7)];
w = [b(8);b(9);b(10)];
rdot = [b(11);b(12);b(13)];

BqD = [BqD(2); BqD(3); BqD(4)];

Ktp = 10;
Ktd = 50;

Kfp = 500;
Kfd = 750;

TF = [  (Ktp*BqD) - (Ktd*w);...
        (Kfp*(IIrD - r)) - (Kfd*rdot)];