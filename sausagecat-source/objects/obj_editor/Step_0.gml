if (!edit && keyboard_check_pressed(vk_anykey))
{
	var _c = keyboard_lastchar;
	var _k = keyboard_lastkey;
	
	if (_k == vk_backspace) fn = string_copy(fn, 0, string_length(fn) - 1);
	
	if (_k != vk_enter)
	{
		if (_c >= "a" && _c <= "z") fn += _c;
	}
	else
	{
		fn += ".kitten";
		edit = true;
	}
}