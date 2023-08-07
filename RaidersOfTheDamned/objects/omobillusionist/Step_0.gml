/// @description  

//if !oGame.play exit;

event_inherited();



ai_start_cooldown-= localTD;
if(ai_start_cooldown <= -1) ai_start_cooldown = 0;

animVar += image_speed * localTD;

if(shootable_map[?SHOOTABLE_MAP.DEAD]){
	despawnTime-= localTD;
	alpha = lerp(alpha, 0.8, 0.05);
	//depth = layer_get_depth("Mobs")+20;
	
	if(currentSprite != deadSprite){
		animVar = 0;
		currentSprite = deadSprite;
	}
	else{
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
if(ai_start_cooldown > 0) exit;
/*
if(flash_frames > 0)
	control = false;
else
	control = true;
*/

target = instance_nearest(x,y, oPlayer);
if(!instance_exists(target) || target.shootable_map[? SHOOTABLE_MAP.DEAD]){
	target = noone;
	//exit;
}

/*	
if(!shootable_map[? SHOOTABLE_MAP.DEAD]  && shootable_map[? SHOOTABLE_MAP.HSP] == 0 && shootable_map[?SHOOTABLE_MAP.VSP] == 0){
	currentSprite = idleSprite;
	current_state = ILLUSIONER_STATE.IDLE;
}
*/
	
if(control && !shootable_map[? SHOOTABLE_MAP.DEAD]){
		
	currentPath = path_add();
	if(target != noone){
		if(prevX == x && prevY == y){
			mp_grid_path(oGame.mapGrid, currentPath, x,y,x+irandom_range(-32,32),y+irandom_range(-32,32),true);		
		}
		else{
			mp_grid_path(oGame.mapGrid, currentPath, x,y,target.x,target.y,true);	
		}
		
		if(beginIllusion && current_state == ILLUSIONER_STATE.HURT){
			current_state = ILLUSIONER_STATE.CASTING;
			currentSprite = walkSprite;
			currentSpell = irandom(ILLUSIONER_SPELLS.LENGTH-1);
		}
		if(contact_cooldown <= 0 && current_state == ILLUSIONER_STATE.CASTING && point_distance(x, y, target.x, target.y > 300)){
			var proj = instance_create_layer(x,y,"Instances", oIllusionistProjectile);
			proj.hsp = lengthdir_x(1.5, point_direction(x,y,target.x, target.y));
			proj.vsp = lengthdir_y(1.5, point_direction(x,y,target.x, target.y));
			proj.owner = id;
			proj.target = target;	
			contact_cooldown = contact_cooldown_max;
		}
		if(beginIllusion && currentSpell != noone){
			if(currentSpell == ILLUSIONER_SPELLS.MAZE){
				repeat (20){
					var fake = instance_create_layer(x,y,"Walls", oFakeWall);
					array_push(fakeArray, fake);
				}
				beginIllusion = false;
			}
			
			if(currentSpell == ILLUSIONER_SPELLS.HORDE){
				oGame.makeInvisMonsters = true;
			}
			else oGame.makeInvisMonsters = false;
			
			if(currentSpell == ILLUSIONER_SPELLS.MIMICS){
				repeat (30){
					var fake = instance_create_layer(x,y,"Items", oItem,
					{
						itemEnum: 1+irandom(ITEMS.LENGTH-2)	
					});
					fake.image_xscale = -1;
					fake.x = (irandom_range(LEFT, RIGHT) div 32) * 32;
					fake.y = (irandom_range(UP, DOWN) div 32) * 32;
					
					fake.faked = true;
					array_push(fakeArray, fake);
				}
				beginIllusion = false;
			}
			
			if(currentSpell == ILLUSIONER_SPELLS.FAKES){
				repeat(5){
					var fake = instance_create_layer(x,y,"Mobs", oMobIllusionistFake);	
					fake.target = target;
					fake.owner = id;
					array_push(fakeArray, fake);
				}
				beginIllusion = false;
			}
		}
		
		//Too close!
		if(point_distance(x,y, target.x, target.y) < 30){
			event_user(1);
		}
	}
	
	
	if(currentPath != noone){
		
		if(target != noone)
			scLookAt(path_get_point_x(currentPath,1), path_get_point_y(currentPath,1));
		
		currentSpeed = walk_speed;
		
		path_delete(currentPath);
		
	}
	
	
	
	
	
}


if(!control || shootable_map[?SHOOTABLE_MAP.DEAD]){
	
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


if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	
	
	
	if (0 != hitNum){
		for (var i = 0; i < ds_list_size(hitList); i++) {
			
			var ent_hit = hitList[|i];
			if(!ent_hit.shootable_map[?SHOOTABLE_MAP.DEAD] && !shuffled){
				shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
				shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(0.1,point_direction(x,y,ent_hit.x,ent_hit.y));
				shuffled = true;
			}
		}	
		
	}
	
	
	//Animation check
	if(animVar >= sprite_get_number(currentSprite)){
		if(current_state == ILLUSIONER_STATE.HURT && currentSprite == hurtSprite){
			part_emitter_region(global.particleSystem, global.emitter, x-5,x+5,y-2,y+2,ps_shape_ellipse,ps_distr_linear);
			part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_smoke1, irandom_range(2,4));
			do{
				if(choose(1,-1) == 1)
					x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + irandom_range(100, 300);
				else
					x = camera_get_view_x(view_camera[0]) - irandom_range(100, 300);
			}
			until(x > LEFT && x < RIGHT);
			
			do{
				if(choose(1,-1) == 1)
					y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + irandom_range(100, 300);
				else
					y = camera_get_view_y(view_camera[0]) - irandom_range(100, 300);
			}
			until( y > UP && y < DOWN);
			beginIllusion = true;
			
		}
	}
}


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
	facing = 1;
else
	facing = -1;




