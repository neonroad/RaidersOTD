/// @description  

//if !oGame.play exit;

event_inherited();



ai_start_cooldown-= localTD;
if(ai_start_cooldown == -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	despawnTime-= localTD;
	alpha = lerp(alpha, 0.8, 0.05*localTD);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(!deadSpriteChosen){
		
		//if(deadSprite == spWormDogDie1 && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -1*facing) deadSprite = spWormDogDie3;
		//else if(deadSprite == spWormDogDie1 && currentSpeed == 0) deadSprite = spWormDogDie4;
	}
	
	
	if(currentSprite != deadSprite && !deadSpriteChosen){
		animVar = 0;
		currentSprite = deadSprite;
		deadSpriteChosen = true;
	}
	else{
		if(!deadSpriteAnimLoop && animVar >= sprite_get_number(deadSprite)-1){
			animVar = sprite_get_number(deadSprite)-1;
		}
		if(deadSpriteAnimLoop && currentSpeed < 0.05) animVar -= image_speed*localTD;
	}
	
	if(despawnTime <= 0){
		surface_set_target(oDecalSurf.surf);
		draw_sprite_ext(currentSprite, floor(animVar), x, y, !asym ? -facing*scale : 1, scale, 0, c_color, alpha);
		surface_reset_target();
		instance_destroy();
		exit;
	}
}


//if(ai_start_cooldown > 0 && instance_place(x,y,oWall) != noone) instance_destroy();
if(ai_start_cooldown > 0) exit;
/*
if(flash_frames > 0)
	control = false;
else
	control = true;
*/

	
if(!shootable_map[? SHOOTABLE_MAP.DEAD] && (!instance_exists(target) && current_state == WISP_STATE.CHARGING) || (!shootable_map[? SHOOTABLE_MAP.DEAD] && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0)){
	currentSprite = idleSprite;
	current_state = WISP_STATE.IDLE;
	walk_speed = walk_speed_base;
}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	
	
	if(current_state == WISP_STATE.WALKING)
		currentSprite = walkSprite;
	else if(current_state == WISP_STATE.ATTACKING)
		currentSprite = attackSprite;
	else if(current_state == WISP_STATE.CHARGING)
		currentSprite = chargeSprite;
	
	
	
	currentPath = path_add();
	
	if(!instance_exists(target)){
		if(prevX == x && prevY == y){
			mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);	
		}
	}
	else{
		if(prevX == x && prevY == y){
			mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true);	
		}	
	}
		
		
	
	
	
	if(currentPath != noone){
		
		
		scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
		
		currentSpeed = walk_speed;
		shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, angleFacing);
		shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(currentSpeed, angleFacing);
		
		path_delete(currentPath);
		
		if(instance_exists(target) && !target.shootable_map[? SHOOTABLE_MAP.DEAD] && point_distance(x,y,target.x,target.y) < 10 && current_state == WISP_STATE.CHARGING){
			scDamage(target, id, 10, DAMAGE_TYPE.TOUCH);
			attacking = target;
			shootable_map[? SHOOTABLE_MAP.DEAD] = true;	
		}
		
	}
	
	
	
	
	
}

else if(!control || shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0, friction_base * localTD);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	//if(currentSpeed > 0.01 && (shootable_map[?SHOOTABLE_MAP.DEAD])) scParticleBurst(x,y,x,y,irandom_range(1,3),3,30,c_red);
	
	
	
	
}


//Hurt on collision

ds_list_clear(hitList);
var padding = attack_range;
var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);



if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	if (0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			//Connect attack
			if(!ent_hit.shootable_map[? SHOOTABLE_MAP.DEAD] && !ent_hit.shootable_map[?SHOOTABLE_MAP.FRIENDLY] && current_state != WISP_STATE.CHARGING && !instance_exists(target)){
				target = ent_hit;
				current_state = WISP_STATE.CHARGING;
				walk_speed *= 5;
				break;
				
			}
		}	
		
	}
	
	if(invisible){
		alpha = 0;
		if(point_distance(x,y,oPlayer.x,oPlayer.y) < 40){
			alpha = (40-point_distance(x, y, oPlayer.x, oPlayer.y))/40;	
		}
		if(animVar%2 == 0){
			part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-5,bbox_bottom+5,ps_shape_ellipse,ps_distr_linear);
			part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_invis, irandom(3));
		}
		
	}
}




currently_attacking = current_state == WISP_STATE.CHARGING;
damageTaken = currently_attacking ? 2 : 1;

contact_cooldown-= localTD;

if(instance_place(x,y,oWall) == noone){
	prevX = x;
	prevY = y;
}
else if(!ignoreWalls){
	var attempts = 0;
	while(attempts < 100 && instance_place(x,y,oWall) != noone){
		x = lerp(x,prevX,0.1);
		y = lerp(y,prevY,0.1);
		attempts++;
		if(x == prevX && y == prevY){
			x++;
			y++;
			prevX = x;
			prevY = y;
		}
	}
}

scCheckCollision2();

var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = -1;
else
	facing = 1;




