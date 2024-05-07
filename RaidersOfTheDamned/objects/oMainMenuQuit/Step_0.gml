/// @description Insert description here
// You can write your code in this editor


if(mouse_x > x-15 && mouse_x < x+string_width("PLAY")*2.5 && mouse_y > y-15 && mouse_y < y+string_height("PLAY")*2.5){

	part_emitter_stream(_ps, _pemit1, _ptype1, 50);
	if(mouse_check_button_pressed(mb_left)){
		game_end();
	}
}	
else if(part_system_exists(_ps)){
		part_emitter_stream(_ps, _pemit1, _ptype1, 0);
}







