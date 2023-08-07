/// @description  


if(other.current_state != PLAYER_STATE.ROLLING){
	hsp += other.shootable_map[?SHOOTABLE_MAP.HSP]*2;
	vsp += other.shootable_map[?SHOOTABLE_MAP.VSP]*2;
}

if(vsp!= 0 || hsp != 0){

	//audio_play_sound_at(snTrashFall, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.2,0.5));

	upright = false;
	if(instance_place(x,y,oWall)){
		hsp = 0;
		vsp = 0;
		exit;
	}
	part_emitter_region(global.particleSystem, global.emitter, (x+hsp) - 5, (x+hsp) + 5,(y+vsp) - 5,(y+vsp) + 5, ps_shape_rectangle, ps_distr_invgaussian);
	part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_roll, 5);
					
}		