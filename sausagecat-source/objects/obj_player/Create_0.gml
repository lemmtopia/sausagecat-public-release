// Horizontal and vertical velocity
hsp = 0;
vsp = 0;

// my segment array
segs_x = [x];
segs_y = [y];

// angle of the segments
angs = [0];

// Useful variables
start_angle = 0;

head_angle = 0;
size = 0;

delta = 0;

grow_index = [];

// prevent getting stuck
last_tile_x = 0;
last_tile_y = 0;

move_delay = 0;

moved_time = 0;
max_moved_time = 5;

// blink
blink_frame = 0;
time_blink = 0;
max_time_blink = 2;

// Tilemap layer
tilemap = layer_tilemap_get_id("Tiles");

// Start by setting a tile at my position
tilemap_set_at_pixel(tilemap, 2, x, y);
global.total_tiles--;

milk = false;
scale = 1;

// Number of undos that I can make
n_undos = array_length(segs_x);

// Undo function
function go_back() {	
	if (moved_time > 0) return;
	
	// Only undo if we have undos left
	if (n_undos > 1) {
		// Pop
		array_pop(segs_x);
		array_pop(segs_y);
		
		// Pop again and get the results
		var _x = array_pop(segs_x);
		var _y = array_pop(segs_y);
	
		// Reset the tile
		tilemap_set_at_pixel(tilemap, 0, x, y);
	
		// Set my position
		x = _x;
		y = _y;		
		
		// Push my new position
		array_push(segs_x, x);
		array_push(segs_y, y);
		
		// Make the angle of my head the popped angle
		head_angle = array_pop(angs);
		
		// Reset the tile in my old position
		tilemap_set_at_pixel(tilemap, 0, x, y);
		
		// Decrease values
		global.cur_tiles--;
		size--;
		n_undos--;
	}	
}

max_move_delay = 8;