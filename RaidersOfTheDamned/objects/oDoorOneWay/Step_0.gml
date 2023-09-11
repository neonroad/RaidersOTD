/// @description 


if(collision_rectangle(x,y,bbox_right, bbox_bottom, pShootable,false, true) != noone){
	
	image_speed = 0.3;
	
	

	if(sign(image_speed) > 0 && image_index >= image_number-1){
		if(!open) audio_play_sound_at(snDoorOpen, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));
		open = true;	
		oGame.reloadWalls();
		
		image_speed = 0;
	}

}
else{
	image_speed = -0.3;
	if(sign(image_speed) < 0 && image_index <= 0){
		image_speed = 0;
		open = false;
		oGame.reloadWalls();
	}	
}