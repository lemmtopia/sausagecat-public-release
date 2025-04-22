w = 16;
h = 12;

bytesrow = 2;

buff = buffer_create(bytesrow * h, buffer_fixed, 1);

var _xx = 0;
var _yy = 0;

var _byte = 0;

for (var _i = 0;  _i < w * h; _i++)
{
	var _tile = tilemap_get(obj_level.tilemap, _xx + 2, _yy) == 1;
	
	_byte += _tile << _xx;
	
	_xx++;
	if (_xx >= w - 1) { 
		_xx = 0;

		buffer_write(buff, buffer_u16, _byte);
		
		_byte = 0; 
		_yy++ 
	}
}

buffer_save(buff, "hello.kitten");