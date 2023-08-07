/// @description  Take damage

if(current_state != ILLUSIONER_STATE.HURT){
	current_state = ILLUSIONER_STATE.HURT;
	animVar = 0;
	currentSprite = hurtSprite;
	currentSpell = noone;
	beginIllusion = false;
	scParticleBurstLight(bbox_left,bbox_top, bbox_right, bbox_bottom, 3, 1, 60+irandom(30), make_color_rgb(75, 128, 202));
	for (var i = 0; i < array_length(fakeArray); i++) {
	    instance_destroy(fakeArray[i]);
	}
	fakeArray = [];
}




