/// @description Insert description here
// You can write your code in this editor



//psTitle2
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_square);
part_type_size(_ptype1, 0.25, 0.5, -0.03, 0);
part_type_scale(_ptype1, 0.25, 0.5);
part_type_speed(_ptype1, 2, 3, 0, 0);
part_type_direction(_ptype1, 0, 0, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $033AAF, $00008C, $0296D6);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 20, 40);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, 60, 60, 0, 10, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 16);

part_system_position(_ps, x+15, y);






