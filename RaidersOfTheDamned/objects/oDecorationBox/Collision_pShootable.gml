/// @description  
if(!upright) exit;

audio_play_sound_at(snBoxFlat, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));

image_index = 1;
upright = false;
depth = layer_get_depth("Assets");
		