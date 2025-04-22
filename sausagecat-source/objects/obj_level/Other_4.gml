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

global.cur_tiles = 0;