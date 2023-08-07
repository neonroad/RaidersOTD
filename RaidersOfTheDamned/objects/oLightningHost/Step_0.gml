/// @description  

if(checkDamage || !instance_exists(owner) || !instance_exists(target)) exit;

collision_rectangle_list(x-range,y-range,x+range,y+range,pShootable,false,true,hitList,false);

for (var i = 0; i < ds_list_size(hitList); i++) {
    if(ds_list_find_index(confirmList, hitList[|i]) == -1 && hitList[| i].id != owner && hitList[| i].id != target && !hitList[| i].shootable_map[? SHOOTABLE_MAP.DEAD] && hitList[| i].shootable_map[? SHOOTABLE_MAP.FRIENDLY] != owner.shootable_map[? SHOOTABLE_MAP.FRIENDLY] ){
		ds_list_add(confirmList, hitList[|i]);
		scDamage(hitList[|i], owner, 5, DAMAGE_TYPE.CHAIN);
	}
}

checkDamage = true;
