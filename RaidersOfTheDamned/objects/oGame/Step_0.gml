/// @description  
function reloadWalls(){
	mp_grid_destroy(mapGrid);
	mapGrid = mp_grid_create(864,768,50,50,32,32);
	mp_grid_add_instances(mapGrid,oWall,false);
	
	var tempGrid = ds_grid_create(50,50);
	mp_grid_to_ds_grid(mapGrid,tempGrid);
	
	for (var i = 0; i < instance_number(oDoor); i++) {
	    var wall = instance_find(oDoor, i);
		if(wall.open || (variable_instance_exists(wall, "destroyed") && wall.destroyed)) mp_grid_clear_cell(mapGrid,1+((wall.x - 896) div 32),1+((wall.y- 800) div 32));
	}	
	

	
	mp_grid_destroy(mapGridBreakable);
	mapGridBreakable = mp_grid_create(864,768,50,50,32,32);
	mp_grid_add_instances(mapGridBreakable,oWall,false);

	for (var i = 0; i < instance_number(oDoor); i++) {
	    var wall = instance_find(oDoor, i);
		if(wall.object_index == oObstacleCrystal || wall.open || (variable_instance_exists(wall, "destroyed") && wall.destroyed)) 
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
		
		
	}
}

if(gameStart){

	
	combatTimer = max(0, combatTimer-1);

}

if(player.cameraControl){
	xTo = player.x+player.shootable_map[? SHOOTABLE_MAP.HSP]*1;
	yTo = player.y+player.shootable_map[? SHOOTABLE_MAP.VSP]*1;

	xIs += (xTo - xIs)/10;//player.shootable_map[? SHOOTABLE_MAP.HSP] //(xTo - xIs)/25;
	yIs += (yTo - yIs)/10;
}
else{
	xTo = player.cameraPivotX;
	yTo = player.cameraPivotY;	

	xIs += (xTo - xIs)/5;//player.shootable_map[? SHOOTABLE_MAP.HSP] //(xTo - xIs)/25;
	yIs += (yTo - yIs)/5;
}
//player.shootable_map[? SHOOTABLE_MAP.VSP]//(yTo - yIs)/25;

camera_set_view_pos(viewCamera, xIs-(camera_get_view_width(view_camera[0])*0.5),yIs-(camera_get_view_height(view_camera[0])*0.5));
//camera_set_view_pos(viewCamera, floor(xIs - (cameraSize*0.5)),floor(yIs - (cameraSize*0.5)));

scUIShakeControl();


instance_activate_object(oDecorParent);
collision_rectangle_list(oPlayer.x-cameraSize*2,oPlayer.y-cameraSize*2,oPlayer.x+cameraSize*2,oPlayer.y+cameraSize*2,oDecorParent,false,false,decorationList,false);

for (var i = 0; i < instance_number(oDecorParent); i++) {
    instance_deactivate_object(instance_find(oDecorParent,i));
}

for (var i = 0; i < ds_list_size(decorationList); i++) {
    instance_activate_object(decorationList[|i]);
}
ds_list_clear(decorationList);


