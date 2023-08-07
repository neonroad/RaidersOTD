/// @description 

if(!instance_exists(oPlayer)) exit;


if(!open && point_distance(x+(16*image_xscale*0),y+(16*image_yscale*0),oPlayer.x,oPlayer.y) < 24){
	scInteractAvailable();
	interactable = true;
}
else{
	scInteractRemove();
			
	
	interactable = false;	
}

if(unlocked && interactable && interacted){
		
	if(!open){
		openDoor();
	}
	//else {
	//	closeDoor();
	//}
	aura_shadowcaster_box_init();
	oGame.reloadWalls();
}

else if(!unlocked && interactable && interacted){
	
	for (var i = 0; i < array_length(oPlayer.keyItems); i++) {
	    if(oPlayer.keyItems[i].itemID = ITEMS.KEYCARD_GREEN)
			unlocked = true;
	}
	
	if(!unlocked){
		popup = instance_create_layer(x, y, "Instances", oPopup);
		popup.image_index = 5;
		popup.image_alpha = 1;
		audio_play_sound(snError, 12, false);
	}
	else{
		audio_play_sound(snDoorUnlock, 20, false);
		scParticleBurstLight(x-10,y-10,x+10,y+10, 10, 8, 40, c_white, false, 0,360, 0.5);
		openDoor();
	}
}

if(image_index >= image_number-1){
	image_speed = 0;
}
if(!open && instance_place(x, y, pShootable) != noone) openDoor();

interacted = false;