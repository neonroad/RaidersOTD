/// @description  
//depth = obj_Aura_Control.depth-100;
emitsLight = Aura_Light_Create_Fast("Instances",oLightFast,spDecorLightLamp,0,x,y+5,1,1,0,make_color_rgb(207, 138, 203),1);
emitsLight.timer = -1;
image_speed = 0;
image_index = irandom(2);
depth = -y;
Aura_Light_Init_Fast(1,1,0,c_white,1);
image_alpha = 0.5;