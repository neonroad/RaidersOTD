/// @description  

if(ds_exists(gridSpace, ds_type_grid))
	ds_grid_destroy(gridSpace);
	
if(variable_instance_exists(id, "itemMap"))
	if(ds_exists(itemMap, ds_type_map))
		ds_map_destroy(itemMap);
		
		