function scAnimateInteraction(){
	
	if(current_state == PLAYER_STATE.PLAYING && array_length(interactList) > 0){
		if(!instance_exists(icursor)){
			icursor = instance_create_layer(x,y,"Walls",oInteractCursor);
			icursor.target = interactList[0];
		}
		else{
			var shortestDist = point_distance(mouse_x,mouse_y,interactList[0].x,interactList[0].y);
			icursor.target = interactList[0];
			for (var i = 0; i < array_length(interactList); i++) {
				var newDist = point_distance(mouse_x,mouse_y,interactList[i].x,interactList[i].y);
				if(newDist < shortestDist){
					icursor.target = interactList[i];	
					shortestDist = newDist;
				}
			}	
		}
		interactAvailable = true;
		if(keyboard_check_pressed(ord("E"))){
			icursor.target.interacted = true;
		}
	}
	else{
		if(instance_exists(icursor)){
			instance_destroy(icursor);
			icursor = noone;
		}
		interactAvailable = false;
	}
	/*
	interacted = false;
	
	if(!switchAvailable){
		switchAnim = 0;	
	}
	
	if(!interactAvailable){
		interactAnim = 0;	
		if(interactToggle) interactToggle = false;
	}
	else{
		if(!interactToggle){
			interactToggle = true;
			if(!pickupError) audio_play_sound(snPickupNotification, 7, false);
		}
		interactAnim += 0.4*localTD;
		interactAnim = min(interactAnim, sprite_get_number(spUIInteract)-1);
		if(keyboard_check_pressed(ord("E"))){
			icursor.target.interacted = true;
		}
		if(switchAvailable) switchAnim += 0.2*localTD;
	}

	interactAvailable = false;
	switchAvailable = false;
	pickupError = false;
	switchWith = noone;
	*/
}