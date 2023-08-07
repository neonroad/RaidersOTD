function scRoomChanged(){
	if(!variable_instance_exists(id, "roomLast")){
		roomLast = room;
		show_debug_message("roomLast didn't exist!");
		return true;
	}
	if(roomLast != room){
		roomLast = room;
		return true;
	}
	roomLast = room;
	return false;
}