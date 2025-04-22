var _player = instance_place(x, y, obj_player);
var _tile = tilemap_get_at_pixel(tilemap, x, y);

// using this instead of a if-else is shorter to write.
pressed = (_player || _tile);

if (last_pressed != pressed && pressed) {
	func();
}	

last_pressed = pressed;