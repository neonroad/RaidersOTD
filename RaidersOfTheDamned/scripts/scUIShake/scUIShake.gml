// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scUIShakeSet(shakeMag,shakeDur){
	with(oGame){
		uiShake = shakeMag;
		uiShakeDur = shakeDur;
	}
	with(oPlayer){
		uiShake = shakeMag;
		uiShakeDur = shakeDur;
	}
}

function scUIShakeControl(){
	
	uiShakeDur-= global.TD;
	
	if(uiShakeDur > 0){
		uiXShake = choose(-1,1)*uiShake;
		uiYShake = choose(-1,1)*uiShake;
	}
	else{
		uiXShake = lerp(uiXShake,0, 0.5*global.TD);
		uiYShake = lerp(uiYShake,0, 0.5*global.TD);
	}
}