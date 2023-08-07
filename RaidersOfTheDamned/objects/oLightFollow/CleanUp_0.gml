/// @description  

aura_light_free();

if(instance_exists(owner) && owner.object_index == oPlayer && owner.flashlightObj == id)
	owner.flashlightObj = noone;
