stand_time -= 1 / 60;

if (stand_time <= 0) {
	rad -= decr_spd;
	if (rad <= 0)
	{
		instance_destroy();	
	}
}