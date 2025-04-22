display_set_gui_size(window_get_width(), window_get_height());

draw_set_font(fnt_game_default);

//draw tile brush
if (tile_brush == 0) scr_draw_text_shaded(0, 0, "Eraser");
else scr_draw_text_shaded(0, 0, "Brush");

// Getting the scale
var _scale = window_get_width() / 320;

// Drawing the cursor
draw_sprite(spr_cursor, 0, mouse_x * _scale, mouse_y * _scale);
	
display_set_gui_size(320, 180);

draw_set_color(c_blue);
draw_rectangle(320 - 32, 32, 320, 64, false);

// drawing icons
var _icons = [
	spr_player,
	spr_milk,
	spr_box,
	spr_blocker
];

var _offsetx = sprite_get_xoffset(_icons[place_obj_id]);
var _offsety = sprite_get_yoffset(_icons[place_obj_id]);
draw_sprite(_icons[place_obj_id], 0, 320 - 32 + _offsetx, 32 + _offsety);

draw_set_color(c_white);