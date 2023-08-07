/// @description Insert description here
// You can write your code in this editor
if(instance_exists(owner))
	timer-= owner.localTD;
else
	timer -= global.TD;
	
if(owner != noone && !owner.shootable_map[? SHOOTABLE_MAP.DEAD]){
	x0 = owner.x+lengthdir_x(10,point_direction(x,y,x + lengthdir_x(100,owner.angleFacing), y - lengthdir_y(100, owner.angleFacing)));
	y0 = owner.y+lengthdir_y(10,point_direction(x,y,x + lengthdir_x(100,owner.angleFacing), y - lengthdir_y(100, owner.angleFacing)));
	
	x = x0;
	y = y0;
	
	x1 = owner.x+lengthdir_x(100,point_direction(x,y,x + lengthdir_x(100,owner.angleFacing), y - lengthdir_y(100, owner.angleFacing)));
	y1 = owner.y+lengthdir_y(100,point_direction(x,y,x + lengthdir_x(100,owner.angleFacing), y - lengthdir_y(100, owner.angleFacing)));
	
	var dx = abs(x1-x0);
	var sx = -1;
	if(x0 < x1) sx = 1;	
	var dy = -abs(y1-y0)
	var sy = -1;
	if(y0 < y1) sy = 1;
	var error = dx+dy;
	var e2 = 0;
	while true{
		ds_list_clear(hitList);
		x0 = floor(x0);
		y0 = floor(y0);
		x1 = floor(x1);
		y1 = floor(y1);
		//var wallHit = instance_place(x0,y0,oWall);
		//var entHit = instance_place_list(x0,y0,pShootable,hitList,false);
		
		//if(wallHit != noone && ds_list_empty(hitList)){
		//	hit = true;
		//	x1 = x0;
		//	y1 = y0;
			
		//	break;
		//}
		
		//else if(!ds_list_empty(hitList)){
		//	for (var i = 0; i < ds_list_size(hitList); i++) {
		//		var mob = hitList[|i];	
		//		if(mob.id != owner.id && !mob.shootable_map[?SHOOTABLE_MAP.DEAD]){
		//			x1 = x0;
		//			y1 = y0;
		//			hit = true;
		//		}
		//	}
			
		//}
		
		
		
		if(x0 == x1 && y0 == y1) break;	
		e2 = 2*error;
		if(e2 >= dy){
			if(x0 == x1) break;
			error += dy;
			x0 += sx;
		}
		if(e2 <= dx){
			if(y0 == y1) break;
			error += dx;
			y0 += sy;
		}
	}	
	var col1 = instance_exists(owner.target) && owner.target.object_index == oPlayer ? make_color_rgb(211,160,104) : make_color_rgb(162,220,199);
	var col2 = instance_exists(owner.target) && owner.target.object_index == oPlayer ? make_color_rgb(180,82,82) : make_color_rgb(75,128,202);
	scPlotLine(floor(x),floor(y),x1,y1, 
	col1, clamp(floor(timer),1,2), 
	col2);
}