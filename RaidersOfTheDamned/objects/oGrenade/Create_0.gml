/// @description Insert description here
// You can write your code in this editor
targetX = x;
targetY = y;
y1=y;
x1=x;
targetAngle = 0;
owner = noone;
hitList = ds_list_create();

//lightObj = Aura_Light_Create_Fast("Instances",obj_Aura_FastAura, -1,-1,x,y,1,1,0,c_white,1);
lineColor = c_white;
timer = 60;
hit = false;
image_xscale = 1;
image_yscale = 1;
image_speed = 0.8;
crit = false;
explode = false;

bulletType = ITEMS.WEAPON_PISTOL;