// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scAim(){
	angleAiming = point_direction(x,y,mouse_x,mouse_y);
	if(!moved){
		currentSprite = spPlayerIdle;
		image_speed = 0;
		animVar = scAimGeneric();
	}
	else{
		currentSprite = spPlayerIdle;
		image_speed = 0.2;
		var angle = scAimGeneric();
		
		switch (angle) {
		    case 0:
		        currentSprite = spPlayerRunE;
		        break;
		    case 1:
		        currentSprite = spPlayerRunNE;
		        break;		
		    case 2:
		        currentSprite = spPlayerRunN;
		        break;		
		    case 3:
		        currentSprite = spPlayerRunNW;
		        break;
		    case 4:
		        currentSprite = spPlayerRunW;
		        break;
		    case 5:
		        currentSprite = spPlayerRunSW;
		        break;
		    case 6:
		        currentSprite = spPlayerRunS;
		        break;
		    case 7:
		        currentSprite = spPlayerRunSE;
		        break;
		}
		
	}

}

function scAimGeneric(angleToUse = angleAiming, weaponFlip=false){
	var angle = 0;
	if(angleToUse<22.5 || angleToUse>=337.5){
		angle = 0;	
	}
	else if(angleToUse >=22.5 && angleToUse < 67.5){
		angle = 1;	
	}
	else if(angleToUse >= 67.5 && angleToUse < 112.5){
		angle = 2;	
	}
	else if(angleToUse >= 112.5 && angleToUse < 157.5){
		angle = 3;	
	}
	else if(angleToUse >=157.5 && angleToUse < 202.5){
		angle = 4; 	
	}
	else if(angleToUse >= 202.5 && angleToUse < 247.5){
		angle = 5;	
	}
	else if(angleToUse >= 247.5 && angleToUse < 292.5){
		angle = 6;	
	}
	else if(angleToUse >= 292.5 && angleToUse < 337.5){
		angle = 7;	
	}
	
	if weaponFlip angle += 4
	angle = angle % 8;
	return angle;

}