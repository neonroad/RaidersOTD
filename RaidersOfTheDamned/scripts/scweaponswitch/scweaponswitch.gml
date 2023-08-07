function scWeaponSwitch(force=false){
	var switchWeaponUp = mouse_wheel_up();
	var switchWeaponDown = mouse_wheel_down();
	if(force){
		switchWeaponUp = choose(0,1);
		switchWeaponDown = !switchWeaponUp;
	}
	if(!oCursor.reloading && !ds_list_empty(weaponList) && ds_list_size(weaponList) > 1){
		var index = scFindWeapon(weaponList, weaponEquipped);// ds_list_find_index(weaponList, weaponEquipped);
		if(index == -1) return false;
		if(index == ds_list_size(weaponList)-1 && switchWeaponUp){
			index = 0;
		}
		else if(index == 0 && switchWeaponDown){
			index = ds_list_size(weaponList)-1;	
		}
		else if(switchWeaponUp) index++;
		else if(switchWeaponDown) index--;
		
		if(switchWeaponDown || switchWeaponUp) audio_play_sound(snWeaponSwitch, 3, false);
		var curWeapon = weaponList[|index];
		weaponEquipped = curWeapon[?"WEAPON"];
		weaponEquippedSprite = curWeapon[? "WEAPON_SPRITE"];
		meleewep = curWeapon[?"MELEE"];
	}
	
	for (var i = 0; i < ds_list_size(inventory); i++) {
		if((inventory[|i].attachmentFor == noone || inventory[|i].attachmentFor == weaponEquipped) && !inventory[|i].appliedChange){
			inventory[|i].apply();	
		}
		else if(inventory[|i].attachmentFor != noone && inventory[|i].attachmentFor != weaponEquipped && inventory[|i].appliedChange){
			inventory[|i].unapply();	
		}
	}
	
}