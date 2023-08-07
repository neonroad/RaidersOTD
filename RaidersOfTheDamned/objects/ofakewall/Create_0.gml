/// @description Insert description here
// You can write your code in this editor

do{
image_xscale = irandom_range(1, 5);
image_yscale = irandom_range(1, 5);
x = (irandom_range(LEFT,RIGHT) div 32) * 32;

y = (irandom_range(UP,DOWN) div 32) * 32;
}
until (instance_place(x, y, oWall) == noone)
aura_shadowcaster_box_init();