/// @description  

player = other.id;
player.current_state = scStateManager(PLAYER_STATE.TRANSITIONING, player);
player.shootable_map[? SHOOTABLE_MAP.VSP] = 0;
player.shootable_map[? SHOOTABLE_MAP.HSP] = 0;
if(roomToGo != noone){
	//room_goto(roomToGo);	
	if(room == rmMainTest){
		scDropAll(player);
		intro = true;
		if(config == "noIntro"){
			roomToGo = rmA1;
			oGame.gameStart = true;
			oGame.introSpawn = true;
		}
	}
	roomChanged = true;
}
/*


