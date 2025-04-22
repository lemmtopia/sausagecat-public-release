x += hsp;
y += vsp;

if (x mod 16 == 8 && y mod 16 == 8)
{
	if (place_meeting(x, y, obj_box_target))
	{
		global.cur_tiles++;
		instance_destroy();
	}
	
	hsp = 0;
	vsp = 0;
}

image_angle = angle;