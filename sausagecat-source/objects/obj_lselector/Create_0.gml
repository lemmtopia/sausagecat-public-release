var _lvls = [
	rm_01a,
	rm_02a,
	rm_03a,
	rm_04a,
	rm_05a,
	rm_06a,
	rm_07a,
	rm_08a,
	rm_09a,
	rm_10a,
	rm_11a,
	rm_12a,
	rm_13a,
	rm_14a,
	rm_15a,
	rm_16a,
	rm_17a,
	rm_18a,
	rm_19a,
	rm_10a,
	rm_21a,
	rm_22a,
	rm_23a,
	rm_24a,
	rm_25a,
	rm_26a,
	rm_27a,
	rm_28a,
	rm_29a,
	rm_30a
];

var _xx = -32;
var _yy = 0;

for (var _i = 0; _i < array_length(_lvls); _i++) {
	var _lvl = _lvls[_i];
	
	_xx += 32;
	if (_i mod 5 == 0 && _i > 0) {
		_yy += 32;
		_xx = 0;
	}
	
	var _inst = instance_create_depth(_xx, _yy, 0, obj_level_button);
	_inst.level_id = _lvl;
}