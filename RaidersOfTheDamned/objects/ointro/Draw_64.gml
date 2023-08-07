/// @description 
splashAlpha = lerp(splashAlpha, 1, 0.01);
draw_sprite_ext(spNeonSplash, 0, splashX, splashY, 20, 20, 0, c_white, splashAlpha);

if(splashAlpha > 0.95){
	splashTimer++;	
}

if(splashTimer > 60){
	splashY = lerp(splashY, -500, 0.01);
}

if(splashY < 0){
	logoY = lerp(logoY, display_get_gui_height()*0.5, 0.01);
	draw_sprite_ext(spLogo, 0, logoX, logoY, 20, 20, 0, c_white, logoAlpha);

}

if(logoY < display_get_gui_height()*0.6){
	logoTimer++;	
}

if(logoTimer > 120){
	if(room == rmIntro){ 
		room_goto(rmA1);
		//room_goto(choose(rmA1,rmA2,rmA3,rmB1,rmB3,rmC1,rmC2,rmC3)); 
		//audio_sound_gain(oSoundSystem.current_song, 0, 3000);	
		oGame.gameStart = true;
		oGame.introSpawn = true;
		oGame.spawnTimer = 60*5;
	}
	logoAlpha = lerp(logoAlpha, 0, 0.01);
	logoY = lerp(logoY, -500, 0.001);
}