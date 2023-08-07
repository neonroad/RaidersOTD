/// @description  

part_emitter_region(global.particleSystem, global.emitter, bbox_left-5,bbox_right+5,bbox_top-2,bbox_bottom+2,ps_shape_ellipse,ps_distr_linear);
part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_smoke1, irandom_range(4,8));


instance_destroy();

