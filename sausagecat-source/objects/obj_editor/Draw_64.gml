display_set_gui_size(window_get_width(), window_get_height());

draw_set_color(c_gray);
draw_rectangle(0, 0, window_get_width(), font_get_size(fnt_game) * 1.2, false);
draw_set_color(c_black);
draw_text(0, 0, fn);

display_set_gui_size(320, 180);