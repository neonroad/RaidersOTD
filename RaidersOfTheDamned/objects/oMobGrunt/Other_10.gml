/// @description On Death
// You can write your code in this editor

if(attacking != noone){
	attacking.current_state = PLAYER_STATE.PLAYING;
	attacking = noone;
}

audio_play_sound_at(snDie1, x, y, 0, 60, 240, 0.5, false, 2);
var pickup = instance_create_layer(x,y,"Items", oUpgradePickup);
pickup.upgradeEnum = UPGRADES.K1;