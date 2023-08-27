/// @description 



/// @description 
if(point_distance(x+16,y+16,oPlayer.x,oPlayer.y) < 38){
	oPlayer.interactAvailable = true;	
	interactable = true;
}
else{
	interactable = false;	
}

if(interactable && oPlayer.interacted){
	open = !open;	
	audio_play_sound_at(snDoorOpen, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));
	aura_shadowcaster_box_init()

	if(open){
		image_index = 1;
		//mask_index = spBullet;
	}
	else {
		image_index = 0;
		//mask_index = spWall;
	}
	aura_shadowcaster_box_init();
	oGame.reloadWalls();
}
