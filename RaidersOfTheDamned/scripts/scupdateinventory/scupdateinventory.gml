// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scUpdateBullets(remove=true, ammotype=ITEMS.AMMO_1){
	if(remove){
		for (var i = array_length(oPlayer.invObj.invArray)-1; i>=0; i--) {
		    var item = oPlayer.invObj.invArray[i];
			if(item.itemID == ammotype){
				item.stackAmount--;
			
				if(item.stackAmount <= 0){
					with(oPlayer.invObj)instance_destroy(scInventoryRemove(item));
				}
				break;
				
			}
			
		}	
	}
}