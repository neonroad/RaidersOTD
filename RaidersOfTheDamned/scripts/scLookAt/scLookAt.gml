// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scLookAt( x1, y1){
	//Aim towards reticle w/ swing speed

	var disX = (x1 - x);
	var disY = (y1 - y);

	var len = sqrt( (disX*disX) + (disY*disY) );



	if(len != 0){
		disX /= len;
		disY /= len;
	}

	angX = dcos(angleFacing);
	angY = dsin(angleFacing);

	angX += (disX-angX) * ((look_speed*localTD)/10);
	angY += (disY-angY) * ((look_speed*localTD)/10);

	var old_angleFacing = angleFacing;

	angleFacing = darctan2(angY,angX);
	
	return old_angleFacing-angleFacing;
}

function scLookAtFrom(x1,y1,x2,y2){
	//Aim towards reticle w/ swing speed

	var disX = (x1 - x2);
	var disY = (y1 - y2);

	var len = sqrt( (disX*disX) + (disY*disY) );



	if(len != 0){
		disX /= len;
		disY /= len;
	}

	angX = dcos(angleFacing);
	angY = dsin(angleFacing);

	angX += (disX-angX) * ((look_speed*localTD)/10);
	angY += (disY-angY) * ((look_speed*localTD)/10);

	var old_angleFacing = angleFacing;

	angleFacing = darctan2(angY,angX);
	
	return old_angleFacing-angleFacing;
}

function checkLOS(){
	var wall = collision_line(x,y,target.x,target.y,oWall, false,true);	
	if(wall != noone){
		if(variable_instance_exists(wall, "open"))
			if(wall.open) return true;
	
		return false;
	}
	return true;
}