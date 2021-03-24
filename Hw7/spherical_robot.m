function bdot = spherical_robot(b,V,F)


m1 = 1.37080227;
r1cm = [0;-0.02570462;0.05114915];
m2 = 0.76240603;
r2cm = [-0.05449109;.02681265;0];
m3 = .77189259;
r3cm = [0.00001023;0.00115005;0.00081791];
Gam1x = m1*r1cm(1); Gam1y = m1*r1cm(2); Gam1z = m1*r1cm(3);
Gam2x = m2*r2cm(1); Gam2y = m2*r2cm(2); Gam2z = m2*r2cm(3);
Gam3x = m3*r3cm(1); Gam3y = m3*r3cm(2); Gam3z = m3*r3cm(3);

end