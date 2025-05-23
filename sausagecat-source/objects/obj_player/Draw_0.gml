depth = -100;

for (var _j = 0; _j < array_length(grow_index); _j++) {
	grow_index[_j] -= 0.2;
	if (grow_index[_j] <= 0) {
		array_delete(grow_index, _j, 1);
	}
}

var _s = 1;

for (var _i = 1; _i < array_length(segs_x) - 1; _i++)  {	
	var _l = segs_x[_i + 1] - segs_x[_i] < 0;
	var _r = segs_x[_i + 1] - segs_x[_i] > 0;
	var _u = segs_y[_i + 1] - segs_y[_i] < 0;
	var _d = segs_y[_i + 1] - segs_y[_i] > 0;
	
	var _l2 = segs_x[_i - 1] - segs_x[_i] < 0;
	var _r2 = segs_x[_i - 1] - segs_x[_i] > 0;
	var _u2 = segs_y[_i - 1] - segs_y[_i] < 0;
	var _d2 = segs_y[_i - 1] - segs_y[_i] > 0;
		
	var _frame = 0;
	var _xx = 1;
	var _yy = 1;
		
	if (_u) {
		_yy = -1;
		if (_l2) {
			_frame = 5;	
		} else if (_r2) {
			_frame = 5;	
			_xx = -1;
		} else {
			_frame = 4;
		}
	}
		
	if (_d) {
		if (_l2) {
			_frame = 3;	
		} else if (_r2) {
			_frame = 3;	
			_xx = -1;
		} else {
			_frame = 4;
		}
	}
		
	if (_l) {	
		if (_u2) {
			_frame = 5;	
			_yy = -1;
		} else if (_d2) {
			_frame = 3;	
		} else {
			_frame = 2;				
		}
	}
		
	if (_r) {		
		_xx = -1;
		
		if (_u2) {
			_frame = 5;	
			_yy = -1;
		} else if (_d2) {
			_frame = 3;	
		} else {
			_frame = 2;				
		}
	}

	draw_sprite_ext(sprite_index, _frame, segs_x[_i], segs_y[_i], _xx * _s, _yy * _s, 0, c_white, image_alpha);
	
	for (var _j = 0; _j < array_length(grow_index); _j++) {
		if (floor(grow_index[_j]) == _i) {
			draw_sprite_ext(spr_player_ball2, _frame, segs_x[_i], segs_y[_i], _xx * _s, _yy * _s, 0, c_white, image_alpha);
		}
	}
	
	_s = 1;
}

if (array_length(segs_x) > 0) {
	for (var _j = 0; _j < array_length(grow_index); _j++) {
		if (floor(grow_index[_j]) == 0) {
			_s = 1.1;	
		}
	}
	
	draw_sprite_ext(spr_player_tail, 0, segs_x[0], segs_y[0], _s, _s, start_angle, c_white, image_alpha);
	
	_s = 1;
	
	draw_sprite_ext(spr_player_head, blink_frame, segs_x[array_length(segs_x) - 1], segs_y[array_length(segs_y) - 1], scale, scale, head_angle, c_white, image_alpha);
	//draw_sprite_ext(sprite_index, 0, x, y, scale, scale, head_angle, c_white, 1);
} else {
	draw_self();	
}

//if (milk) sprite_index = spr_player_sleepy;

scale = lerp(scale, 1, 0.1);