/// @description  


if(destroyed){
	draw_sprite(spObstacleBarrel,1,x,bbox_top);

	draw_sprite(spObstacleBarrel,2,x-10,y);


	draw_sprite(spObstacleBarrel,3,x+10,y);


	draw_sprite(spObstacleBarrel,1,x,bbox_bottom);
	
	//Trigger once
	if(!open){
		open = true;
		with(oGame) reloadWalls();
	}
}

else{
	draw_sprite(spObstacleCrystal,0,x,y);
}

part_timer-=global.TD;
if(part_timer <= 0){
	part_particles_create(global.particleSystem, irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), oParticleSystem.particle_crystal, 1);
	part_timer += irandom_range(10,20);
}