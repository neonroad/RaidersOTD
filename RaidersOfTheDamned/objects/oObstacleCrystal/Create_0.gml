/// @description  

// Inherit the parent event
event_inherited();

destroyed = false;
open = false;

depth = -bbox_top;

part_timer = irandom_range(15,40);


emitsLight = Aura_Light_Create_Fast("Instances",oLightFast,spDecorLightLamp,0,bbox_left+((0.5)*(bbox_right-bbox_left)),bbox_bottom,1,1,0,make_color_rgb(104,194,211),1);
emitsLight.timer = -1;
Aura_Light_Init_Fast(1,1,0,c_white,1);
