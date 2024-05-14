/// @description  

animVar += 0.2;

draw_sprite_ext(spBullet,0,0,0,1000,1000,0,c_black,screenAlpha);

var guiMouseX = device_mouse_x_to_gui(0);
var guiMouseY = device_mouse_y_to_gui(0)

if(global.inventoryOpen){
	screenAlpha = lerp(screenAlpha,0.8,0.05);
	spdY = lerp(spdY, (packTargetY-packY)*0.05, 0.2);
	packY += spdY;
	draw_sprite_ext(spUIInventoryPack,0,0,packY,4,4,0,c_white,1);
	
}
else{
	screenAlpha = lerp(screenAlpha,0,0.05);
	
	packY = lerp(packY, display_get_gui_height()*1.5, 0.1);
	draw_sprite_ext(spUIInventoryPack,0,0,packY,4,4,0,c_white,1);
}

draw_sprite_ext(spUIInventoryGrid, 0, 0,packY,4,4,0,c_white,1);

var gridStartX = 40*4;
var gridStartY = packY+(51*4)
var gridPaddingX = 39*4;
var gridPaddingY = 39*4;

for (var i = 0; i < array_length(invArray); i++) {
    if(invArray[i].inventoryX >= 0 && invArray[i].inventoryY >= 0){
		draw_sprite_ext(invArray[i].inventorySprite,0,gridStartX+(gridPaddingX*invArray[i].inventoryX) + (sprite_get_width(invArray[i].inventorySprite)*0.5*4), gridStartY+(gridPaddingY*invArray[i].inventoryY) + (sprite_get_height(invArray[i].inventorySprite)*0.5*4), 4, 4, invArray[i].invDir * 90, c_white, 1);	
		
		if(invArray[i].stackAmount > 1) draw_text_transformed(gridStartX+(gridPaddingX*invArray[i].inventoryX) + (sprite_get_width(invArray[i].inventorySprite)*0.5*4), gridStartY+(gridPaddingY*invArray[i].inventoryY) + (sprite_get_height(invArray[i].inventorySprite)*0.5*4), invArray[i].stackAmount, 4, 4, 0);
	}
}

//Mouse
if(global.inventoryOpen){
	var cellOnTopX = -1;
	var cellOnTopY = -1;
	var cellGridX = -1;
	var cellGridY = -1;
	for (var yy = 0; yy < ds_grid_height(inventoryGrid); yy++) {
	    for (var xx = 0; xx < ds_grid_width(inventoryGrid); xx++) {
		    var cellX = gridStartX+(xx*gridPaddingX);
			var cellY = gridStartY+(yy*gridPaddingY);
			var cellBBoxRight = cellX + gridPaddingX;
			var cellBBoxBottom = cellY + gridPaddingY;
			var hoveringCell = guiMouseX >= cellX && guiMouseX < cellBBoxRight && guiMouseY >= cellY && guiMouseY < cellBBoxBottom;
			
			if(hoveringCell){
				cellOnTopX = cellX;
				cellOnTopY = cellY;
				cellGridX = xx;
				cellGridY = yy;
			}
			 
			draw_sprite_ext(spUIInventoryCell, 0, cellX, cellY, 4, 4, 0, c_white, tempGrid[# xx, yy] || inventoryGrid[# xx, yy] != -1 ? 1 : 0);
		}
	}
	
	ds_grid_clear(tempGrid, -1);
	ds_grid_copy(tempGrid, inventoryGrid);
	
	if(instance_exists(holding)){
		//Attempting to place
		if(cellOnTopX >= 0 && cellOnTopY >= 0){
			draw_sprite_ext(holding.inventorySprite, 0, cellOnTopX + sprite_get_width(holding.inventorySprite)*0.5*4, cellOnTopY + sprite_get_height(holding.inventorySprite)*0.5*4, 4, 4, holding.invDir*90, c_black, 1);
			
			ds_grid_set_grid_region(tempGrid,holding.gridSpace,0,0,ds_grid_width(holding.gridSpace), ds_grid_height(holding.gridSpace),cellGridX, cellGridY);
		}
		//Holding
		
		if(cursorSprite == spUICursorPoint || (cursorSprite == spUICursorRotate && animVar > sprite_get_number(spUICursorRotate)-1)){
			cursorSprite = spUICursorGrab;	
		}
		
		draw_sprite_ext(holding.inventorySprite, 0, guiMouseX - sprite_get_width(holding.inventorySprite)*0, guiMouseY - sprite_get_height(holding.inventorySprite)*0, 4, 4, holding.invDir*90, c_white, 1);
		draw_sprite(cursorSprite,animVar, guiMouseX, guiMouseY);
		
		if((cellOnTopX != -1 && cellOnTopY != -1) && mouse_check_button_pressed(mb_left)){
			if(scInventoryAttemptToPlace(holding, cellGridX, cellGridY)){
				//ds_grid_set_grid_region(inventoryGrid,holding.gridSpace,0,0,ds_grid_width(holding.gridSpace), ds_grid_height(holding.gridSpace),cellGridX, cellGridY);
				if scInventoryPlaceAt(holding, cellGridX, cellGridY) holding = noone;
				
			}
			
		}
		else if((cellOnTopX == -1 || cellOnTopY == -1) && mouse_check_button_pressed(mb_left)){
			scInventoryPlaceInWorld(holding);
			holding = noone;
		}
		
		if(mouse_check_button_pressed(mb_right)){
			animVar = 0;
			cursorSprite = spUICursorRotate;
			holding.invDir --;
			var newGrid = ds_grid_create(ds_grid_width(holding.gridSpace), ds_grid_height(holding.gridSpace));
			ds_grid_copy(newGrid, holding.gridSpace);
			for (var yy = 0; yy < ds_grid_width(newGrid); yy++) {
			    for (var xx = 0; xx < ds_grid_height(newGrid); xx++) {
				    newGrid[# ds_grid_width(newGrid)-1-yy, xx] = holding.gridSpace[# xx, yy];
				}
			}
			ds_grid_copy(holding.gridSpace, newGrid);
			ds_grid_destroy(newGrid);
			//show_debug_message("Rotate Missing");
		}
	}
	else{
		cursorSprite = spUICursorPoint;
		draw_sprite(cursorSprite,animVar, guiMouseX, guiMouseY);
		
		if(mouse_check_button_pressed(mb_left)){
			if(cellGridX >= 0 && cellGridY >= 0 && inventoryGrid[# cellGridX, cellGridY] != -1){
				holding = inventoryGrid[# cellGridX, cellGridY];
				for (var i = 0; i < array_length(invArray); i++) {
				    if(invArray[i] == holding){
						array_delete(invArray, i, 1);
						break;
					}
				}
				
				for (var yy = 0; yy < ds_grid_height(inventoryGrid); yy++) {
				    for (var xx = 0; xx < ds_grid_width(inventoryGrid); xx++) {
					    if(inventoryGrid[# xx, yy] == holding.id) inventoryGrid[# xx, yy] = -1;
					}
				}
				scInventoryPlaceInWorld(holding);
				
			}
		}
	}
	
}