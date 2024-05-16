/// @description  


inventoryX = -1;
inventoryY = -1;
invDir = 0;
gridSpace = noone;
inPack = false;
interacted = false;
//itemMap = noone;
stackAmount = 1;
stackMax = 1;
keyItem = false;
image_speed = 0;

switch (itemID) {
    case ITEMS.WEAPON_PISTOL:
        sprite_index = spItemPistol;
		itemName = "Pistol";
        break;
	case ITEMS.WEAPON_SHOTGUN:
        sprite_index = spItemShotgun;
		itemName = "Shotgun";
        break;
	case ITEMS.WEAPON_RIFLE:
        sprite_index = spItemRifle;
		itemName = "Rifle";
        break;
	case ITEMS.KEYCARD_GREEN:
		sprite_index = spItemGreenKeycard;
		keyItem = true;
		itemName = "Green Keycard";
		break;
    case ITEMS.AMMO_1:
        sprite_index = spItemAmmoPistol;
		itemName = "Pistol Ammo";
		stackAmount = 7;
	    stackMax = 14;
	    break;	
	case ITEMS.AMMO_2:
        sprite_index = spItemAmmoShotgun;
		itemName = "Shotgun Ammo";
		stackAmount = 4;
	    stackMax = 24;
	    break;	
	case ITEMS.AMMO_3:
        sprite_index = spItemAmmoRifle;
		itemName = "Rifle Ammo";
		stackAmount = 16;
	    stackMax = 64;
	    break;
	case ITEMS.HEALTH_1:
        sprite_index = spItemHealth;
		image_index = 0;
		itemName = "Pistol";
        break;
    
}
inventorySprite = scGetInventorySprite(itemID, id);
gridSpace = scGetGridSpace(itemID, id);


if((itemID == ITEMS.WEAPON_SHOTGUN || itemID == ITEMS.WEAPON_RIFLE || itemID == ITEMS.WEAPON_PISTOL)){
			if(!variable_instance_exists(id,"itemMap") || !ds_exists(itemMap, ds_type_map)){
				itemMap = ds_map_create(); //remember to delete map
				var _map = itemMap;
				_map[? "MELEE"] = false;
				switch (itemID) {
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
					case ITEMS.WEAPON_SHOVEL:
						_map[? "MAG_SIZE"] = 1;
						_map[? "ICON"] = spItemShovel;
						_map[? "MELEE"] = true;
						_map[? "WEAPON_SPRITE"] = spShovel;
						break;
				}
				_map[? "CURRENT_MAG"] = 0;
				_map[? "BULLET_DAMAGE"] = 1;
				_map[? "WEAPON"] = itemID;
			}
			//_map[? "ATTACHMENTS"] = [];
			//audio_play_sound(snWeaponPickup, 6, false);
}