/// @description  

part_timer-=global.TD;
if(part_timer <= 0){
	part_particles_create(global.particleSystem, irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), oParticleSystem.particle_crystal, 1);
	part_timer += irandom_range(100,200);
}