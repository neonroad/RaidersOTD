/// @description 

if(!instance_exists(oPlayer)) exit;


if(point_distance(x+(16*image_xscale*0),y+(16*image_yscale*0),oPlayer.x,oPlayer.y) < 24){
	scInteractAvailable();
	interactable = true;
}
else{
	scInteractRemove();
			
	
	interactable = false;	
}

if(interactable && interacted){
		
	if(!open){
		openDoor();
	}
	else {
		closeDoor();
	}
	aura_shadowcaster_box_init();
	oGame.reloadWalls();
}

if(image_index >= image_number-1){
	image_speed = 0;
}
if(!open && instance_place(x, y, pShootable) != noone) openDoor();

interacted = false;