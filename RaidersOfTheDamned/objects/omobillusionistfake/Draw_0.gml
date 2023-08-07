/// @description  

draw_self();

if(!instance_exists(eyes) && !place_meeting(x, y, obj_Aura_Light_Parent)){
	eyes = instance_create_layer(x,y,"Instances", oIllusionEyes);	
}

//draw_arrow(x,y, x+ lengthdir_x(abs(shootable_map[?SHOOTABLE_MAP.HSP])*1000,darctan2(-shootable_map[?SHOOTABLE_MAP.VSP],shootable_map[?SHOOTABLE_MAP.HSP])), y +lengthdir_y(abs(shootable_map[?SHOOTABLE_MAP.VSP])*1000,darctan2(-shootable_map[?SHOOTABLE_MAP.VSP],shootable_map[?SHOOTABLE_MAP.HSP])), 10)
//draw_line_width(x,y, x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing),10);
