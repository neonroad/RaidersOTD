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
	draw_sprite(spObstacleBarrel,0,x,bbox_top);

	draw_sprite(spObstacleBarrel,0,x-10,y);


	draw_sprite(spObstacleBarrel,0,x+10,y);


	draw_sprite(spObstacleBarrel,0,x,bbox_bottom);	
}

//draw_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom, false);