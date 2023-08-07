/// @description  
if(instance_number(oPlayer) <= 0) exit;

x = oPlayer.x;
y = oPlayer.y;

audio_listener_position(x, y, 0);
audio_listener_orientation(0,0,-1000,0,1,0);

if(!musicEnabled) exit;

if(room == rmIntro && !playedIntroSong){
	playedIntroSong = true;
	current_song = audio_play_sound(snMusicGameStart, 30, false);
	audio_sound_gain(current_song, 0, 0);
	audio_sound_gain(current_song, 0.5, 3000);
}

if(!audio_is_playing(current_song)){
	
	if(oGame.roomTemp[? room] > 50){
		current_song = audio_play_sound(snMusicBattle, 30, false);	
		exit;
	}
	else if(oPlayer.shootable_map[? SHOOTABLE_MAP.HEALTH] == 1 && oPlayer.healthIllusion <= 0){
		current_song = audio_play_sound(snMusicLowHP, 30, false);	
		//exit;
	}
	else if(room == rmA1){
		current_song = audio_play_sound(snMusicRoam, 30, false);
		roam_song = current_song;
	}
}

if(audio_is_playing(current_song) && roam_song == current_song){
		
	if(oGame.combatTimer <= 0 && audio_sound_get_track_position(current_song) >= endTrack){
		startTrack = 7;
		endTrack = 31;
		audio_sound_set_track_position(current_song,7);
	}
	else if(oGame.combatTimer > 0){
		var currentTrack = audio_sound_get_track_position(current_song);
		if(currentTrack > 31 && currentTrack <= 48.58) endTrack = 48.58;
		else if(currentTrack > 48.58) endTrack = 82.57;
	}
	
}

if(oPlayer.shootable_map[? SHOOTABLE_MAP.DEAD] && !playedGameOverSong){
	audio_stop_sound(current_song);
	playedGameOverSong = true;
	current_song = audio_play_sound(snMusicTitle, 30, true);
	audio_sound_gain(current_song, 0, 0);
	audio_sound_gain(current_song, 0.5, 3000);
}