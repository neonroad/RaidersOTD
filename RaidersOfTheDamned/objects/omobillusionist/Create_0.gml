/// @description  

event_inherited()

walk_speed_base = 0;
walk_speed = walk_speed_base;

enum ILLUSIONER_STATE {
	IDLE, CASTING, HURT, DYING,	
}

enum ILLUSIONER_SPELLS {
	MIMICS, HORDE, FAKES, MAZE,	LENGTH,
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spIllusionerIdle1;
walkSprite = spIllusionerCasting;
deadSprite = spIllusionerDie;
chargeSprite = spZombieCharge;
attackSprite = spZombieAttack;
hurtSprite = spIllusionerHit;
currentSprite = idleSprite;
current_state = ILLUSIONER_STATE.CASTING;
eyes = noone;
beginIllusion = false;
currentSpell = noone;
fakeArray = [];


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

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 250;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
