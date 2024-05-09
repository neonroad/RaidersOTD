/// @description  


if(destroyed){
	
	draw_sprite(spObstacleBarrel,1,x,y-10);
	draw_sprite(spObstacleBarrel,2,x-5,y-5);


	draw_sprite(spObstacleBarrel,3,x+5,y);


	
	
	draw_sprite(spObstacleBarrel,1,x,y+5);
	
	//Trigger once
	if(!open){
		open = true;
		with(oGame) reloadWalls();
	}
}

else{
	
	draw_sprite(spObstacleBarrel,0,x,y-10);
	draw_sprite(spObstacleBarrel,0,x-5,y-5);


	draw_sprite(spObstacleBarrel,0,x+5,y);


		
	
	draw_sprite(spObstacleBarrel,0,x,y+5);
}

//draw_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom, false);