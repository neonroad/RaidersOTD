/// @description Insert description here
// You can write your code in this editor
if(!active){ instance_destroy(); exit;}
if !instance_exists(target) exit;

x = lerp(x, target.x + (0*target.image_xscale*sprite_get_width(target.sprite_index)*0.5), 0.1);
y = lerp(y, target.y + (0*target.image_yscale*sprite_get_height(target.sprite_index)*0.5), 0.1);

