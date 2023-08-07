/// @description  

//if !oGame.play exit;

event_inherited();



ai_start_cooldown-= localTD;
if(ai_start_cooldown == -1) ai_start_cooldown = 0;

animVar += image_speed*localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	justDied = false;
	despawnTime-= localTD;
	alpha = lerp(alpha, 0.8, 0.05*localTD);
	invisible = false;
	//depth = layer_get_depth("Mobs")+20;
	
	if(!deadSpriteChosen){
		if(shootable_map[? SHOOTABLE_MAP.VSP] < 0) deadSprite = spCardboardFlipBackward;
		else deadSprite = spCardboardFlipForward;
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
/*
if(flash_frames > 0)
	control = false;
else
	control = true;
*/

target = instance_nearest(x,y, oPlayer);


	
if(!shootable_map[? SHOOTABLE_MAP.DEAD] && current_state != ZOMBIE_STATE.ATTACKING && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
	currentSprite = idleSprite;
	current_state = ZOMBIE_STATE.IDLE;
	walk_speed = walk_speed_base;
	deadSprite = spZombieDie;
}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(shootable_map[? SHOOTABLE_MAP.HSP] != 0 || shootable_map[?SHOOTABLE_MAP.VSP] != 0){
		if(current_state == ZOMBIE_STATE.WALKING)
			currentSprite = walkSprite;
		else if(current_state == ZOMBIE_STATE.CHARGING)
			currentSprite = chargeSprite;
		else if(current_state == ZOMBIE_STATE.ATTACKING)
			currentSprite = attackSprite;
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


//FIX AUDIO/TIME SYNCH
if(currentSprite == spZombieRun && point_distance(x, y, target.x, target.y) < 300){
	if(animVar%8 == 2)
		audio_play_sound_at(snWalk1, x, y, 0, 60, 240, 0.5, false, 0);	
	if(animVar%8 == 6)
		audio_play_sound_at(snWalk2, x, y, 0, 60, 240, 0.5, false, 0);
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
			current_state = ZOMBIE_STATE.WALKING;
			walk_speed = walk_speed_base;
			deadSprite = spZombieDie;
			endChargeX = x;
			endChargeY = y;
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
	}
}

currently_attacking = current_state == ZOMBIE_STATE.CHARGING;
damageTaken = currently_attacking ? 2 : 1;

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
	facing = 1;
else
	facing = -1;




