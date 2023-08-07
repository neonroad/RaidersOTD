/// @description  

player = other.id;
player.current_state = scStateManager(PLAYER_STATE.TRANSITIONING, player);
player.shootable_map[? SHOOTABLE_MAP.VSP] = 0;
player.shootable_map[? SHOOTABLE_MAP.HSP] = 0;
if(roomToGo != noone){
	//room_goto(roomToGo);	
	if(room == rmTutorial){
		scDropAll(player);
		intro = true;
		if(config == "noIntro"){
			roomToGo = rmDemo1;
			oGame.gameStart = true;
			oGame.introSpawn = true;
		}
		
		if(config == "Test"){
			roomToGo = rmTest;
			oGame.gameStart = true;
			oGame.introSpawn = true;
		}
	}
	roomChanged = true;
}
/*


