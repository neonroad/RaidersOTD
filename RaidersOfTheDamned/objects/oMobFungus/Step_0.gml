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
		//Nothing yet
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
	
	if(array_length(touchingWalls)>0){
		surface_set_target(oDecalSurfW.surf);
		draw_sprite_ext(spBloodSplatWall,irandom(sprite_get_number(spBloodSplatWall)),x,y,1,1,point_direction(x,y,x+shootable_map[? SHOOTABLE_MAP.HSP],y+shootable_map[? SHOOTABLE_MAP.VSP])-90,make_color_hsv(color_get_hue(bloodColor), color_get_saturation(bloodColor), color_get_value(bloodColor)-10),1);
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

target = instance_nearest(x,y, oPlayer);
if(!instance_exists(target) || target.shootable_map[? SHOOTABLE_MAP.DEAD] || point_distance(x,y,target.x,target.y)>400){
	//instance_destroy();
	//exit;
}

	
//if(!shootable_map[? SHOOTABLE_MAP.DEAD] && current_state != ZOMBIE_STATE.ATTACKING && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
//	currentSprite = idleSprite;
//	current_state = ZOMBIE_STATE.IDLE;
//	walk_speed = walk_speed_base;
//	deadSprite = spZombieDie;
	
//	if(point_distance(x,y,target.x,target.y) < 128) current_state = ZOMBIE_STATE.WALKING;
//}
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	if(target != noone){
		//Attack?
	}
	
	
	
		
	if(instance_exists(target) && point_distance(x,y, target.x, target.y) < 500)
		scLookAt(target.x, target.y);
	
	//shootable_map[?SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, angleFacing);
	//shootable_map[?SHOOTABLE_MAP.VSP] = -lengthdir_y(currentSpeed, angleFacing);
		
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
//var hitNum = collision_rectangle_list(bbox_left+padding, bbox_top+padding, bbox_right-padding, bbox_bottom-padding, pShootable, false, true, hitList, true);

//var shuffled = false;


if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
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
		
	}
	
		
}

currently_attacking = current_state == FUNGUS_STATE.IDLEOPEN || current_state == FUNGUS_STATE.HURTOPEN;
damageTaken = currently_attacking ? 2 : 1;

contact_cooldown-= localTD;

scCheckCollision2();


var drawFacingAngle =point_direction(x,y,x + lengthdir_x(100,angleFacing), y - lengthdir_y(100, angleFacing));

if(drawFacingAngle <= 120 || drawFacingAngle >= 290)
	facing = 1;
else
	facing = -1;




