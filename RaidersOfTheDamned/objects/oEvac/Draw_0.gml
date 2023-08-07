/// @description Insert description here
// You can write your code in this editor


draw_sprite_ext(currentSprite,floor(animVar),x,y-120,1,1,0,c_white,1);

if(animVar >= sprite_get_number(spLadderDrop) && currentSprite == spLadderDrop){
	currentSprite = spLadderSway;
	animVar = 0;
}