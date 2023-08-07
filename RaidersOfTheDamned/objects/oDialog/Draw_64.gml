/// @description Insert description here
// You can write your code in this editor

if(textDisplay != ""){
	var color = make_color_rgb(180,82,82);
	//draw_rectangle_color(0,0,string_width(textDisplay),string_height(textDisplay)*(max(1,string_width(textDisplay) div 200)),c_black,c_black,c_black,c_black,false);
	draw_text_ext_transformed_color(0,0,textDisplay,20,surface_get_width(application_surface),1,1,0,color,color,color,color,1);
	//draw_text(0,display_get_gui_width()*0.9,string_width(textDisplay));
}