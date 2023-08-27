/// @description  

event_inherited()

walk_speed_base = 0.8;
walk_speed = walk_speed_base;

enum GRUNT_STATE {
	IDLE, WALKING, CHARGING, ATTACKING, RECHARGING,	DEAD, PUNCHING,
}

scale = 2;
pushing = false;
//image_xscale = scale;
//image_yscale = scale;
idleSprite = spGrunt_IdleS;
walkSprite = spGrunt_IdleS;
deadSprite = spGrunt_Die;
chargeSprite = spZombieCharge;
attackSprite = spZombieAttack;
currentSprite = idleSprite;
current_state = ZOMBIE_STATE.IDLE;

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

look_speed = 10;

ableToDamage = false;

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 600;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
