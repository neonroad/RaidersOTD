/// @description  

event_inherited()

walk_speed_base = 0.1;
walk_speed = walk_speed_base;

enum PROPHET_STATE {
	IDLE, WALKING, CHARGING, ATTACKING, ALARMED,
}

scale = 1;
image_xscale = scale;
image_yscale = scale;
idleSprite = spProphetIdle;
alarmedSprite = spProphetAlarmedIdle;
walkSprite = spProphetIdle;
deadSprite = spProphetIdle;
chargeSprite = spProphetIdle;
attackSprite = spProphetIdle;
currentSprite = idleSprite;
current_state = PROPHET_STATE.IDLE;

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

look_speed_base = 0.2;
look_speed = 0.2;
ableToDamage = false;
laserObj = noone;
asym = true;
bloodColor = make_color_rgb(106,83,110);

lightFollow = Aura_Light_Create_Fast("Instances", oLightFollowFast, spr_Aura_Prophet_Light,-1,x,y,1,1,0,c_yellow,0.5);
lightFollow.owner = id;

image_speed = 0.2;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 40;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

headDead = false;
