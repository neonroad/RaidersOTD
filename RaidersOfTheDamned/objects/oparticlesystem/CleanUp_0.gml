/// @description 
if(surface_exists(surf))
	surface_free(surf);


part_emitter_destroy(global.particleSystem, global.emitter);
part_system_destroy(global.particleSystem);