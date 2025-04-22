if (mouse_check_button_pressed(mb_left) && level_id != undefined && global.n_unlocked_levels >= level_num) {
	global.cur_level_index = level_num;
	room_goto(level_id);
}