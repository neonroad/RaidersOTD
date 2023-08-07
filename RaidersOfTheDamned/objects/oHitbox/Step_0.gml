/// @description  


ds_list_clear(hitList)
var hitNum = instance_place_list(x,y,pShootable,hitList,false);
for (var i = 0; i < ds_list_size(hitList); i++){
	hitboxScript(hitList[|i]);
}	


if(image_index >= image_number-1){
	instance_destroy();
}

image_speed = owner.localTD;
timer += owner.localTD;
