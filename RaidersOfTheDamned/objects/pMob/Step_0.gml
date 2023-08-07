/// @description  

event_inherited();

timerShadow+= localTD;

if( !checkDead && shootable_map[?SHOOTABLE_MAP.DEAD]){
	checkDead = true;
	event_user(0);
	if(sqrt(sqr(shootable_map[? SHOOTABLE_MAP.HSP])+sqr(shootable_map[? SHOOTABLE_MAP.VSP])) > 1){
		surface_set_target(oDecalSurf.surf);
		draw_sprite_ext(spBloodSlideDirectional,irandom(sprite_get_number(spBloodSlideDirectional)),x,y,max(0.5*sqrt(sqr(shootable_map[? SHOOTABLE_MAP.HSP])+sqr(shootable_map[? SHOOTABLE_MAP.VSP])),1),1,darctan2(-shootable_map[?SHOOTABLE_MAP.VSP],shootable_map[?SHOOTABLE_MAP.HSP]),bloodColor,1);
		surface_reset_target();
		oDecalSurf.drawnTo = true;
	}
}

if(bleedEnabled){
	bleedTimeCurrent+= localTD;
	
	if(bleedTimeFuture%bleedTimeTick == 0 && bleedTimeCurrent >= bleedTimeFuture){ //REPLACE WITH BUFF
		bleedTimeFuture +=  bleedTimeTick;//localTD + (floor(localTD) == localTD  ? bleedTimeCurrent: ceil(bleedTimeCurrent));
		scDamage(id,bleedApplier,bleedDamage,DAMAGE_TYPE.BLEED);
		
	}
	if(bleedTimeCurrent >= bleedTimeMax){
		bleedTimeCurrent = 0;
		bleedEnabled = false;
	}
	
}