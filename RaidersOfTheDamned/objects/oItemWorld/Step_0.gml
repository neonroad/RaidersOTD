/// @description  

if(invDir > 3) invDir = 0;
if(invDir < 0) invDir = 3;

if(!instance_exists(oPlayer)) exit;
persistent = inPack;


if(!inPack && point_distance(x+(16*image_xscale*0),y+(16*image_yscale*0),oPlayer.x,oPlayer.y) < 24){
	scInteractAvailable();
	interactable = true;
}
else{
	scInteractRemove();
			
	
	interactable = false;	
}

if(!inPack && interactable && interacted){
	scInteractRemove();
	if(!keyItem)
		scAddToInventory(id);		
	else{
		inPack = true;
		array_push(oPlayer.keyItems, id);
	}
	//in_pack = true;
	//persistent = true;
	
}

interacted = false;