tilemap = layer_tilemap_get_id("Tiles");

tile_brush = 2;

enum PLACE_OBJ_ID {
	CAT,
	MILKPOT,
	BOX,
	BLOCKER,
	N_OBJ_IDS
}

place_obj_id = 0;

function reset_and_place(_xx, _yy, _obj) {
	// reset level
	instance_destroy(obj_level);
		
	var _l = instance_create_depth(0, 0, 0, obj_level);
	instance_create_depth(_xx, _yy, 0, _obj);	
	_l.start();
}

function place_tile() {
	var _xx = floor(mouse_x / 16);
	var _yy = floor(mouse_y / 16);
	
	tilemap_set(tilemap, tile_brush, _xx, _yy);
	
	if (instance_exists(obj_level)) {
		obj_level.start();	
	}
}