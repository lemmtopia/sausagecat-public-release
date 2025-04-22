if (can_spawn) 
{
	var _c = instance_create_layer(xx, yy, "Instances", obj_player);
	array_push(obj_level.cats, _c);
}