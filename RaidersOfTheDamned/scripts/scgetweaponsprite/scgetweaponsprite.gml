function scGetWeaponSprite(weapon){
	switch (weapon) {
	    case ITEMS.WEAPON_PISTOL:
	        return spItemPistol;
	        break;
	    case ITEMS.WEAPON_SHOTGUN:
	        return spItemShotgun;
	        break;
		case ITEMS.WEAPON_RIFLE:
	        return spItemRifle;
	        break;
	}
}