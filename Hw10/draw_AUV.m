function rtrn = draw_AUV(b)

rB = b(11:13);
q = b(7:10);

T = rotq(q);

h = clf(gcf);

[Base,Base_f,n,c,stltitle]   = stlread('HW_auv.stl');

Base_v=repmat(rB,1,length(Base))+ T*Base';
patch('Faces',Base_f,'Vertices',Base_v','EdgeColor','None','FaceColor',[0 .5 1]);

set(gca,'ZDir','reverse');
set(gca,'YDir','reverse');

axis equal;

camlight left;
set(gca,'projection','perspective');
view([1;1;.5]);
axis([-3 3 -3 3 -3 3]);
