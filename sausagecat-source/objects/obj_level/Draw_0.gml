depth = 100;

if (!global.debug) {
	if (global.cur_level_index < 11 && room != rm_10a) {
		draw_sprite_tiled(spr_bg, 0, bg_x, bg_y);
	} else if (global.cur_level_index < 16 && room != rm_15a) {
		draw_sprite_tiled(spr_bg_1, 0, bg_x, bg_y);
	} else if (global.cur_level_index < 26 && room != rm_25a) {
		draw_sprite_tiled(spr_bg_2, 0, bg_x, bg_y);
	} else {
		draw_sprite_tiled(spr_bg_1, 0, bg_x, bg_y);
	}
	layer_set_visible("Tiles", false);
	layer_set_visible("Tiles_1", true);
}