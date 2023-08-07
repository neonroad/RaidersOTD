/// @description Insert description here
// You can write your code in this editor
event_inherited();

if(attacking != noone){
	attacking.current_state = PLAYER_STATE.PLAYING;
	attacking = noone;
}

scParticleBurst(bbox_left,bbox_top,bbox_right,bbox_bottom,5,5,100,bloodColor,,,,0.8);

audio_play_sound_at(snDie1, x, y, 0, 60, 240, 0.5, false, 2);

//var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
//var newItem = instance_create_layer(x,y,"Items",oItemWorld, {itemID : ITEMS.KEYCARD_GREEN});
//var itemSeq = layer_sequence_get_instance(item);
//sequence_instance_override_object(itemSeq,oItemWorld,newItem);