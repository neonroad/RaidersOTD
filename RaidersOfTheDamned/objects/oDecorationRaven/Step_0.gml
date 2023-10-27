/// @description Insert description here
// You can write your code in this editor


if(!flying && image_index >= image_number-1){
	image_index = 0;
	sprite_index = choose(spDecorRavenIdle, spDecorRavenIdlePeck, spDecorRavenIdleCaw, spDecorRavenIdleCaw2);
}


var checkObj = instance_nearest(x,y,pShootable);

if(!flying && point_distance(x,y,checkObj.x,checkObj.y) < 40){
	flying = true;
	sprite_index = spDecorRavenFlying;
	randdir = random_range(45,135);
}

if(flying){

	x += lengthdir_x(flySpeed, randdir);
	y += lengthdir_y(flySpeed, randdir);

	flySpeed += 0.02*global.TD;
}
if(flySpeed > 5) instance_destroy();