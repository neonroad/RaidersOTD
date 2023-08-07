/// @description Insert description here
// You can write your code in this editor


if(owner != noone && !owner.shootable_map[? SHOOTABLE_MAP.DEAD] && owner.bullets > 0){
	x0 = owner.x+lengthdir_x(7,owner.angleAiming);
	y0 = owner.y+lengthdir_y(7,owner.angleAiming);
	
	x = x0;
	y = y0;
	
	x1 = owner.x+lengthdir_x(350,owner.angleAiming);
	y1 = owner.y+lengthdir_y(350,owner.angleAiming);
	
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
		var wallHit = instance_place(x0,y0,oWall);
		var entHit = instance_place_list(x0,y0,pShootable,hitList,false);
		
		if(wallHit != noone && ds_list_empty(hitList)){
			hit = true;
			x1 = x0;
			y1 = y0;
			
			break;
		}
		
		else if(!ds_list_empty(hitList)){
			for (var i = 0; i < ds_list_size(hitList); i++) {
				var mob = hitList[|i];	
				if(mob.id != owner.id && !mob.shootable_map[?SHOOTABLE_MAP.DEAD]){
					x1 = x0;
					y1 = y0;
					hit = true;
				}
			}
			
		}
		
		
		
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
	scPlotLine(floor(x),floor(y),x1,y1, c_red);
}