/// @description  

if(irandom(3)==1){
	instance_create_depth(x, y, depth, choose(oMobWarriorBug, oMobIllusionist, oMobGrunt));
	var pop = instance_create_layer(oPlayer.x,oPlayer.bbox_top,"Instances",oPopup);
	pop.image_index = 4;
	pop.fadeRate*=0.5;
	audio_play_sound(snEvacAlarm,10,false);
	instance_destroy();
}
else
instance_destroy();


