/// @description Insert description here
// You can write your code in this editor

if !surface_exists(surf)
{
    surf = surface_create(room_width, room_height);
    //surf = surface_create(1,1);
	
	surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
	//draw_surface(surf,0,0);
	//draw_rectangle_color(0,0,1000,1000,c_lime,c_lime,c_lime,c_lime,false);
    surface_reset_target();
	
}
var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);



surface_set_target(surf);
draw_clear_alpha(c_black, 0);
part_system_drawit(global.particleSystem);
surface_reset_target();
draw_surface(surf, 0, 0);