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

	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	
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
		
		if(current_state == BOG_STATE.IDLE){
			walk_speed = walk_speed_base;
			currentSprite = walkSprite;
			current_state = BOG_STATE.WALKING
		}
		attack_range = 64;
	}
	
	else if(pathfindCooldown <= 0){
		walk_speed = 0;	
		currentSprite = idleSprite;
		pathfindCooldown = pathfindCooldown_Max;
		attack_range = 34;
		current_state = BOG_STATE.IDLE;
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
var padding = 0;
var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);

//var shuffled = false;


if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	if (control && 0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
				
			//Connect attack
			
			if(ent_hit.id == oPlayer.id && oPlayer.iframes <= -30 && oPlayer.current_state == PLAYER_STATE.PLAYING){
				if(current_state == BOG_STATE.WALKING){
					walk_speed = walk_speed_base*0.5;
					current_state = BOG_STATE.CHARGING;
					currentSprite = chargeSprite;
					animVar = 0;
				}
				else if(current_state == BOG_STATE.CHARGING && animVar >= sprite_get_number(currentSprite)-1){
					walk_speed = 0;
					current_state = BOG_STATE.ATTACKING
					animVar = 0;
					currentSprite = attackSprite;
					attacking = ent_hit;
					x = (facing == 1 ? ent_hit.bbox_left : ent_hit.bbox_right);
					y = ent_hit.bbox_bottom+10;
					with(attacking){
						current_state = scStateManager(PLAYER_STATE.GRABBED);	
					}
				}
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
		if(current_state == BOG_STATE.CHARGING){
			current_state = BOG_STATE.MISS;	
			animVar = 0;
			currentSprite = spBogCreepMiss;
			walk_speed = 0;
		}
		else if(current_state == BOG_STATE.MISS){
			current_state = BOG_STATE.IDLE;	
			animVar = 0;
			currentSprite = idleSprite;
			walk_speed = 0;
		}
		else if(current_state == BOG_STATE.ATTACKING){
			animVar = sprite_get_number(currentSprite)-1;
			walk_speed = 0;
			if(instance_exists(attacking) && attacking.current_state == PLAYER_STATE.GRABBED){
				attacking.deadSprite = spPlayerDieSubmerged;
				scDamage(attacking, id, 500, DAMAGE_TYPE.BULLET);
			}
			else{
				current_state = BOG_STATE.IDLE;	
				animVar = 0;
				currentSprite = idleSprite;
				walk_speed = 0;
			}
		}
	}
	
		
}

//currently_attacking = current_state == ZOMBIE_STATE.CHARGING;
//damageTaken = currently_attacking ? 2 : 1;

contact_cooldown-= localTD;

scCheckCollision2();

var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = 1;
else
	facing = -1;


shotgunHit = false;

