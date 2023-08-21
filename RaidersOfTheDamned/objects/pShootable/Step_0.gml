/// @description  
localTD = global.TD*truelocalTD;

crowdcontrol_cooldown -= localTD;
crowdcontrol_cooldown = max(0, crowdcontrol_cooldown);
flash_frames-= localTD;
flash_frames = max(0, flash_frames);

if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	depth = -y;	
}

if(max_lifetime >= 1){
	lifetime+= localTD;
	
	if(lifetime >= max_lifetime)
		shootable_map[?SHOOTABLE_MAP.DEAD] = true;
}


if(crowdcontrol_cooldown > 0){
	//Save state
	//if(control){
	//	prevState = current_state;	
	//}
	control = false;
}

else{
	//Restore state
	//if(!control && prevState != noone){
	//	current_state = prevState;
	//}
	control = true;
}