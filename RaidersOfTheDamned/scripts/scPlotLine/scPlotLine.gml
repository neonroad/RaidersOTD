// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scPlotLine(x0,y0,x1,y1, col=c_white,scale=1,col2=col){
	//x0 = (x0 div scale)*scale;
	x1 = ((x1 div scale)*scale)+(x0%floor(x0));
	//y0 = (y0 div scale)*scale;
	y1 = ((y1 div scale)*scale)+(y0%floor(y0));
	var dx = abs(x1-x0);
	var sx = -scale;
	if(x0 < x1) sx = scale;	
	var dy = -abs(y1-y0)
	var sy = -scale;
	if(y0 < y1) sy = scale;
	var error = dx+dy;
	var e2 = 0;
	var lerpColAmt = min(1,scale/max(1,(sqrt(sqr(x1-x0)+sqr(y1-y0)))));
	
	var lerpCol = col;
	
	while true{
		var lerpCol = make_color_rgb(
		lerp(color_get_red(lerpCol), color_get_red(col2), lerpColAmt),
		lerp(color_get_green(lerpCol), color_get_green(col2), lerpColAmt),
		lerp(color_get_blue(lerpCol), color_get_blue(col2), lerpColAmt)
		)
		if(scale>1)draw_rectangle_color(x0,y0,x0+scale*1,y0+scale*1, lerpCol, lerpCol, lerpCol, lerpCol, false);
		else draw_rectangle_color(x0,y0,x0,y0, lerpCol, lerpCol, lerpCol, lerpCol, false);
		if(x0 == x1 && y0 == y1) break;	
		e2 = 2*error;
		if(e2 >= dy){
			if((x0 div scale)*scale == (x1 div scale)*scale) break;
			error += dy;
			x0 += sx;
		}
		if(e2 <= dx){
			if((y0 div scale)*scale == (y1 div scale)*scale) break;
			error += dx;
			y0 += sy;
		}
	}
}