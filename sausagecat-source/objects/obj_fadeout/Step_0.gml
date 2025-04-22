stand_time -= 1 / 60;

if (stand_time <= 0) {
	rad += incr_spd;
	if (rad >= 200)
	{
		instance_destroy();	
	}
}