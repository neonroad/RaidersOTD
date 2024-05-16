/// @description 


enum INTERACTABLES {
	SHOVELMOUND, DRAWER, WEAPONBOX, LOCKER,
	ZOMBIECORPSE, 
}

if(randomLocation){
	do{
	x = (irandom_range(LEFT, RIGHT) div 32 ) * 32;
	y = (irandom_range(LEFT, RIGHT) div 32 ) * 32;
	}
	until(collision_point(x,y,oWall,false, true) == noone)
}
image_speed = 0;

//interactType = INTERACTABLES.SHOVELMOUND;


interacted = false;

interactable = true;

currentlyInteracting = false;

itemRequired = noone;

activeRoom = room;

function dropUpgrade(){
	if(other.interacted && currentlyInteracting){
		image_index = 1;
		interactable = false;
		instance_create_depth(x,y,depth-1,oUpgradePickup);
	}
}

function dropItem(){
	if(other.interacted && currentlyInteracting){
		image_index = 1;
		interactable = false;
		layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
	}
}

function dropHealthItem(){
	if(interacted && interactable){
		scInteractRemove();
		image_index = 1;
		interactable = false;
		var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
		var newItem = instance_create_layer(x,y,"Items",oItemWorld, {itemID : ITEMS.HEALTH_1});
		var itemSeq = layer_sequence_get_instance(item);
		sequence_instance_override_object(itemSeq,oItemWorld,newItem);
	}
}

function dropAmmoItem(){
	if(interacted && interactable){
		scInteractRemove();
		image_index = 1;
		interactable = false;
		var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
		var newItem = instance_create_layer(x,y,"Items",oItemWorld, {itemID : ITEMS.AMMO_1});
		var itemSeq = layer_sequence_get_instance(item);
		sequence_instance_override_object(itemSeq,oItemWorld,newItem);
		
		}
}

function dropAmmoItemSmart(){
	if(interacted && interactable){
		scInteractRemove();
		interactable = false;
		var selectedWep = oPlayer.weaponList[| irandom(ds_list_size(oPlayer.weaponList)-1)];
		var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
		var newItem = instance_create_layer(x,y,"Items",oItemWorld, {itemID : selectedWep[? "BULLET_TYPE"]});
		var itemSeq = layer_sequence_get_instance(item);
		sequence_instance_override_object(itemSeq,oItemWorld,newItem);
		
		}
}

function dropWeaponItem(){
	if(other.interacted && currentlyInteracting){
		image_index = 1;
		interactable = false;
		var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
		var newItem = instance_create_layer(x,y,"Items",oItem);
		newItem.itemEnum = choose(ITEMS.WEAPON_NADE, ITEMS.WEAPON_PISTOL, ITEMS.WEAPON_RIFLE, ITEMS.WEAPON_SHOTGUN, ITEMS.WEAPON_SHOVEL, ITEMS.WEAPON_SNIPER);
		var itemSeq = layer_sequence_get_instance(item);
		sequence_instance_override_object(itemSeq,oItem,newItem);
	
	}
}