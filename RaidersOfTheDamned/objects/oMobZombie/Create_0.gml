/// @description  

event_inherited()

walk_speed_base = 0.2;
walk_speed = walk_speed_base;

enum ZOMBIE_STATE {
	IDLE, WALKING, CHARGING, ATTACKING,	
	DOORLEANSTART,DOORLEANFAIL,DOORLEANLOOP,
	FLINCHING,
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spZombieIdle;
walkSprite = spZombieRun;
deadSprite = choose(spZombieDie, spZombieDie2);
chargeSprite = spZombieCharge;
attackSprite = spZombieAttack;
flinchSprite = spZombieFlinch;
currentSprite = idleSprite;
current_state = ZOMBIE_STATE.WALKING;

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
doorLeaningOn = noone; 

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 40;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

startChargeX = 0;
startChargeY = 0;
endChargeX = 0;
endChargeY = 0;
