var _brush = keyboard_check_pressed(ord("B"));
var _erase = keyboard_check_pressed(ord("E"));
var _place = keyboard_check_pressed(vk_space);
var _milk_toggle = keyboard_check(vk_shift);
var _box = keyboard_check_pressed(ord("C"));
var _blocker = keyboard_check_pressed(ord("V"));
var _delta_scroll = mouse_wheel_down() - mouse_wheel_up();

if (_brush) tile_brush = 2;
else if (_erase) tile_brush = 0;

if (mouse_check_button(mb_left)) {
	place_tile();
}

// select with scrollwheel
place_obj_id += _delta_scroll;
place_obj_id = clamp(place_obj_id, 0, PLACE_OBJ_ID.N_OBJ_IDS - 1);

if (_place) {
	var _xx = floor(mouse_x / 16) * 16;
	var _yy = floor(mouse_y / 16) * 16;
	
	switch (place_obj_id) {
		case PLACE_OBJ_ID.CAT:	
			// Place cat
			reset_and_place(_xx + 8, _yy + 8, obj_player);
			break;
		case PLACE_OBJ_ID.MILKPOT:
			instance_create_depth(_xx, _yy, 0, obj_milk);
			break;
		case PLACE_OBJ_ID.BOX:
			if (instance_exists(obj_player)) reset_and_place(_xx + 8, _yy + 8, obj_box);
			break;
		case PLACE_OBJ_ID.BLOCKER:
			instance_create_depth(_xx + 8, _yy + 8, 0, obj_blocker);
			break;
	}
}
