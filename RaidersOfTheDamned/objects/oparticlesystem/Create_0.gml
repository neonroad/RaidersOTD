/// @description 

surf = noone;

global.particleSystem = part_system_create();
global.emitter = part_emitter_create(global.particleSystem);

particle_healPart = part_type_create();
part_type_sprite(particle_healPart, spParticle_Heal, true, true, false);
part_type_life(particle_healPart, 6, 36);
part_type_gravity(particle_healPart, 0.001, 90);

particle_exclam = part_type_create();
part_type_sprite(particle_exclam, spParticle_Exclam, true, true, false);
part_type_life(particle_exclam, 40, 40);

particle_hitpart = part_type_create();
part_type_sprite(particle_hitpart, spParticle_HitPart, true, true, false);
part_type_life(particle_hitpart, 20, 20);

particle_invis = part_type_create();
part_type_sprite(particle_invis, spParticle_Invis, true, true, false);
part_type_life(particle_invis, 20, 60);

particle_smoke1 = part_type_create();
part_type_sprite(particle_smoke1, spParticle_SmokeCloud1, true, true, false);
part_type_life(particle_smoke1, 60, 120);
part_type_speed(particle_smoke1,0,0.01,-0.005,0);
part_type_direction(particle_smoke1,0,180,0,0);

particle_splat = part_type_create();
part_type_sprite(particle_splat, spParticle_Splat1, true, true, false);
part_type_life(particle_splat, 10, 24);

particle_roll = part_type_create();
part_type_sprite(particle_roll, spParticle_Roll, true, true, false);
part_type_life(particle_roll, 10, 30);
part_type_size(particle_roll,0.5,1,0.01,0);
//part_type_alpha3(particle_roll,1,0.5,0);
part_type_direction(particle_roll,0,359,0,0);
part_type_speed(particle_roll,0.1,0.2,-0.01,0);

particle_scrap = part_type_create();
part_type_sprite(particle_scrap, spParticle_Scrap, false, false, true);
part_type_life(particle_scrap, 500, 1000);
//part_type_speed(particle_scrap,0,0,0,0);

particle_itemCommon = part_type_create();
part_type_sprite(particle_itemCommon, spParticle_itemCommon, true, true, false);
part_type_life(particle_itemCommon, 30, 100);
part_type_speed(particle_itemCommon, 0,0.01,0.001,0);
part_type_direction(particle_itemCommon, 90,90,0,0);

particle_itemRare = part_type_create();
part_type_sprite(particle_itemRare, spParticle_itemRare, true, true, false);
part_type_life(particle_itemRare, 15, 30);
part_type_speed(particle_itemRare, 0,0.01,-0.005,0);
part_type_direction(particle_itemRare, 90,90,0,0);

particle_sleep = part_type_create();
part_type_sprite(particle_sleep, spParticle_Sleep,true,true,false);
part_type_life(particle_sleep, 60,60);
part_type_direction(particle_sleep,45,55,0,0);
part_type_speed(particle_sleep,0.01,0.02,0,0);

part_system_automatic_draw(global.particleSystem, false);