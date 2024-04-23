/// @description  Hit

invisible = false;
alpha = 1;

if(current_state == WARRIOR_STATE.WALKING && (currentSprite == spWarriorBugIdleLeft || currentSprite == spWarriorBugIdleRight)){
	warriorBugRetreat();
}

