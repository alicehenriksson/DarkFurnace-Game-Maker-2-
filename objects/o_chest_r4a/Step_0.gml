/// @description 
event_inherited();
if chestopen == true and runonce == true {
	runonce = false;
	image_index = 1;
	//Items here:
	global.iron += 3;
	reset_text();
	global.textalert = "You found 3 iron!";
	o_game.alarm[1] = room_speed *1.5;
	audio_play_sound(a_chestopen,1,0);
}