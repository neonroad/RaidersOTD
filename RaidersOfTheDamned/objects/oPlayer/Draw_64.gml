/// @description Insert description here
// You can write your code in this editor

if(true || room == rmIntro) exit;

if(room != rmIntro && alphaTransition > 0.05 && !shootable_map[? SHOOTABLE_MAP.DEAD]){
	
	alphaTransition = lerp(alphaTransition, 0, 0.01*localTD);
	draw_sprite_ext(spBullet,0,0,0,display_get_gui_width(),display_get_gui_height(), 0, c_black, alphaTransition);
}

if(shootable_map[? SHOOTABLE_MAP.DEAD]){
	alphaTransition = lerp(alphaTransition, 1, 0.005*localTD);
	draw_sprite_ext(spBullet,0,0,0,display_get_gui_width(),display_get_gui_height(), 0, c_black, alphaTransition);
	if(alphaTransition > 0.95){
		game_restart();	
	}
}

var spriteToUse = spUIHealth0;
if(shootable_map[?SHOOTABLE_MAP.HEALTH] == 2) spriteToUse = spUIHealth1;
if(shootable_map[?SHOOTABLE_MAP.HEALTH] == 1) spriteToUse = spUIHealth2;
if(shootable_map[?SHOOTABLE_MAP.HEALTH] == 0) spriteToUse = spUIHealth3;
if(healthIllusion > 0) spriteToUse = choose(spUIHealth0, spUIHealth1, spUIHealth2, spUIHealth3);

//Health
draw_sprite_ext(spriteToUse, floor(animVarHP), uiXShake + display_get_gui_width()*0.05, uiYShake + display_get_gui_height()*0.8, 5, 5, 0, c_white, 1);

//Weapon
for (var i = 0; i < ds_list_size(weaponList); i++) {
    var alphaWep = 0.5;
	var wepMap = weaponList[|i];
	if(wepMap[? "WEAPON"] == weaponEquipped) alphaWep = 1;
	draw_sprite_ext(wepMap[? "ICON"], 0,uiXShake + display_get_gui_width()*0.85,uiYShake + (display_get_gui_height()*0.8)-(64*i*1.5), 5, 5, 0, c_white, alphaWep);
	
	if(alphaWep == 1 && bullets <= 0 && !meleewep) draw_sprite_ext(spUIAmmoOut, 0, display_get_gui_width()*0.85, (display_get_gui_height()*0.8)-(64*i*1.5), 4, 4, 0, c_white, alphaWep);
	else if(!meleewep && alphaWep == 1){
		draw_text_transformed(uiXShake + display_get_gui_width()*0.85,uiYShake + (display_get_gui_height()*0.9), string(wepMap[? "CURRENT_MAG"]) + "/" + string(wepMap[? "MAG_SIZE"]) , 5, 5, 0);	
		//draw_text_transformed(display_get_gui_width()*0.95, (display_get_gui_height()*0.9), bullets, 5, 5, 0);
	}
}



//Items
for (var i = 0; i < ds_list_size(inventory); i++) {
	var item = inventory[|i];
	var scale = 5;
	draw_sprite_ext(item.sprite_index,item.image_index,uiXShake + i*scale*sprite_get_width(item.sprite_index), uiYShake + 0,scale,scale,0,c_white,1);
	draw_text_transformed(uiXShake+ (i*sprite_get_width(item.sprite_index)*scale),uiYShake +0,item.stackAmount,scale,scale,0);
	if(switchWith == item){
		draw_sprite_ext(spUISwitch, floor(switchAnim),i*scale*sprite_get_width(item.sprite_index), 0,scale,scale,0,c_white, 1);
	}
}

//Upgrades
for (var i = 0; i < array_length(oUpgradeManager.upgrades); i++) {
	var item = oUpgradeManager.upgrades[i];
	var scale = 5;
	draw_sprite_ext(spUpgradePickup,item,uiXShake + 0,uiYShake + (1+i)*scale*sprite_get_height(spUpgradePickup),scale,scale,0,c_white,1);
}

//Health outline effect
draw_sprite_ext(spUIHealthOutline, 0, (sprite_get_width(spUIHealthOutline)*5*0.5) + display_get_gui_width()*0.05, (sprite_get_height(spUIHealthOutline)*5*0.5) + display_get_gui_height()*0.8, hpScale, hpScale, 0, hpCol, hpAlpha);

scLevelTitleFade();




