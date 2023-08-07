// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scOnDamage(target=noone){
	for (var i = 0; i < array_length(oUpgradeManager.upgrades); i++) {
		var curUG = oUpgradeManager.upgrades[i];
		
		switch (curUG) {
		    case UPGRADES.G1:
				target.bleedApplier = oUpgradeManager.player;
				target.bleedEnabled = true;
				target.bleedTimeMax += 60;
				//target.bleedDamage++;
		        break;
			case UPGRADES.H1:
				if(!target.shootable_map[? SHOOTABLE_MAP.DEAD] && target.shootable_map[? SHOOTABLE_MAP.HEALTH] < target.shootable_map[? SHOOTABLE_MAP.HEALTH_START]*0.3){
					var reap = instance_create_depth(target.x-10,target.y,target.depth,oReaperAnim);
					reap.follow = target;
					reap.owner = oUpgradeManager.player;
					//scDamage(target, oUpgradeManager.player, 0, DAMAGE_TYPE.EXECUTE);	
				}
				break;
			case UPGRADES.I1:
				var lightn = instance_create_layer(target.x, target.y,"Instances",oLightningHost);
				lightn.owner = oUpgradeManager.player;
				lightn.target = target;
				break;
		    
		}
	}
}