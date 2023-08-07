// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scCheckInventory(forceOpen=false){
	if((current_state == PLAYER_STATE.PLAYING || current_state == PLAYER_STATE.INVENTORYACCESS) && (forceOpen || keyboard_check_pressed(ord("Q"))) ){
		global.inventoryOpen = !global.inventoryOpen;
	
		if(global.inventoryOpen){
			image_speed = 0.2;
			current_state = scStateManager(PLAYER_STATE.INVENTORYACCESS);
			animVar = 0;
			currentSprite = spPlayerInventoryOpen;
			
			if(!forceOpen) invObj.holding = noone;
		}
		
		else{
			image_speed = 0.2;
			animVar = 0;
			currentSprite = spPlayerInventoryClose;
		}
	}
	
}