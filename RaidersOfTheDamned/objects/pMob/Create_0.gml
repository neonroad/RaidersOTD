/// @description  

event_inherited()

control = true;

currentPath = noone;
prevX = x;
prevY = y;

despawnTime = 100;
spawned = false;
justDied = false;
invuln = false;
shotgunHit = false;

asym = false; //For drawing asymmetrical sprites

currently_attacking = false;

deadSpriteChosen = false;
idleSprite = noone;
deadSprite = noone;
walkSprite = noone;
currentSprite = idleSprite;
checkDead = false;
animVar = 0;
alpha = 1;
c_color = c_white;
facing = 1;
scale = 1;
flash_frames = 0;
target = noone;
damageTaken = 1;
timerShadow = 0;
deadSpriteAnimLoop = false;
shootable_map[? SHOOTABLE_MAP.FRIENDLY] = false;
bloodColor = make_color_rgb(151,46,46);
touchingWalls = [];

//Not proud of these
bleedApplier = noone;
bleedTimeMax = 60;
bleedTimeFuture = 0;
bleedTimeTick = 30;
bleedTimeCurrent = 0;
bleedDamage = 1;
bleedEnabled = false;

enum MOB {
	BASIC_ZOMBIE,
	//LEAVE LAST
	LENGTH
}
