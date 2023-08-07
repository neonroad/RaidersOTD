/// @description Insert description here
// You can write your code in this editor
if(!instance_exists(oPlayer)) exit;

player = oPlayer;

x = player.x;
y = player.y;



dialog_cooldown-= global.TD;

if(dialog_cooldown <= 0){
	
	if(array_length(textQueue)<2){
		if(player.current_state == PLAYER_STATE.SLEEP){
			array_push(textQueue, "[E]: Wake Up");
		}
	
		else if(instance_exists(player.icursor) && instance_exists(player.icursor.target)){
			if(player.icursor.target.object_index == oItemWorld)
				array_push(textQueue, "[E]: Pick Up " + player.icursor.target.itemName);
			if(player.icursor.target.object_index == oDoorSliding)
				array_push(textQueue, "[E]: Open/Close Door");
			if(player.icursor.target.object_index == oInteractive)
				array_push(textQueue, "[E]: Interact");
		}
		
		else if(player.current_state == PLAYER_STATE.PLAYING){
			array_push(textQueue, "[WASD]: Move");
		}
	}
	
	if(array_length(textQueue)>0){
		textLoad = textQueue[0];
		array_delete(textQueue,0,1);
		dialog_cooldown = 120;
		textChar = 0;
	}
	else{
		textLoad = noone;	
		//textDisplay = "";
	}
	
}

if(textLoad != noone && textChar < string_length(textLoad)){
	if(textDisplay == textLoad){
		textChar = string_length(textLoad);	
		dialog_cooldown = 0;
	}
	
	timeBtwnChars -= global.TD;
	
	if(dialog_cooldown > 0) dialog_cooldown+=global.TD;
	
	if(timeBtwnChars <= 0){
		timeBtwnChars = timeBtwnCharsMax;
		textDisplay = "";
		textChar++;
		for (var i = 1; i <= textChar; i++) {
			textDisplay = string_concat(textDisplay, string_char_at(textLoad,i));
		}
	}
}