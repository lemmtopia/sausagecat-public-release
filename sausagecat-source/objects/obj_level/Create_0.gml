// undo
undo_delay = 0;
max_undo_delay = 3; // 5% of 1 second

function start() {
	tilemap = layer_tilemap_get_id("Tiles");
	global.total_tiles = 0;

	for (var _i = 0; _i < 320 / 16; _i++)
	{
		for (var _j = 0; _j < 160 / 16; _j++)
		{
			if (tilemap_get(tilemap, _i, _j) == 0)
			{
				global.total_tiles++;
			}
		}
	}
	
	global.total_tiles -= instance_number(obj_box);

	global.cur_tiles = 0;

	if (!instance_exists(obj_player)) exit;

	cats = [];

	for (var _i = 0; _i < instance_number(obj_player); _i++)
	{
		array_push(cats, instance_find(obj_player, _i));
	}

	cur_cat = 0;
	selected_cat = cats[cur_cat];
	
	instance_create_layer(x, y, "Instances", obj_fadeout);

	next_level_time = 0;
	completed = false;

	bg_x = 0;
	bg_y = 0;	
}


function handle_next_level() {
	if (room == room_last) {
		room_goto(rm_menu);
	} else {
		room_goto_next();	
	}
}

start();

switch (room) {
	case rm_11a:
		// achievement code
		break;
	case rm_16a:
		// achievement code
		break;	
	case rm_26a:
		// achievement code
		break;
}