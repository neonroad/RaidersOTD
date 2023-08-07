/// @description 


open = true;

emitsLight = Aura_Light_Create_Fast("Instances",oLightFast,spDecorLightLamp,0,x,y,1,1,0,make_color_rgb(207, 138, 203),1);
emitsLight.timer = -1;


switch (wallDir) {
    case 0:
    case 1:
		sprite_index = spMobFungusEyeSideOpen;
        break;
    case 2:
		sprite_index = spMobFungusEyeSideOpen;
		image_xscale = -1;
		break;
	
	case 3:
	default:
        sprite_index = spMobFungusEyeSouthOpen;
        break;
}