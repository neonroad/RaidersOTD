/// @description Insert description here
// You can write your code in this editor
event_inherited();

if(attacking != noone){
	attacking.current_state = PLAYER_STATE.PLAYING;
	attacking = noone;
}

audio_play_sound_at(snBoxFlat, x, y, 0, 60, 240, 0.5, false, 2);

