/// @description Insert description here
// You can write your code in this editor

x = lerp(x,mouse_x,1);
y = lerp(y,mouse_y,1);
if(instance_exists(obj_Aura_Control))
	depth = obj_Aura_Control.depth-10;
if(owner.weaponEquipped != noone && owner.damageDealt > 1 ) sprite_index = spReticleCrit;
else if(owner.weaponEquipped != noone) sprite_index = spReticle;
else sprite_index = spReticleNoWeaponz;
shoot_cooldown-= owner.localTD;

if(reloading && shoot_cooldown <= 0 && owner.weaponEquipped != noone){
	reloading = false;
	image_speed = 0;
	image_index = 0;
	var weaponMap = owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)];
	var bulletsToTake = min(weaponMap[? "MAG_SIZE"], owner.bullets) - weaponMap[?"CURRENT_MAG"];
	weaponMap[? "CURRENT_MAG"] += bulletsToTake;
	quickReloadAvailable = false;
	audio_play_sound_at(snReload, owner.x, owner.y, 0, 60, 240, 0.5, false, 2);
	//repeat bulletsToTake scUpdateBullets(,weaponMap[? "BULLET_TYPE"]);
}
else if(reloading && owner.weaponEquipped == noone){
	image_speed = 0;
	image_index = 0;
	reloading = false;
}
//TODO: Fix reloading mid time changes
//else if(reloading){
//	image_speed = (image_number/shoot_cooldown)*owner.localTD;
//}

if(shoot_cooldown > 0 || owner.current_state != PLAYER_STATE.PLAYING){
	image_alpha = 0.5;
	if(mouse_check_button_pressed(mb_left)) bufferedInput = 20;
	bufferedInput--;
}
else{
	image_alpha = 1;
	quickReloadWindowCurrent+= owner.localTD;
	if(quickReloadWindowCurrent > quickReloadWindow)
		quickReloadAvailable = false;
}


if(mouse_check_button_pressed(mb_left) || bufferedInput > 0){
	if(!reloading && instance_exists(owner) && !owner.meleewep &&  owner.current_state == PLAYER_STATE.PLAYING && shoot_cooldown <= 0 && owner.bullets > 0){
		
		var weaponMap = owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)];
		
		if(weaponMap[? "CURRENT_MAG"] > 0){
			
			
			if(owner.weaponEquipped == ITEMS.WEAPON_PISTOL){
				var bullet = instance_create_depth(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),0,oBullet);	
				bullet.targetAngle = owner.angleAiming;
				bullet.owner = owner;
				bullet.x0 = floor(bullet.x);
				bullet.y0 = floor(bullet.y);
				bullet.crit = max(0,irandom(5-owner.critChance))==0;
				shoot_cooldown = weaponMap[? "SHOOT_COOLDOWN"];
				audio_play_sound_at(snShoot1, owner.x, owner.y, 0, 60, 240, 0.5, false, 2);
				scUpdateBullets();
				weaponMap[? "CURRENT_MAG"]--;
				scUIShakeSet(10,5);
				scParticleBurstLight(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming), bullet.crit ? 10 : 5, bullet.crit ? 10 : 7, 40, bullet.crit ? c_yellow : c_white, false, owner.angleAiming,6, 0.7);
				owner.gunRecoilX += -lengthdir_x(irandom_range(5,7),owner.angleAiming);
				owner.gunRecoilY += -lengthdir_y(irandom_range(5,7),owner.angleAiming);
				
				if(weaponMap[? "CURRENT_MAG"] <= 0){
					quickReloadWindowCurrent = 0;
					quickReloadWindow = weaponMap[?"RELOAD_TIME"]*0.5;
					quickReloadAvailable = true;
				}
			}
			
			else if(owner.weaponEquipped == ITEMS.WEAPON_SNIPER){
				var bullet = instance_create_depth(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),0,oBullet);	
				bullet.targetAngle = owner.angleAiming;
				bullet.owner = owner;
				bullet.x0 = floor(bullet.x);
				bullet.y0 = floor(bullet.y);
				bullet.crit = true;
				bullet.bulletType = ITEMS.WEAPON_SNIPER;
				shoot_cooldown = weaponMap[? "SHOOT_COOLDOWN"];
				audio_play_sound_at(snShoot1, owner.x, owner.y, 0, 60, 240, 0.5, false, 2);
				scUpdateBullets(, weaponMap[? "BULLET_TYPE"]);
				weaponMap[? "CURRENT_MAG"]--;
				scUIShakeSet(35,10);
				scParticleBurstLight(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming), bullet.crit ? 45 : 30, bullet.crit ? 30 : 25, 40, bullet.crit ? c_yellow : c_white, false, owner.angleAiming,3, 0.5);
			
			}
			
			else if(owner.weaponEquipped == ITEMS.WEAPON_NADE){
				var bullet = instance_create_depth(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),0,oGrenade);	
				bullet.targetAngle = owner.angleAiming;
				bullet.owner = owner;
				bullet.crit = true;
				bullet.bulletType = ITEMS.WEAPON_NADE;
				shoot_cooldown = weaponMap[? "SHOOT_COOLDOWN"];
				audio_play_sound_at(snWeaponPickup, owner.x, owner.y, 0, 60, 240, 0.5, false, 2);
				scUpdateBullets(, weaponMap[? "BULLET_TYPE"]);
				weaponMap[? "CURRENT_MAG"]--;
				scUIShakeSet(5,10);
			}
	
			else if(owner.weaponEquipped == ITEMS.WEAPON_SHOTGUN){
				var critVar = max(0,irandom(5-owner.critChance)) == 0;
				for (var i = 0; i < 5; i++) {
					var bullet = instance_create_depth(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),0,oBullet);	
					bullet.targetAngle = (owner.angleAiming)+(i*irandom_range(-5*weaponMap[?"SPREAD"],5*weaponMap[?"SPREAD"]));
					if(bullet.targetAngle < 0) bullet.targetAngle+= 360;
					if(bullet.targetAngle > 360) bullet.targetAngle -= 360;
					bullet.owner = owner;
					bullet.crit = critVar;
					bullet.x0 = floor(bullet.x);
					bullet.y0 = floor(bullet.y);
					shoot_cooldown = weaponMap[? "SHOOT_COOLDOWN"];
					bullet.bulletType = ITEMS.WEAPON_SHOTGUN;
					
					
			
				}
				
				scParticleBurstLight(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming), critVar ? 35 : 20, critVar ? 20 : 15, 40, critVar ? c_yellow : c_white, false, owner.angleAiming,15, 0.5);
			
				
				//owner.current_state = scStateManager(PLAYER_STATE.RECOIL,owner);
				//owner.shootable_map[? SHOOTABLE_MAP.HSP] += lengthdir_x(2,owner.angleAiming-180);
				//owner.shootable_map[? SHOOTABLE_MAP.VSP] += lengthdir_y(2,owner.angleAiming-180);
				//owner.recoilTime = 5;
				
				scUpdateBullets(, weaponMap[? "BULLET_TYPE"]);
				audio_play_sound_at(snShoot1, owner.x, owner.y, 0, 60, 240, 0.5, false, 2);
				weaponMap[? "CURRENT_MAG"]--;
				scUIShakeSet(20,5);
			}
		}
		
		else{
			popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
			popup.image_index = 2;
			popup.image_alpha = 1;
			audio_play_sound(snError, 12, false);	
			bufferedInput = 0; 
		}
	
	}	
	else if(instance_exists(owner) && owner.meleewep && owner.current_state == PLAYER_STATE.PLAYING && shoot_cooldown <= 0 && owner.weaponEquipped != noone){
		var hb = instance_create_depth(owner.x,owner.y, depth, oHitbox);	
		hb.sprite_index = owner.weaponFlip ? spShovelAttack1 : spShovelAttack2;
		hb.owner = owner;
		hb.image_angle = owner.angleAiming;
		hb.image_xscale = 2;
		hb.image_yscale = 2;
		shoot_cooldown = 30;
		owner.weaponFlip = !owner.weaponFlip;
		bufferedInput = 0;
		audio_play_sound_at(choose(snWhoosh1,snWhoosh2), owner.x, owner.y, 0, 60, 240, 0.5, false, 2,,,random_range(0.8,1.2));	
		
	}
}

if(!reloading && mouse_check_button(mb_left) && owner.weaponEquipped == ITEMS.WEAPON_RIFLE && instance_exists(owner) && owner.current_state == PLAYER_STATE.PLAYING && shoot_cooldown <= 0 && owner.bullets > 0 ){	
	var weaponMap = owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)];
	
	if(weaponMap[? "CURRENT_MAG"] > 0){
		
		scParticleBurstLight(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming), 5, 3, 40, c_yellow, false);	
		
		var bullet = instance_create_depth(owner.x +lengthdir_x(7,owner.angleAiming),owner.y+lengthdir_y(7,owner.angleAiming),0,oBullet);	
		bullet.targetAngle = (owner.angleAiming)+(irandom_range(-3,3));
		if(bullet.targetAngle < 0) bullet.targetAngle+= 360;
		if(bullet.targetAngle > 360) bullet.targetAngle -= 360;
		bullet.owner = owner;
		bullet.x0 = floor(bullet.x);
		bullet.y0 = floor(bullet.y);
		bullet.bulletType = ITEMS.WEAPON_RIFLE;
		bullet.crit = max(0,irandom(5-owner.critChance))==0;
		shoot_cooldown = weaponMap[? "SHOOT_COOLDOWN"];
		
		if(weaponMap[? "BULLET_DAMAGE"] > 1){
			audio_play_sound_at(choose(snShootRifle1, snShootRifle2, snShootRifle3), owner.x, owner.y, 0, 60, 240, 0.5, false, 2,1,0,random_range(1.2,1.5));
		}
		else
			audio_play_sound_at(choose(snShootRifle1, snShootRifle2, snShootRifle3), owner.x, owner.y, 0, 60, 240, 0.5, false, 2,1,0,random_range(0.8,1));
		scUpdateBullets(, weaponMap[? "BULLET_TYPE"]);
		weaponMap[? "CURRENT_MAG"]--;
		scUIShakeSet(10,12);
	}
	
	else{
		popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
		popup.image_index = 2;
		popup.image_alpha = 1;
		audio_play_sound(snError, 12, false);	
	}
}

if(mouse_check_button_pressed(mb_left) && instance_exists(owner) && !owner.meleewep && owner.current_state == PLAYER_STATE.PLAYING && !ds_list_empty(owner.weaponList) && owner.bullets <= 0){
	audio_play_sound(snEmptyWeapon,5, false);
	popup = instance_create_layer(other.bbox_left, other.bbox_top, "Instances", oPopup);
	popup.image_index = 3;
	popup.image_alpha = 1;
	audio_play_sound(snError, 12, false);
	quickReloadAvailable = false;
}

if(owner.bullets > 0 && !reloading && keyboard_check_pressed(ord("R"))){
	var weaponMap = owner.weaponList[| scFindWeapon(owner.weaponList, owner.weaponEquipped)];
	
	if(weaponMap[? "CURRENT_MAG"] < weaponMap[? "MAG_SIZE"] && weaponMap[? "CURRENT_MAG"] < owner.bullets){
		
		totalReloads++;
		if((quickReloadAvailable) || totalReloads%2 == 0 && ds_map_exists(weaponMap, "TAPED_MAGS") && weaponMap[? "TAPED_MAGS"] > 1){
			shoot_cooldown = floor(weaponMap[? "RELOAD_TIME"]*0.5);
			scParticleBurstLight(owner.x-10,owner.y-10,owner.x+10,owner.y+10, 15, 3, 40, c_yellow, false, 0,360, 0.5);
			audio_play_sound(snCrit, 4, false);
		}
		else
			shoot_cooldown = weaponMap[? "RELOAD_TIME"];
		image_speed = (image_number/shoot_cooldown)*owner.localTD;
		reloading = true;
	}
}