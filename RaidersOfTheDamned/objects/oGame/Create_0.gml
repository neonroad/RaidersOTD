/// @description Insert description here
// You can write your code in this editor

/*
rollback_define_player(oPlayer);
var _joined = rollback_join_game();

if (!_joined)
{
    rollback_create_game(2, false);
}
*/
#macro config "SP"
#macro Default:config "Default"
#macro noIntro:config "noIntro"
#macro Test:config "Test"

randomise();

mapGrid = mp_grid_create(864,768,50,50,32,32);
mapGridBreakable = mp_grid_create(864,768,50,50,32,32);

minimapGrid = noone;
minimapScale = 1;

uiShake = 0;
uiShakeDur = 0;
uiXShake = 0;
uiYShake = 0;

global.inventoryOpen = false;
global.TD = 1;

//new_font = font_add("NOTJAMCHUNKYSANS.TTF", 6, false, false, 32, 128);
//font_enable_sdf(new_font, true);
draw_set_font(fnNotJamChunky);


mp_grid_add_instances(mapGrid,oWall,false);

mp_grid_add_instances(mapGridBreakable,oWall,false);

for (var i = 0; i < instance_number(oBreakableWall); i++) {
	var wall = instance_find(oBreakableWall, i);
	mp_grid_clear_cell(mapGridBreakable,1+((wall.x - 896) div 32),1+((wall.y- 800) div 32));
}	


makeInvisMonsters = false;
//mapSurf = noone;
initiatePlay = false;
play = false;

//First created in rmMenu
roomWidth = 1600;
roomHeight = 1600;
roomTest = rmTutorial;
viewportIndex = 0;
viewCamera = view_camera[0];
cameraSize = 240;
xTo = 0;
yTo = 0;
yIs = 0;
xIs = 0;


surface_resize(application_surface, cameraSize+1,cameraSize+1);
application_surface_draw_enable(false);

//camera = camera_create();
player = noone;
upgradeObj = noone;
spawnTimer = 100;
spawnTimerMax = 600;
evacTimer = -1;
evacRoom = noone;

combatTimer = 0;

roomTemp = ds_map_create();

introSpawn = false;
gameStart = false;
roomArray = [rmA1,rmB1,rmC1,rmA2,rmB2,rmC2,rmA3,rmB3,rmC3];



//camera_set_view_size(view_camera[0], cameraSize,cameraSize);
window_set_size(cameraSize,cameraSize);

instance_create_depth(x,y,600,oDecalSurf);
instance_create_depth(x,y,700,oDecalSurfW);
//x = -500;
//y = -500;
