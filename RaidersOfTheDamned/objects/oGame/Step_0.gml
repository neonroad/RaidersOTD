/// @description  
function reloadWalls(){
	mp_grid_destroy(mapGrid);
	mapGrid = mp_grid_create(864,768,50,50,32,32);
	mp_grid_add_instances(mapGrid,oWall,false);
	
	var tempGrid = ds_grid_create(50,50);
	mp_grid_to_ds_grid(mapGrid,tempGrid);
	
	for (var i = 0; i < instance_number(oDoor); i++) {
	    var wall = instance_find(oDoor, i);
		if(wall.open) mp_grid_clear_cell(mapGrid,1+((wall.x - 896) div 32),1+((wall.y- 800) div 32));
	}	

	
	mp_grid_destroy(mapGridBreakable);
	mapGridBreakable = mp_grid_create(864,768,50,50,32,32);
	mp_grid_add_instances(mapGridBreakable,oWall,false);

	for (var i = 0; i < instance_number(oBreakableWall); i++) {
	    var wall = instance_find(oBreakableWall, i);
		mp_grid_clear_cell(mapGridBreakable,1+((wall.x - 896) div 32),1+((wall.y- 800) div 32));
	}	
	if(ds_exists(minimapGrid, ds_type_grid))
		ds_grid_destroy(minimapGrid);
	
	minimapGrid = ds_grid_create(50,50)
	mp_grid_to_ds_grid(mapGrid, minimapGrid);
	ds_grid_destroy(tempGrid);
}


if(!instance_exists(oPlayer)){
	player = instance_create_layer(200, 200, "Mobs", oPlayer);
	evacTimer = 60*60*5;
	upgradeObj = instance_create_depth(x,y,depth,oUpgradeManager);
	upgradeObj.player = player;
}


if(scRoomChanged()){
	//show_debug_message("Reloading");
	instance_create_depth(x,y,600,oDecalSurf);
	instance_create_depth(x,y,700,oDecalSurfW);
	
	reloadWalls();
	
	//viewCamera = view_camera[0];
	//camera_set_view_pos(viewCamera, floor(player.x),floor(player.y));
	
	//camera_set_view_size(viewCamera, cameraSize, cameraSize);
	//camera_set_view_target(viewCamera, player);	
	//camera_set_view_speed(viewCamera, 100, 100);
	//camera_set_view_pos(viewCamera, player.x, player.y);	
	//camera_set_view_border(viewCamera, camera_get_view_width(viewCamera)*.5,camera_get_view_height(viewCamera)*.5);
	
	minimapGrid = ds_grid_create(50,50)
	mp_grid_to_ds_grid(mapGrid, minimapGrid);
	
	//visit room first time
	if is_undefined(ds_map_find_value(roomTemp, room)){
		ds_map_add(roomTemp, room, irandom(30));
		//if(irandom(10) == 1){
			
		//	var interact = instance_create_layer(x,y,"Items",oInteractive,{interactType: INTERACTABLES.SHOVELMOUND, randomLocation: true});
		//}
	}
	
	if(gameStart && introSpawn){
		
		with(player){
			var randSpawn = instance_number(oSpawnLoc);
			randSpawn = instance_find(oSpawnLoc,irandom_range(0, randSpawn-1));
			x = randSpawn.x;
			y = randSpawn.y;	
		}
		introSpawn = false;
	}
	
	
}

if(room != rmTutorial && room != rmIntro && player != noone && instance_exists(player)){
	spawnTimer-= global.TD;
	if(spawnTimer <= 0){
		spawnTimer = max(1,spawnTimerMax-irandom(roomTemp[? room]));
		roomTemp[? room] = min(100, roomTemp[?room]+1);
		repeat max(1,ceil(roomTemp%25)){
			//var zomb = instance_create_layer(x, y, "Mobs", oMobProphet /*choose(oMobProphet, oMobZombie,oMobWormDog)*/);	
			var specialChance = roomTemp[? room] > irandom(120);
			var zomb = noone;
			//if(specialChance){
			//	//zomb = instance_create_layer(x, y, "Mobs", choose(oMobGrunt, oMobIllusionist, oMobWarriorBug, oMobProphet,oMobZombie,oMobZombie,oMobZombie,oMobWormDog,oMobWormDog));	
			//	roomTemp[? room] *= 1.05;
			//}
			//else
				
			zomb = instance_create_layer(x, y, "Mobs", choose(oMobRockHead,oMobZombie)/*choose(/*oMobImp,oMobProphet,oMobZombie,oMobZombie,oMobZombie,oMobWormDog,oMobWormDog)*/);	
			
			
			zomb.ai_start_cooldown = 60;
			zomb.invisible = makeInvisMonsters;
			var xsign = choose(-1,1,0);
			var ysign = choose(-1,1,0);
		
			if(xsign == 0){
				zomb.x = irandom_range(camera_get_view_x(viewCamera), camera_get_view_width(viewCamera));	
				ysign = choose(-1,1);
			}
		
			if(ysign == 0){
				zomb.y = irandom_range(camera_get_view_y(viewCamera), camera_get_view_height(viewCamera));	
				xsign = choose(-1,1);
			}
		
			if(xsign == 1){
				zomb.x = irandom_range(64,128)+camera_get_view_x(viewCamera)+camera_get_view_width(viewCamera);	
			}
			else zomb.x = camera_get_view_x(viewCamera)-irandom_range(64,128);
		
			if(ysign == 1){
				zomb.y = irandom_range(64,128)+camera_get_view_y(viewCamera)+camera_get_view_height(viewCamera);	
			}
			else zomb.y = camera_get_view_y(viewCamera)-irandom_range(64,128);
			
			with(zomb){
				var interiorFound = instance_place(x,y,oInteriorArea);
				if(interiorFound != noone){
					var doorFound = interiorFound.entrances[0];
					x = interiorFound.entrances[0].x+16;
					y = interiorFound.entrances[0].y+16;
					//Move instance "out" of room
				}
			}
		}
		
		
	}
}

if(gameStart){
	//evacTimer-= global.TD;
	//if(evacTimer < 0){
	//	evacRoom = irandom(array_length(roomArray)-1);	
	//	instance_create_layer(x, y, "Instances", oEvac);
	//}
	
	combatTimer = max(0, combatTimer-1);
	
	
	
	
	//if(player.weaponEquipped == ITEMS.WEAPON_SNIPER){
	//	cameraSize = lerp(cameraSize,300,0.05*global.TD);	
	//}
	//else cameraSize = lerp(cameraSize, 240, 0.05*global.TD);
	//camera_set_view_size(viewCamera, cameraSize, cameraSize);
	//camera_set_view_border(viewCamera, camera_get_view_width(viewCamera)*.5,camera_get_view_height(viewCamera)*.5);
	
}

if(player.cameraControl){
	xTo = player.x+player.shootable_map[? SHOOTABLE_MAP.HSP];
	yTo = player.y+player.shootable_map[? SHOOTABLE_MAP.VSP];

	xIs += (xTo - xIs)/25;//player.shootable_map[? SHOOTABLE_MAP.HSP] //(xTo - xIs)/25;
	yIs += (yTo - yIs)/25;
}
else{
	xTo = player.cameraPivotX;
	yTo = player.cameraPivotY;	

	xIs += (xTo - xIs)/25;//player.shootable_map[? SHOOTABLE_MAP.HSP] //(xTo - xIs)/25;
	yIs += (yTo - yIs)/25;
}
//player.shootable_map[? SHOOTABLE_MAP.VSP]//(yTo - yIs)/25;

camera_set_view_pos(viewCamera, xIs - (cameraSize*0.5),yIs - (cameraSize*0.5));
//camera_set_view_pos(viewCamera, floor(xIs - (cameraSize*0.5)),floor(yIs - (cameraSize*0.5)));

scUIShakeControl();