/// @desc 
shootable_map = ds_map_create();
shootable_map[? SHOOTABLE_MAP.HEALTH_START] = 6;
shootable_map[? SHOOTABLE_MAP.FRIENDLY] = true;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[? SHOOTABLE_MAP.HEALTH_START];
shootable_map[? SHOOTABLE_MAP.HSP] = 0;
shootable_map[? SHOOTABLE_MAP.VSP] = 0;
flash_frames = 0;
crowdcontrol_cooldown = 0;
friction_base = 0.5;
damageDealt = 1;
ignoreWalls = false;
angleFacing = 0;
look_speed = 1;
angX = 0;
angY = 0;
currentSpeed = 0;
truelocalTD = 1;
localTD = 1;
iframes = 0;
lifetime = -1;
max_lifetime = -1;
inside = false;
prevState = noone;

enum SHOOTABLE_MAP {
	HEALTH_START,
	HEALTH,
	DEAD,
	FRIENDLY,
	HSP,
	VSP,
}