// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scOnKill(target=noone){
	for (var i = 0; i < array_length(oUpgradeManager.upgrades); i++) {
		var curUG = oUpgradeManager.upgrades[i];
		
		switch (curUG) {
		    case UPGRADES.A1:
				#region A1
				var pushBuff = new buff();
				with(pushBuff){
					buffInit = function(){
						buffID = BUFF.A1HASTE;
						if(array_find_index(oUpgradeManager.stepScripts, function(_element, _index){return _element.buffID == buffID;}) != -1){
							markForDelete = true;
							return;
						}
						A1HasteTimer = 60;
						addedSpeed = oUpgradeManager.player.walk_speed_base*.5;
						oUpgradeManager.player.walk_speed += addedSpeed;
					}
					pushBuff.buffEnd = function(){
						oUpgradeManager.player.walk_speed -= addedSpeed;
						markForDelete = true;
					}
				
					pushBuff.buffStep = function(){
						A1HasteTimer-= global.TD;
						if(A1HasteTimer <= 0) buffEnd(); 	
					}
				}
				pushBuff.buffInit();
				array_push(oUpgradeManager.stepScripts, pushBuff);
				#endregion
		        break;
			case UPGRADES.B1:
				instance_create_layer(target.x,target.y,"Mobs",oMobWisp);
				break;
			case UPGRADES.C1:
				oUpgradeManager.player.vampKills ++;
				break;
		    
		}
	}
}