/// @description Game Step Events

//Node Regen
noderegen();

#region Toxicshit
//Set oxygencaps for all rooms
switch(room) {
    case r_base:
		oxygencap = 10;
    break;
    case r_1a:
		oxygencap = 80;
    break;
    case r_1b:
		oxygencap = 20;
    break;
	case r_1c:
		oxygencap = 20;
    break;
	case r_2b:
		oxygencap = 100;
    break;
	case r_3a:
		oxygencap = 140;
    break;
	case r_3b:
		oxygencap = 120;
    break;
	case r_4a:
		oxygencap = 150;
    break;
	case r_4c:
		oxygencap = 200;
    break;
	case r_5a:
		oxygencap = 150;
    break;
	case r_5b:
		oxygencap = 180;
    break;
	case r_5c:
		oxygencap = 180;
    break;
}
//Change toxic to true if conditions met, -> do damage
if global.oxygenlevel <= oxygencap {
	if !audio_is_playing(a_gas) {
		audio_play_sound(a_gas,10,1);
	}
	toxictimer += 1;
	if global.gasmask == true {
		var _timer = 180;
	} else {
		var _timer = 60;
	}
	if toxictimer mod(_timer) = 0 {
		health -= round(toxictimer/_timer)
		audio_play_sound(a_hurt,1,0);
	}
	if gas == false {
		instance_create_layer(0,0,"Instances",o_toxicgas);
		gas = true;
	}
	if gas == true and !instance_exists(o_toxicgas) {
		instance_create_layer(0,0,"Instances",o_toxicgas)
	}
} else {
	audio_stop_sound(a_gas);
	toxictimer = 0;
	gas = false;
}
#endregion

//if keyboard_check_pressed(ord("P")) {
//	game_restart();
//}

//medpack
if global.medcharge >= 7 {
	if room == r_base {
		o_medpack.usable = true;
	}
}
//Oxygen Alert stuff

//alert if oxygen levels critical
var _0 = oxygencap + 5;
if global.oxygenlevel <= _0 and global.oxygenlevel > oxygencap and criticalalert == false {
	global.textalert = "Oxygen level close to critical!"
	global.texthold = true;
	alarm[1] = room_speed * 3;
	criticalalert = true;
	audio_play_sound(a_alarm,1,1);
}
if global.oxygenlevel <= oxygencap {
	audio_stop_sound(a_alarm);
}
//resetalert
if global.oxygenlevel > _0 {
	criticalalert = false;
	audio_stop_sound(a_alarm);
}
if room != r_startscreen or room != r_controls {
	audio_stop_sound(a_start)
	if !audio_is_playing(a_ambience) {
		audio_play_sound(a_ambience,1,1);
	}
	if !audio_is_playing(a_background) {
		audio_play_sound(a_background,2,1);
	}
}

//Update health
if global.hardhat == true and healthbarswitch == 0 {
	healthbarswitch = 1;
	if health == o_player.maxhealth {
		health = 10;
	}
	o_player.maxhealth = 10;
	healthbar = s_healthbarhh;
}

//Biggerbag upgrade and item full texts:
if global.biggerbag == false {
	global.coal = clamp(global.coal,0,24);
	global.iron = clamp(global.iron,0,9);	
} else if global.biggerbag == true {
	global.coal = clamp(global.coal,0,48);
	global.iron = clamp(global.iron,0,32);	
}






