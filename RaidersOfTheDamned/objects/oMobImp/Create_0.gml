/// @description  

event_inherited()

walk_speed_base = 0.06;
walk_speed = walk_speed_base;

enum IMP_STATE {
	IDLE, WALKING, CHARGING, ATTACKING,	
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spImpIdle;
walkSprite = spImpIdle;
deadSprite = spImpIdle;
chargeSprite = spImpIdle;
attackSprite = spImpIdle;
currentSprite = idleSprite;
current_state = IMP_STATE.IDLE;

invisible = false;

hitList = ds_list_create();
confirmList = ds_list_create();

friction_base = 0.05;
damageToDo = 2;
target = oPlayer;
attacking = noone;

contact_cooldown_max = 180;
contact_cooldown = -1;
attack_range = 64;

ai_start_cooldown = 0;

look_speed = 0.8;

ableToDamage = false;

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 10;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
