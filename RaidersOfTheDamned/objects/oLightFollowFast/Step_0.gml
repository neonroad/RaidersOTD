/// @description  
if(instance_exists(owner)){
	x = owner.x;
	y = owner.y;
	
	if(owner.object_index == oPlayer){
		if(owner.flashlightObj == id) image_angle = owner.angleAiming;
		else{
			image_xscale += 0.00001;
			image_xscale = min(image_xscale, 3);
			image_yscale = image_xscale;
		}
	}
	
}
else{
	instance_destroy();	
}
