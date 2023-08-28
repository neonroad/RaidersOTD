///scCheckCollision()
///@desc Calculates to see if entity can move to desired space
///Runs from within desired entity, so all built-in variables are accessible. 
function scCheckCollision() {

	
	var key_right = keyboard_check(ord("D"));
	var key_left = keyboard_check(ord("A"));
	var key_up = keyboard_check(ord("W"));
	var key_down = keyboard_check(ord("S"));
	
	var move_h = key_right - key_left;
	var move_v = key_down - key_up;

	////If cant control, neutralize move
	//if(!is_alive || !is_controlling)
	//	exit;
	

	var pixelsThisFrame = walk_speed;
	
	//MOB variables
	//move_hsp = 0;
	//move_vsp = 0;
	
	var prevX = x;
	var prevY = y;

	if ((move_h != 0 || move_v != 0)) {

		var dir = point_direction(0, 0, move_h, move_v);
		
		var movedSuccesfully = false;
		for (var i = 0; i <= 80 ; i += 10) {
			if(movedSuccesfully) break;
			for (var n = -1;  n <= 1; n += 2){
				var modifyDir = (n * i) + dir;	
				var xTarget = prevX + lengthdir_x(pixelsThisFrame, modifyDir);
				var yTarget = prevY + lengthdir_y(pixelsThisFrame, modifyDir);
				var modX = prevX + (lengthdir_x(pixelsThisFrame, modifyDir) * localTD);
				var modY = prevY + (lengthdir_y(pixelsThisFrame, modifyDir) * localTD);
				ds_list_clear(touchingWalls);
				var checkWall = instance_place_list(modX, modY, oWall, touchingWalls, false);
				
				var solidWall = false;
				if(!ignoreWalls){
					for (var j = 0; j < ds_list_size(touchingWalls); j++) {
						if(!variable_instance_exists(touchingWalls[|j], "open") || !touchingWalls[|j].open){
							solidWall = true;
							break;
						}
					}
				}
				if(!solidWall){
					x = modX;
					y = modY;
					movedSuccesfully = true;
				}
			}
		}
		
		//current speed
		shootable_map[? SHOOTABLE_MAP.HSP] = x - prevX;
		shootable_map[? SHOOTABLE_MAP.VSP] = y - prevY;
		
		//TRUE speed
		move_hsp = xTarget - prevX;
		move_vsp = yTarget - prevY;
		//show_debug_message(string(x) + "-" + string(prevX));
		
		angle_facing = darctan2(-move_vsp,move_hsp);
		
		return movedSuccesfully
		
	}


}

function scCheckCollision2() {

	var move_h = shootable_map[?SHOOTABLE_MAP.HSP];
	var move_v = shootable_map[?SHOOTABLE_MAP.VSP];

	//Remove walls touching every frame
	

	//If cant control, neutralize move
	
	
	var pixelsThisFrame = sqrt((move_h*move_h)+(move_v*move_v));
	
	var prevX = x;
	var prevY = y;

	if ((move_h != 0 || move_v != 0)) {

		var dir = point_direction(0, 0, move_h, move_v);
		
		var movedSuccesfully = false;
		for (var i = 0; i <= 80 ; i += 10) {
			if(movedSuccesfully) break;
			for (var n = -1;  n <= 1; n += 2){
				ds_list_clear(touchingWalls);
				var modifyDir = (n * i) + dir;	
				var xTarget = prevX + lengthdir_x(pixelsThisFrame, modifyDir);
				var yTarget = prevY + lengthdir_y(pixelsThisFrame, modifyDir);
				var modX = prevX + (lengthdir_x(pixelsThisFrame, modifyDir)*localTD);
				var modY = prevY + (lengthdir_y(pixelsThisFrame, modifyDir)*localTD);
				var checkWall = instance_place_list(xTarget, yTarget, oWall, touchingWalls, false);
				var solidWall = false;
				if(!ignoreWalls){
					for (var j = 0; j < ds_list_size(touchingWalls); j++) {
						if(!variable_instance_exists(touchingWalls[|j], "open") || !touchingWalls[|j].open){
							solidWall = true;
							break;
						}
					}
				}
				if(!solidWall){
					x = modX;
					y = modY;
					movedSuccesfully = true;
				}
				////destroy wall
				//if(object_index == oMobGrunt && solidWall){
				//	instance_destroy(checkWall);
				//	oGame.reloadWalls();
				//	scUIShakeSet(10,10);
				//	part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-2,bbox_bottom+2,ps_shape_ellipse,ps_distr_linear);
				//	part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_smoke1, irandom_range(14,18));
					

				//}
				
				
				//if(checkWall != noone || (variable_instance_exists(checkWall, "open") && !checkWall.open)){
				//	if(!array_find_index(touchingWalls, function(element, index, checkWall){
				//		return element == checkWall;
				//	})){
				//		array_push(touchingWalls, checkWall);	
				//	}
				//}
			}
		}
		//OBSERVED speed
		//shootable_map[? SHOOTABLE_MAP.HSP] = x - prevX;
		//shootable_map[? SHOOTABLE_MAP.VSP] = y - prevY;
		
		//TRUE speed
		move_hsp = xTarget - prevX;
		move_vsp = yTarget - prevY;
		return movedSuccesfully
		
		
	}


}