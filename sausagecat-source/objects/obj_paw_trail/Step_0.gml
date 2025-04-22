time += 1 / 60;
ang -= sin(time) * angspd;


// move
x += lengthdir_x(spd, ang);
y += lengthdir_y(spd, ang);