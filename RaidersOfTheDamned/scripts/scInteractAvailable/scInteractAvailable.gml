// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scInteractAvailable(){
	if(!array_contains(oPlayer.interactList, id)) array_push(oPlayer.interactList, id);	
}

function scInteractRemove(){
	array_find_index(oPlayer.interactList, function(element, index){
		
		if(element == id){
			array_delete(oPlayer.interactList, index,1);
			return true;
		}
		return false;
	});	
}