/// @description  

x += hsp;
y += vsp;


totalSpeed = sqrt((hsp*hsp)+(vsp*vsp));


directionFacing = point_direction(x,y,x+hsp,y+vsp);

hsp = lengthdir_x(totalSpeed, directionFacing)*0.01;
vsp = lengthdir_y(totalSpeed, directionFacing)*0.01;

if(upright) image_index = 0;

else{
	if(directionFacing <= 22.5 || directionFacing >= 337.5) image_index = 3;
	else if(directionFacing <= 67.5 && directionFacing > 22.5) image_index = 4;
	else if(directionFacing <= 112.5 && directionFacing > 67.5) image_index = 5;
	else if(directionFacing <= 157.5 && directionFacing > 112.5) image_index = 6;
	else if(directionFacing <= 202.5 && directionFacing > 157.5) image_index = 7;
	else if(directionFacing <= 247.5 && directionFacing > 202.5) image_index = 8;
	else if(directionFacing <= 292.5 && directionFacing > 247.5) image_index = 1;
	else image_index = 2;
}
