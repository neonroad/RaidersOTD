/// @description  

event_inherited()

walk_speed_base = 1;
walk_speed = walk_speed_base;

enum WARRIOR_STATE {
	IDLE, WALKING, CHARGING, ATTACKING,	FLYING,
	ROAR, SLIDE, TURNFORWARD, COMBO1, BLOCKING,
	RETREAT, TELEPORTING, SHORTHOP,
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = choose(spWarriorBugIdleLeft, spWarriorBugIdleRight);
walkSprite = spZombieRun;
deadSprite = choose(spZombieDie, spZombieDie2);
chargeSprite = spZombieCharge;
attackSprite = spZombieAttack;
currentSprite = idleSprite;
current_state = WARRIOR_STATE.WALKING;
blockTimer = 0;
invisible = false;

hitList = ds_list_create();
confirmList = ds_list_create();

friction_base = 0.08;
damageToDo = 2;
target = oPlayer;
attacking = noone;

contact_cooldown_max = 180;
contact_cooldown = -1;
attack_range = 128;
bloodColor = make_color_rgb(62, 108, 173);
ai_start_cooldown = 0;

look_speed = 1;

connectedHit = false;
ableToDamage = false;
checkHitboxApplication = false;

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 600;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

startChargeX = 0;
startChargeY = 0;
endChargeX = 0;
endChargeY = 0;
