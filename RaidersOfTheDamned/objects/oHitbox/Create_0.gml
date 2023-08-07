/// @description  


owner = noone;

hitList = ds_list_create();
confirmList = ds_list_create();
timer = 0;
hitboxScript = function(mob){
	
	if(instance_exists(mob) && mob != owner && !mob.shootable_map[? SHOOTABLE_MAP.FRIENDLY]
	&& !mob.shootable_map[? SHOOTABLE_MAP.DEAD] && ds_list_find_index(confirmList, mob) == -1){
		mob.crowdcontrol_cooldown = max(mob.crowdcontrol_cooldown + 15, 15);
		ds_list_add(confirmList, mob);
		
		with(mob){
			shootable_map[?SHOOTABLE_MAP.HSP] += lengthdir_x(3, other.image_angle + ((other.owner.weaponFlip) ? -45 : 45)); 
			shootable_map[?SHOOTABLE_MAP.VSP] += lengthdir_y(3, other.image_angle + ((other.owner.weaponFlip) ? -45 : 45)); 
			scLookAt(x+shootable_map[?SHOOTABLE_MAP.HSP],y+shootable_map[?SHOOTABLE_MAP.VSP]);
		}
		scDamage(mob,owner,10, DAMAGE_TYPE.MELEE);
		scParticleBurst(mob.x-3,mob.y-3,mob.x+3,mob.y+3,15,1,65,mob.bloodColor);
		audio_play_sound_at(choose(snMetalHit1,snMetalHit2), x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));	
					
	}
}


hitboxConnect = function(mob){
	//nothing
}

hitboxWhiff = function(){
	audio_play_sound_at(choose(snWhoosh1,snWhoosh2), x, y, 0, 60, 240, 0.5, false, 2);
		
}