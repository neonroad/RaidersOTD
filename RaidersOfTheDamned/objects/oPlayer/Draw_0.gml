/// @description Insert description here
// You can write your code in this editor

//draw_sprite(spr_Aura_Point_LightPP, 0, x, y);

if(current_state == PLAYER_STATE.PLAYING)
	scDrawArm(true);

if(current_state == PLAYER_STATE.LAUNCHED){
	draw_sprite(spShadow, 0, x, y);	
}


draw_sprite_ext(currentSprite, floor(animVar), x + xModDraw, y + yModDraw, scale, scale, 0, c_color, alpha);

if(current_state == PLAYER_STATE.PLAYING)
	scDrawArm(false);

//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false);
//draw_text(x,bbox_bottom, move_hsp);
//draw_text(x,bbox_bottom+10, shootable_map[? SHOOTABLE_MAP.HSP]);
//if(instance_exists(oMobIllusionist))
//draw_arrow(x,y,oMobIllusionist.x,oMobIllusionist.y,5);
//draw_text(x,y+20,critChance);
//draw_sprite(spStreetLight,0,oGame.x,oGame.y);
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false);