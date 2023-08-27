/// @description Insert description here
// You can write your code in this editor


if(!eventOver && !eventTriggered){
	eventTriggered = true;
	var cam = noone;
	for (var i = 0; i < instance_number(oCamTarget); i++) {
	    cam = instance_find(oCamTarget,i);
		if(cam.owner == id) break;
	}
	
	other.cameraControl = false;
	other.cameraPivotX = cam.x;
	other.cameraPivotY = cam.y;
	
	var mob = noone;
	for (var i = 0; i < instance_number(oMobGrunt); i++) {
	    mob = instance_find(oMobGrunt,i);
		if(mob.eventOwner == id) break;
	}
	
	mob.ai_start_cooldown = 0;
}



