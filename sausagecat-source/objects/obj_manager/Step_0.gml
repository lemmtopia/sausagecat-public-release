if (!global.music) {
	// Stop the music
	if (audio_is_playing(snd_music)) {
		audio_stop_sound(snd_music);	
	}
} else {
	// Play the music
	if (!audio_is_playing(snd_music) && room != rm_menu) {
		audio_play_sound(snd_music, 1, true);
	}
	
	if (room == rm_menu) {
		audio_stop_sound(snd_music);		
	}
}	

// Input
// Check if we have a controller
if (global.controller != CONTROLLER_TYPES.GAMEPAD) {
	for (var _i = 0; _i < gamepad_get_device_count(); _i++) {
		if (gamepad_is_connected(_i)) {
			global.pad_index = _i;
			break;
		}
	}
	
	var _btn = [
		gp_face1,
		gp_face2,
		gp_face3,
		gp_face4,
		gp_start,
		gp_select,
		gp_padl,
		gp_padr,
		gp_padu,
		gp_padd,
	];
	
	for (var _i = 0; _i < array_length(_btn); _i++) {
		if (gamepad_button_check(global.pad_index, _btn[_i])) {
			global.controller = CONTROLLER_TYPES.GAMEPAD;	
		}
	}
} else if (global.controller != CONTROLLER_TYPES.KEYBOARD) {
	if (keyboard_check(vk_anykey)) {
		global.controller = CONTROLLER_TYPES.KEYBOARD;
	}
}

if (global.controller == CONTROLLER_TYPES.KEYBOARD) {
	global.left = keyboard_check_pressed(vk_left);
	global.right = keyboard_check_pressed(vk_right);
	global.up = keyboard_check_pressed(vk_up);
	global.down = keyboard_check_pressed(vk_down);

	global.undo = keyboard_check_pressed(vk_backspace);
	global.change = keyboard_check_pressed(ord("X"));
	global.confirm = keyboard_check_pressed(vk_enter);
	global.pause = keyboard_check_pressed(vk_escape);
	global.restart = keyboard_check_pressed(ord("R"));	
} else {
	global.left = gamepad_button_check_pressed(global.pad_index, gp_padl);
	global.right = gamepad_button_check_pressed(global.pad_index, gp_padr);
	global.up = gamepad_button_check_pressed(global.pad_index, gp_padu);
	global.down = gamepad_button_check_pressed(global.pad_index, gp_padd);
	
	global.undo = gamepad_button_check_pressed(global.pad_index, gp_face2);
	global.change = gamepad_button_check_pressed(global.pad_index, gp_face3);
	global.confirm = gamepad_button_check_pressed(global.pad_index, gp_face1);
	global.pause = gamepad_button_check_pressed(global.pad_index, gp_start);
	global.restart = gamepad_button_check_pressed(global.pad_index, gp_face4);
}

if ((global.paused || room == rm_menu) && !instance_exists(obj_fadein2)) {
	if (global.up || global.down) {
		var _dir = global.down - global.up;
		var _new_option = cur_option + _dir;
		var _can_move = (_new_option >= 0 && _new_option <= array_length(menu_options) - 1);
		if (global.sfx && _can_move) {
			audio_play_sound(snd_menu_select, 0, 0);	
		}
	}
}

if (!instance_exists(obj_fadein2)) {
	cur_option += global.down - global.up;
}
cur_option = clamp(cur_option, 0, array_length(menu_options) - 1);

var _scale = window_get_width() / 320;

if ((array_length(menu_options) > 0 && (global.paused == true || room == rm_menu)) && !instance_exists(obj_fadein2)) {
	for (var _i = 0; _i < array_length(menu_options); _i++) {
		var _opt = menu_options[_i];
		if (point_in_rectangle(mouse_x * _scale, mouse_y * _scale, _opt.xx - _opt.width / 2, _opt.yy, _opt.xx + _opt.width / 2, _opt.yy + _opt.height)) {
			if (last_my != mouse_y || last_mx != mouse_x) {
				if (cur_option != _i && global.sfx) audio_play_sound(snd_menu_select, 0, 0);
				
				cur_option = _i;
			}
			
			if (mouse_check_button_pressed(mb_left)) {
				menu_options[cur_option].func();
				
				if (global.sfx) {
					audio_play_sound(snd_menu_confirm, 0, 0);
				}
			}
		}
	}
}


if (global.confirm && array_length(menu_options) > 0 && (global.paused || room == rm_menu))
{
	menu_options[cur_option].func();
	audio_play_sound(snd_menu_confirm, 0, 0);
}

if (room != rm_menu && room != rm_editor0)
{
	if (global.restart && !global.paused) 
	{
		room_restart();
	}	
}

if (room == rm_menu) {
	paw_delay--;
	if (paw_delay <= 0) {
		var _trail = instance_create_layer(choose(0, 320), random(180), "Instances", obj_paw_trail);
		paw_delay = paw_rate;
		
		if (_trail.x >= 320) {
			_trail.ang = choose(160, -160);
		} else {
			_trail.ang = choose(80, -80);	
		}
	}
}

if (room == rm_thanks && global.confirm) game_restart();

last_mx = mouse_x;
last_my = mouse_y;

time += 1 / 60;