/// @description Insert description here
// You can write your code in this editor

var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);

/*
if(!surface_exists(pixSurf)){
	pixSurf = surface_create(240,240);
	//draw_clear_alpha(c_white,1);
}
surface_set_target(pixSurf);
draw_clear_alpha(c_white,0);
draw_line_color(x-_vx,y-_vy,targetX-_vx,targetY-_vy,lineColor,lineColor);

surface_reset_target();

draw_surface(pixSurf,_vx,_vy);
*/

scPlotLine(floor(x),floor(y),floor(x1),floor(y1), lineColor,1);
//draw_line_color(x,y,targetX,targetY,lineColor,lineColor);
