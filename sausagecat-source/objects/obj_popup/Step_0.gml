if (instance_exists(obj_fade)) exit;

xx = window_get_width() / 2;
yy = lerp(yy, window_get_height() / 2, 0.12);

var _yy_floored = floor(yy);

if (_yy_floored == window_get_height() / 2)
{
	alpha = lerp(alpha, 1, 0.2);	
	ang *= 0.9;
}

if (room == rm_11a)
{
	text = "X change cat\n\nPress enter to continue";	
}

if (global.confirm) {
	if (instance_exists(obj_fade)) exit;

	instance_destroy();	
}