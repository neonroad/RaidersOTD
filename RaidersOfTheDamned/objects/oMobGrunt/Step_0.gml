/// @description  

//if !oGame.play exit;

event_inherited();




//if(ai_start_cooldown <= -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	despawnTime-= localTD;
	current_state = GRUNT_STATE.DEAD;
	alpha = lerp(alpha, 0.8, 0.05);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(currentSprite != deadSprite){
		animVar = 0;
		currentSprite = deadSprite;
	}
	else{
		if(instance_exists(target) && point_distance(x,y, target.x, target.y) < 20 && animVar == 12){
			scUIShakeSet(10,10);	
		}
		if(animVar >= sprite_get_number(deadSprite)-1){
			animVar = sprite_get_number(deadSprite)-1;
		}
	}
	
	if(despawnTime == 0){
		surface_set_target(oDecalSurf.surf);
		draw_sprite_ext(currentSprite, floor(animVar), x, y, !asym ? -facing*scale : 1, scale, 0, c_color, alpha);
		surface_reset_target();
		instance_destroy();
		exit;
	}
}


//if(ai_start_cooldown > 0 && instance_place(x,y,oWall) != noone) instance_destroy();
if(ai_start_cooldown != 0) exit;
else if(ai_start_cooldown > 0) ai_start_cooldown-= localTD;
/*
if(flash_frames > 0)
	control = false;
else
	control = true;
*/

target = instance_nearest(x,y, oPlayer);

	
if(!shootable_map[? SHOOTABLE_MAP.DEAD] && current_state == GRUNT_STATE.RECHARGING && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
	currentSprite = idleSprite;
	current_state = GRUNT_STATE.IDLE;
}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(current_state != GRUNT_STATE.PUNCHING){
		currentPath = path_add();
		var madePath = false;
		if(target != noone && path_exists(currentPath)){
			if(prevX == x && prevY == y){
				madePath = mp_grid_path(oGame.mapGridBreakable, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
			}
			else{
				madePath = mp_grid_path(oGame.mapGridBreakable, currentPath, x,y,target.x,target.y,true);	
			}
		}
	
		if(currentPath != noone && contact_cooldown <= 0){
		
			if(target != noone){
				
				if(point_distance(x,y,target.x, target.y) < 64*4 && animVar % 4 == 0){
					scUIShakeSet(floor(0.25*((4*64) - point_distance(x,y,target.x, target.y))), 2);
					oGame.combatTimer += 600;
				}
			
				if(target.iframes <= 0 && point_distance(x,y,target.x, target.y) < 32){
					walk_speed *= 1.01;	
				}
				else
					walk_speed = walk_speed_base;
			}
		
			shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(walk_speed, angleFacing);
			shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(walk_speed, angleFacing);
	
		
			current_state = GRUNT_STATE.WALKING;	
		
			if(!instance_exists(target) && madePath)
				scLookAt(x+irandom_range(-32*5,32*5),y+irandom_range(-32*5,32*5));
			else if(instance_exists(target) && madePath)
				scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
			else if(instance_exists(target))
				scLookAt(target.x, target.y);
			
			path_delete(currentPath);
		
		}
	}
	
	
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

var shuffled = false;


if(!shootable_map[?SHOOTABLE_MAP.DEAD] && crowdcontrol_cooldown <= 0){
	
	if (0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			if(current_state == GRUNT_STATE.WALKING && !ent_hit.shootable_map[?SHOOTABLE_MAP.DEAD]){
				shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
				shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
				//shuffled = true;
				
				if(instance_exists(oPlayer) && oPlayer.iframes <= 0 && ent_hit.current_state == PLAYER_STATE.PLAYING && ent_hit.id == oPlayer.id){
					//ds_list_add(confirmList, ent_hit.id);
					scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
					scParticleBurst(ent_hit.x-5,ent_hit.y-5, ent_hit.x+5, ent_hit.y+5, 3, 2, 30, ent_hit.bloodColor);
					scDropSpecificItemEnum(ent_hit, ent_hit.weaponEquipped);
					with(ent_hit){
						current_state = scStateManager(PLAYER_STATE.LAUNCHED);
						shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(0.05,point_direction(x,y,other.x,other.y));
						shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(0.05,point_direction(x,y,other.x,other.y));				
					}
					contact_cooldown = contact_cooldown_max;
					crowdcontrol_cooldown = 60;
					current_state = GRUNT_STATE.IDLE;
					walk_speed = walk_speed_base;
					
				}
				if(ent_hit.object_index == oMobZombie && !pushing){
					scDamage(ent_hit,id,100,DAMAGE_TYPE.BULLET);
					scParticleBurst(ent_hit.x-5,ent_hit.y-5, ent_hit.x+5, ent_hit.y+5, 3, 2, 30, ent_hit.bloodColor);
					ent_hit.crowdcontrol_cooldown = 20;
					if(ent_hit.current_state == ZOMBIE_STATE.CHARGING) ent_hit.deadSprite = spZombieDieChargeB;
					ent_hit.deadSprite = spZombieDieLaunch;
					if(instance_exists(target) && point_distance(x,y,target.x,target.y) < 15) scUIShakeSet(20, 5);
					with(ent_hit){
						shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(1,point_direction(x,y,other.x,other.y));
						shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(1,point_direction(x,y,other.x,other.y));
					}
					animVar = 0;
					pushing = true;
					
				}
				if(ent_hit.object_index == oMobWormDog){
					scDamage(ent_hit,id,100,DAMAGE_TYPE.BULLET);
					scParticleBurst(ent_hit.x-5,ent_hit.y-5, ent_hit.x+5, ent_hit.y+5, 3, 2, 30, ent_hit.bloodColor);
					if(instance_exists(target) && point_distance(x,y,target.x,target.y) < 15) scUIShakeSet(5, 5);
					
					if(ent_hit.current_state == DOG_STATE.ATTACKING){
						with(ent_hit){
							shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(1,point_direction(x,y,other.x,other.y));
							shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(1,point_direction(x,y,other.x,other.y));
						}
						animVar = 0;
						pushing = true;
					}
					else{
						ent_hit.shootable_map[? SHOOTABLE_MAP.HSP] = 0;
						ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = 0;
					}
				}
			}
			
		}	
		
	}
	
	if(animVar >= sprite_get_number(currentSprite)){
		if(pushing){
			pushing = false;	
		}
		if(current_state == GRUNT_STATE.PUNCHING){
			current_state = GRUNT_STATE.IDLE;	
			walk_speed = walk_speed_base;
			
		}
	}
	
	if(current_state == GRUNT_STATE.PUNCHING && animVar == 7){
		doorLeaningOn.destroyed = true;
			
		if(instance_exists(eventOwner) && eventOwner.eventTriggered && !eventOwner.eventOver){
			eventOwner.eventOver = true;	
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
}


contact_cooldown-= localTD;


scCheckCollision2();

if(current_state != GRUNT_STATE.PUNCHING){
	for (var i = 0; i < ds_list_size(touchingWalls); i++) {
	    if(touchingWalls[| i].object_index == oObstacleCrystal && !touchingWalls[| i].open){
			if(current_state == GRUNT_STATE.WALKING){
				current_state = GRUNT_STATE.PUNCHING;
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

var aimIndex = scAimGeneric(drawFacingAngle);


if(current_state == GRUNT_STATE.WALKING){
	
	if(pushing){
		switch (aimIndex) {
		    case 0:
			case 4:
		        currentSprite = spGrunt_WalkEPush;
		        break;
		    case 1:
			case 3:
				currentSprite = spGrunt_WalkNEPush;
				break;
			case 2:
				currentSprite = spGrunt_WalkNPush;
				break;
			case 5:
			case 7:
				currentSprite = spGrunt_WalkSEPush;
				break;
			case 6:
				currentSprite = spGrunt_WalkSPush;
				break;
		}
	}
	
	else{
		switch (aimIndex) {
		    case 0:
			case 4:
		        currentSprite = spGrunt_WalkE;
		        break;
		    case 1:
			case 3:
				currentSprite = spGrunt_WalkNE;
				break;
			case 2:
				currentSprite = spGrunt_WalkN;
				break;
			case 5:
			case 7:
				currentSprite = spGrunt_WalkSE;
				break;
			case 6:
				currentSprite = spGrunt_WalkS;
				break;
		}
	}
	
}
else if(current_state == GRUNT_STATE.IDLE){
	switch (aimIndex) {
	    case 0:
		case 4:
	        currentSprite = spGrunt_IdleE;
	        break;
	    case 1:
		case 3:
			currentSprite = spGrunt_IdleNE;
			break;
		case 2:
			currentSprite = spGrunt_IdleN;
			break;
		case 5:
		case 7:
			currentSprite = spGrunt_IdleSE;
			break;
		case 6:
			currentSprite = spGrunt_IdleS;
			break;
	}	
}
else if(current_state == GRUNT_STATE.PUNCHING){
	currentSprite = spGrunt_IdleEPunch;
}
if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = -1;
else
	facing = 1;




