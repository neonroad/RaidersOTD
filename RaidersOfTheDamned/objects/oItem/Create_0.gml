/// @description Insert description here
// You can write your code in this editor

enum ITEMS {
	FLASHLIGHT_BASIC, FLASHLIGHT_SUPER, AMMO_1, AMMO_2, AMMO_3, LASERPOINT, HEALTH_1, HEALTH_2, 
	WEAPON_PISTOL, WEAPON_SHOTGUN, WEAPON_RIFLE, MAG_UP_PISTOL, WEAPON_SNIPER, AMMO_4,
	HPR_RIFLE, ERGO_PUMP, TIGHT_CHOKE, TAPED_MAG, WEAPON_NADE, ITEM_GRENADES, WEAPON_SHOVEL,
	KEYCARD_GREEN,
	LENGTH	
	
}

player = noone;
surf = noone;
faked = false;
rarity = 0;
partTimer = 0;
interacted = false;
itemMap = noone;

image_speed = 0;
image_xscale = 1;
image_yscale = 1;

if(itemEnum == 0){
	var item = irandom(100);
	if(item < 3)
		itemEnum = ITEMS.FLASHLIGHT_SUPER;
	else if(item < 6)
		itemEnum = ITEMS.LASERPOINT;
	else if(item < 9)
		itemEnum = ITEMS.HEALTH_1;
	else if(item < 10)
		itemEnum = ITEMS.HEALTH_2;
	else if(item < 20)
		itemEnum = ITEMS.WEAPON_PISTOL;
	else if(item < 23)
		itemEnum = ITEMS.WEAPON_SHOTGUN;
	else if(item < 25)
		itemEnum = ITEMS.WEAPON_RIFLE;
	else if(item < 30)
		itemEnum = ITEMS.AMMO_3;
	else if(item < 35)
		itemEnum = ITEMS.AMMO_2;
	else if(item < 45)
		itemEnum = ITEMS.AMMO_1;
	else if(item < 46)
		itemEnum = ITEMS.MAG_UP_PISTOL;
	else if(item < 47)
		itemEnum = ITEMS.WEAPON_SNIPER;
	else if(item < 48)
		itemEnum = ITEMS.AMMO_4;
	else if(item < 49)
		itemEnum = ITEMS.HPR_RIFLE;
	else if(item < 50)
		itemEnum = ITEMS.ERGO_PUMP;
	else if(item < 51)
		itemEnum = ITEMS.TIGHT_CHOKE;
	else if(item < 52)
		itemEnum = ITEMS.TAPED_MAG;
	else if(item < 53)
		itemEnum = ITEMS.WEAPON_NADE;
	else if(item < 54)
		itemEnum = ITEMS.ITEM_GRENADES;
	else if(item < 55)
		itemEnum = ITEMS.WEAPON_SHOVEL;
	else
		itemEnum = ITEMS.AMMO_1;
}


changed = true;

stackAmount = 1;
stackMax = 1;


attachmentFor = noone;
attachmentSlot = -1;
appliedChange = false;
in_pack = false;
popup = noone;

itemName = "";

add = function(){
	show_debug_message("Nothing to add");	
}

apply = function(){
	//show_debug_message("Nothing to apply");	
}

unapply = function(){
	//show_debug_message("Nothing to unapply");	
}

remove = function(){
	show_debug_message("Nothing to remove");	
}