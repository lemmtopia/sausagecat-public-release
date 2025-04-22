// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_text_shaded(_x, _y, _text)
{
	draw_set_color(c_black);
	draw_text(_x, _y + 2, _text);
	draw_set_color(c_white);
	draw_text(_x, _y, _text);
}