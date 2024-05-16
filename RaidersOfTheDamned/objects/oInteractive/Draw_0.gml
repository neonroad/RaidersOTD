/// @description 
if(room != activeRoom) exit;

switch (interactType) {
    case INTERACTABLES.DRAWER:
        sprite_index = spInteractDrawer;
        break;
	case INTERACTABLES.WEAPONBOX:
        sprite_index = spInteractWeaponBox;
        break;
	case INTERACTABLES.LOCKER:
        sprite_index = spInteractLocker;
        break;
	case INTERACTABLES.ZOMBIECORPSE:
		if(sprite_index != spInteractZombieCorpse)
			image_index = irandom(sprite_get_number(sprite_index));
		sprite_index = spInteractZombieCorpse;
		break;
    default:
        sprite_index = spInteractShovelMound;
        break;
}


draw_self();

var touchingPlayer = collision_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom, oPlayer, false, true)

if(touchingPlayer != noone){
	currentlyInteracting = false;

	switch (interactType) {
	    case INTERACTABLES.SHOVELMOUND:
	        if(scFindWeapon(other.weaponList, ITEMS.WEAPON_SHOVEL) != -1){
				currentlyInteracting = true;
				other.interactAvailable = true;
			}
			dropUpgrade();
	        break;
		case INTERACTABLES.DRAWER:
			currentlyInteracting = true;
			other.interactAvailable = true;
			dropItem();
			break;
		case INTERACTABLES.WEAPONBOX:
			if(interactable){
				scInteractAvailable();
				dropHealthItem();
			}
			break;
		case INTERACTABLES.LOCKER:
			if(interactable){
				scInteractAvailable();
				dropAmmoItem();
			}
			break;
		case INTERACTABLES.ZOMBIECORPSE:
			if(interactable){
				scInteractAvailable();
				dropAmmoItemSmart();
			}
			break;
	}

}

else{
	scInteractRemove();	
}

interacted = false;