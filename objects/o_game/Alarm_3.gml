/// @description Typewriter effect
global.typewriter_out += string_char_at(global.text, global.tw);							//add new character to string
global.tw += 1;
//Audio
if global.tw mod(5) == 0 {	//Sound speed 
	audio_play_sound(a_typewriter,3,0);
}
if ((global.tw - 1) != string_length(global.text)) and global.inputcooldown == true {		//if not end of text
	alarm[3] = 1.8 //Typespeed																			//restart alarm
}