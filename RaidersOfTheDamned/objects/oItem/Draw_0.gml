/// @description Insert description here
// You can write your code in this editor


if(!in_pack){
	
	draw_self();
	//draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,1);
	
	partTimer++;
	
	if(partTimer % 60 == 0){
		part_emitter_region(global.particleSystem, global.emitter, bbox_left, bbox_right,bbox_top,bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(global.particleSystem, global.emitter, rarity == 0 ? oParticleSystem.particle_itemCommon : oParticleSystem.particle_itemRare,1);
	}
}
