// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scOnHurt(target=noone){
	for (var i = 0; i < array_length(oUpgradeManager.upgrades); i++) {
		var curUG = oUpgradeManager.upgrades[i];
		
		switch (curUG) {
			case UPGRADES.D1:
				var splode = instance_create_depth(x,y,depth,oImpSplosion);
				splode.owner = id;
				break;
		    case UPGRADES.E1:
				#region E1
				var pushBuff = new buff();
				with(pushBuff){
					buffInit = function(){
						buffID = BUFF.E1DAMAGE;
						if(array_find_index(oUpgradeManager.stepScripts, function(_element, _index){return _element.buffID == buffID;}) != -1){
							markForDelete = true;
							return;
						}
						E1DamageTimer = 600;
						addedDMG = 2;
						oUpgradeManager.player.damageDealt += addedDMG;
					}
					pushBuff.buffEnd = function(){
						oUpgradeManager.player.damageDealt -= addedDMG;
						markForDelete = true;
					}
				
					pushBuff.buffStep = function(){
						E1DamageTimer-= global.TD;
						if(E1DamageTimer <= 0) buffEnd(); 	
					}
				}
				pushBuff.buffInit();
				array_push(oUpgradeManager.stepScripts, pushBuff);
				#endregion
				break;
			case UPGRADES.F1:
				oUpgradeManager.player.lightFollowP.image_xscale *= 1.25;
				break;
		}
	}
}