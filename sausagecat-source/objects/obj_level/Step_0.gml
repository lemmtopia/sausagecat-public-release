if (!global.paused) {
	next_level_time--;	
}
	
if (global.cur_tiles >= global.total_tiles && obj_player.milk)
//if (obj_player.milk)
{
	if (!completed) {
		next_level_time = 60;
		completed = true;
	}
	
	if (array_length(obj_player.grow_index) <= 0 && !instance_exists(obj_fadein)) {
		if (room != room_last) {
			global.cur_level_index++;
			
			if (global.n_unlocked_levels < global.cur_level_index) {
				global.n_unlocked_levels++;
			}
			
			scr_save(global.fname);
		} else {
			instance_destroy(obj_manager);
		}
		
		instance_create_depth(0, 0, 0, obj_fadein);
	}
}

undo_delay--;
if (global.undo && undo_delay <= 0) {
	if (selected_cat != noone && !selected_cat.milk) {
		selected_cat.go_back();
		undo_delay = max_undo_delay;
	}
}

if (global.change) {
	cur_cat++;
	
	if (cur_cat > array_length(cats) - 1) {
		cur_cat = 0;	
	}
	
	selected_cat = cats[cur_cat];
}

if (global.pause)  {
	global.paused = !global.paused;
	obj_manager.ingame_menu();
}

if (global.debug && keyboard_check_pressed(ord("P"))) {
	instance_create_depth(0, 0, 0, obj_kitten_convert);	
}