/// @description  

event_inherited()

walk_speed_base = 0;
walk_speed = walk_speed_base;

enum FUNGUS_STATE {
	IDLECLOSED, IDLEOPEN, CLOSEDATTACKING, HURTOPEN
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spMobFungusClosedIdle;
walkSprite = spMobFungusClosedIdle;
deadSprite = choose(spMobFungusClosedIdle, spMobFungusClosedIdle);
chargeSprite = spMobFungusClosedIdle;
attackSprite = spMobFungusClosedIdle;
flinchSprite = spMobFungusClosedIdle;
currentSprite = idleSprite;
current_state = FUNGUS_STATE.IDLECLOSED;

invisible = false;

invuln = true;

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

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 300;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

startChargeX = 0;
startChargeY = 0;
endChargeX = 0;
endChargeY = 0;
