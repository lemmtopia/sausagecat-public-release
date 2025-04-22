// Check if the game is paused or we have a popup on screen
if (global.paused || instance_exists(obj_popup)) {
	// Do not execute
	exit;	
}

// Checking if we are not the selected cat
if (obj_level.selected_cat != id) {
	// Become half visible
	image_alpha = 0.5;
	
	// Do not execute anything more
	exit;
}

// Set my alpha to full visible
image_alpha = 1;

// Get the input axis X and Y
var _dx = 0;
var _dy = 0;

if (global.right && !global.left) {
	_dx = 1;
} else if (global.left && !global.right) {
	_dx = -1;
}

if (global.down && !global.up) {
	_dy = 1;
} else if (global.up && !global.down) {
	_dy = -1;
}

// Prevent diagonal movement
if (_dx != 0) _dy = 0;

// Make my direction variable
var _dir = point_direction(0, 0, _dx, _dy);

// Make it snap to 0, 90, 180 and 270
_dir = floor(_dir / 90) * 90;

// Variables for my position snapped to 16
var _xx = floor(x / 16) * 16;
var _yy = floor(y / 16) * 16;

// Variable for checking if my next position is blocked
var _col = tilemap_get_at_pixel(tilemap, _xx + _dx * 16, _yy + _dy * 16) && (_xx div 16 != last_tile_x || _yy div 16 != last_tile_y);

// Variable for checking if we are in the grid
var _in_grid = (x mod 16 == 8) && (y mod 16 == 8);
var _segment_in_grid = segs_x[size] mod 16 == 8 && segs_y[size] mod 16 == 8;

// Checking if we are inside the grid
move_delay--;
if (_segment_in_grid && move_delay <= 0) {
	// Check if we have milk or we collide with a wall
	if (_col || milk) {
		// Stop
		hsp = 0;
		vsp = 0;
		
		if (_dx != 0 || _dy != 0) {
			if (global.sfx && !milk) {
				audio_play_sound(snd_block, 0, 0, 1, 0, random_range(0.9, 1.1));
			}	
		}
		
		segs_x[size] = x;
		segs_y[size] = y;
	} else {
		// Check if our last segment is inside the grid
		if (_segment_in_grid) {
			var _pog = false;
			
			// Checking if the X axis or the Y axis is different than 0
			if (_dx != 0 || _dy != 0) {
				// Grow
				array_push(grow_index, array_length(segs_x) - 1);
				
				// Shrink our scale to make a good game feel
				scale = 0.9;
				
				// Instance collision variables
				var _box = instance_place(x + _dx * 16, y + _dy * 16, obj_box);
				var _box2 = instance_place(x + _dx, y + _dy, obj_box);
				var _box_target = instance_place(x + _dx, y + _dy, obj_box_target);
				var _box_os = instance_place(x + _dx, y + _dy, obj_box_oneside);
				var _ow = instance_place(x + _dx * 16, y + _dy * 16, obj_blocker);
				var _icon = instance_place(x + _dx, y + _dy, obj_level_icon);
				
				// Checking if we collide with a box that is not in a target
				if (_box && !_box.intarget) {	
					// Executing the following code as the box instance					
					// Checking if we have a tile in our next position
					if (tilemap_get_at_pixel(tilemap, _box.x + _dx * 16, _box.y + _dy * 16)) {
						_pog = true;
						//tilemap_set_at_pixel(tilemap, 3, x, y);
					}
						
					// Checking if we have a box in our next position
					if (place_meeting(_box.x + _dx * 16, _box.y + _dy * 16, obj_box)) _pog = true;
					
					if (!_pog) {
						// Make the box move
						_box.hsp = lengthdir_x(2, _dir);
						_box.vsp = lengthdir_y(2, _dir);
						
						// Push to the states array of the box its position
						array_push(_box.states, {xx: _box.x, yy: _box.y});
						
						_box.last_hsp = _box.hsp;
						_box.last_vsp = _box.vsp;
					}
				}
				
				// Checking if we collide with the box target object
				if (_box_target) {
					_pog = true;	
				}
				
				// Checking if we collide with the level icon in the hub
				if (_icon) {
					// Checking if it is locked
					if (_icon.level_num > global.n_unlocked_levels) _pog = true;
				}
				
				// Checking the one way blocker
				if (_ow) {
					if (_dir == _ow.block) _pog = true;
				}
				
				// If we aren't pog
				if (!_pog)
				{
					// Move code	
					n_undos++;
					array_push(segs_x, x);
					array_push(segs_y, y);
					array_push(angs, head_angle);
					
					last_tile_x = x;
					last_tile_y = y;
		
					tilemap_set_at_pixel(tilemap, 3, x, y);
					size++;
	
					head_angle = point_direction(0, 0, _dx, _dy);
					if (array_length(segs_x) == 2)
					{
						start_angle = point_direction(0, 0, _dx, _dy);
					}
				
					var _inbox = place_meeting(x, y, obj_box);
					
					if (!_inbox) {
						global.cur_tiles++;
					}
					
					if (instance_exists(obj_box)) {
						for (var _i = 0; _i < instance_number(obj_box); _i++) {
							var _box2 = instance_find(obj_box, _i);
							array_push(_box2.states, {xx: _box2.x, yy: _box2.y});
						}
					}
				}
			}
		
		
			// Move code if we aren't pog
			if (!_pog) {
				x += 16 * _dx;
				y += 16 * _dy;
				
				hsp = _dx * 2;
				vsp = _dy * 2;
								
				if (hsp != 0 || vsp != 0) {
					blink_frame = 0;
					time_blink = 0;

					if (global.sfx) {
						audio_play_sound(snd_move, 0, 0, 1, 0, random_range(0.8, 1.2));
					}
					
					move_delay = max_move_delay;
					moved_time = max_moved_time;
				}
			}
		}
	}
}

time_blink += 1 / 60;
if (time_blink >= max_time_blink) {
	blink_frame += 0.1;
	
	if (blink_frame > sprite_get_number(spr_player_head)) blink_frame = 0;
	
	//show_debug_message(blink_frame);
}

moved_time--;

// Moving the last segment position 
segs_x[array_length(segs_x) - 1] += hsp;
segs_y[array_length(segs_y) - 1] += vsp;