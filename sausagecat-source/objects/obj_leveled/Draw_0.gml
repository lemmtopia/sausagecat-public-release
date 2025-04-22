draw_set_alpha(0.5);

var _xx = floor(mouse_x / 16) * 16;
var _yy = floor(mouse_y / 16) * 16;
draw_rectangle(_xx, _yy, _xx + 16, _yy + 16, false);

draw_set_alpha(1);