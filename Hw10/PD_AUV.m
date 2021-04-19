function TF = PD_AUV(b,BqD,IIrD)

w = [b(1);b(2);b(3)];
rdot = [b(4);b(5);b(6);];
q = [b(7);b(8);b(9);b(10)];
r = [b(11);b(12);b(13)];


BqD = [BqD(2); BqD(3); BqD(4)];

Ktp = 1500;
Ktd = 750;

Kfp = 500;
Kfd = 750;

TF = [  (Ktp*(BqD)) - (Ktd*w);...
        (Kfp*(IIrD - r)) - (Kfd*rdot)];