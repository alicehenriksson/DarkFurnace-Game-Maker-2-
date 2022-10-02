/// @description Oxygen depletion + Random noises
global.oxygenlevel -= 1;
alarm[0] = room_speed * 15;


//Play random noises
var _i = irandom_range(0,10);
if _i == 1 {
	var _is = irandom_range(0,2);
	if _is == 0 { audio_play_sound(a_noise1,1,0); }
	if _is == 1 { audio_play_sound(a_noise2,1,0); }
	if _is == 2 { audio_play_sound(a_noise3,1,0); }
}