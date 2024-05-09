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
		if(currentSpeed == 0 && shootable_map[? SHOOTABLE_MAP.HEALTH] <= -shootable_map[? SHOOTABLE_MAP.HEALTH_START]*2) deadSprite = spWormDogDieSplat;	
		if(deadSprite == spWormDogDie1 && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -1*facing) deadSprite = spWormDogDie3;
		else if(deadSprite == spWormDogDie1 && currentSpeed == 0) deadSprite = spWormDogDie4;
	}
	
	
	if(currentSprite != deadSprite && !deadSpriteChosen){
		animVar = 0;
		currentSprite = deadSprite;
		deadSpriteChosen = true;
	}
	else{
		if(animVar >= sprite_get_number(deadSprite)-1){
			animVar = sprite_get_number(deadSprite)-1;
		}
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

target = instance_nearest(x,y, oPlayer);

//on miss?

if(!shootable_map[? SHOOTABLE_MAP.DEAD] && current_state != DOG_STATE.CHARGING && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
	currentSprite = idleSprite;
	current_state = DOG_STATE.IDLE;
	walk_speed = walk_speed_base;
	damageTaken = 1;
	deadSprite = spWormDogDie1;
	endChargeX = x;
	endChargeY = y;
	//show_debug_message(point_distance(startChargeX, startChargeY, endChargeX, endChargeY));
}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(current_state == DOG_STATE.IDLE && (shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[?SHOOTABLE_MAP.VSP] != 0)){
		current_state = DOG_STATE.WALKING;
		currentSprite = walkSprite;
	}
	
	
	currentPath = path_add();
	if(target != noone){
		
		if((prevX == x && prevY == y) || !mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true))
			if(current_state != DOG_STATE.ATTACKING){
				scLookAt(target.x, target.y);
			}
		
		//Attack
		if(current_state == DOG_STATE.WALKING && oPlayer.iframes <= 0 && contact_cooldown <= 0 && checkLOS() && point_distance(x,y,target.x,target.y)<attack_range){
			contact_cooldown = contact_cooldown_max;
			currentSprite = chargeSprite;
			walk_speed = 0;
			animVar = 0;
			current_state = DOG_STATE.CHARGING;
			//growlTimeMax = 30;
			growlTimeCurrent = growlTimeMax;
			part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
			audio_play_sound_at(snRun1, x, y, 0, 60, 240, 0.5, false, 2);
		}
		//else if(current_state != WORM_STATE.CHARGING && current_state != WORM_STATE.ATTACKING){
		//	current_state = WORM_STATE.WALKING;	
		//}
	}
	
	
	if(currentPath != noone){
		
		if(target != noone && current_state != DOG_STATE.ATTACKING)
			//scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
		
		currentSpeed = walk_speed;
		shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, angleFacing);
		shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(currentSpeed, angleFacing);
		
		path_delete(currentPath);
		
		if(current_state == DOG_STATE.ATTACKING){
			walk_speed = lerp(walk_speed,0,friction_base*localTD);	
			if(abs(walk_speed)<1) walk_speed = 0;
		}
		
		if(current_state != DOG_STATE.CHARGING && current_state != DOG_STATE.ATTACKING && (shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[? SHOOTABLE_MAP.VSP] != 0)){
			current_state = DOG_STATE.WALKING;	
			currentSprite = walkSprite;
		}
		
	}
	
	
	
	
	
}

else if(!control || shootable_map[?SHOOTABLE_MAP.DEAD] || current_state == DOG_STATE.ATTACKING){
	
	if(shootable_map[? SHOOTABLE_MAP.DEAD]) friction_base = 0.25;
	
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0, friction_base * localTD);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	//if(currentSpeed > 0.01*localTD && shootable_map[?SHOOTABLE_MAP.DEAD]) scParticleBurst(x,y,x,y,irandom_range(1,3),3,30,c_white);
		
}



//Hurt on collision

ds_list_clear(hitList);
var padding = -2;
var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);




if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	if (control && 0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			
			//Connect attack
			
			if(ent_hit.id == target.id && current_state == DOG_STATE.ATTACKING && oPlayer.iframes <= 0 && oPlayer.current_state == PLAYER_STATE.PLAYING){
				
				ent_hit.iframes =180;
				ent_hit.current_state = scStateManager(PLAYER_STATE.HURT, ent_hit);
				attacking = ent_hit.id;
				audio_play_sound_at(snChomp, x, y, 0, 60, 240, 0.5, false, 2);
				

				if(!scDamage(attacking,id,1,DAMAGE_TYPE.BULLET)) audio_play_sound_at(snHurt1, attacking.x, attacking.y, 0, 60, 240, 0.5, false, 2);
			
				attacking.current_state = scStateManager(PLAYER_STATE.ENDSTUN,attacking);
				
				scParticleBurst(attacking.x,attacking.y,attacking.x+10,attacking.y+10,15,1,100,attacking.bloodColor);
				attacking = noone;
				break;
			}
		}	
		
	}
	
	if(current_state == DOG_STATE.ATTACKING && !ds_list_empty(touchingWalls)){
		scDamage(id,id,10,DAMAGE_TYPE.MELEE);	
	}
	
	if(invisible){
		alpha = 0;
		if(point_distance(x,y,target.x,target.y) < 40){
			alpha = (40-point_distance(x, y, target.x, target.y))/40;	
		}
		if(animVar%2 == 0){
			part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-5,bbox_bottom+5,ps_shape_ellipse,ps_distr_linear);
			part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_invis, irandom(3));
		}
		
	}
	
	//Animation check
	if(animVar >= sprite_get_number(currentSprite)){
		//Nothing here
	}
	
	if(control && current_state == DOG_STATE.CHARGING && growlTimeCurrent > 0){
		
		growlTimeCurrent-= localTD;
		
		//Leap
		if(growlTimeCurrent <= 5 && deadSprite != spWormDogCharge){
			damageTaken *= 2;	
			deadSprite = spWormDogDieCharge;
		}
		else if(growlTimeCurrent > 5) scLookAt(target.x + target.shootable_map[? SHOOTABLE_MAP.HSP]*5,target.y+ target.shootable_map[? SHOOTABLE_MAP.VSP]*5);
		
		if(growlTimeCurrent <= 0){
			current_state = DOG_STATE.ATTACKING;
			currentSprite = attackSprite;
			shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(lungeSpeed, angleFacing);
			shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(lungeSpeed, angleFacing);
			walk_speed = sqrt((shootable_map[?SHOOTABLE_MAP.HSP]*shootable_map[?SHOOTABLE_MAP.HSP])+(shootable_map[?SHOOTABLE_MAP.VSP]*shootable_map[?SHOOTABLE_MAP.VSP]));
			//crowdcontrol_cooldown = 30;
			deadSprite = spWormDogDie2;
			startChargeX = x;
			startChargeY = y;
			
		}
		
	}
}

currently_attacking = current_state == DOG_STATE.ATTACKING;


contact_cooldown-= localTD;

scCheckCollision2();

var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = -1;
else
	facing = 1;




