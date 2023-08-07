/// @description Insert description here
// You can write your code in this editor

gpu_set_blendenable(false);
var _scaleX = cameraSize;
var _scaleY = cameraSize;

draw_surface_ext(
	application_surface,
	0 - (frac(x)*_scaleX),
	0 - (frac(y)*_scaleY),
	1,
	1,
	0,
	c_white,
	1.0
);
gpu_set_blendenable(true);