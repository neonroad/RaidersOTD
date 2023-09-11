/// @description    

if(!shootable_map[? SHOOTABLE_MAP.DEAD]){
	shader_set(shFlashAlpha);
	draw_sprite_ext(currentSprite, floor(animVar), x+(2*cos(timerShadow*0.15)), y+(2*sin(timerShadow*0.15)), !asym ? -facing*scale*1 : 1, scale*1, drawAngle, currently_attacking ? c_yellow : c_black, alpha*0.8);
	draw_sprite_ext(currentSprite, floor(animVar), x+(2*sin(timerShadow*0.15)), y+(2*cos(timerShadow*0.15)), !asym ? -facing*scale*1 : 1, scale*1, drawAngle, currently_attacking ? c_yellow : c_black, alpha*0.8);
	shader_reset();
}
draw_sprite_ext(currentSprite, floor(animVar), x, y, !asym ? -facing*scale : 1, scale, drawAngle, c_color, alpha);

