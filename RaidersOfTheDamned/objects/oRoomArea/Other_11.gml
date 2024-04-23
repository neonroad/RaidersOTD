/// @description Bug
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
	for (var i = 0; i < instance_number(oMobWarriorBug); i++) {
	    mob = instance_find(oMobWarriorBug,i);
		if(mob.eventOwner == id) break;
	}
	with(mob) warriorBugRoar();
	mob.ai_start_cooldown = 0;
}



