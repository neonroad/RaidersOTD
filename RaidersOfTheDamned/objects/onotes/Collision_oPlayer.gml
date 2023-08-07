/// @description 

if(!show_text) other.interactAvailable = true;

if(!show_text && other.interacted){
	show_text = true;	
	audio_play_sound(snNoteRead, 2, false);
	instance_destroy(light)
}
