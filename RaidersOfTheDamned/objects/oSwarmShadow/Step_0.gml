/// @description Insert description here
// You can write your code in this editor

image_yscale = 1;

image_angle += irandom_range(-5,5);


if(point_distance(x,y,oPlayer.x,oPlayer.y) > 250)
	image_angle = point_direction(x, y, oPlayer.x, oPlayer.y);
	
var inArea = instance_position(x,y,oAreaDefine);

if(inArea == noone || inArea.areaName != AREA.SWAMP){ //Hardcoded, eew!)
	image_angle = point_direction(x, y, targetArea.x + (targetArea.image_xscale*sprite_get_width(targetArea.sprite_index)*0.5), targetArea.y + (targetArea.image_yscale*sprite_get_height(targetArea.sprite_index)*0.5));
}

x += lengthdir_x(_speed,image_angle);
y += lengthdir_y(_speed,image_angle);
