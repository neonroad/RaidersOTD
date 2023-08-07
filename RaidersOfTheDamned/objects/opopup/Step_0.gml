/// @description Insert description here
// You can write your code in this editor
if(instance_exists(owner)){
	x = owner.x;
	y = owner.bbox_top;
}

y-=0.05;
image_alpha -= fadeRate;

if(image_alpha <= 0) instance_destroy();