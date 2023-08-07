/// @description  
var item = layer_sequence_create("ItemsAssets",x+16,y+16,sqItemBounce);
var newItem = instance_create_layer(x,y,"Items",oItemWorld, {itemID : itemToSpawn});
var itemSeq = layer_sequence_get_instance(item);
sequence_instance_override_object(itemSeq,oItemWorld,newItem);