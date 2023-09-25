function scStateManager(stateRequested, entity=id){
	
	
	if(entity.shootable_map[?PLAYER_STATE.DEAD]) return PLAYER_STATE.DEAD;
	
	if(stateRequested == PLAYER_STATE.SLEEP) return PLAYER_STATE.SLEEP;
	if(stateRequested == PLAYER_STATE.SLEEPWAKEUP) return PLAYER_STATE.SLEEPWAKEUP;
	
	if(stateRequested == PLAYER_STATE.INVENTORYACCESS) return PLAYER_STATE.INVENTORYACCESS;
	
	
	if((stateRequested == PLAYER_STATE.LAUNCHED || 
		stateRequested == PLAYER_STATE.GRABBED)
		&& iframes <= 0){
		
		return stateRequested;
	}
	
	if(stateRequested == PLAYER_STATE.RECOIL && entity.current_state == PLAYER_STATE.PLAYING) return PLAYER_STATE.RECOIL;
	
	if(stateRequested == PLAYER_STATE.TRANSITIONING) return PLAYER_STATE.TRANSITIONING;
	
	if(stateRequested == PLAYER_STATE.ROLLING && entity.current_state == PLAYER_STATE.PLAYING) return PLAYER_STATE.ROLLING;
	
	if(stateRequested == PLAYER_STATE.PLAYING && 
	(entity.current_state != PLAYER_STATE.INVENTORYACCESS
	&& entity.current_state != PLAYER_STATE.TRANSITIONING 
	&& entity.current_state != PLAYER_STATE.GRABBED
	&& entity.current_state != PLAYER_STATE.ROLLING
	&& (entity.current_state != PLAYER_STATE.HURT || entity.current_state == PLAYER_STATE.ENDSTUN) 
	&& entity.current_state != PLAYER_STATE.LAUNCHED
	&& entity.current_state != PLAYER_STATE.SLEEP
	&& entity.current_state != PLAYER_STATE.SLEEPWAKEUP)
	&& (entity.current_state != PLAYER_STATE.RECOIL || entity.recoilTime < 0)){
		return PLAYER_STATE.PLAYING;
	}
	
	if(stateRequested == PLAYER_STATE.ENDSTUN){
		return PLAYER_STATE.ENDSTUN;	
	}
	
	if(stateRequested == PLAYER_STATE.HURT && entity.current_state == PLAYER_STATE.PLAYING){
		return PLAYER_STATE.HURT;	
	}
	
	return entity.current_state;
}