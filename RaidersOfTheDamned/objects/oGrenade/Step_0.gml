/// @description Insert description here
// You can write your code in this editor

var explodeHere = function(){
	if(explode) return false;
	audio_play_sound_at(snLevelDong, x, y, 0, 120, 360, 0.5, false, 20);
	sprite_index = spNadeSplode;
	image_index = 0;
	explode = true;
	Aura_Light_Create_Fast(layer_get_id("Instances"),oLightFast, -1,-1,x,y,2,2,0,c_white,1);
}

if(!explode){
	x += lengthdir_x(4,targetAngle);
	y += lengthdir_y(4,targetAngle);
}

ds_list_clear(hitList);
var wallHit = instance_place(x,y,oWall);
var entHit = instance_place_list(x,y,pShootable,hitList,false);
		
if(wallHit != noone && ds_list_empty(hitList)){
	hit = true;
	explodeHere();
}
		
else if(!ds_list_empty(hitList)){
	for (var i = 0; i < ds_list_size(hitList); i++) {
		var mob = hitList[|i];	
				
		if(mob.id != owner.id && !mob.shootable_map[?SHOOTABLE_MAP.DEAD]){
			
			mob.crowdcontrol_cooldown = 5;
			mob.shootable_map[? SHOOTABLE_MAP.HSP] += lengthdir_x(random(0.5),point_direction(x,y,mob.x,mob.y));
			mob.shootable_map[? SHOOTABLE_MAP.VSP] += lengthdir_y(random(0.5),point_direction(x,y,mob.x,mob.y));
			var damage = clamp(32-point_distance(x,y,mob.x,mob.y),1,32);
			damage*= owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)][? "BULLET_DAMAGE"];
			scDamage(mob,owner,damage,DAMAGE_TYPE.BULLET);
			scParticleBurst(x,y,x+10,y+10,damage,damage*0.2,100,mob.bloodColor);
			
			if(!explode) explodeHere();
		}
	}
			
}



timer--;

if(timer<0 || (image_index >= image_number-1 && explode))instance_destroy();