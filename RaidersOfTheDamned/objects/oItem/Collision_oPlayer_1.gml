/// @description Insert description here
// You can write your code in this editor
if(in_pack) exit;

if(faked){
	other.interactAvailable = true;
	if(other.interacted){
		var zomb = instance_create_layer(other.x,other.y,"Mobs", oMobZombie);
		zomb.ai_start_cooldown = 15;
		part_emitter_region(global.particleSystem, global.emitter, x-5,x+5,y-2,y+2,ps_shape_ellipse,ps_distr_linear);
		part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_smoke1, irandom_range(2,4));
		instance_destroy();	
	}
	exit;
}

if(ds_list_size(other.inventory) < other.inventory_limit && (itemEnum == ITEMS.WEAPON_PISTOL || itemEnum == ITEMS.WEAPON_SHOTGUN || itemEnum == ITEMS.WEAPON_RIFLE || itemEnum == ITEMS.WEAPON_SNIPER || itemEnum == ITEMS.WEAPON_NADE)){
	if(ds_list_empty(other.weaponList) || ds_list_find_index(other.weaponList, itemEnum) == -1){
		other.interactAvailable = true;
		if(other.interacted){
			if(!ds_exists(itemMap, ds_type_map)){
				itemMap = ds_map_create(); //remember to delete map
				var _map = itemMap;
				switch (itemEnum) {
				    case ITEMS.WEAPON_PISTOL:
						_map[? "MAG_SIZE"] = 7;
						_map[? "ICON"] = spItemPistol;
						_map[? "RELOAD_TIME"] = 60;
						_map[? "BULLET_TYPE"] = ITEMS.AMMO_1;
						_map[? "SHOOT_COOLDOWN"] = 20;
						_map[? "WEAPON_SPRITE"] = spGun;
				        break;
					case ITEMS.WEAPON_SHOTGUN:
						_map[? "MAG_SIZE"] = 4;
				        _map[? "ICON"] = spItemShotgun;
						_map[? "RELOAD_TIME"] = 30;
						_map[? "BULLET_TYPE"] = ITEMS.AMMO_2;
						_map[? "SHOOT_COOLDOWN"] = 40;
						_map[? "SPREAD"] = 1;
						_map[? "WEAPON_SPRITE"] = spShotgun;
						break;
					case ITEMS.WEAPON_RIFLE:
						_map[? "MAG_SIZE"] = 30;
						_map[? "ICON"] = spItemRifle;
						_map[? "RELOAD_TIME"] = 60;
						_map[? "BULLET_TYPE"] = ITEMS.AMMO_3;
						_map[? "SHOOT_COOLDOWN"] = 5;
						_map[? "WEAPON_SPRITE"] = spRifle;
						_map[? "TAPED_MAGS"] = 1;
				        break;
					case ITEMS.WEAPON_SNIPER:
						_map[? "MAG_SIZE"] = 1;
						_map[? "ICON"] = spItemSniper;
						_map[? "RELOAD_TIME"] = 90;
						_map[? "BULLET_TYPE"] = ITEMS.AMMO_4;
						_map[? "SHOOT_COOLDOWN"] = 90;
						_map[? "WEAPON_SPRITE"] = spSniper;
				        break;
					case ITEMS.WEAPON_NADE:
						_map[? "MAG_SIZE"] = 1;
						_map[? "ICON"] = spItemNadeLauncher;
						_map[? "RELOAD_TIME"] = 40;
						_map[? "BULLET_TYPE"] = ITEMS.ITEM_GRENADES;
						_map[? "SHOOT_COOLDOWN"] = 60;
						_map[? "WEAPON_SPRITE"] = spNadeLauncher;
				        break;
				}
				_map[? "CURRENT_MAG"] = 0;
				_map[? "BULLET_DAMAGE"] = 1;
				_map[? "WEAPON"] = itemEnum;
				//_map[? "ATTACHMENTS"] = [];
			}
			ds_list_add(other.weaponList, itemMap);
			ds_list_add(other.inventory, id);
			in_pack = true;
			persistent = true;
			audio_play_sound(snWeaponPickup, 6, false);
			var pickup = instance_create_layer(x,y,"Instances",oPopup);
			pickup.textDisplay = itemName;
		}
		exit;
	}
	else exit;
}

else if((itemEnum == ITEMS.HEALTH_1 || itemEnum == ITEMS.HEALTH_2)){
	
	if(other.shootable_map[?SHOOTABLE_MAP.HEALTH] == other.shootable_map[?SHOOTABLE_MAP.HEALTH_START]){
		other.interactAvailable = true;
		other.pickupError = true;
		if(other.interacted){
			if(!instance_exists(popup)){	
				popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
				popup.image_alpha = 1;
				audio_play_sound(snError, 12, false);
			}
		}
		exit;
	}
	other.interactAvailable = true;
	if(other.interacted){
		other.shootable_map[? SHOOTABLE_MAP.HEALTH] ++;
	
		if(itemEnum == ITEMS.HEALTH_2) other.shootable_map[? SHOOTABLE_MAP.HEALTH] = other.shootable_map[? SHOOTABLE_MAP.HEALTH_START];
		var pickup = instance_create_layer(x,y,"Instances",oPopup);
		pickup.textDisplay = itemName;
		part_emitter_region(global.particleSystem, global.emitter, bbox_left,bbox_right,bbox_top,bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_healPart, 5);
		audio_play_sound(snHeal, 6, false);
		instance_destroy();
	}
	exit;

}



else if(stackMax > 1){
	other.interactAvailable = true;
	if(other.interacted){
		for (var i = 0; i < ds_list_size(other.inventory); i++) {
		    var itemLookingAt = other.inventory[|i];
			var leftovers = -1;
			if(itemLookingAt.id != id && itemLookingAt.itemEnum == itemEnum && itemLookingAt.stackAmount < itemLookingAt.stackMax){
				itemLookingAt.stackAmount += stackAmount;
				leftovers = itemLookingAt.stackAmount - itemLookingAt.stackMax;
			
				if(leftovers > 0) {
					itemLookingAt.stackAmount -= leftovers;
				}
				else{ 
					in_pack = true; 
					audio_play_sound(snPickupItem, 6, false);
					var pickup = instance_create_layer(x,y,"Instances",oPopup);
					pickup.textDisplay = itemName;
					exit;
				}
				stackAmount = leftovers;
				break;
			}
		
		}
		if(ds_list_size(other.inventory) < other.inventory_limit){
			in_pack = true;
			ds_list_add(other.inventory, id);
			persistent = true;
			audio_play_sound(snPickupItem, 6, false);
			var pickup = instance_create_layer(x,y,"Instances",oPopup);
			pickup.textDisplay = itemName;
		}
		else{
			if(!instance_exists(popup)){	
				popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
				popup.image_index = 1;
				popup.image_alpha = 1;
			}
			
		}
	}
}

else if( scFindSpecificItem(other, itemEnum) != -1 || ds_list_size(other.inventory) < other.inventory_limit) {
	
	other.interactAvailable = true;
	
	
		
	if(scFindSharedItemType(other, id) != -1){
		other.switchAvailable = true;
				
		other.switchWith = scFindSharedItemType(other,id);
				
				
		if(other.interacted){
			scDropSpecificItemID(other, other.switchWith);
		}
	}
			
	if(other.interacted){
		add();
		in_pack = true;
		ds_list_add(other.inventory,id);
		persistent = true;
		audio_play_sound(snPickupItem, 6, false);
		var pickup = instance_create_layer(x,y,"Instances",oPopup);
		pickup.textDisplay = itemName;
	}
			
	
	exit;
}

else{
	other.interactAvailable = true;
	other.pickupError = true;	
	if(other.interacted){
		if(!instance_exists(popup)){	
			popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
			popup.image_index = 1;
			popup.image_alpha = 1;
			audio_play_sound(snError, 12, false);
		}
	}
}