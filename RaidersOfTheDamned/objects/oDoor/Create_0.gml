/// @description 

// Inherit the parent event
event_inherited();

open = false;

interactable = false;

image_speed = 0;

if(instance_exists(interiorEntrance)){
	array_push(interiorEntrance.entrances, id);
}