/// @description  

x += hsp;
y += vsp;


totalSpeed = sqrt((hsp*hsp)+(vsp*vsp));


directionFacing = point_direction(x,y,x+hsp,y+vsp);

hsp = 0.25*lengthdir_x(totalSpeed, directionFacing);
vsp = 0.25*lengthdir_y(totalSpeed, directionFacing);


