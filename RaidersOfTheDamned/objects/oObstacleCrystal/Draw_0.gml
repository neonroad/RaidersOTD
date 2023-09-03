/// @description  


if(destroyed){
	image_index = 1;
	
	//Trigger once
	if(!open){
		open = true;
		with(oGame) reloadWalls();
		audio_play_sound_at(snCrystalShatter, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));
		scParticleBurst(x, y,x,y,50,7,60,make_color_rgb(75, 128, 202), true, 0,360,0.7);
		instance_destroy(emitsLight);
	}
}

draw_self();

part_timer-=global.TD;
if(!destroyed && part_timer <= 0){
	part_particles_create(global.particleSystem, irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), oParticleSystem.particle_crystal, 1);
	part_timer += irandom_range(10,20);
}

