window_set_size(1280, 720);
window_center();
display_set_gui_size(window_get_width(), window_get_height());

surface_resize(application_surface, 320, 180);

window_set_cursor(cr_none);

padx = 70;
pady = 20;
btn_padding = 3;
height = 48;

global.starting_level = rm_hub;
global.cur_level_index = 1;
global.debug = false;

// Sound stuff
global.music = true;
global.sfx = true;

global.is_steamed = true;

global.n_unlocked_levels = 1;

global.fname = "save.sav";

menu_options = [];

last_mx = mouse_x;
last_my = mouse_y;

paw_rate = 60 * 3;
paw_delay = 60;

time = 0;

function clear_menu() 
{
	while (array_length(obj_manager.menu_options) > 0)
	{
		array_pop(obj_manager.menu_options);	
	}
}

function add_option(_text, _func) 
{
	var _h = 36;
	var _width = string_length(_text) * _h;
	array_push(obj_manager.menu_options, { text: _text, xx: 0, yy: 0, width: _width, height: _h, func: _func });
}

function you_sure() 
{
	clear_menu();
	cur_option = 0;
	add_option(scr_get_text(GAME_TEXT.REALLY), game_end);
	add_option(scr_get_text(GAME_TEXT.NEVERMIND), main_menu);
}

function you_sure2() 
{
	clear_menu();
	cur_option = 0;
	add_option(scr_get_text(GAME_TEXT.REALLY), function() {
		scr_save(global.fname);
		game_restart();
	});
	add_option(scr_get_text(GAME_TEXT.NEVERMIND), main_menu);
}

function settings() 
{
	clear_menu();
	cur_option = 0;
	
	if (!window_get_fullscreen())
	{
		add_option("Fullscreen Off", change_fs);
	}
	else
	{
		add_option("Fullscreen On", change_fs);
	}
	
	// Music
	if (global.music) {
		add_option("Music On", function() {
			global.music = false;
			scr_save(global.fname);
			settings();
		});	
	} else {
		add_option("Music Off", function() {
			global.music = true;
			scr_save(global.fname);
			settings();
		});
	}
	
	/// Sounds
	if (global.sfx) {
		add_option("SFX On", function() {
			global.sfx = !global.sfx;
			scr_save(global.fname);
			settings();
		});
	} else {
		add_option("SFX Off", function() {
			global.sfx = !global.sfx;
			scr_save(global.fname);
			settings();
		});	
	}
	
	add_option(scr_get_text(GAME_TEXT.BACK), function() {
		if (room != rm_menu)
		{
			ingame_menu();
		}	
		else
		{
			main_menu();
		}
	});
}

function change_fs() 
{	
	window_set_fullscreen(!window_get_fullscreen());
	
	if (!window_get_fullscreen()) {
		window_set_size(1280, 720);
		window_center();	
	}
	
	scr_save(global.fname);
	settings();	
}

function blank_func() {}

function credits() 
{
	clear_menu();
	cur_option = 0;
	
	// Make the credits text
	instance_create_depth(x, y, 0, obj_credits);
	
	add_option(scr_get_text(GAME_TEXT.BACK), function() {
		instance_destroy(obj_credits);
		
		if (room != rm_menu)
		{
			ingame_menu();
		}	
		else
		{
			main_menu();
		}
	});
}

function main_menu() 
{
	clear_menu();
	cur_option = 0;
	
	add_option(scr_get_text(GAME_TEXT.START), function() 
	{
		if (!instance_exists(obj_fadein2)) instance_create_depth(0, 0, 0, obj_fadein2);
	});
	
	
	if (global.debug)
	{
		add_option("Level Editor", function()
		{
			room_goto(rm_leveled);	
		});
	}

	add_option(scr_get_text(GAME_TEXT.SETTINGS), settings);
	
	add_option(scr_get_text(GAME_TEXT.CREDITS), credits);
	
	add_option(scr_get_text(GAME_TEXT.QUIT), you_sure);
}

function ingame_menu() 
{
	clear_menu();
	cur_option = 0;
	
	add_option(scr_get_text(GAME_TEXT.BACK), function() 
	{
		global.paused = false;
	});

	/*
	if (room != rm_hub) {
		add_option("Go to map", function() {
			room_goto(rm_hub);
			global.paused = false;
		});	
	}
	*/

	add_option(scr_get_text(GAME_TEXT.SETTINGS), settings);
	
	add_option(scr_get_text(GAME_TEXT.MAINMENU), you_sure2);

	add_option(scr_get_text(GAME_TEXT.QUIT), you_sure);
}

main_menu();

cur_option = 0;

text_col = 255;

global.left = 0;
global.right = 0;
global.up = 0;
global.down = 0;

global.undo = 0;
global.change = 0;
global.confirm = 0;
global.restart = 0;
global.pause = 0;

enum CONTROLLER_TYPES  {
	KEYBOARD,
	GAMEPAD
}

global.controller = CONTROLLER_TYPES.KEYBOARD;
global.pad_index = 0;

global.paused = false;

global.tilemap = layer_tilemap_get_id("Tiles");

function load_tilemap(_fname)
{
	if (file_exists(_fname))
	{
		var _buff = buffer_create(2 * 12, buffer_fixed, 1);
		_buff = buffer_load("hello.kitten");
		var _j = 0;
	
		repeat (12)
		{
			var _b = buffer_read(_buff, buffer_u16);
		
			tilemap_set(global.tilemap, 1, 0, _j);
			tilemap_set(global.tilemap, 1, 1, _j);
			tilemap_set(global.tilemap, 1, 2 + 16, _j);
			tilemap_set(global.tilemap, 1, 2 + 16 + 1, _j);
		
			for (var _i = 0; _i < 16; _i++)
			{
				var _tileval = (_b >> _i) & 1;
				tilemap_set(global.tilemap, _tileval, _i + 2, _j);
			}
		
			tilemap_set(global.tilemap, 1, 2 + 16 - 1, _j);
		
			_j++;
		}
	}
}

if (file_exists(global.fname)) scr_load(global.fname);

/*
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
	rm_30a,
	rm_thanks
];

global.starting_level = _lvls[global.n_unlocked_levels - 1];
global.cur_level_index = global.n_unlocked_levels;

if (global.starting_level == rm_thanks) {
	global.starting_level = rm_01a;
	global.cur_level_index = 1;
	global.n_unlocked_levels = 1;
}
*/