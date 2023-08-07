/// @description  
animVar++;

if(instance_exists(target)){
	x = target.x;
	y = target.y;
}

for (var i = 0; i < ds_list_size(confirmList); i++) {
	if(!instance_exists(confirmList[|i])) continue;
	draw_sprite_ext(spLightningBolt,animVar+random(2),x,y,point_distance(x,y,confirmList[|i].x,confirmList[|i].y)/sprite_get_width(spLightningBolt),1,point_direction(x,y,confirmList[|i].x,confirmList[|i].y),c_white,1);
}

if(animVar > 10) instance_destroy()


