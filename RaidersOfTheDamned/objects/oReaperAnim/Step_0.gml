/// @description  

timer+= 0.5*global.TD;

if(instance_exists(follow)){
	x = lerp(x,follow.x,0.01*global.TD);
	y = lerp(y, follow.y, 0.01*global.TD);
}

y+= 0.4 * sin(5* timer);

if(image_speed = 0){
	image_alpha-=0.01*global.TD;	
	if(instance_exists(follow)) scDamage(follow, owner, 0, DAMAGE_TYPE.EXECUTE);
}
else
	image_speed = global.TD;
	
if(image_alpha <= 0){
		
	instance_destroy();
}




