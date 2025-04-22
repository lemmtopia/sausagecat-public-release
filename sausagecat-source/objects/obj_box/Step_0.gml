x += hsp;
y += vsp;

var _target = instance_place(x, y, obj_box_target);
if (x mod 16 == 8 && y mod 16 == 8) {	
	if (_target) {
		global.cur_tiles++;
		instance_destroy(_target);
		
		sprite_index = spr_box_inplace;
		scale = 1.2;
		
		intarget = true;
		
		for (var _i = 0; _i < instance_number(obj_box); _i++) {
			var _b = instance_find(obj_box, _i);
			while (array_length(_b.states) > 0) {
				array_pop(_b.states);
			}
		}

		for (var _i = 0; _i < instance_number(obj_player); _i++) {
			var _p = instance_find(obj_player, _i);
			_p.n_undos = 1;
		}
	}
	
	hsp = 0;
	vsp = 0;
}

lastx = x;
lasty = y;
