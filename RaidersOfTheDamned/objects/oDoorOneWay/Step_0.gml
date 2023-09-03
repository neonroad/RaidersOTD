/// @description 


if(collision_rectangle(x,y,bbox_right, bbox_bottom, pShootable,false, true) != noone){
	open = !open;	
	image_speed = 0.3;
	audio_play_sound_at(snDoorOpen, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));
	
	oGame.reloadWalls();
}

if(image_index){
	
}

