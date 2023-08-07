/// @description Insert description here
// You can write your code in this editor

if(attacking != noone){
	attacking.current_state = PLAYER_STATE.PLAYING;
	attacking = noone;
}

audio_play_sound_at(snDie1, x, y, 0, 60, 240, 0.5, false, 2);

