/// @description  

//if !oGame.play exit;

image_speed = global.TD;

if(point_distance(x,y,target.x,target.y) > 300){
	reposition();	
	if(instance_exists(eyes)) instance_destroy(eyes);
}

if(point_distance(x, y, target.x, target.y) < 30){
	var proj = instance_create_layer(x,y,"Instances", oIllusionistProjectile);
	proj.hsp = lengthdir_x(0.5, point_direction(x,y,target.x, target.y));
	proj.vsp = lengthdir_y(0.5, point_direction(x,y,target.x, target.y));
	proj.owner = owner;
	proj.target = target;
	instance_destroy();
	exit;
}

if(instance_place(x,y,oWall) == noone){
	prevX = x;
	prevY = y;
}
else if(!ignoreWalls){
	var attempts = 0;
	while(attempts < 100 && instance_place(x,y,oWall) != noone){
		x = lerp(x,prevX,0.1);
		y = lerp(y,prevY,0.1);
		attempts++;
		if(x == prevX && y == prevY){
			x++;
			y++;
			prevX = x;
			prevY = y;
		}
	}
}
