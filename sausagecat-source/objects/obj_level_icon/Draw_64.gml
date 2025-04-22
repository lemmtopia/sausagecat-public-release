if (!place_meeting(x, y, obj_player)) exit;
display_set_gui_size(window_get_width(), window_get_height());

scr_draw_text_shaded(0, 0, "Level " + string(level_num));

display_set_gui_size(320, 180);