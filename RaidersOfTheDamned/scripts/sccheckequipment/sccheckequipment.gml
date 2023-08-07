function scCheckEquipment(){
	
	var changed = scRoomChanged();
	
	if(ds_list_empty(weaponList)){
		weaponEquipped = noone;	
	}
	
	else if(ds_list_size(weaponList) == 1){
		weaponEquipped = weaponList[|0][? "WEAPON"];
		weaponEquippedSprite = weaponList[|0][? "WEAPON_SPRITE"];
		meleewep = weaponList[|0][? "MELEE"];
	}
	
	oPlayer.bullets = 0;
	for (var i = 0; i < array_length(oPlayer.invObj.invArray); i++) {
		var item = oPlayer.invObj.invArray[i];
		if(!meleewep && weaponEquipped != noone && scFindWeapon(oPlayer.weaponList, weaponEquipped) != -1 && item.itemID == oPlayer.weaponList[| scFindWeapon(oPlayer.weaponList, weaponEquipped)][? "BULLET_TYPE"]){
			oPlayer.bullets  += item.stackAmount;
		}

	}
	
	//Infinite pistol ammo
	if(weaponEquipped == ITEMS.WEAPON_PISTOL)
		oPlayer.bullets = 99;
	
	if(laserpointer && (laserObj == noone || changed) ){
		show_debug_message(laserObj);
		laserObj = instance_create_layer(x,y,"Instances",oLaser);
		laserObj.owner = id;	
		show_debug_message("made laser");
	}
	
	else if(!laserpointer && laserObj != noone){
		instance_destroy(laserObj);	
	}

	if(flashlight != noone && (flashlightObj == noone || changed) ){
		flashlightObj = instance_create_layer(x,y, "Instances", oLightFollow);
		show_debug_message("Made flashlight");
		var lightF = flashlightObj;
		lightF.sprite_index = spr_Aura_TorchPP;
		lightF.image_xscale = 4;
		lightF.image_yscale = 1;
		lightF.owner = id;
	}
	else if(flashlight == noone && flashlightObj != noone){
		instance_destroy(flashlightObj);
	}
}