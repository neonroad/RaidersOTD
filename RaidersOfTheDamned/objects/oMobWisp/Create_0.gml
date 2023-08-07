/// @description  

event_inherited()

walk_speed_base = 0.2;
walk_speed = walk_speed_base;

enum WISP_STATE {
	IDLE, WALKING, CHARGING, ATTACKING,	
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spWispIdle;
walkSprite = spWispIdle;
deadSprite = spWispDie;
chargeSprite = spWispCharge;
attackSprite = spWispIdle;
currentSprite = idleSprite;
current_state = WISP_STATE.IDLE;

invisible = false;
shootable_map[? SHOOTABLE_MAP.FRIENDLY] = true;

hitList = ds_list_create();
confirmList = ds_list_create();

friction_base = 0.05;
damageToDo = 2;
target = noone;
attacking = noone;

contact_cooldown_max = 180;
contact_cooldown = -1;
attack_range = 64;

ignoreWalls = true;
ai_start_cooldown = 0;

look_speed = 0.8;
max_lifetime = 300;
ableToDamage = false;

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 10;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
