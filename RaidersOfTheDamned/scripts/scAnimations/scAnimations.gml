function scAnimateHP(){
	animVarHP += 0.5*localTD;

	if(oldHP != shootable_map[? SHOOTABLE_MAP.HEALTH]){
		hpScale = 5;
		hpAlpha = 1;
		if(oldHP < shootable_map[? SHOOTABLE_MAP.HEALTH]) hpCol = c_lime;
		else hpCol = c_red;
	}

	hpScale += 0.05*localTD;
	hpAlpha -= 0.01*localTD;

	oldHP = shootable_map[?SHOOTABLE_MAP.HEALTH];
	//if(room != rmIntro && !shootable_map[? SHOOTABLE_MAP.DEAD] && animVarHP % 30 == 0 && hpAlpha > 0) audio_play_sound_at(snHeartBeep, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]), 1, 30, 200, 0.4, false, 3);
}