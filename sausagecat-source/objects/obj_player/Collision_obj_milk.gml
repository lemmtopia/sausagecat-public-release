// Setting milk to true to say that I'm done
milk = true;

// Set my last segment position to my position
segs_x[size] = x;
segs_y[size] = y;

hsp = 0;
vsp = 0;

// Destroy the milk
instance_destroy(other);

// Create 5 stars
repeat(5) instance_create_layer(x, y, "Instances", obj_star);

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

if (global.sfx) {
	audio_play_sound(snd_glitter_old, 0, 0, 1, 0, random_range(0.9, 1.1));
}