/// @description Medpack charge
if global.medcharge < 7 {
	global.medcharge += 1;
	alarm[2] = room_speed * 15;
}
