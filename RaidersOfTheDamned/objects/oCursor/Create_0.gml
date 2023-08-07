/// @description Insert description here
// You can write your code in this editor
shoot_cooldown = 0;
shoot_cooldown_max = 60;
window_set_cursor(cr_none);

dist_min_falloff = 10;
dist_max_falloff = 50;
totalReloads = 0;
bufferedInput = 0;

quickReloadWindowCurrent = 0;
quickReloadWindow = 25;
quickReloadAvailable = true;

owner = noone;

aura_light_init(256,c_white,1,false,false);

image_xscale = 1;
image_yscale = 1;
image_speed = 0;

reloading = false;
//depth = -100;