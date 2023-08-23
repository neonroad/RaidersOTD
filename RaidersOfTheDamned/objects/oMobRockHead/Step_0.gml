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
	
	if(shotgunHit) deadSprite = choose(spRockHeadIdleDeadStrong);
	
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



if(ai_start_cooldown > 0) exit;

var prevTarget = target;
target = point_distance(x,y, instance_nearest(x,y,oPlayer).x, instance_nearest(x,y,oPlayer).y) < 100 ? instance_nearest(x,y,oPlayer) : noone;
if(control && target != prevTarget) part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(current_state == ROCK_STATE.IDLE){
		currentSprite = idleSprite;
	}
	
	currentPath = path_add();
	var madePath = false;
	if(target != noone){
		if(prevX == x && prevY == y){
			madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true);	
		}
		
		if(ds_list_size(touchingWalls) <= 0 && point_distance(x,y,target.x,target.y) < 60 && contact_cooldown < 0 && current_state == ROCK_STATE.IDLE){
			current_state = ROCK_STATE.CHARGING;
			animVar = 0;
			currentSprite = spRockHeadHealthyCharge;
			contact_cooldown = 300;
		}

	}
	
	else{
		madePath = mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32*5,32*5),y+irandom_range(-32*5,32*5),true);		
	}
	
		
	var walkSpeedGain = 0;	
	if(madePath)
		walkSpeedGain = scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
	else if(instance_exists(target) && point_distance(x,y, target.x, target.y) < 500)
		walkSpeedGain = scLookAt(x+random_range(-1,1), target.y+random_range(-1,1));
		
	
		
	//if(!madePath || !path_exists(currentPath) ){
	//	current_state = ROCK_STATE.IDLE;
	//	currentSpeed = 0;
		
	//}
	//else{
		//if(current_state == ROCK_STATE.IDLE) currentSpeed = walk_speed_base;
		shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(walk_speed, angleFacing);
		shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(walk_speed, angleFacing);
	//}
		
	path_delete(currentPath);
	
}

else if(!control || shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0,localTD * friction_base);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	//if(currentSpeed > 0.01*localTD && (shootable_map[?SHOOTABLE_MAP.DEAD])) scParticleBurst(x,y,x,y,irandom_range(1,3),3,30,c_red);
		
}

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
			
			if(ent_hit.id == oPlayer.id && current_state == ROCK_STATE.ATTACKING && oPlayer.iframes <= 0 && oPlayer.current_state == PLAYER_STATE.PLAYING){
				
				scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
				scParticleBurst(ent_hit.x-5,ent_hit.y-5, ent_hit.x+5, ent_hit.y+5, 3, 2, 30, ent_hit.bloodColor);
				with(ent_hit){
					current_state = scStateManager(PLAYER_STATE.LAUNCHED);
					shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(10,point_direction(x,y,other.x,other.y));
					shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(10,point_direction(x,y,other.x,other.y));				
				}
				attacking = ent_hit.id;
				ent_hit.iframes = 90;
				audio_play_sound_at(snImpactWall, x, y, 0, 60, 240, 0.5, false, 2);
				
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
	
	if(shootable_map[? SHOOTABLE_MAP.HEALTH] < shootable_map[? SHOOTABLE_MAP.HEALTH_START]*0.5){
		idleSprite = spRockHeadWoundedIdle;	
	}
	else{
		idleSprite = spRockHeadHealthyIdle;
	}
	
	if(animVar >= sprite_get_number(currentSprite)){
		if(control && current_state == ROCK_STATE.CHARGING){
			current_state = ROCK_STATE.ATTACKING;
			currentSprite = spRockHeadHealthyAttacking;
			walk_speed = walk_speed_base*4;
			animVar = 0;
		}
		if((!control && current_state == ROCK_STATE.CHARGING) || current_state == ROCK_STATE.ATTACKING){
			attackAnimLoop++;
			animVar = 0;
			if(attackAnimLoop > 5){
				current_state = ROCK_STATE.IDLE;
				attackAnimLoop = 0;
				contact_cooldown = 200;
				walk_speed = walk_speed_base;
			}
		}
	}
		
		
	if(current_state == ROCK_STATE.ATTACKING && (shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[? SHOOTABLE_MAP.VSP] != 0)){
		if(ds_list_size(touchingWalls) > 0){
			for (var i = 0; i < ds_list_size(touchingWalls); i++) {
			    if(variable_instance_exists(touchingWalls[| i], "open") && touchingWalls[| i].open){
					
				}
			}
			scDamage(id,id,20,DAMAGE_TYPE.BULLET);	
			animVar = sprite_get_number(currentSprite);
			attackAnimLoop = 99;
			//Guarantee change through normal means
		}
	}
}

else{
	if (control && 0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
				
			//Connect attack
			
			if(abs(shootable_map[?SHOOTABLE_MAP.HSP])>0.1 && abs(shootable_map[?SHOOTABLE_MAP.VSP])>0.1 && ent_hit.id != oPlayer.id && deadSprite == spRockHeadIdleDeadStrong && ent_hit.iframes <= 0){
				
				scDamage(ent_hit,id,10,DAMAGE_TYPE.BULLET);
				scParticleBurst(ent_hit.x-5,ent_hit.y-5, ent_hit.x+5, ent_hit.y+5, 3, 2, 30, ent_hit.bloodColor);
				with(ent_hit){
					//current_state = scStateManager(PLAYER_STATE.LAUNCHED);
					shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(10,point_direction(x,y,other.x,other.y));
					shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(10,point_direction(x,y,other.x,other.y));				
				}
				audio_play_sound_at(snImpactWall, x, y, 0, 60, 240, 0.5, false, 2);
				
			}
		}	
		
	}
}
currently_attacking = current_state == ROCK_STATE.ATTACKING;
damageTaken = currently_attacking ? 2 : 1;

contact_cooldown-= localTD;

scCheckCollision2();


var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = -1;
else
	facing = 1;


shotgunHit = false;

