function scFindWeapon(weaponList, targetWeapon){
	for (var i = 0; i < ds_list_size(weaponList); i++) {
	    if(weaponList[| i][? "WEAPON"] == targetWeapon) return i;
	}
	return -1;
}