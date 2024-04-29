/// @description Insert description here
// You can write your code in this editor

var explodeHere = function(){
	if(explode) return false;
	audio_play_sound_at(snLevelDong, x, y, 0, 120, 360, 0.5, false, 20);
	sprite_index = spNadeSplode;
	image_index = 0;
	//image_xscale = 2;
	//image_yscale = 2;
	explode = true;
	Aura_Light_Create_Fast(layer_get_id("Instances"),oLightFast, -1,-1,x,y,2,2,0,c_white,1);
}

explodeHere();

ds_list_clear(hitList);
var entHit = instance_place_list(x,y,pShootable,hitList,false);


if(!ds_list_empty(hitList) && timer == 60){
	for (var i = 0; i < ds_list_size(hitList); i++) {
		var mob = hitList[|i];	
				
		if(instance_exists(owner) && mob.id != owner.id && !mob.shootable_map[?SHOOTABLE_MAP.DEAD]){
			
			mob.crowdcontrol_cooldown = 5;
			mob.shootable_map[? SHOOTABLE_MAP.HSP] += 3;
			mob.shootable_map[? SHOOTABLE_MAP.VSP] += 3;
			var damage = mob.object_index == oPlayer ? 1 : clamp(128-point_distance(x,y,mob.x,mob.y),1,128);
			scDamage(mob,owner,damage,DAMAGE_TYPE.EXPLOSION);
			
			if(mob.object_index == oPlayer){
				with(mob){
					current_state = scStateManager(PLAYER_STATE.LAUNCHED);
					shootable_map[?SHOOTABLE_MAP.HSP] -= lengthdir_x(10,point_direction(x,y,other.x,other.y));
					shootable_map[?SHOOTABLE_MAP.VSP] += -lengthdir_y(10,point_direction(x,y,other.x,other.y));				
				}	
			}
			
			scParticleBurst(x,y,x+10,y+10,damage,damage*0.2,100,mob.bloodColor);
			//show_debug_message(damage);
			
		}
	}
			
}



timer-=global.TD;

if(timer<0 || (image_index >= image_number-1 && explode))instance_destroy();