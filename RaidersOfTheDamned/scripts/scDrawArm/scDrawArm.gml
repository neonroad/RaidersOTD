function scDrawArm(front){
	gunRecoilX = lerp(gunRecoilX, 0, 0.04);
	gunRecoilY = lerp(gunRecoilY, 0, 0.04);
	if(abs(gunRecoilX) < 0.01) gunRecoilX = 0;
	if(abs(gunRecoilY) < 0.01) gunRecoilY = 0;
	
	if(weaponEquipped == noone) exit;
	var armLength = 5;
	if(!meleewep){
		if(!front && bullets > 0 && angleAiming > 160 && angleAiming < 340 && current_state != PLAYER_STATE.WINNING && current_state != PLAYER_STATE.DEAD){
			scPlotLine(bbox_right,y-1,floor(gunRecoilX+x+ lengthdir_x(armLength,angleAiming)),floor(gunRecoilY+y+ lengthdir_y(armLength,angleAiming)),make_color_rgb(180,82,82),1);
			scPlotLine(bbox_left+1,y-1,floor(gunRecoilX+x+ lengthdir_x(armLength,angleAiming)),floor(gunRecoilY+y+ lengthdir_y(armLength,angleAiming)),make_color_rgb(180,82,82),1);
		
			draw_sprite_ext(weaponEquippedSprite, scAimGeneric(),gunRecoilX+x+ lengthdir_x(armLength,angleAiming),gunRecoilY+y+ lengthdir_y(armLength,angleAiming),1,1,0,c_white,1);
		}
	
		else if(front && bullets > 0 && current_state != PLAYER_STATE.WINNING && current_state != PLAYER_STATE.DEAD){
	
			draw_sprite_ext(weaponEquippedSprite, scAimGeneric(),gunRecoilX+x+ lengthdir_x(armLength,angleAiming),gunRecoilY+y+ lengthdir_y(armLength,angleAiming),1,1,0,c_white,1);
			scPlotLine(bbox_right,y-1,floor(gunRecoilX+x+ lengthdir_x(armLength,angleAiming)),floor(gunRecoilY+y+ lengthdir_y(armLength,angleAiming)),make_color_rgb(180,82,82),1);
			scPlotLine(bbox_left+1,y-1,floor(gunRecoilX+x+ lengthdir_x(armLength,angleAiming)),floor(gunRecoilY+y+ lengthdir_y(armLength,angleAiming)),make_color_rgb(180,82,82),1);
		
		}
	}
	else{
		armLength = 1;
		draw_sprite_ext(weaponEquippedSprite, scAimGeneric(,weaponFlip),x+ lengthdir_x(armLength,angleAiming),y+ lengthdir_y(armLength,angleAiming),1,1,0,c_white,1);
	}
}