/// @description  


if(destroyed){
	draw_sprite(spObstacleBarrel,1,x,y+20);

	draw_sprite(spObstacleBarrel,2,x-10,y+10);


	draw_sprite(spObstacleBarrel,3,x+10,y+10);


	draw_sprite(spObstacleBarrel,1,x,y);
	
	//Trigger once
	if(!open){
		open = true;
		with(oGame) reloadWalls();
	}
}

else{
	draw_sprite(spObstacleBarrel,0,x,y+20);

	draw_sprite(spObstacleBarrel,0,x-10,y+10);


	draw_sprite(spObstacleBarrel,0,x+10,y+10);


	draw_sprite(spObstacleBarrel,0,x,y);	
}

//draw_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom, false);