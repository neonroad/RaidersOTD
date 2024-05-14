/// @description Insert description here
// You can write your code in this editor


upgrader = oUpgradeManager;

if(!instance_exists(upgrader)) exit;

for (var i = 0; i <array_length(upgrader.upgrades); i++) {
    if(upgrader.upgrades[i] == UPGRADES.K1) {
		instance_create_layer(x,y,"Mobs", oMobWarriorBug);
		
		var interact = instance_create_layer(x+15,y+15,"Instances", oInteractive);
		interact.interactType = INTERACTABLES.ZOMBIECORPSE;
		
		var interact = instance_create_layer(x,y-15,"Instances", oInteractive);
		interact.interactType = INTERACTABLES.ZOMBIECORPSE;
		
		var interact = instance_create_layer(x-15,y,"Instances", oInteractive);
		interact.interactType = INTERACTABLES.ZOMBIECORPSE;
		
		
		
		instance_destroy();
	}
}







