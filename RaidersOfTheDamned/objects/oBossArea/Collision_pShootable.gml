/// @description 

if(other.object_index == oPlayer && !instance_exists(interiorLight)){
	interiorLight = Aura_Light_Create_Fast("Instances",oLightBlockFast, -1,-1,x,y,image_xscale*32,image_yscale*32,0,lightColor,1);
	visible = false;
	other.cameraControl = false;
	other.cameraPivotX = ((bbox_right-x)*0.5)+x;
	other.cameraPivotY = ((bbox_bottom-y)*0.5)+y;
	
}

//if(other.object_index == oPlayer) oGame.roomTemp[? room] += 0.005;

