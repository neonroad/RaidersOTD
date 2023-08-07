/// @description Insert description here
// You can write your code in this editor


if(!hit){
	x1 = floor(x0+lengthdir_x(350, targetAngle));
	y1 = floor(y0+lengthdir_y(350, targetAngle));
	var dx = abs(x1-x0);
	var sx = -1;
	if(x0 < x1) sx = 1;	
	var dy = -abs(y1-y0)
	var sy = -1;
	if(y0 < y1) sy = 1;
	var error = dx+dy;
	var e2 = 0;
	var cycles = 0;
	if(crit) { lineColor = c_yellow; damage *= 2; audio_play_sound_at(snCrit, x, y, 0, 60, 240, 0.5, false, 0);}
	
	var dirOff = point_direction(x0,y0,x1,y1);
	
	part_emitter_region(global.particleSystem, global.emitter, x0-5, x0+5,y0-5,y0+5, ps_shape_rectangle, ps_distr_invgaussian);
	part_type_orientation(oParticleSystem.particle_splat, dirOff-15,dirOff+15,0,0,false);
	part_type_color1(oParticleSystem.particle_splat, lineColor);
	part_type_scale(oParticleSystem.particle_splat, 1.2,1.2);
	part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_splat, 1);
					
	
	while cycles<350{
		cycles++;
		
		ds_list_clear(hitList);
		var wallHit = instance_place(x0,y0,oWall);
		var entHit = instance_place_list(x0,y0,pShootable,hitList,false);
		
		if(wallHit != noone && ds_list_empty(hitList) && (!variable_instance_exists(wallHit, "open") || !wallHit.open)){
			hit = true;
			if(bulletType != ITEMS.WEAPON_SHOTGUN) Aura_Light_Create_Fast(layer_get_id("Instances"),oLightFast, -1,-1,x0,y0,1,1,0,lineColor,1);
			x1 = x0;
			y1 = y0;
			audio_play_sound_at(snImpactWall, x1, y1, 0, 60, 240, 0.5, false, 2);
			
			if(wallHit.object_index == oObstacleBarrel){
				scParticleBurst(x1, y1,x1,y1,15,5,60,make_color_rgb(128, 73, 58), true, -dirOff,5,1);
				if(bulletType == ITEMS.WEAPON_SHOTGUN){
					wallHit.destroyed = true;	
					scParticleBurst(x1, y1,x1,y1,30,10,60,make_color_rgb(128, 73, 58), true, -dirOff,360,1);
				}
				
				
			}
			
			break;
		}
		
		else if(!ds_list_empty(hitList)){
			for (var i = 0; i < ds_list_size(hitList); i++) {
			    var mob = hitList[|i];	
				
				if(mob.id != owner.id &&  owner.shootable_map[? SHOOTABLE_MAP.FRIENDLY] != mob.shootable_map[? SHOOTABLE_MAP.FRIENDLY] && (!mob.shootable_map[?SHOOTABLE_MAP.DEAD] || mob.justDied) && mob.iframes <= 0 && !mob.invuln){
					
					if(bulletType == ITEMS.WEAPON_PISTOL){
						damage *= 0.25;	
					}
					
					else if(bulletType == ITEMS.WEAPON_SHOTGUN){
						damage *= 0.8;
						mob.crowdcontrol_cooldown = 20;
						mob.shootable_map[? SHOOTABLE_MAP.HSP] += lengthdir_x(0.005*(250-cycles),owner.angleAiming);
						mob.shootable_map[? SHOOTABLE_MAP.VSP] += lengthdir_y(0.005*(250-cycles),owner.angleAiming);
						
					}
					else if(bulletType == ITEMS.WEAPON_RIFLE){
						damage *= 0.5;
					}
					
					else if(bulletType == ITEMS.WEAPON_SNIPER){
						damage *= 5;
					}
					
					if(owner.object_index == oPlayer) damage*= owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)][? "BULLET_DAMAGE"];
					else if(mob.object_index == oPlayer) damage = 1;
					//damage*= mob.damageTaken;
					scDamage(mob,owner,damage,DAMAGE_TYPE.BULLET);
					if(mob.damageTaken > 1) mob.crowdcontrol_cooldown += 5;
					
					var dirOff = point_direction(x,y,x0,y0);
					var xOff = lengthdir_x(mob.bbox_right-mob.bbox_left,dirOff);
					var yOff = lengthdir_y(mob.bbox_bottom-mob.bbox_top,dirOff);
					
					scParticleBurst(x0,y0,x0+10,y0+10,damage,damage*0.8,100,mob.bloodColor,,dirOff,25,0.8);
					
					
					part_emitter_region(global.particleSystem, global.emitter, xOff+(x0-5), xOff+(x0+5),yOff+(y0-5),yOff+(y0+5), ps_shape_rectangle, ps_distr_invgaussian);
					part_type_orientation(oParticleSystem.particle_splat, dirOff-15,dirOff+15,0,0,false);
					part_type_color1(oParticleSystem.particle_splat, mob.bloodColor);
					part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_splat, 1);
					
					
					//audio_play_sound_at(snImpactFlesh, x1, y1, 0, 60, 240, 0.5, false, 2,,,mob.damageTaken>1 ? 0.3 : 1);
					if(bulletType != ITEMS.WEAPON_SNIPER){
						x1 = x0;
						y1 = y0;
						hit = true;
					}
					if(bulletType != ITEMS.WEAPON_SHOTGUN) Aura_Light_Create_Fast(layer_get_id("Instances"),oLightFast, -1,-1,x0,y0,1,1,0,c_white,1);
				}
			}
			
		}
		
		
		
		if(x0 == x1 && y0 == y1) break;	
		e2 = 2*error;
		if(e2 >= dy){
			if(x0 == x1) break;
			error += dy;
			x0 += sx;
		}
		if(e2 <= dx){
			if(y0 == y1) break;
			error += dx;
			y0 += sy;
		}
	}	
}

timer--;

if(timer<0)instance_destroy();