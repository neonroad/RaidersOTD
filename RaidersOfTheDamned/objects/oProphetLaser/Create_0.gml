/// @description Insert description here
// You can write your code in this editor

owner = noone;
x0=x;
x1=0;
y0=y;
y1=0;
hit = false;
hitList = ds_list_create();
if(instance_exists(obj_Aura_Control))
	depth = obj_Aura_Control.depth-300;
timer = 100;
