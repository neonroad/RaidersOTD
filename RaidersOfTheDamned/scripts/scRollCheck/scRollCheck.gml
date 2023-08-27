// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scRollCheck(){
	if(current_state == PLAYER_STATE.PLAYING && (mouse_check_button_pressed(mb_right) || rollBuffer > 0)){
		scOnRoll();
		rollBuffer = 0;
		current_state = scStateManager(PLAYER_STATE.ROLLING);
		image_speed = 0.3;
		animVar = 0;
		
		audio_play_sound(snWeaponSwitch,1,false,,,rollEnhanced ? 1.2 : 0.5);
		var rollAngle = point_direction(x,y,mouse_x,mouse_y);
		var angle = scAimGeneric(rollAngle);
		shootable_map[? SHOOTABLE_MAP.HSP] = lengthdir_x(rollEnhanced ? walk_speed * 4 : walk_speed*2,rollAngle);
		shootable_map[? SHOOTABLE_MAP.VSP] = lengthdir_y(rollEnhanced ? walk_speed * 4 : walk_speed*2,rollAngle);
		switch (angle) {
		    case 0:
		        currentSprite = spPlayerRollE;
		        break;
		    case 1:
		        currentSprite = spPlayerRollNE;
		        break;		
		    case 2:
		        currentSprite = spPlayerRollN;
		        break;		
		    case 3:
		        currentSprite = spPlayerRollNW;
		        break;
		    case 4:
		        currentSprite = spPlayerRollW;
		        break;
		    case 5:
		        currentSprite = spPlayerRollSW;
		        break;
		    case 6:
		        currentSprite = spPlayerRollS;
		        break;
		    case 7:
		        currentSprite = spPlayerRollSE;
		        break;
		}
	}
	if(current_state == PLAYER_STATE.ROLLING){
		if(iframes <= 0) iframes = 1;
		if(floor(animVar) >= 3 && floor(animVar) <= 4){
			//part_emitter_region(global.particleSystem, global.emitter, bbox_left,bbox_right,y-5,y, ps_shape_ellipse, ps_distr_gaussian);
			//part_emitter_burst(global.particleSystem, global.emitter, oParticleSystem.particle_roll, 1);
			part_particles_create(global.particleSystem, x,y, oParticleSystem.particle_roll, 1);
		}
		if(animVar > sprite_get_number(currentSprite)-1){
			current_state = PLAYER_STATE.PLAYING;	
		}
		if(mouse_check_button_pressed(mb_right)){
			rollBuffer = 10;	
		}
		rollBuffer--;
	}
}