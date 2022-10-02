// @description Everything related to global node regen

//Set variables per room
function nodevar(){
	global.n_r1a = 0;
	global.n_r1b = 0;
	global.n_r1c = 0;
	global.n_r2b = 0;
	global.n_r3a = 0;
	global.n_r3b = 0;
	global.n_r4a = 0;
	global.n_r4c = 0;
	global.n_r5a = 0;
	global.n_r5b = 0;
	global.n_r5c = 0;
	
	global.n_timer = room_speed*6*30; //max timer value: frames*levels*seconds
}
//Regen "timers" per room, better way to do this?
function noderegen() {
	if room!=r_1a{
		global.n_r1a += 1;
		global.n_r1a = clamp(global.n_r1a,0,global.n_timer);
	} else {
		global.n_r1a = 0;
	}
	if room!=r_1b{
		global.n_r1b += 1;
		global.n_r1b = clamp(global.n_r1b,0,global.n_timer);
	} else {
		global.n_r1b = 0;
	}
	if room!=r_1c{
		global.n_r1c += 1;
		global.n_r1c = clamp(global.n_r1c,0,global.n_timer);
	} else {
		global.n_r1c = 0;
	}
	if room!=r_2b{
		global.n_r2b += 1;
		global.n_r2b = clamp(global.n_r2b,0,global.n_timer);
	} else {
		global.n_r2b = 0;
	}
	if room!=r_3a{
		global.n_r3a += 1;
		global.n_r3a = clamp(global.n_r3a,0,global.n_timer);
	} else {
		global.n_r3a = 0;
	}
	if room!=r_3b{
		global.n_r3b += 1;
		global.n_r3b = clamp(global.n_r3b,0,global.n_timer);
	} else {
		global.n_r3b = 0;
	}
	if room!=r_4a{
		global.n_r4a += 1;
		global.n_r4a = clamp(global.n_r4a,0,global.n_timer);
	} else {
		global.n_r4a = 0;
	}
	if room!=r_4c{
		global.n_r4c += 1;
		global.n_r4c = clamp(global.n_r4c,0,global.n_timer);
	} else {
		global.n_r4c = 0;
	}
	if room!=r_5a{
		global.n_r5a += 1;
		global.n_r5a = clamp(global.n_r5a,0,global.n_timer);
	} else {
		global.n_r5a = 0;
	}
	if room!=r_5b{
		global.n_r5b += 1;
		global.n_r5b = clamp(global.n_r5b,0,global.n_timer);
	} else {
		global.n_r5b = 0;
	}
	if room!=r_5c{
		global.n_r5c += 1;
		global.n_r5c = clamp(global.n_r5c,0,global.n_timer);
	} else {
		global.n_r5c = 0;
	}
}
//Update node on room enter with timer value
function nodecheck() {

	var _temp = 0;
	switch(room) {
		case r_1a:
			_temp = global.n_r1a;
		break;
		case r_1b:
			_temp = global.n_r1b;
		break;
		case r_1c:
			_temp = global.n_r1c;
		break;
		case r_2b:
			_temp = global.n_r2b;
		break;
		case r_3a:
			_temp = global.n_r3a;
		break;
		case r_3b:
			_temp = global.n_r3b;
		break;
		case r_4a:
			_temp = global.n_r4a;
		break;
		case r_4c:
			_temp = global.n_r4c;
		break;
		case r_5a:
			_temp = global.n_r5a;
		break;
		case r_5b:
			_temp = global.n_r5b;
		break;
		case r_5c:
			_temp = global.n_r5c;
		break;
	}
	if _temp > 0 and charge < 6 {
		//Add to the charge current rooms counter value / ( 60*20 )
		charge += round(_temp/(room_speed*20)); 
		charge = clamp(charge,0,6);
	}
}