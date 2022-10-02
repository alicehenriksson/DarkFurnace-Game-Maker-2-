/// @description 
event_inherited();
if chestopen == true and runonce == true {
	runonce = false;
	image_index = 1;
	//Items here:
	global.gears += 1;
	reset_text();
	global.textalert = "You found 2 gears!";
	o_game.alarm[1] = room_speed *1.5;
	audio_play_sound(a_chestopen,1,0);
}