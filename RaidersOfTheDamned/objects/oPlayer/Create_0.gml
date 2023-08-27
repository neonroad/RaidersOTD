/// @description Insert description here
// You can write your code in this editor
event_inherited();

enum PLAYER_STATE{
	PLAYING, HURT,DEAD,WINNING,ENDSTUN,TRANSITIONING,ROLLING,
	LAUNCHED,RECOIL,SLEEP,SLEEPWAKEUP,INVENTORYACCESS,
}

var curs = instance_create_depth(x,y,-500,oCursor);
curs.owner = id;

rollEnhanced = false;
recoilTime = 0;
uiShake = 0;
uiShakeDur = 0;
uiXShake = 0;
uiYShake = 0;
critChance = -5; //Higher number is better
walk_speed = 1;
walk_speed_base = walk_speed;
hitWall = false;
moved = false;
angleAiming = 0;
angle_facing = 0;
move_vsp = 0;
move_hsp = 0;
currentSprite = spPlayerIdle;
animVar = 0;
animDir = 1;
damageTaken = 1;
damageDealt = 1;
c_color = c_white;
alpha = 1;
scale = 1;
textFade = 0;
alphaTransition = 1;
vampKills = 0;
vampKillsMax = 10;
bloodColor = make_color_rgb(151,46,46);
meleewep = false;
weaponFlip = false;
rollBuffer = 0;
interactList = [];
icursor = noone;
keyItems = [];

cameraControl = true;
cameraPivotX = x;
cameraPivotY = y;

minimapIllusion = 0;
healthIllusion = 0;

interactAvailable = false;
interactToggle = false;
interactAnim = 0;
interacted = false;
switchAvailable = false;
switchAnim = 0;
switchWith = noone;
pickupError = false;

inventory = ds_list_create();
inventory_limit = 8;
image_speed = 0;
facing = 1;
oldFacing = 1;
current_state = PLAYER_STATE.PLAYING;
laserpointer = false;
laserObj = noone;

weaponList = ds_list_create();
weaponEquipped = noone;
weaponEquippedSprite = spGun;
weaponItemSprite = noone;
gunRecoilX = 0;
gunRecoilY = 0;

shootable_map[?SHOOTABLE_MAP.HEALTH_START] = 3;
shootable_map[? SHOOTABLE_MAP.HEALTH] = shootable_map[?SHOOTABLE_MAP.HEALTH_START];

oldHP = shootable_map[?SHOOTABLE_MAP.HEALTH];

hpCol = c_white;
hpAlpha = 0;
hpScale = 5;

invObj = instance_create_depth(x,y,-990,oInventoryManager);


animVarHP = 0;
yModDraw = 0;
xModDraw = 0;
bullets = 0;
flashlight = noone;
flashlightObj = noone;
friction_base = 0.1;
iframes = 0;

image_xscale = scale;
image_yscale = scale;

camera_set_view_pos(view_camera[0], x-120, y-120);

roomChanged = noone;




var randSpawn = instance_number(oSpawnLoc);
randSpawn = instance_find(oSpawnLoc,irandom_range(0, randSpawn-1));
x = randSpawn.x;
y = randSpawn.y;


