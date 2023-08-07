/// @description  
if(!upright) exit;

hsp += other.shootable_map[?SHOOTABLE_MAP.HSP]*1;
vsp += other.shootable_map[?SHOOTABLE_MAP.VSP]*1;

audio_play_sound_at(snTrashFall, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));

upright = false;

part_emitter_region(global.particleSystem, global.emitter, (x+hsp) - 5, (x+hsp) + 5,(y+vsp) - 5,(y+vsp) + 5, ps_shape_rectangle, ps_distr_invgaussian);

part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_scrap, 5);
					
depth = layer_get_depth("Assets");	