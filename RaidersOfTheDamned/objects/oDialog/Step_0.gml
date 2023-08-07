/// @description Insert description here
// You can write your code in this editor
if(!instance_exists(oPlayer)) exit;

player = oPlayer;

x = player.x;
y = player.y;



dialog_cooldown-= global.TD;

if(dialog_cooldown <= 0){
	
	
	if(player.current_state == PLAYER_STATE.SLEEP){
		array_push(textQueue, "Zzz...");
		currentTextStoryId="WAKINGUP";
		currentTextStorySeq=0;
		
	}
	
	if(currentTextStoryId == "WAKINGUP" && array_any(player.invObj.invArray, function(_element, _index){ return _element.itemID == ITEMS.WEAPON_PISTOL;})){
		currentTextStoryId = "FINDAMMO";
		currentTextStorySeq =0;
	}
	
	if(player.current_state == PLAYER_STATE.PLAYING){
		switch (currentTextStoryId) {
		    case "WAKINGUP":
						
				switch (currentTextStorySeq) {
				    case 0:
						array_push(textQueue, "How long was I out for..?");
						currentTextStoryId="WAKINGUP";
						break;
					case 1:
				        array_push(textQueue, "Did I miss it?!");
				        break;
					case 2:
				        array_push(textQueue, "Damn!");
				        break;
					case 3:
						array_push(textQueue, "No use crying over it. I need a weapon.");
						needWeaponEquipped = true;
						break;
				}	
				currentTextStorySeq++;
				
		        break;
				
			case "FINDAMMO":
						
				switch (currentTextStorySeq) {
				    case 0:
						array_push(textQueue, "This weapon is empty...");
						break;
					case 1:
				        array_push(textQueue, "I wonder if I can find any ammunition laying around.");
				        break;
				}	
				currentTextStorySeq++;
				
		        break;
		}
		
	}
	

	
	if(array_length(textQueue)>0){
		textLoad = textQueue[0];
		array_delete(textQueue,0,1);
		dialog_cooldown = dialog_cooldown_default;
		textChar = 0;
	}
	else{
		textLoad = noone;	
		//textDisplay = "";
	}
	
}

if(textLoad != noone && textChar < string_length(textLoad)){
	timeBtwnChars -= global.TD;
	
	if(dialog_cooldown > 0) dialog_cooldown+=global.TD;
	
	if(timeBtwnChars <= 0){
		timeBtwnChars = timeBtwnCharsMax;
		textDisplay = "";
		textChar++;
		audio_play_sound(snPlayerTalk1, 1, false, 0.1,,random_range(1,1.5));
		for (var i = 1; i <= textChar; i++) {
			textDisplay = string_concat(textDisplay, string_char_at(textLoad,i));
		}
	}
}