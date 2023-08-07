/// @description  
part_emitter_region(global.particleSystem, global.emitter, x-5,x+5,y-2,y+2,ps_shape_ellipse,ps_distr_linear);
part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_smoke1, irandom_range(2,4));
			
if(irandom(5) == 1) scParticleBurstLight(bbox_left,bbox_top, bbox_right, bbox_bottom, 1, 1, 60+irandom(30), make_color_rgb(75, 128, 202));
if(instance_exists(eyes)) instance_destroy(eyes);

