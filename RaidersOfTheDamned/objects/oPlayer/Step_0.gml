/// @description Insert description here
// You can write your code in this editor

localTD = global.TD*truelocalTD;


animVarChanged = false;
oldAnimVar = floor(animVar);
animVar += image_speed*localTD;
hitWall = false;
depth = -y;	

if(floor(animVar) != oldAnimVar) animVarChanged = true;

if(room != rmIntro && scRoomChanged()){
	audio_play_sound(snLevelDong, 10, false);
	current_state = scStateManager(PLAYER_STATE.SLEEP);
	//current_state = PLAYER_STATE.PLAYING; //Override any state
	alphaTransition = 1;
	//lightFollowF = instance_create_layer(x,y, "Instances", oLightFollowFast);
	//lightFollowF.owner = id;
	lightFollowP = instance_create_layer(x,y, "Instances", oLightFollowFast);
	lightFollowP.owner = id;	
	textFade = 5;
}

var maxFrameAnim = sprite_get_number(currentSprite)-1;
if(animVar >= maxFrameAnim){
	if(currentSprite == spPlayerDie){
		animVar = maxFrameAnim;
	}
	if(current_state == PLAYER_STATE.INVENTORYACCESS){
		image_speed = 0;
		
		if(currentSprite == spPlayerInventoryClose)
			current_state = PLAYER_STATE.PLAYING;
	}
	
	if(current_state == PLAYER_STATE.SLEEPWAKEUP){
		if(currentSprite == spPlayerSleepWake){
			animVar = 0;
			currentSprite = spPlayerSitGetup;
		}
		else if(currentSprite == spPlayerSitGetup){
			animVar = 0
			current_state = PLAYER_STATE.PLAYING; //Override
			image_speed = 0;
		}
	}
}

if(shootable_map[?SHOOTABLE_MAP.DEAD] && currentSprite != spPlayerDie){
	alphaTransition = 0;
	currentSprite = spPlayerDie;
	animVar = 0;
	image_speed = 0.3;
	audio_play_sound_at(snDie2, x, y, 0, 60, 240, 0.5, false, 2);
}

current_state = scStateManager(PLAYER_STATE.PLAYING);

scRollCheck(); 

if(!shootable_map[?SHOOTABLE_MAP.DEAD]){
	if(current_state == PLAYER_STATE.PLAYING){
		minimapIllusion -= localTD; //Tick down every step
		healthIllusion -= localTD;
		moved = scCheckCollision();
		
		
		//FIX AUDIO/TIME DILATION
		if(moved && animVarChanged && floor(animVar)%3 == 0){
			walkSound = audio_play_sound(snPlayerWalk, 2, false);
			audio_sound_pitch(walkSound, random_range(0.8,1.2));
		}
		scAim();
		
		scWeaponSwitch();
		
	}
	else{
		hitWall = scCheckCollision2();
		
		if(current_state == PLAYER_STATE.ROLLING){
			for (var i = 0; i < ds_list_size(touchingWalls); i++) {
			    if(rollEnhanced && touchingWalls[| i].object_index == oObstacleCrystal)
					touchingWalls[| i].destroyed = true;
			}
		}
	}
	if(current_state == PLAYER_STATE.LAUNCHED){
		if(currentSprite != spPlayerLaunch){
			image_speed = 0;
			currentSprite = spPlayerLaunch;
			animVar = choose(0,1);
			yModDraw = -5;
		}
		
		if(yModDraw >= 0 || (!hitWall)){
			current_state = PLAYER_STATE.PLAYING;
			shootable_map[? SHOOTABLE_MAP.VSP] = 0;
			shootable_map[? SHOOTABLE_MAP.HSP] = 0;
		}
	}
	
	if(current_state == PLAYER_STATE.RECOIL) recoilTime -= localTD;
	if(current_state == PLAYER_STATE.SLEEP){
		currentSprite = spPlayerSleep;
		image_speed = 0.05;
		if(animVar % 4 == 0) part_particles_create(global.particleSystem, bbox_right,bbox_top, oParticleSystem.particle_sleep, 1);
		if(keyboard_check_pressed(ord("E"))){
			current_state = scStateManager(PLAYER_STATE.SLEEPWAKEUP);	
			currentSprite = spPlayerSleepWake;
			animVar = 0;
			 part_particles_create(global.particleSystem, bbox_right,bbox_top, oParticleSystem.particle_exclam, 1);
		}
	}
	if(current_state == PLAYER_STATE.SLEEPWAKEUP){
		image_speed = 0.2;
	}
	
	scCheckInventory();
	
	var hsp = shootable_map[? SHOOTABLE_MAP.HSP];
	var vsp = shootable_map[? SHOOTABLE_MAP.VSP];
	
	currentSpeed = lerp(sqrt((hsp*hsp) + (vsp*vsp)), 0,localTD * friction_base);
	
	shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(currentSpeed, darctan2(-vsp,hsp));
	shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(currentSpeed, darctan2(-vsp,hsp));
	scAnimateInteraction();
}



scCheckEquipment()


//To equalize yModDraw
yModDraw += 0.2*localTD;
yModDraw = min(0, yModDraw);
/*
if(!moved && noone != instance_place(x, y, oWall)){
	x++;
	y++;
}

*/
//Iframe
iframes-= localTD;
if(iframes>=0) alpha = 0.5;
else alpha = 1;

scAnimateHP();

scUIShakeControl();

if(vampKills >= vampKillsMax){
	if(	shootable_map[? SHOOTABLE_MAP.HEALTH] < shootable_map[? SHOOTABLE_MAP.HEALTH_START]){
		shootable_map[? SHOOTABLE_MAP.HEALTH]++;
		vampKills = 0;
	}
	else{
		vampKills = vampKillsMax-1;	
	}
}


