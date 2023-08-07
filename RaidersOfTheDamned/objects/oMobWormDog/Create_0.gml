/// @description  

event_inherited()

walk_speed_base = 0.8;
walk_speed = walk_speed_base;

enum DOG_STATE {
	IDLE, WALKING, CHARGING, ATTACKING,	
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spWormDogIdle;
walkSprite = spWormDogIdle;
deadSprite = spWormDogCharge;
chargeSprite = spWormDogCharge;
attackSprite = spWormDogAttack;
currentSprite = idleSprite;
current_state = DOG_STATE.IDLE;

invisible = false;

hitList = ds_list_create();
confirmList = ds_list_create();

friction_base = 0.02;
damageToDo = 2;
target = oPlayer;
attacking = noone;

contact_cooldown_max = 180;
contact_cooldown = -1;
attack_range = 44;

ai_start_cooldown = 0;

look_speed = 0.4;

ableToDamage = false;
lungeSpeed = 3;
growlTimeCurrent = 0;
growlTimeMax = 45;
bloodColor = make_color_rgb(190, 188, 190);

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 20;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
startChargeX = 0;
startChargeY = 0;
endChargeX = 0;
endChargeY = 0;