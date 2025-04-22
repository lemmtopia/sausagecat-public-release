function scr_load(fname) {
	if (file_exists(fname)) {
		var _file = file_text_open_read(fname);
		
		var _json = file_text_read_string(_file);
		var _data = json_parse(_json);
		
		global.n_unlocked_levels = _data.n_unlocked_levels;
		global.music = _data.music;
		global.sfx = _data.sfx;
		
		window_set_fullscreen(_data.fullscreen);
		
		file_text_close(_file);
	}
}
 