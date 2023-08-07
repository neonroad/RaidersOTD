/// @description  
display_set_gui_size(surface_get_width(application_surface),surface_get_height(application_surface));


if(true || room == rmIntro) exit;

var xmaporigin = display_get_gui_width()*0.9;

var ymaporigin = display_get_gui_height()*0.1;



//draw_sprite_ext(spBullet, 0, display_get_gui_width()*0.5, display_get_gui_height()*0.5, 50, 50, 0, c_lime, 1);
var illusionOffset = 0;
if(player.minimapIllusion > 0){
	illusionOffset += irandom_range(-30,30);
}

var playerGridX = illusionOffset+(player.x - 864) div 32;
var playerGridY = illusionOffset+(player.y - 768) div 32;
var miniSize = 8;

for (var yy = -miniSize; yy <= miniSize; yy++) {
	for (var xx = -miniSize; xx <= miniSize; xx++) {
		var color_val = irandom_range(100,150);
		var color = c_grey;
		color = make_color_hsv(color_get_hue(color),color_get_saturation(color), color_val);
		draw_sprite_ext(spBullet, 0, uiXShake + xmaporigin+(xx*minimapScale), uiYShake + ymaporigin+(yy*minimapScale), minimapScale, minimapScale, 0, color, 1);
		
	}
}

for (var yy = -miniSize; yy <= miniSize; yy++) {
	for (var xx = -miniSize; xx <= miniSize; xx++) {
		
		
		
		
	    var color = c_white;
		if(playerGridY+yy < 0){ yy-=playerGridY+yy;}
		if(playerGridX+xx < 0){ xx-=playerGridX+xx;}
		if(playerGridY+yy > ds_grid_height(minimapGrid)-1){ break;}
		if(playerGridX+xx > ds_grid_width(minimapGrid)-1){ break;}
		switch (minimapGrid[# playerGridX+xx,playerGridY+yy]) {
		    case -1:
		        color = make_color_rgb(58,56,88);
		        break;
		    default:
		        color = make_color_rgb(138,176,96);
		        break;
		}
		
		var color_val = irandom_range(100,150);
		color = make_color_hsv(color_get_hue(color),color_get_saturation(color), color_val);
		draw_sprite_ext(spBullet, 0, uiXShake + xmaporigin+(xx*minimapScale), uiYShake + ymaporigin+(yy*minimapScale), minimapScale, minimapScale, 0, color, 1);

	}
}

draw_set_halign(fa_right);
draw_text_transformed(uiXShake + xmaporigin, 100+uiYShake + ymaporigin, score,5,5,0);
draw_set_halign(fa_left);


draw_sprite_ext(spBullet, 0, uiXShake + xmaporigin, uiYShake + ymaporigin, minimapScale, minimapScale, 0, c_lime, 1);

draw_sprite_ext(spUIMapOutline, 0, uiXShake + xmaporigin+((-miniSize-1)*minimapScale),uiYShake + ymaporigin+((-miniSize-1)*minimapScale), 2, 2, 0, c_white, 1); 
//draw_sprite_ext(spBullet, 0, xmaporigin+ (((player.x - 864) div 32)*minimapScale),ymaporigin+ (((player.y-768) div 32)*minimapScale), minimapScale, minimapScale, 0, c_lime, 1);
//draw_text_transformed(500,500,roomTemp[?room],4,4,0);

