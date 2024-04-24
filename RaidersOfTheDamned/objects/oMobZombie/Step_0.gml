/// @description  

//if !oGame.play exit;

event_inherited();

function checkLOS(){
	var wall = collision_line(x,y,target.x,target.y,oWall, false,true);	
	if(wall != noone){
		if(variable_instance_exists(wall, "open"))
			if(wall.open) return true;
	
		return false;
	}
	return true;
}


ai_start_cooldown-= localTD;
if(ai_start_cooldown == -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	justDied = false;
	despawnTime-= localTD;
	//alpha = lerp(alpha, 0.8, 0.05*localTD);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(!deadSpriteChosen){
		if(deadSprite == spZombieDie && sign(shootable_map[? SHOOTABLE_MAP.VSP]) == -1) deadSprite = choose(spZombieDie4);
		if(deadSprite == spZombieDie && sign(shootable_map[? SHOOTABLE_MAP.VSP]) == 1) deadSprite = choose(spZombieDie3);
		
		if(deadSprite == spZombieDie && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -facing) deadSprite = choose(spZombieDie4, spZombieDie5);
		
		if(shootable_map[? SHOOTABLE_MAP.HEALTH] <= -shootable_map[? SHOOTABLE_MAP.HEALTH_START]*2 && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -facing){
			//scParticleBurst(x,y,x,y,irandom_range(1,3),3,30,c_lime);
			deadSprite = choose(spZombieDieOverkillF, spZombieDieOverkillF2);	
		}
		else if(shootable_map[? SHOOTABLE_MAP.HEALTH] <= -shootable_map[? SHOOTABLE_MAP.HEALTH_START]*0.75 && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -facing) deadSprite = spZombieDie2;	
		
		else if(deadSprite == spZombieDieChargeB && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -facing) deadSprite = spZombieDieChargeF;	
		else if(deadSprite == spZombieDieLaunch && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == -facing){
			deadSprite = spZombieDieLaunchB;
			deadSpriteAnimLoop = true;
		}
		else if(deadSprite == spZombieDieLaunch && sign(shootable_map[? SHOOTABLE_MAP.HSP]) == facing){
			deadSprite = spZombieDieLaunch;
			deadSpriteAnimLoop = true;
		}
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
		if(deadSpriteAnimLoop && currentSpeed < 0.05*localTD) animVar -= image_speed*localTD;
	}
	
	if(despawnTime <= 0){
		surface_set_target(oDecalSurf.surf);
		draw_sprite_ext(currentSprite, floor(animVar), x, y, !asym ? -facing*scale : 1, scale, 0, c_color, alpha);
		surface_reset_target();
		instance_destroy();
		exit;
	}
	
	if(ds_list_size(touchingWalls)>0){
		surface_set_target(oDecalSurfW.surf);
		draw_sprite_ext(spBloodSplatWall,irandom(sprite_get_number(spBloodSplatWall)),x,y,0.3,0.3,point_direction(x,y,x+shootable_map[? SHOOTABLE_MAP.HSP],y+shootable_map[? SHOOTABLE_MAP.VSP])-90,make_color_hsv(color_get_hue(bloodColor), color_get_saturation(bloodColor), color_get_value(bloodColor)-10),1);
		surface_reset_target();
		oDecalSurf.drawnTo = true;	
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

var prevTarget = target;
target = point_distance(x,y, instance_nearest(x,y,oPlayer).x, instance_nearest(x,y,oPlayer).y) < attack_range*1.5 ? instance_nearest(x,y,oPlayer) : noone;
if(control && target != prevTarget) part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);


	
//if(!shootable_map[? SHOOTABLE_MAP.DEAD] && current_state != ZOMBIE_STATE.ATTACKING && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
//	currentSprite = idleSprite;
//	current_state = ZOMBIE_STATE.IDLE;
//	walk_speed = walk_speed_base;
//	deadSprite = spZombieDie;
	
//	if(point_distance(x,y,target.x,target.y) < 128) current_state = ZOMBIE_STATE.WALKING;
//}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[?SHOOTABLE_MAP.VSP] != 0){
		if(current_state == ZOMBIE_STATE.WALKING){
			currentSprite = walkSprite;
			if(target == noone) currentSprite = spZombieWalk;
		}
		else if(current_state == ZOMBIE_STATE.ATTACKING)
			currentSprite = attackSprite;
	}
	
	else{
		if(current_state == ZOMBIE_STATE.DOORLEANSTART)
			currentSprite = spZombieDoorLean;
		else if(current_state == ZOMBIE_STATE.DOORLEANLOOP)
			currentSprite = spZombieDoorLeanHit;
		else if(current_state == ZOMBIE_STATE.DOORLEANFAIL)
			currentSprite = spZombieDoorLeanFail;
		else if(current_state == ZOMBIE_STATE.WALKING)
			currentSprite = idleSprite;
	}
	
	
	if(pathfindCooldown <= 0) currentPath = path_add();
	var madePath = false;
	if(target != noone && path_exists(currentPath)){
		if(prevX == x && prevY == y){
			madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true);	
		}
		
		pathfindCooldown = 10+irandom_range(-5,5);
		//Attack
		if(current_state == ZOMBIE_STATE.WALKING && target.iframes <= 0 && contact_cooldown <= 0 && checkLOS() && point_distance(x,y,target.x,target.y)<attack_range && target.current_state == PLAYER_STATE.PLAYING){
			contact_cooldown = contact_cooldown_max;
			currentSprite = chargeSprite;
			walk_speed *= 2;
			animVar = 0;
			current_state = ZOMBIE_STATE.CHARGING;
			currentSprite = spZombieCharge;
			part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
			audio_play_sound_at(snRun1, x, y, 0, 60, 240, 0.5, false, 2);
			deadSprite = spZombieDieChargeB;
			startChargeX = x;
			startChargeY = y;
		}
		else if(current_state == ZOMBIE_STATE.WALKING){
			walk_speed = walk_speed_base;	
		}
		//else if(current_state != ZOMBIE_STATE.CHARGING && current_state != ZOMBIE_STATE.ATTACKING){
		//	current_state = ZOMBIE_STATE.WALKING;	
		//}
		/**localTD*/;
	}
	
	else if((current_state != ZOMBIE_STATE.DOORLEANLOOP && current_state != ZOMBIE_STATE.DOORLEANSTART) && target == noone && path_exists(currentPath)){
		walk_speed = walk_speed_base*0.5;
		//madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32*5,32*5),y+irandom_range(-32,32),true);		
		madePath = true;
		
		pathfindCooldown_Max = irandom_range(100,360);
		pathfindCooldown = pathfindCooldown_Max;
	}
	
	else if(pathfindCooldown <= 0){
		walk_speed = 0;	
		currentSprite = idleSprite;
		pathfindCooldown = pathfindCooldown_Max;
	}
	
		
	if(!instance_exists(target) && madePath)
		scLookAt(x+irandom_range(-32*5,32*5),y+irandom_range(-32*5,32*5));
	else if(instance_exists(target) && madePath)
		scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
	else if(instance_exists(target) && point_distance(x,y, target.x, target.y) < 500)
		scLookAt(target.x, target.y);
	
	
	shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(walk_speed, angleFacing);
	shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(walk_speed, angleFacing);
		
	
		
	pathfindCooldown -= localTD;
	
	if(pathfindCooldown <= 0) path_delete(currentPath);
	
	
	
	
}

else if(!control || shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	
	
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0,localTD * friction_base);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	//if(currentSpeed > 0.01*localTD && (shootable_map[?SHOOTABLE_MAP.DEAD])) scParticleBurst(x,y,x,y,irandom_range(1,3),3,30,c_red);
		
}


//FIX AUDIO/TIME SYNCH
//if(currentSprite == spZombieRun && point_distance(x, y, target.x, target.y) < 300){
//	if(animVar%8 == 2)
//		audio_play_sound_at(snWalk1, x, y, 0, 60, 240, 0.5, false, 0);	
//	if(animVar%8 == 6)
//		audio_play_sound_at(snWalk2, x, y, 0, 60, 240, 0.5, false, 0);
//}





//Hurt on collision

ds_list_clear(hitList);
var padding = 2;
var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);

//var shuffled = false;


if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	if (control && 0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
				
			//Connect attack
			
			if(ent_hit.id == oPlayer.id && current_state == ZOMBIE_STATE.CHARGING && oPlayer.iframes <= -30 && oPlayer.current_state == PLAYER_STATE.PLAYING){
				current_state = ZOMBIE_STATE.ATTACKING;
				animVar = 0;
				currentSprite = attackSprite;
				walk_speed = 0;
				ent_hit.iframes = 90;
				ent_hit.current_state = scStateManager(PLAYER_STATE.HURT, ent_hit);
				ent_hit.move_hsp = 0;
				ent_hit.move_vsp = 0;
				ent_hit.shootable_map[? SHOOTABLE_MAP.HSP] = 0;
				ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = 0;
				attacking = ent_hit.id;
				audio_play_sound_at(snChomp, x, y, 0, 60, 240, 0.5, false, 2);
				
			}
		}	
		
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
		if(current_state == ZOMBIE_STATE.CHARGING){
			if(currentSprite != spZombieCharge || irandom(2) != 1){	
				current_state = ZOMBIE_STATE.WALKING;
				walk_speed = walk_speed_base;
				deadSprite = spZombieDie;
				endChargeX = x;
				endChargeY = y;
			}
			else{
				animVar = 0;
			}
			//show_debug_message(point_distance(startChargeX,startChargeY,endChargeX,endChargeY));
		}
		else if(current_state == ZOMBIE_STATE.ATTACKING){
			current_state = ZOMBIE_STATE.WALKING;	
			if(!scDamage(attacking,id,1,DAMAGE_TYPE.BULLET)) audio_play_sound_at(snHurt1, attacking.x, attacking.y, 0, 60, 240, 0.5, false, 2);
			
			attacking.current_state = scStateManager(PLAYER_STATE.ENDSTUN,attacking);
			
			attacking.iframes += 90;
			walk_speed = walk_speed_base;
			
			scParticleBurst(attacking.x,attacking.y,attacking.x+10,attacking.y+10,15,1,100,bloodColor);
			attacking = noone;
			
			
		}
		else if(current_state == ZOMBIE_STATE.DOORLEANSTART){
			animVar = 0;
			current_state = ZOMBIE_STATE.DOORLEANLOOP;
			currentSprite = spZombieDoorLeanHit;
		}
		else if(current_state == ZOMBIE_STATE.DOORLEANFAIL){
			current_state = ZOMBIE_STATE.WALKING;
			walk_speed = walk_speed_base;
		}
		else if(current_state == ZOMBIE_STATE.FLINCHING){
			current_state = ZOMBIE_STATE.WALKING;
			walk_speed = walk_speed_base;
		}
	}
	
	//Other checks (while alive)
	if(instance_exists(doorLeaningOn)){
		if(current_state == ZOMBIE_STATE.DOORLEANSTART && doorLeaningOn.open){
			animVar = 0;
			current_state = ZOMBIE_STATE.DOORLEANFAIL;
			currentSprite = spZombieDoorLeanFail;
			shootable_map[? SHOOTABLE_MAP.HSP] += facing*0.25;
			contact_cooldown += 40 + irandom(40);
			doorLeaningOn = noone;
		}
		if(current_state == ZOMBIE_STATE.DOORLEANLOOP && doorLeaningOn.open){
			doorLeaningOn = noone;
			current_state = ZOMBIE_STATE.WALKING;
			walk_speed = walk_speed_base;
		}
		if(current_state == ZOMBIE_STATE.CHARGING && !doorLeaningOn.open && currentSprite != spZombieDoorCharge){
			doorLeaningOn = noone;
			currentSprite = spZombieDoorCharge;
			currentSpeed = 0;
			animVar = 0;
		}
	}
		
}

currently_attacking = current_state == ZOMBIE_STATE.CHARGING;
damageTaken = currently_attacking ? 2 : 1;

contact_cooldown-= localTD;


//TODO: REFACTOR FOR BETTER PERFORMANCE
//if(instance_place(x,y,oWall) == noone){
//	prevX = x;
//	prevY = y;
//}
//else if(!ignoreWalls){
//	var attempts = 0;
//	while(attempts < 100 && instance_place(x,y,oWall) != noone){
//		x = lerp(x,prevX,0.1);
//		y = lerp(y,prevY,0.1);
//		attempts++;
//		if(x == prevX && y == prevY){
//			x++;
//			y++;
//			prevX = x;
//			prevY = y;
//		}
//	}
//}

scCheckCollision2();

if(current_state != ZOMBIE_STATE.DOORLEANFAIL && current_state != ZOMBIE_STATE.DOORLEANLOOP && current_state != ZOMBIE_STATE.DOORLEANSTART){
	for (var i = 0; i < ds_list_size(touchingWalls); i++) {
	    if(touchingWalls[| i].object_index == oDoorSliding && !touchingWalls[| i].open){
			if(current_state == ZOMBIE_STATE.WALKING){
				current_state = ZOMBIE_STATE.DOORLEANSTART;
				animVar = 0;
				shootable_map[? SHOOTABLE_MAP.HSP] = 0;
				shootable_map[? SHOOTABLE_MAP.VSP] = 0;
				walk_speed = 0;
			}
			//walk_speed = 0;
			doorLeaningOn = touchingWalls[|i];
			break;
		}
	}
}

var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = 1;
else
	facing = -1;


shotgunHit = false;

