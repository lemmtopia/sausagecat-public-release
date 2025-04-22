function scr_save(_fname) {
	var _file = file_text_open_write(_fname);
	
	var _save = {};
	with (_save) {
		n_unlocked_levels = global.n_unlocked_levels;
		music = global.music;
		sfx = global.sfx;
		fullscreen = window_get_fullscreen();
	}
	
	var _json = json_stringify(_save);
	file_text_write_string(_file, _json);
	
	file_text_close(_file);
}