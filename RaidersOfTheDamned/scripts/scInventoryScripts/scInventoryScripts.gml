// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function scGetInventorySprite(objectEnum, itemID){
	switch (objectEnum) {
	    case ITEMS.WEAPON_PISTOL:
	        return spINVPistol;
	        break;
	    case ITEMS.AMMO_1:
			return spINVAmmo1;
			break;
		case ITEMS.AMMO_2:
			return spINVAmmo2;
			break;
		case ITEMS.AMMO_3:
			return spINVAmmo3;
			break;
		case ITEMS.WEAPON_SHOTGUN:
		case ITEMS.WEAPON_RIFLE:
			return spINVShotgun;
			break;
	}
}
function scGetGridSpace(objectEnum, itemID){
	switch (objectEnum) {
	    case ITEMS.WEAPON_PISTOL:
	        
			var grid = ds_grid_create(2,2);
			ds_grid_clear(grid,-1);
			grid[# 0, 0] = itemID;
			grid[# 1, 0] = itemID;
	        grid[# 0, 1] = itemID;
			
			return grid;
			break;
		
		case ITEMS.WEAPON_SHOTGUN:
	        
			var grid = ds_grid_create(2,2);
			ds_grid_clear(grid,-1);
			grid[# 0, 0] = itemID;
			grid[# 1, 0] = itemID;
			return grid;
			break;
			
		case ITEMS.WEAPON_RIFLE:
	        
			var grid = ds_grid_create(2,2);
			ds_grid_clear(grid,-1);
			grid[# 0, 0] = itemID;
			grid[# 1, 0] = itemID;
			return grid;
			break;
		
		case ITEMS.AMMO_1:
		case ITEMS.AMMO_2:
		case ITEMS.AMMO_3:
			var grid = ds_grid_create(1,1);
			ds_grid_clear(grid, itemID);
			return grid;
			break;
		default:
			return noone;
	}	
}

function scAddToInventory(object){
	
	if(stackMax > 1){
		for (var i = 0; i < array_length(oPlayer.invObj.invArray); i++) {
		    var currItem = oPlayer.invObj.invArray[i];
			if(currItem.itemID == object.itemID){
				if(currItem.stackAmount < currItem.stackMax){
					currItem.stackAmount += object.stackAmount;
					
					//I hate doing double repeated checks like this but it'll get the job done
					
					if(currItem.stackAmount > currItem.stackMax){
						object.stackAmount = currItem.stackAmount-object.stackMax;
						currItem.stackAmount = currItem.stackMax;
					}
					//Added everything from newly picked up object, we destroy picked up obj
					else{
						instance_destroy(object);	
						return;
					}
				}
			}
		}	
	}
	
	for (var yy = 0; yy < ds_grid_height(oPlayer.invObj.inventoryGrid); yy++) {
	    for (var xx = 0; xx < ds_grid_width(oPlayer.invObj.inventoryGrid); xx++) {
		    with(oPlayer.invObj){
				if(scInventoryAttemptToPlace(object,xx,yy)){
					scInventoryPlaceAt(object,xx,yy);
					return;
				}
			}
		}
	}
	with(oPlayer) scCheckInventory(true);
	with(oInventoryManager) holding = object;
}

function scInventoryAttemptToPlace(object, cellX, cellY){
	for (var yy = 0; yy < ds_grid_height(object.gridSpace); yy++) {
	    for (var xx = 0; xx < ds_grid_width(object.gridSpace); xx++) {
		    if(((cellX + xx) > ds_grid_width(inventoryGrid)-1 || (cellY + yy) > ds_grid_height(inventoryGrid)-1)) return false;
			
			if((inventoryGrid[# cellX + xx, cellY + yy] != -1 && object.gridSpace[# xx, yy] != -1)){
				if((inventoryGrid[# cellX + xx, cellY + yy] != -1 && object.gridSpace[# xx, yy] != -1) && inventoryGrid[# cellX + xx, cellY + yy].itemID == object.itemID && inventoryGrid[# cellX + xx, cellY + yy].stackAmount < inventoryGrid[# cellX + xx, cellY + yy].stackMax){
					return true;
				}
				else if(inventoryGrid[# cellX + xx, cellY + yy] != -1 && object.gridSpace[# xx, yy] != -1)
				return false;	
			}
		}
	}
	return true;
}

function scInventoryPlaceInWorld(obj){
	obj.x = oPlayer.x;
	obj.y = oPlayer.y;
	obj.inPack = false;
	if(variable_instance_exists(obj,"itemMap")){
		ds_list_delete(oPlayer.weaponList, ds_list_find_index(oPlayer.weaponList, obj.itemMap));
		with(oPlayer) scWeaponSwitch(true);
	}
	
}

function scInventoryPlaceAt(object, cellX, cellY){
	if(inventoryGrid[# cellX, cellY] != -1 && inventoryGrid[# cellX, cellY].itemID == object.itemID && inventoryGrid[# cellX, cellY].stackAmount < inventoryGrid[# cellX, cellY].stackMax){
		inventoryGrid[# cellX, cellY].stackAmount += object.stackAmount;
		if(inventoryGrid[# cellX, cellY].stackAmount <= inventoryGrid[# cellX, cellY].stackMax){
			instance_destroy(object);
			return true;
		}
		else{
			object.stackAmount = inventoryGrid[# cellX, cellY].stackAmount - inventoryGrid[# cellX, cellY].stackMax;
			inventoryGrid[# cellX, cellY].stackAmount = inventoryGrid[# cellX, cellY].stackMax;
			return false;
		}
	}
	for (var yy = 0; yy < ds_grid_height(object.gridSpace); yy++) {
		for (var xx = 0; xx < ds_grid_width(object.gridSpace); xx++) {
			if(object.gridSpace[# xx, yy] != -1){
				inventoryGrid[# cellX + xx, cellY + yy] = object.gridSpace[# xx, yy];	
			}
		}
	}
	object.inventoryX = cellX;
	object.inventoryY = cellY;
	array_push(invArray,object);
	object.inPack = true;
	
	//Indicative of a weapon being placed in inventory
	if(variable_instance_exists(object,"itemMap")){
		ds_list_add(oPlayer.weaponList, object.itemMap);
		audio_play_sound(snWeaponPickup, 6, false);
	}
	return true;
}

function scInventoryRemove(obj){
	var found = false;
	for (var i = 0; i < array_length(invArray); i++) {
		if(invArray[i] == obj){
			array_delete(invArray, i, 1);
			found = true;
			break;
		}
	}
	
	if !found return noone;
				
	for (var yy = 0; yy < ds_grid_height(inventoryGrid); yy++) {
		for (var xx = 0; xx < ds_grid_width(inventoryGrid); xx++) {
			if(inventoryGrid[# xx, yy] == obj.id) inventoryGrid[# xx, yy] = -1;
		}
	}
	obj.inPack = false;
	
	return obj;
		
}