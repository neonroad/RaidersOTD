function scLevelTitleFade(){
	var levelText = "The Outlands";
	switch (room) {
	    case rmTutorial:
	        levelText = "The Training Grounds";
	        break;
		case rmB2:
	        levelText = "Epicenter";
	        break;
		
	    default:
	        levelText = "The Outlands";
	        break;
	}
	
	textFade -=0.02*localTD;
	if(textFade > 0){
		draw_text_transformed_color(display_get_gui_width()*0.2, display_get_gui_height()*0.85, levelText, 5,5,0,c_white,c_white,c_white,c_white, textFade);
	}
}