if (instance_exists(obj_fade)) exit;

if (global.paused) exit;
draw_set_font(fnt_game2);

display_set_gui_size(window_get_width(), window_get_height());

draw_sprite_ext(spr_popup, 0, xx, yy, 1, 1, ang, c_white, 1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_gray);
draw_set_alpha(alpha);
draw_text(xx, yy, text);
draw_set_color(c_white);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

display_set_gui_size(320, 180);