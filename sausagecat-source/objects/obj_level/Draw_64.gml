if (room == rm_hub) exit;

display_set_gui_size(window_get_width(), window_get_height());
draw_set_color(c_white);

if (window_get_width() < 1280) {
	draw_set_font(fnt_game2);
} else {
	draw_set_font(fnt_game);
}


draw_set_halign(fa_center);
scr_draw_text_shaded(window_get_width() / 2, 2, "Level " + string(global.cur_level_index));
draw_set_halign(fa_right);
draw_set_color(c_black);
draw_text(window_get_width() - 10, 4, "Tiles to fill: " + string(global.total_tiles - global.cur_tiles));
draw_set_color(c_white);
draw_text(window_get_width() - 10, 0, "Tiles to fill: " + string(global.total_tiles - global.cur_tiles));
draw_set_halign(fa_left);

display_set_gui_size(320, 180);