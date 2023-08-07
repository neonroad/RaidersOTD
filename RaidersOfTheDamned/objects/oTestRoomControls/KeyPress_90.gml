/// @description  

for (var i = 0; i < UPGRADES.LENGTH; i++) {
    var inst = instance_create_layer(oPlayer.x+i*sprite_get_width(spUpgradePickup),oPlayer.y,"Mobs",oUpgradePickup);
	inst.upgradeEnum = i;
}




