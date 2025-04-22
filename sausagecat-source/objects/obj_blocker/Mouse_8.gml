if (room == rm_leveled) {
	image_angle += 90;
	block += 90;
	
	// safeguards
	if (block < 0) block *= -1;
	if (block >= 360) block -= 360;
	
	show_debug_message(block);
}