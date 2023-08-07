// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scParticleBurst(x0,y0,x1,y1, amt=5, speed_part=5, timer_part=10, color_part=c_white, changeValue=true, angle=0,spread=360, scale=1){
	
	//BROKEN UNTIL REFACTOR FOR FAST LIGHTS
	if(instance_number(oPartWorld) > 200) exit;
	repeat amt{
		var part = instance_create_layer(irandom_range(x0,x1),irandom_range(y0,y1),"Mobs",oPartWorld);
		
		var color_val = changeValue ? irandom_range(50,150) : color_get_value(color_part);
		part.image_blend = make_color_hsv(color_get_hue(color_part),color_get_saturation(color_part), color_val);
		
		part.image_xscale*=scale;
		part.image_yscale=part.image_xscale;
		part.dir = angle+irandom_range(-spread,spread);
		part.scaleMult=scale;
		
		
		part.hsp = lengthdir_x(irandom(speed_part),part.dir);
		part.vsp = lengthdir_y(irandom(speed_part),part.dir);

		part.timer = timer_part+irandom(timer_part);
	}
}

function scParticleBurstLight(x0,y0,x1,y1, amt=5, speed_part=5, timer_part=10, color_part=c_white, changeValue=true, angle=0,spread=360, scale=1){
	
	//BROKEN UNTIL REFACTOR FOR FAST LIGHTS
	if(instance_number(oPartWorldLight) > 100) exit;
	repeat amt{
		var part = instance_create_layer(irandom_range(x0,x1),irandom_range(y0,y1),"Mobs",oPartWorldLight);
		
		var color_val = changeValue ? irandom_range(50,150) : color_get_value(color_part);
		part.image_blend = make_color_hsv(color_get_hue(color_part),color_get_saturation(color_part), color_val);
		
		part.image_xscale*=scale;
		part.image_yscale=part.image_xscale;
		part.dir = angle+irandom_range(-spread,spread);
		part.scaleMult=scale;
		
		
		part.hsp = lengthdir_x(irandom(speed_part),part.dir);
		part.vsp = lengthdir_y(irandom(speed_part),part.dir);

		part.timer = timer_part+irandom(timer_part);
	}
}