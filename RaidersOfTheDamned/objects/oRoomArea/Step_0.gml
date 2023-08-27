/// @description 
if(instance_place(x,y,oPlayer) == noone){
	active = false;
}

if(active){
	for (var i = 0; i < array_length(mobs); i++) {
	    instance_activate_object(mobs[i]);
	}	
	mobs = [];
}