if (global.confirm && level_id != undefined && global.n_unlocked_levels >= level_num) {
	global.cur_level_index = level_num;
	room_goto(level_id);
}