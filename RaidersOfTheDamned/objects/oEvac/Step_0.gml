/// @description Insert description here
// You can write your code in this editor

if(room != oGame.evacRoom){
	visible = false;
	evacStart = false;
	instance_destroy(lightObj);
	exit;
}

if(!pointFound && collision_point(x, y, oWall, false, true) != noone){
	x = irandom_range(room_width*.2,room_width*.8);
	y = irandom_range(room_height*.3,room_height*.3);
	
}
else{
	pointFound = true;	
}

timer--;
animVar += image_speed;

if(pointFound && timer < 0 && !evacStart){
	evacStart = true;
	lightObj = Aura_Light_Create_Fast("Instances", oLightFast, spr_Aura_Point_LightPP, -1, x,y,0.5,0.5,0,c_white,1);
	lightObj.timer = -1;
	
}

if(lightObj != noone){
	lightObj.x +=cos(0.1*timer);
	lightObj.y +=sin(0.1*timer);
}

if(evacCountdown && evacStart && timer < 0 && currentSprite == spBullet){
	currentSprite = spLadderDrop;	
	animVar = 0;
	visible = true;
}