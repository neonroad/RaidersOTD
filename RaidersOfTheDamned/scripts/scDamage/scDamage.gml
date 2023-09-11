// @arg Entity
// @arg Damager
// @arg Damage
// @arg Reason(DAMAGE_TYPE)

function scDamage(entity, damager, damage, reason) { //instance, DAMAGE_TYPE
	
	//show_debug_message(instanceof(entity))
	damage *= damager.damageDealt;
	damage *= entity.damageTaken;
	
	if(entity.invuln) return false;
	
	with (entity) {
		var _map = shootable_map;
		switch (reason) {
			case DAMAGE_TYPE.TOUCH: //Only for mob-to-mob
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				flash_frames = 9;
				
				_map[?SHOOTABLE_MAP.HSP] += lengthdir_x(3, point_direction(damager.x, damager.y,x,y)); 
				_map[?SHOOTABLE_MAP.VSP] += lengthdir_y(3, point_direction(damager.x, damager.y,x,y)); 
				
				surface_set_target(oDecalSurf.surf);
				draw_sprite_ext(spBloodDripPositional,irandom(sprite_get_number(spBloodSpatterDirectional)),x,y,1,1,point_direction(damager.x,damager.y,x,y),bloodColor,1);
				surface_reset_target();
				
				break;
			case DAMAGE_TYPE.MELEE: //Only for mob-to-mob
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				flash_frames = 9;
				surface_set_target(oDecalSurf.surf);
				draw_sprite_ext(spBloodSpatterDirectional,irandom(sprite_get_number(spBloodSpatterDirectional)),x,y,1,1,point_direction(x,y,x+shootable_map[?SHOOTABLE_MAP.HSP],y+shootable_map[?SHOOTABLE_MAP.VSP]),bloodColor,1);
				surface_reset_target();
				oDecalSurf.drawnTo = true;
				break;
			case DAMAGE_TYPE.EXPLOSION: //mob-to-projectile
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				flash_frames = 9;
				crowdcontrol_cooldown += 25;
				_map[?SHOOTABLE_MAP.HSP] += lengthdir_x(damage, point_direction(damager.x, damager.y,x,y)); 
				_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(damage, point_direction(damager.x, damager.y,x,y)); 
				break;
				
			case DAMAGE_TYPE.DOT:
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				//flash_frames = 5;
				break;
			case DAMAGE_TYPE.ILLUSION:
				if(entity.object_index == oPlayer){
				
					switch(irandom(3)){
						case 0: scWeaponSwitch(true); break;
						case 1: ds_list_shuffle(weaponList); break;
						case 2: minimapIllusion = 500; break;
						case 3: healthIllusion = 600; break;
					}
				}
				break;
			case DAMAGE_TYPE.BULLET:
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				surface_set_target(oDecalSurf.surf);
				draw_sprite_ext(spBloodSpatterDirectional,irandom(sprite_get_number(spBloodSpatterDirectional)),x,y,clamp(damage/10,0.5,1.5),clamp(damage/10,0.5,1.5),point_direction(damager.x,damager.y,x,y),bloodColor,1);
				surface_reset_target();
				surface_set_target(oDecalSurfW.surf);
				draw_sprite_ext(spBloodSplatWall,irandom(sprite_get_number(spBloodSplatWall)),x,y,clamp(damage/10,0.5,1.5),clamp(damage/10,0.5,1.5),point_direction(damager.x,damager.y,x,y)-90,make_color_hsv(color_get_hue(bloodColor), color_get_saturation(bloodColor), color_get_value(bloodColor)-10),1);
				surface_reset_target();
				oDecalSurf.drawnTo = true;
				break;
			case DAMAGE_TYPE.BLEED:
				_map[? SHOOTABLE_MAP.HEALTH] -= damage;
				surface_set_target(oDecalSurf.surf);
				draw_sprite_ext(spBloodDripPositional,irandom(sprite_get_number(spBloodSpatterDirectional)),x,y,1,1,point_direction(damager.x,damager.y,x,y),bloodColor,1);
				surface_reset_target();
				
				break;
			case DAMAGE_TYPE.EXECUTE:
				_map[? SHOOTABLE_MAP.HEALTH] = 0;
				break;
			default:
				_map[? SHOOTABLE_MAP.HEALTH]-= damage;
				break;
		}
		
		
		event_user(1); //Take damage
		
		
		
		if(entity.object_index == oPlayer && damage > 0) scOnHurt(entity); //Player takes damage
		if((reason != DAMAGE_TYPE.DOT && reason != DAMAGE_TYPE.CHAIN && reason != DAMAGE_TYPE.EXECUTE) && damager.object_index == oPlayer && damage > 0){
			scOnDamage(entity); //Player deals damage
			oGame.combatTimer = 600;
		}
		
		if (!_map[? SHOOTABLE_MAP.DEAD] && _map[? SHOOTABLE_MAP.HEALTH] <= 0) {
			//_map[? SHOOTABLE_MAP.HEALTH] = 0;
			_map[? SHOOTABLE_MAP.DEAD] = true;
			if(damager.object_index == oPlayer) scOnKill(entity); //Player kills enemy
			return true;
		}
	}
	
	return false;
}


enum DAMAGE_TYPE {
	BASIC,
	TOUCH,
	BULLET,
	EXPLOSION,
	DOT,
	ILLUSION,
	BLEED,
	EXECUTE,
	CHAIN,
	MELEE,
	//Fire, laser, explosive...
}