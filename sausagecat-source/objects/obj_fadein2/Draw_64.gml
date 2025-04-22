display_set_gui_size(320, 180);

depth = -10000;

draw_set_circle_precision(32);

if (!surface_exists(surf)) {
	surf = surface_create(320, 180);	
}

surface_set_target(surf);
draw_set_color(c_black);

draw_clear(col);
gpu_set_blendmode(bm_subtract);
draw_circle(160, 90, rad, false);
gpu_set_blendmode(bm_normal);

draw_set_color(c_white);
surface_reset_target();

draw_surface(surf, 0, 0);

draw_set_circle_precision(24);
