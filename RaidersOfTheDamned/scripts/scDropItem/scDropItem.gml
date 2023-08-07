function scDropFirstItem(playerId){
	scDropSpecificItemEnum(playerId, playerId.inventory[|0].itemEnum);
}

function scDropSpecificItemEnum(playerId, item){
	
	for (var i = 0; i < ds_list_size(playerId.inventory); i++) {
	    if(playerId.inventory[| i].itemEnum == item){ //Should check for something other than enum
			playerId.inventory[|i].x = (x div 32)*32;
			playerId.inventory[|i].y = (y div 32)*32;
			playerId.inventory[|i].in_pack = false;
			playerId.inventory[|i].persistent = false;
			playerId.inventory[|i].remove();
			
			if(playerId.inventory[|i].appliedChange) playerId.inventory[|i].unapply();
			var isWeapon = scFindWeapon(playerId.weaponList, item);
			if(isWeapon != -1){
				//if(playerId.weaponEquipped == item) playerId.weaponEquipped = noone;
				ds_list_delete(playerId.weaponList, isWeapon);
			}
			ds_list_delete(playerId.inventory,i);
			return true;
		}
	}
	return false;

}


function scDropSpecificItemID(playerId, item){
	
	for (var i = 0; i < ds_list_size(playerId.inventory); i++) {
	    if(playerId.inventory[| i] == item){ //Should check for something other than enum
			playerId.inventory[|i].x = (x div 32)*32;
			playerId.inventory[|i].y = (y div 32)*32;
			playerId.inventory[|i].in_pack = false;
			playerId.inventory[|i].persistent = false;
			playerId.inventory[|i].remove();
			if(playerId.inventory[|i].appliedChange) playerId.inventory[|i].unapply();
			ds_list_delete(playerId.inventory,i);
			return true;
		}
	}
	return false;

}

function scFindSpecificItem(playerId, item){
	
	for (var i = 0; i < ds_list_size(playerId.inventory); i++) {
	    if(playerId.inventory[| i].attachmentSlot == item){ //Should check for something other than enum
			return playerId.inventory[|i];
		}
	}
	return -1;

}

function scFindSharedItemType(playerId, itemId){
	if(itemId.attachmentSlot == -1) return -1;
	for (var i = 0; i < ds_list_size(playerId.inventory); i++) {
	    if(playerId.inventory[| i].attachmentSlot == itemId.attachmentSlot && playerId.inventory[|i].attachmentFor == itemId.attachmentFor){ //Should check for something other than enum
			return playerId.inventory[|i];
		}
	}
	return -1;

}

function scDropAll(playerId){
	while(!ds_list_empty(playerId.inventory)){
		scDropFirstItem(playerId);	
	}
	ds_list_clear(playerId.weaponList);
	//ds_list_add(playerId.weaponList, ITEMS.WEAPON_PISTOL); //Why?!
}