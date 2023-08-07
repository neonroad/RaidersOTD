/// @description  

//if !oGame.play exit;

event_inherited();

function warriorBugRetreat(){
	current_state = WARRIOR_STATE.RETREAT;
	animVar = 0;
	currentSprite = spWarriorBugRetreatShort;
	shootable_map[? SHOOTABLE_MAP.VSP] = -5;
}

function warriorBugShortHop(){
	current_state = WARRIOR_STATE.RETREAT;
	animVar = 0;
	currentSprite = spWarriorBugRetreatShort;
	if(instance_exists(target)){
		shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(2+abs(target.shootable_map[? SHOOTABLE_MAP.HSP]*2),point_direction(x,y,target.x,target.y));
		shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(2+abs(target.shootable_map[? SHOOTABLE_MAP.VSP]*2),point_direction(x,y,target.x,target.y));
	}
}

ai_start_cooldown-= localTD;
if(ai_start_cooldown == -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	despawnTime-= localTD;
	alpha = lerp(alpha, 0.8, 0.05*localTD);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(!deadSpriteChosen){
		//nothing
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
}


//if(ai_start_cooldown > 0 && instance_place(x,y,oWall) != noone) instance_destroy();
if(ai_start_cooldown > 0) exit;



target = instance_nearest(x,y, oPlayer);


if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	currentPath = path_add();
	if(instance_exists(target)){
		if(prevX == x && prevY == y){
			mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true);	
		}
		
		//Attack
		//Spin
		if(current_state == WARRIOR_STATE.WALKING && oPlayer.iframes <= 0 && point_distance(x,y, target.x, target.y) < 20){
			animVar = 0;
			//contact_cooldown = contact_cooldown_max;
			currentSprite = spWarriorBugAttackSpin;
			current_state = WARRIOR_STATE.ATTACKING;
			part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
			checkHitboxApplication = true;
		}
		//Charge
		if(current_state == WARRIOR_STATE.WALKING && contact_cooldown <= 0 && oPlayer.iframes <= 0 && collision_line(x,y,target.x,target.y,oWall, false,true) == noone && point_distance(x,y,target.x,target.y)<=attack_range
		&& target.y > y+30){
			contact_cooldown = contact_cooldown_max;
			currentSprite = spWarriorBugRoarIdle;
			walk_speed = 0;
			animVar = 0;
			current_state = WARRIOR_STATE.ROAR;
			part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
		}
		else if(current_state == WARRIOR_STATE.WALKING && oPlayer.iframes <= 0 && contact_cooldown <= 0 && collision_line(x,y,target.x,target.y,oWall, false,true) == noone && point_distance(x,y,target.x,target.y)<=attack_range
		&& target.y < y && point_distance(x,y,target.x,target.y)<25){
			warriorBugRetreat();
		}
		else if(current_state == WARRIOR_STATE.WALKING && oPlayer.iframes <= 0 && contact_cooldown <= 0 && point_distance(x,y,target.x,target.y)<=attack_range*0.5){
			warriorBugShortHop()
		}
		else if(current_state == WARRIOR_STATE.WALKING && oPlayer.iframes <= 0 && collision_line(x,y,target.x,target.y,oWall, false,true) == noone && abs(target.y - y) < 50 && point_distance(x,y,target.x,target.y)>attack_range*0.5){
			currentSprite = spWarriorBugSideAttackCharge;
			current_state = WARRIOR_STATE.CHARGING;
			animVar = 0;
		}
		
		
		//else if(current_state != WARRIOR_STATE.CHARGING && current_state != WARRIOR_STATE.ATTACKING){
		//	current_state = WARRIOR_STATE.WALKING;	
		//}
	}
	
	
	if(currentPath != noone && (current_state == WARRIOR_STATE.FLYING || current_state == WARRIOR_STATE.BLOCKING)){
		
		if(target != noone)
			scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
		
		currentSpeed = walk_speed;
		shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, angleFacing);
		shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(currentSpeed, angleFacing);
		
		path_delete(currentPath);
		
		
	}
	
	
	
	
	
}

if(!control || shootable_map[?SHOOTABLE_MAP.DEAD] || (current_state != WARRIOR_STATE.FLYING && current_state != WARRIOR_STATE.WALKING)){
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0,localTD * friction_base);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	
}

//Hurt on collision

ds_list_clear(hitList);
var padding = 0;
var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);

var shuffled = false;


if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	blockTimer -= localTD;
	
	if (0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			//if(!shuffled && !ent_hit.shootable_map[?SHOOTABLE_MAP.DEAD]){
			//	ent_hit.shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
			//	ent_hit.shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
			//	shuffled = true;
			//}
			//Connect attack
			if(checkHitboxApplication){
				switch (currentSprite) {
					
					case spWarriorBugAttackSpin:
						if(ent_hit.iframes < 0 && floor(animVar)>= 7 && floor(animVar) < 9){	
							with(ent_hit) current_state = scStateManager(PLAYER_STATE.LAUNCHED);
							ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(2,point_direction(x,y,ent_hit.x,ent_hit.y));
							ent_hit.shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(2,point_direction(x,y,ent_hit.x,ent_hit.y));
							scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
							ent_hit.iframes = 10;
							connectedHit = true;
						}
				        break;
						
					case spWarriorBugSideAttack:
						if(ent_hit.iframes < 0 && floor(animVar)>= 10 && floor(animVar) < 11){	
							with(ent_hit) current_state = scStateManager(PLAYER_STATE.LAUNCHED);
							ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(2,point_direction(x,y,ent_hit.x,ent_hit.y));
							ent_hit.shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(2,point_direction(x,y,ent_hit.x,ent_hit.y));
							scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
							ent_hit.iframes = 10;
							connectedHit = true;
						}
				        break;
					
					case spWarriorBugAttackChargeComboEnd:
						if(ent_hit.iframes < 0 && floor(animVar)>= 3 && floor(animVar) < 5){	
							with(ent_hit) current_state = scStateManager(PLAYER_STATE.LAUNCHED);
							ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = min(shootable_map[? SHOOTABLE_MAP.VSP] - 1.5, -1.5);
							scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
							ent_hit.iframes = 10;
							connectedHit = true;
						}
				        break;
					
				    case spWarriorBugFastAttack:
					case spWarriorBugAttackCharge:
						var diff = currentSprite == spWarriorBugFastAttack ? 0 : 4;
				        if(ent_hit.iframes < 0 && floor(animVar)>= 1+diff && floor(animVar) < 3+diff){	
							with(ent_hit) current_state = scStateManager(PLAYER_STATE.LAUNCHED);
							ent_hit.shootable_map[? SHOOTABLE_MAP.VSP] = max(shootable_map[? SHOOTABLE_MAP.VSP] + 1.5, 1.5);
							scDamage(ent_hit,id,1,DAMAGE_TYPE.BULLET);
							ent_hit.iframes = 10;
							connectedHit = true;
						}
				        break;
				}	
			}
			
			if(ent_hit.id == oPlayer.id && current_state == WARRIOR_STATE.FLYING && point_distance(x,y,target.x,target.y)<20){
				current_state = WARRIOR_STATE.ATTACKING;
				animVar = 0;
				
				if(currentSprite == spWarriorBugFly) currentSprite = walk_speed > walk_speed_base*3 ? spWarriorBugFastAttack : spWarriorBugAttackCharge;
				if(currentSprite == spWarriorBugAttackChargeComboLeapForward) currentSprite = spWarriorBugAttackChargeComboEnd;
				
				checkHitboxApplication = true;
				
				attacking = ent_hit.id;
			
				attacking = noone;
				
			}
		}	
		
	}
	
	//if(invisible){
	//	alpha = 0;
	//	if(point_distance(x,y,target.x,target.y) < 40){
	//		alpha = (40-point_distance(x, y, target.x, target.y))/40;	
	//	}
	//	if(animVar%2 == 0){
	//		part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-5,bbox_bottom+5,ps_shape_ellipse,ps_distr_linear);
	//		part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_invis, irandom(3));
	//	}
		
	//}
	
	if(current_state == WARRIOR_STATE.WALKING){
		shootable_map[? SHOOTABLE_MAP.HSP] = 0;	
		shootable_map[? SHOOTABLE_MAP.VSP] = 0;
		
		if(instance_exists(target) && point_distance(x,y,target.x,target.y) > 200){
			current_state = WARRIOR_STATE.TELEPORTING;	
			x = target.x;
			y = target.y;
			animVar = 0;
			currentSprite = spWarriorBugEnterFall;
			oGame.combatTimer += 600;
		}
	}
	
	if(current_state == WARRIOR_STATE.ATTACKING){
		if(animVar < 11 && currentSprite == spWarriorBugSideAttack && instance_exists(target)){
			x = lerp(x,target.x+target.shootable_map[? SHOOTABLE_MAP.HSP]*2,0.1);
			y = lerp(y,target.y+target.shootable_map[? SHOOTABLE_MAP.VSP]*2,0.1);
			ignoreWalls = true;
			if(point_distance(x,y,target.x,target.y) < 5){
				x = target.x;
				y = target.y;
			}
		}
		
		
	}
	
	//Animation check
	if(animVar >= sprite_get_number(currentSprite)){
		
		if(current_state == WARRIOR_STATE.TELEPORTING){
			current_state = WARRIOR_STATE.WALKING;
			animVar = 0;
			currentSprite = spWarriorBugIdleLeft;
		}
		
		else if(current_state == WARRIOR_STATE.WALKING){
			currentSprite = currentSprite == spWarriorBugIdleLeft ? spWarriorBugIdleRight : spWarriorBugIdleLeft;
			animVar = 0;
			if(instance_exists(target)) scLookAt(target.x,target.y);
		}
		
		else if(current_state == WARRIOR_STATE.ROAR){
			current_state = WARRIOR_STATE.CHARGING;
			animVar = 0;
			currentSprite = spWarriorBugChargeForward;
			walk_speed = walk_speed_base;
		}
		else if(current_state == WARRIOR_STATE.CHARGING){
			animVar = 0;
			current_state = WARRIOR_STATE.FLYING;
			
			//Attack 1
			if(currentSprite == spWarriorBugChargeForward){
				currentSprite = spWarriorBugFly;
				walk_speed = walk_speed_base*1.5;
			}
			
			//Attack 2
			if(currentSprite == spWarriorBugAttackChargeComboLeap){ 
				currentSprite = spWarriorBugAttackChargeComboLeapForward;
				walk_speed = walk_speed_base*2;
			}
			
			if(currentSprite == spWarriorBugSideAttackCharge){ 
				currentSprite = spWarriorBugSideAttack;
				walk_speed = walk_speed_base*2;
				current_state = WARRIOR_STATE.ATTACKING;
			}
			
			
		}
		else if(current_state == WARRIOR_STATE.FLYING){
			walk_speed *= 1.01;	
			var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));
			if(drawFacingAngle < 180){
				animVar = 0;
				currentSprite = spWarriorBugAttackChargeTurn;
				current_state = WARRIOR_STATE.SLIDE;
			}
		}
		else if(current_state == WARRIOR_STATE.SLIDE){
			animVar = 0;
			currentSprite = spWarriorBugAttackChargeTurnGetup;
			current_state = WARRIOR_STATE.TURNFORWARD;
		}
		else if(current_state == WARRIOR_STATE.TURNFORWARD){
			walk_speed = 0;
			animVar = 0;
			current_state = WARRIOR_STATE.WALKING;
			currentSprite = spWarriorBugIdleLeft;
		}
		else if(current_state == WARRIOR_STATE.ATTACKING){
			
			if(!connectedHit && currentSprite == spWarriorBugFastAttack){
				current_state = WARRIOR_STATE.CHARGING;
				animVar = 0;
				currentSprite = spWarriorBugAttackChargeComboLeap;
			}
			else if(currentSprite == spWarriorBugAttackChargeComboEnd){
				if(instance_exists(target) && point_distance(x,y, target.x, target.y) > 30){
					animVar = 0;
					currentSprite = spWarriorBugAttackChargeComboBlockStart;
					current_state = WARRIOR_STATE.BLOCKING;
					walk_speed = walk_speed_base*0.5;
				}
				else if(instance_exists(target) && target.y < y-5){
					warriorBugRetreat();	
				}
				
				else{
					ignoreWalls = false;
					animVar = 0;
					currentSprite = spWarriorBugAttackChargeComboReturn;
					current_state = WARRIOR_STATE.TURNFORWARD;
				}
			}
			else{
				current_state = WARRIOR_STATE.WALKING;
				currentSprite = choose(spWarriorBugIdleLeft,spWarriorBugIdleRight);
				connectedHit = false;
			}
		}
		
		else if(current_state == WARRIOR_STATE.BLOCKING){
			if(currentSprite == spWarriorBugAttackChargeComboBlockStart){
				animVar = 0;
				currentSprite = spWarriorBugBlocking;
				blockTimer = 120;
			}
			if(blockTimer <= 0 && currentSprite == spWarriorBugBlocking){
				animVar = 0;
				currentSprite = spWarriorBugBlockEnd;
				walk_speed = walk_speed_base;
			}
			if(currentSprite == spWarriorBugBlockEnd){
				animVar = 0;
				currentSprite = spWarriorBugRoarIdle;
				current_state = WARRIOR_STATE.ROAR;	
			}
		}
		
		else if(current_state == WARRIOR_STATE.RETREAT || current_state == WARRIOR_STATE.SHORTHOP){
			animVar = 0;
			currentSprite = spWarriorBugIdleLeft;
			current_state = WARRIOR_STATE.WALKING;
		}
	}
}

currently_attacking = current_state == WARRIOR_STATE.ATTACKING;
damageTaken = currently_attacking ? 2 : 1;
damageTaken = damageTaken * (blockTimer > 0 ? 0.5 : 1);
contact_cooldown-= localTD;


//TODO: REFACTOR FOR BETTER PERFORMANCE
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




