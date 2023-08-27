// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scOnRoll(target=noone){
	for (var i = 0; i < array_length(oUpgradeManager.upgrades); i++) {
		var curUG = oUpgradeManager.upgrades[i];
		
		switch (curUG) {
		    case UPGRADES.J1:
				#region J1
				var pushBuff = new buff();
				with(pushBuff){
					buffInit = function(){
						buffID = BUFF.J1SLOWDOWN;
						var indexOfBuff = array_find_index(oUpgradeManager.stepScripts, function(_element, _index){return _element.buffID == buffID;}) 
						if(indexOfBuff != -1){
							oUpgradeManager.stepScripts[indexOfBuff].J1SlowdownTimer = 60;
							markForDelete = true;
							return;
						}
						J1SlowdownTimer = 60;
						currentGlobalTime = global.TD;
						changedTime = currentGlobalTime*0.5;
						global.TD -= changedTime;
						
					}
					pushBuff.buffEnd = function(){
						global.TD += changedTime;
						markForDelete = true;
					}
				
					pushBuff.buffStep = function(){
						J1SlowdownTimer -= oUpgradeManager.player.localTD;
						if(J1SlowdownTimer < 0) buffEnd();
						
					}
				}
				pushBuff.buffInit();
				array_push(oUpgradeManager.stepScripts, pushBuff);
				#endregion
		        break;
				
			case UPGRADES.K1:
				oUpgradeManager.player.rollEnhanced = true;
				break;
		    
		}
	}
}