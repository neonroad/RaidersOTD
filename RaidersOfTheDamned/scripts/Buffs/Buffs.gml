// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum BUFF {
	A1HASTE, E1DAMAGE, J1SLOWDOWN,
}
function buff() constructor{
	markForDelete = false;
	buffID = noone;
	buffInit = noone;
	buffStep = noone;
	buffEnd = noone;
}