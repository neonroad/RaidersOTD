/// @description Insert description here
// You can write your code in this editor

x = irandom_range(LEFT,RIGHT);
y = irandom_range(UP,DOWN);

timer = 0;
//timer = 0;
pointFound = false;

lightObj = noone;

evacStart = false;
evacCountdown = false;
currentSprite = spBullet;
animVar = 0;
image_speed = 0.3;

if(instance_exists(obj_Aura_Control))
	depth = obj_Aura_Control.depth-1500