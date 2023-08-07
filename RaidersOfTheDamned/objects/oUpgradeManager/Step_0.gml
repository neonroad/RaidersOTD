/// @description  

for (var i = 0; i < array_length(stepScripts); i++) {
    if(!stepScripts[i].markForDelete) with(stepScripts[i]) buffStep();
	else{
		array_delete(stepScripts,i,1);
		i--;
	}
}
