display_set_gui_size(window_get_width(), window_get_height());
draw_set_font(fnt_game2);
depth = -1000;

var _spacing = 32;

if (!window_get_fullscreen()) {
	draw_set_font(fnt_game_small);
	_spacing /= 2;
}

var _xx = window_get_width() / 2;
var _yy = window_get_height() / 2.25;
draw_set_halign(fa_center);
for (var _i = 0; _i < array_length(text); _i++) {
	scr_draw_text_shaded(_xx, _yy + _i * _spacing, text[_i]);	
}
draw_set_halign(fa_left);

display_set_gui_size(320, 180);
