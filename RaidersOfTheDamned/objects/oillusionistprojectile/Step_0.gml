/// @description  

if(!instance_exists(owner)){
	instance_destroy();
	exit;
}

x += hsp*owner.localTD;
y += vsp*owner.localTD;

if(target != noone){
	var obj = instance_place(x, y, target.object_index);
	if(obj != noone){
		scDamage(obj,owner, 1, DAMAGE_TYPE.ILLUSION);
		instance_destroy();	
		exit;
	}
}
lifetime-= owner.localTD;

image_angle = darctan2(-vsp, hsp);

part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-5,bbox_bottom+5,ps_shape_ellipse,ps_distr_linear);
part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_invis, irandom(1));



if(lifetime <= 0){
	instance_destroy();	
}
