draw_set_font(fnt_game_default);

display_set_gui_size(window_get_width(), window_get_height());

// Getting the scale
	var _scale = window_get_width() / 320;

if (room == rm_menu || global.paused)
{	
	draw_set_color(make_color_rgb(193, 204, 165));
	if (room != rm_menu) draw_rectangle(0, 0, window_get_width(), window_get_height(), false);
	draw_set_color(make_color_rgb(243, 108, 79));
//	draw_rectangle(320 - padx, 180 - pady, 320 + padx, 180 + pady, false);
	draw_set_color(c_white);
	
	// Logo scale processing
	var _logo_scale = 1;
	
	if (!window_get_fullscreen()) {
		_logo_scale = 0.75;
	}
	
	// Draw the logo
	var _yy_logo = sin(time * 2) * 4;
	var _ang_logo = sin(time) * 2 + 1;
	draw_sprite_ext(spr_logo, 0, window_get_width() / 2, window_get_height() / 4 + _yy_logo, _logo_scale, _logo_scale, _ang_logo, c_white, 1);

	for (var _i = 0; _i < array_length(menu_options); _i++)
	{
		draw_set_halign(fa_center);
		draw_set_color(c_black);
		draw_text(window_get_width() / 2, (window_get_height() / 3 + (window_get_height() / 3) - array_length(menu_options) * height / 4) - pady + height * _i + 4, menu_options[_i].text);	

		draw_set_color(make_color_rgb(150, 150, 150));
		
		if (_i == cur_option)
		{
			draw_set_color(c_white);
		}
		
		draw_text(window_get_width() / 2, (window_get_height() / 3 + (window_get_height() / 3) - array_length(menu_options) * height / 4) - pady + height * _i, menu_options[_i].text);	
		draw_set_halign(fa_left);
		
		var _yy = ((window_get_height() / 3 + window_get_height() / 3) - array_length(menu_options) * height / 4) - pady + height * _i;
		//draw_rectangle(window_get_width() / 2 - _opt.width / 2, _yy, window_get_width() / 2 + _opt.width / 2, _yy + _opt.height, true);
		menu_options[_i].yy = _yy;
		menu_options[_i].xx = window_get_width() / 2;
	}
	
	
	// Drawing the cursor
	if (global.controller == CONTROLLER_TYPES.KEYBOARD) draw_sprite(spr_cursor, 0, mouse_x * _scale, mouse_y * _scale);
}

if (room == rm_thanks) {
	if (surface_get_width(application_surface) == 320) surface_resize(application_surface, window_get_width(), window_get_height());
	
	draw_set_font(fnt_game2);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_draw_text_shaded(window_get_width() / 2, window_get_height() / 3, "Thank you for playing the game!");
	
	// draw credits
	draw_set_font(fnt_game_default);

	var _credits_text = [
		"Lemmtopia: Design, Art and Programming",
		"Oskar Henrique: Additional Art",
		"Manodeix: Additional Level Design",
		"Lucas Estevao: Musician",
		"Menu SFX by EZduzziteh from OpenGameArt.org",
		"shimmer_1 SFX: The Berklee College of Music"
	];
	
	var _spacing = 32;

	if (!window_get_fullscreen()) {
		draw_set_font(fnt_game_small);
		_spacing /= 2;
	}
	
	var _xx = window_get_width() / 2;
	var _yy = window_get_height() / 2.25;
	draw_set_halign(fa_center);
	for (var _i = 0; _i < array_length(_credits_text); _i++) {
		scr_draw_text_shaded(_xx, _yy + _i * _spacing, _credits_text[_i]);	
	}
	
	draw_set_font(fnt_game_small);
	scr_draw_text_shaded(window_get_width() / 2, window_get_height() / 3 * 2, "Press enter to restart the game.");
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	if (global.controller == CONTROLLER_TYPES.KEYBOARD) draw_sprite(spr_cursor, 0, mouse_x * _scale, mouse_y * _scale);
}

if (room == rm_lselect) {
	if (global.controller == CONTROLLER_TYPES.KEYBOARD) draw_sprite(spr_cursor, 0, mouse_x * _scale, mouse_y * _scale);	
}

display_set_gui_size(320, 180);

//draw_sprite(spr_gradient, 0, 0, 0);

draw_set_color(c_white);