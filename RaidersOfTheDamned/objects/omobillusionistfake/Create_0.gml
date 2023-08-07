/// @description  

eyes = noone;
owner = noone;
target = noone;
prevX = x;
prevY = y;
ignoreWalls = false;
image_index = irandom(5);
image_xscale *= choose(1,-1);
reposition = function(){
	do{
		if(choose(1,-1) == 1)
			x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + irandom_range(100, 300);
		else
			x = camera_get_view_x(view_camera[0]) - irandom_range(10, 30);
		}
	until(x > LEFT && x < RIGHT);
			
	do{
		if(choose(1,-1) == 1)
			y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + irandom_range(100, 300);
		else
			y = camera_get_view_y(view_camera[0]) - irandom_range(10, 30);
		}
	until( y > UP && y < DOWN);
}
reposition();
