/// @description Insert description here
// You can write your code in this editor


x+=hsp;
y+=vsp;

var currentSpeed = sqrt((hsp*hsp) + (vsp*vsp));
hsp = lerp(lengthdir_x(currentSpeed,dir),0,fric);
vsp = lerp(lengthdir_y(currentSpeed,dir),0,fric);

timer --;

var wallHit = collision_point(x,y,oWall,false,true);
if(wallHit != noone && (!variable_instance_exists(wallHit, "open") || !wallHit.open)){
	hsp = 0;
	vsp = 0;
}

if(timer < 0){
	instance_destroy();	
}