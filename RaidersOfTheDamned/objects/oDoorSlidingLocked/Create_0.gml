/// @description 

// Inherit the parent event
event_inherited();

open = false;
unlocked = false;

interactable = false;
interacted = false;


image_speed = 0;

if(instance_exists(interiorEntrance)){
	array_push(interiorEntrance.entrances, id);
}

function openDoor(){
	open = true;
	image_speed = 1;
	image_index = 1;
	sprite_index = spSlidingDoorGreenOpen;
	audio_play_sound_at(snDoorSlide, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(1.5,1.7));	
}

function closeDoor(){
	open = false;
	image_speed = 1;
	image_index = 1;
	sprite_index = spSlidingDoorGreenOpen;
	audio_play_sound_at(snDoorSlideClose, x, y, 0, 60, 240, 0.5, false, 2,,,random_range(1.5,1.7));	
}