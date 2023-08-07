/// @description 


if(roomChanged){
	alphaTransition = lerp(alphaTransition, 1, 0.1);
	draw_sprite_ext(spBullet,0,0,0,display_get_gui_width(),display_get_gui_height(), 0, c_black, alphaTransition);
}

if(alphaTransition > 0.99){
	room_goto(roomToGo);
	switch (orientation) {
		case 0:
		    var diff = oPlayer.x-RIGHT;
			oPlayer.x = LEFT+diff;
		    break;
		case 1: 
			var diff = UP-oPlayer.y;
			oPlayer.y = DOWN - diff;
			break;
		case 2:
		    var diff = oPlayer.x-LEFT;
			oPlayer.x = RIGHT+diff;
		    break;
		case 3:
			var diff = oPlayer.y - DOWN;
			oPlayer.y = UP+diff;
			break;
		default:
		    // code here
		    break;
	}	
	
}