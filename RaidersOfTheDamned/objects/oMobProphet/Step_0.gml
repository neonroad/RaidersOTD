/// @description  

//if !oGame.play exit;

event_inherited();

if(!instance_exists(target)) target = noone;

ai_start_cooldown-= localTD;
if(ai_start_cooldown == -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	despawnTime-= localTD;
	alpha = lerp(alpha, 0.8, 0.05*localTD);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(!deadSpriteChosen){
		if(currentSprite == spProphetIdle) deadSprite = spProphetIdleDie;
		else deadSprite = spProphetAlarmedDie;
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
	
	if(despawnTime == 0){
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

//target = instance_nearest(x,y, oPlayer);
//if(!instance_exists(target) || target.shootable_map[? SHOOTABLE_MAP.DEAD] || point_distance(x,y,target.x,target.y)>400){
//	instance_destroy();
//	exit;
//}

	
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	
	
	if(current_state == PROPHET_STATE.WALKING)
		currentSprite = walkSprite;
	else if(current_state == PROPHET_STATE.ATTACKING)
		currentSprite = attackSprite;
	
	
	
	currentPath = path_add();
	
	if(prevX == x && prevY == y){
		mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
	}
	else{
		mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);	
	}
		
		
	
	
	
	if(currentPath != noone){
		
		if(current_state == PROPHET_STATE.WALKING)
			scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
		
		currentSpeed = walk_speed;
		shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, angleFacing);
		shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(currentSpeed, angleFacing);
		
		path_delete(currentPath);
		
		if(current_state != PROPHET_STATE.CHARGING && current_state != PROPHET_STATE.ATTACKING && (shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[? SHOOTABLE_MAP.VSP] != 0)){
			current_state = PROPHET_STATE.WALKING;	
			target = noone;
		}
		
	}
	
	
	
	
	
}

else if(!control || shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	if(!shootable_map[? SHOOTABLE_MAP.DEAD]){
		current_state = PROPHET_STATE.WALKING;
		currentSprite = spProphetIdle;
		animVar = 0;
		walk_speed = walk_speed_base;
		look_speed = look_speed_base;
		if(instance_exists(laserObj)) instance_destroy(laserObj);	
	}
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	if(shootable_map[? SHOOTABLE_MAP.DEAD]) instance_destroy(lightFollow);
	
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
	
	if (control && 0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			var wallHit = collision_line(x,y,ent_hit.x,ent_hit.y,oWall,true,true);
			//Connect attack
			if(!ent_hit.shootable_map[? SHOOTABLE_MAP.DEAD] && wallHit == noone && ent_hit.object_index != oMobProphet && current_state == PROPHET_STATE.WALKING){
				current_state = PROPHET_STATE.ALARMED;
				target = ent_hit;
				contact_cooldown = target.object_index == oPlayer ? contact_cooldown_max : contact_cooldown_max*0.25;
				shootable_map[? SHOOTABLE_MAP.FRIENDLY] = !target.shootable_map[? SHOOTABLE_MAP.FRIENDLY]
				currentSprite = alarmedSprite;
				part_particles_create(global.particleSystem, x, bbox_top, oParticleSystem.particle_exclam, 1);
				walk_speed = 0;
				attacking = ent_hit.id;
				laserObj = instance_create_depth(x,y,0,oProphetLaser);
				laserObj.owner = id;
				laserObj.timer = contact_cooldown;
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
	
	if(instance_exists(target) && contact_cooldown <= 0 && current_state == PROPHET_STATE.ALARMED && control){
		if(point_distance(x,y, target.x, target.y) < attack_range+20){
			current_state = PROPHET_STATE.CHARGING;
			animVar = 0;
			var aimIndex = scAimGeneric(point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing)));
			switch (aimIndex) {
			    case 0:
			        currentSprite = spProphetChargeE;
			        break;
				case 1:
			        currentSprite = spProphetChargeNE;
			        break;
				case 2:
			        currentSprite = spProphetChargeN;
			        break;
				case 3:
			        currentSprite = spProphetChargeNW;
			        break;
				case 4:
			        currentSprite = spProphetChargeW;
			        break;
				case 5:
			        currentSprite = spProphetChargeSW;
			        break;
				case 6:
			        currentSprite = spProphetChargeS;
			        break;
				case 7:
			        currentSprite = spProphetChargeSE;
			        break;
			}
		}
		else{
			current_state = PROPHET_STATE.WALKING;
			currentSprite = spProphetIdle;
			animVar = 0;
			walk_speed = walk_speed_base;
			look_speed = look_speed_base;
			if(instance_exists(laserObj)) instance_destroy(laserObj);
		}
	}
	
	else if(instance_exists(target) && control && current_state == PROPHET_STATE.ALARMED){
		scLookAt(target.x, target.y);	
		look_speed = 0.7;
	}
	
	else if(contact_cooldown < 0 && current_state == PROPHET_STATE.ALARMED && control){
		current_state = PROPHET_STATE.WALKING;
		currentSprite = spProphetIdle;
		animVar = 0;
		walk_speed = walk_speed_base;
		look_speed = look_speed_base;
		if(instance_exists(laserObj)) instance_destroy(laserObj);
	}
	
	//Animation check
	if(animVar >= sprite_get_number(currentSprite)){
		if(current_state == PROPHET_STATE.CHARGING){
			var bullet = instance_create_depth(x,y,0,oBullet);	
			bullet.targetAngle = point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));
			bullet.owner = id;
			bullet.x0 = floor(bullet.x);
			bullet.y0 = floor(bullet.y);
			bullet.crit = 0;
			bullet.damage*=2;
			audio_play_sound_at(snShoot2, x, y, 0, 60, 240, 0.5, false, 2,,,2);
			if(point_distance(x,y,oPlayer.x,oPlayer.y) < 120) scUIShakeSet(10,5);
			current_state = PROPHET_STATE.WALKING;
			animVar = 0;
			currentSprite = spProphetIdle;
			walk_speed = walk_speed_base;
			look_speed = look_speed_base;
			if(instance_exists(laserObj)) instance_destroy(laserObj);
		}
	}
}


currently_attacking = current_state == PROPHET_STATE.CHARGING;
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
var aimIndex = scAimGeneric(drawFacingAngle);

if(!shootable_map[? SHOOTABLE_MAP.DEAD] && (current_state == PROPHET_STATE.WALKING || current_state == PROPHET_STATE.ALARMED)) animVar = aimIndex;

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = 1;
else
	facing = -1;




