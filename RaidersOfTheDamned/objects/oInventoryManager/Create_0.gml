/// @description  
screenAlpha = 0;

packY = display_get_gui_height()*1.5;
packTargetY = 0;
spdY = 0;

inventoryGrid = ds_grid_create(4,4);
ds_grid_clear(inventoryGrid, -1);
tempGrid = ds_grid_create(4,4);

invArray = [];
animVar = 0;

holding = noone;
hoveringOver = noone;

cursorSprite = spUICursorPoint;
