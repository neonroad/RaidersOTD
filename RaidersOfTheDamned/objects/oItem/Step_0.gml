/// @description Insert description here
// You can write your code in this editor

if(instance_exists(oPlayer)) player = oPlayer;

if(player != noone && instance_exists(player) && !in_pack && scFindWeapon(player.weaponList, itemEnum) != -1){
	itemEnum = player.weaponList[|scFindWeapon(player.weaponList, itemEnum)][? "BULLET_TYPE"];
	changed = true;
}

if(player != noone && instance_exists(player) && attachmentFor != noone && !in_pack && scFindWeapon(player.weaponList, attachmentFor) == -1){
	itemEnum = attachmentFor;
	attachmentFor = noone;
	attachmentSlot = -1;
	changed = true;
}


if(in_pack) exit;

if(changed){
	switch (itemEnum) {
	    case ITEMS.FLASHLIGHT_BASIC:
	        sprite_index = spItemFlashlight;
			image_index = 0;
			itemName = "Basic Flashlight";
	        break;
	    case ITEMS.FLASHLIGHT_SUPER:
	        sprite_index = spItemFlashlight;
			image_index = 1;
			itemName = "Strong Flashlight";
			attachmentSlot = 0;
			add = function(){
				player.flashlight = itemEnum;	
			}
			remove = function(){
				player.flashlight = noone;		
			}
	        break;
		case ITEMS.LASERPOINT:
			sprite_index = spItemLaserPointer;
			image_index = 0;
			itemName = "Lasersight";
			attachmentFor = ITEMS.WEAPON_PISTOL;
			attachmentSlot = 1;
			add = function(){
				player.laserpointer = true;
			}
			remove = function(){
				player.laserpointer = false;		
			}
			apply = function(){
				player.critChance += 5;	
				appliedChange = true;
			}
			unapply = function(){
				player.critChance -= 5;	
				appliedChange = false;
			}
			rarity = 1;
			break;
	    case ITEMS.AMMO_1:
	        sprite_index = spItemAmmoPistol;
			image_index = 0;
			itemName = "Pistol Ammo";
			stackAmount = 7;
	        stackMax = 14;
	        break;	
		case ITEMS.AMMO_2:
	        sprite_index = spItemAmmoShotgun;
			image_index = 0;
			itemName = "Shotgun Ammo";
			stackAmount = 4;
	        stackMax = 12;
	        break;	
		case ITEMS.ITEM_GRENADES:
	        sprite_index = spItemAmmoNade;
			image_index = 0;
			itemName = "Grenades";
			stackAmount = 4;
	        stackMax = 4;
	        break;
		case ITEMS.AMMO_3:
	        sprite_index = spItemAmmoRifle;
			image_index = 0;
			itemName = "Rifle Ammo";
			stackAmount = 30;
	        stackMax = 30;
	        break;
		case ITEMS.AMMO_4:
	        sprite_index = spItemAmmoSniper;
			image_index = 0;
			itemName = "Sniper Ammo";
			stackAmount = 2;
	        stackMax = 6;
	        break;
		case ITEMS.MAG_UP_PISTOL:
			sprite_index = spItemMagUpPistol;
			image_index = 0;
			itemName = "Pistol Extended Magazine";
			attachmentFor = ITEMS.WEAPON_PISTOL;
			attachmentSlot = 2;
			add = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1)
					player.weaponList[| weaponIndex ][? "MAG_SIZE"]  *= 2;
				//appliedChange = true;
			}
			remove = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
					if(weaponIndex != -1)
				player.weaponList[| scFindWeapon(player.weaponList, attachmentFor)][? "MAG_SIZE"]  *= 0.5;
				//appliedChange = true;
			}
			break;
		case ITEMS.HPR_RIFLE:
			sprite_index = spItemHPR;
			image_index = 0;
			itemName = "High Powered Rifle Rounds";
			attachmentFor = ITEMS.WEAPON_RIFLE;
			attachmentSlot = 1;
			add = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex ][? "MAG_SIZE"]  *= 0.5;
					if(player.weaponList[| weaponIndex][? "CURRENT_MAG"] > player.weaponList[| weaponIndex ][? "MAG_SIZE"])
						player.weaponList[| weaponIndex][? "CURRENT_MAG"] = player.weaponList[| weaponIndex ][? "MAG_SIZE"];
					
					player.weaponList[| weaponIndex][? "BULLET_DAMAGE"] *= 2;
				}
				//appliedChange = true;
			}
			remove = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
					if(weaponIndex != -1){
					player.weaponList[| scFindWeapon(player.weaponList, attachmentFor)][? "MAG_SIZE"]  *= 2;
					player.weaponList[| weaponIndex][? "BULLET_DAMAGE"] *= 0.5;	
				}
				//appliedChange = true;
			}
			break;
		case ITEMS.ERGO_PUMP:
			sprite_index = spItemErgoPump;
			image_index = 0;
			itemName = "Ergonomic Pump";
			attachmentFor = ITEMS.WEAPON_SHOTGUN;
			attachmentSlot = 1;
			add = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex ][? "SHOOT_COOLDOWN"]  *= 0.5;
				}
				//appliedChange = true;
			}
			remove = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex][? "SHOOT_COOLDOWN"] *= 2;
				}
				//appliedChange = true;
			}
			break;
		case ITEMS.TIGHT_CHOKE:
			sprite_index = spItemChoke;
			image_index = 0;
			itemName = "Choke";
			attachmentFor = ITEMS.WEAPON_SHOTGUN;
			attachmentSlot = 2;
			add = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex ][? "SPREAD"]  *= 0.25;
				}
				//appliedChange = true;
			}
			remove = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex][? "SPREAD"] *= 4;
				}
				//appliedChange = true;
			}
			break;
		case ITEMS.TAPED_MAG:
			sprite_index = spItemTapedMag;
			image_index = 0;
			itemName = "Taped Magazine";
			attachmentFor = ITEMS.WEAPON_RIFLE;
			attachmentSlot = 2;
			add = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex ][? "TAPED_MAGS"]  += 1;
				}
				//appliedChange = true;
			}
			remove = function(){
				var weaponIndex = scFindWeapon(player.weaponList, attachmentFor);
				if(weaponIndex != -1){
					player.weaponList[| weaponIndex][? "TAPED_MAGS"] -= 1;
				}
				//appliedChange = true;
			}
			break;
		case ITEMS.HEALTH_2:
	        sprite_index = spItemHealth;
			image_index = 1;
			itemName = "Max Health Restore";
	        break;	
		case ITEMS.HEALTH_1:
	        sprite_index = spItemHealth;
			image_index = 0;
			itemName = "Health Restore";
	        break;	
		case ITEMS.WEAPON_SHOTGUN:
			sprite_index = spItemShotgun;
			image_index = 0;
			itemName = "Shotgun";
			rarity = 1;
			break;
		case ITEMS.WEAPON_PISTOL:
			sprite_index = spItemPistol;
			image_index = 0;
			itemName = "Pistol";
			rarity = 1;
			break;
		case ITEMS.WEAPON_RIFLE:
			sprite_index = spItemRifle;
			image_index = 0;
			itemName = "Rifle";
			rarity = 1;
			break;
		case ITEMS.WEAPON_SNIPER:
			sprite_index = spItemSniper;
			image_index = 0;
			itemName = "Sniper";
			rarity = 1;
			break;
		case ITEMS.WEAPON_SHOVEL:
			sprite_index = spItemShovel;
			image_index = 0;
			itemName = "Shovel";
			rarity = 1;
			break;
		case ITEMS.WEAPON_NADE:
			sprite_index = spItemNadeLauncher;
			image_index = 0;
			itemName = "Grenade Launcher";
			rarity = 1;
			break;
	}
	changed = false;
}