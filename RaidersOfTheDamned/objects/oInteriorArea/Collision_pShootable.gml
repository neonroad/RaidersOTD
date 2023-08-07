/// @description 
other.inside = true;
if(other.object_index == oPlayer && !instance_exists(interiorLight)){
	interiorLight = Aura_Light_Create_Fast("Instances",oLightBlockFast, -1,-1,x,y,image_xscale*32,image_yscale*32,0,c_white,1);
	visible = false;
	
}

if(other.object_index == oPlayer) oGame.roomTemp[? room] += 0.005;

