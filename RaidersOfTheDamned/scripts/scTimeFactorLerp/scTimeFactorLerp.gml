// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@ description time factor lerp
/// @param value,target,lerpamount,timefacto
function timeFactorLerp(){
	var _originalValue = argument[0];
	var _targetValue = argument[1]; 
	var _lerpAmount = argument[2];
	var _timeFactor = argument[3]; 
 
	var _val = lerp( _originalValue, _targetValue, 1 - power( 1 -_lerpAmount, _timeFactor));
 
	return _val;
}