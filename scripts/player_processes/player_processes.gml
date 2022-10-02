#region MOVEMENT

function reset_variables() {
	left	= 0;
	right	= 0;
	up		= 0;
	down	= 0;
	vmove	= 0;
	hmove	= 0;
}
function get_input() {
	if keyboard_check(ord("A")) { left	= 1;}
	if keyboard_check(ord("D")) { right	= 1;}
	if keyboard_check(ord("W")) { up	= 1;}
	if keyboard_check(ord("S")) { down	= 1;}
}
function calc_movement() {
	hmove = right - left;
	vmove = down - up;
	//remove text when moving
	if hmove != 0 { 
		facingside = hmove; 
	}
	if hmove != 0 or vmove != 0 {
		//get direction we are moving
		var _dir = point_direction(0, 0, hmove, vmove);
		//Remove text poppups
		if global.texthold == false {
			reset_text();
		}
		//Reset idle counter
		idle = 0;
		//get distance we are moving
		hmove = lengthdir_x(walk_spd, _dir);
		vmove = lengthdir_y(walk_spd, _dir);
		
		//add movement to players position
		x += hmove;
		y += vmove;
		
		//stepping sound
		stepping += 1;
		if stepping > 10 {
			audio_play_sound(a_walk,1,0);
			stepping = 0;
		} 	
	}	
}
function collision() {
	//set target values
	var _tx = x;
	var _ty = y;
	
	//move back to last step position, out of the collision
	x = xprevious;
	y = yprevious;
	
	//get distance we want to move
	var _disx = abs(_tx - x);
	var _disy = abs(_ty - y);
	
	//move as far as in x and y before hitting the solid
	repeat(_disx) {
		if !place_meeting(x + sign(_tx - x), y, o_solid) x += sign(_tx - x);
	}
	repeat(_disy) {
		if !place_meeting(x, y + sign(_ty - y), o_solid) y += sign(_ty - y);
	}	
}

#endregion

function anim() {
	
	//Change player sprite based on direction
	if hmove != 0 {
		sprite_index = s_player_walkside;
		image_speed = 10;
	} else if sign(vmove) = 1 {
		sprite_index = s_player_walkdown;
		image_speed = 10;
	} else if sign(vmove) = -1 {
		sprite_index = s_player_walkup;
		image_speed = 10;
	} else {
		image_speed = 0;
	}
	if sprite_index = s_player_attack or sprite_index = s_player_attack_back {
		sprite_index = s_player_idle;
	}
	
	if hmove == 0 and vmove == 0 {
		idle += 1;
		if idle > 180 {
			image_speed = 2;
			sprite_index = s_player_idle;
		}
	}
	//play idle animation after 5 seconds of idle -- implement this <---
	
	
}

#region mining

function mine() {
	var _node = instance_nearest(x,y,o_nodeparent);
	if _node.isiron == true and global.improvedpick == false { 
		reset_text();
		global.textalert = "You need to upgrade your pickaxe!";
		o_game.alarm[1] = room_speed * 10;
		exit; 
	}
	//Stop from mining if inventory is full
	var _coallimit = 0;
	var _ironlimit = 0;
	var _space = 0;
	if global.biggerbag == true {
		_coallimit = 48;
		_ironlimit = 32;
	} else {
		_coallimit = 24;
		_ironlimit = 9;
	}
	if _node.isiron == true {
		_space = _ironlimit - global.iron;
	} else {
		_space = _coallimit - global.coal;
	}
	if _space == 0 {
		if global.coal == _coallimit {
			global.textalert = "Cant carry anymore coal!";
			o_game.alarm[1] = room_speed * 2;
		}
		if global.iron == _ironlimit {
			global.textalert = "Cant carry anymore iron!";
			o_game.alarm[1] = room_speed * 2;
		}
	}
	
	if _node.charge > 0 and _space > 0 {
		//Change sprite
		image_speed = 5;
		o_player.sprite_index = s_player_mine;
		if global.texthold == false {
			reset_text();
		}
		//Mining variable used for timer
		mining += 1;
		//Every 20 frames, play sound add chips
		if global.fastermining == true {
			var _speed = 20;
			image_speed = 10;
		} else {
			var _speed = 40;	
		}
		if mining mod(_speed) = 0 {
			audio_play_sound(a_minehit,1,0);
			//chips
			var _temp = 0;
			repeat(8) {
				var _chip = instance_create_layer(_node.x,_node.y+9,"Instances",o_chips);
				_chip.direction = _temp;
				_chip.speed = 0.7;
				_chip.depth = _node.depth-1;
				_temp += 45;
			}
		}
		//After 80 frames give 1 item, damage the node
		if mining >= (4*_speed) {
			with(_node) {
				charge -= 1;
				alarm[0] = room_speed * 60;
			}
			audio_play_sound(a_minebreak,1,0);
			mining = 0;
			if distance_to_object(o_coal) <= range {global.coal +=1;}
			if distance_to_object(o_iron) <= range {global.iron +=1;}
		}
	} else {
		//If conditions met reset mining timer -- future with more steps this becomes unnesecary
		mining = 0;
		o_player.sprite_index = s_player_idle;
	}	
	
}

#endregion

#region baseinteraction

function depositcoal() {
	
	var _max = global.oxygencaps[global.prelvl];
	if global.coal > 0 and global.oxygenlevel < _max {
		global.oxygenlevel += 2;
		//Clamp the oxygen level
		global.oxygenlevel = clamp(global.oxygenlevel,0,_max);
		
		global.coal -= 1;
		audio_play_sound(a_deposit,1,0);
		
		//Change Sprite to animted fill sprite
		with(o_airpressurizer){
			if sprite_index == s_airpressurizer {sprite_index = s_pressurfill}
			if sprite_index == s_airpressurizer2 {sprite_index = s_pressurfill2}
			if sprite_index == s_airpressurizer3 {sprite_index = s_pressurfill3}
			if sprite_index == s_airpressurizer4 {sprite_index = s_pressurfill4}
			if sprite_index == s_airpressurizer5 {sprite_index = s_pressurfill5}
			if sprite_index == s_airpressurizer6 {sprite_index = s_pressurfill6}
		}
		
		//Print text
		//reset_text();
		//global.textalert = string(global.oxygenlevel)+" total oxygen!";
		//o_game.alarm[1] = room_speed * 3;
	}
	
	
}

function upgradepres() {
	
	if global.iron >= ironprice and global.gears >= gearprice and global.prelvl < 5 {
		global.iron -= ironprice;
		global.gears -= gearprice;
		//Implement different costs per level
		global.prelvl += 1;
		//Play audio
		audio_play_sound(a_pressureupgrade,1,0);
		//Print text
		var _max = global.oxygencaps[global.prelvl];
		reset_text();
		global.textalert = "Oxygenpressurizer level upgraded to level "+string(global.prelvl)+"! \n Max oxygen now: "+string(_max);
		o_game.alarm[1] = room_speed * 3;
		//Change Sprite
		with(o_airpressurizer){
			if global.prelvl == 1 {sprite_index = s_airpressurizer2}
			if global.prelvl == 2 {sprite_index = s_airpressurizer3}
			if global.prelvl == 3 {sprite_index = s_airpressurizer4}
			if global.prelvl == 4 {sprite_index = s_airpressurizer5}
			if global.prelvl == 5 {sprite_index = s_airpressurizer6}
		}
	}
	
}

function openchest() {
	
	var _chest = instance_nearest(x,y,o_chestparent);
	_chest.chestopen = true;
	
}

function medpack() {

	with(o_medpack) {
		if usable == true and health < 8 {
			health = o_player.maxhealth;
			audio_play_sound(a_medkit,1,0);
			usable = false;
			o_game.alarm[2] = room_speed * 15;
			global.medcharge = 0;
			reset_text();
			global.textalert = "Fully healed!";
			o_game.alarm[1] = room_speed *1.5;
		}
	}
	

}

#endregion

#region InfoPopup

function getinfo() {
	if distance_to_object(o_airpressurizer) <= range and global.inputcooldown == false  {
		var _max = global.oxygencaps[global.prelvl];
		reset_text();
		global.inputcooldown = true;
		global.text = "It's an good old AIRMAX model 307.\n Hint: Try giving it something to burn... \n Current upgrade level: "+string(global.prelvl)+", max oxygen: "+string(_max)+"\n Upgrade costs: "+string(ironprice)+" iron and "+string(gearprice)+" gears";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_medpack) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "It's a MEDPACK, it recharges slowly but heals really well...";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_coal) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "This seems to be a coal node...";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_iron) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "Woah an iron node!";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_chestparent) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "A chest, wonder whats inside...";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_rubble) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "The exit caved in, i have to find another way out...";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_workbench) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = "I can use this table to craft new things.";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r1a) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n This room is not very well ventilated, proceed with caution \n Recommended oxygen level above 80";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r2b) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n This way leads deeper into the mine...\n Recommended oxygen level above 100";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r3b) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n This way leads even deeper into the mine...\n Recommended oxygen level above 120";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r3a) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n Bad ventilation... \n Recommended oxygen level above 140";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r4a) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n You are entering even deeper into the mine \n Recommended oxygen level above 150";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r5b) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n Bad ventilation... \n Recommended oxygen level above 180";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
	if distance_to_object(o_sign_r4c) <= range and global.inputcooldown == false  {
		reset_text();
		global.inputcooldown = true;
		global.text = ">>WARNING<< \n >>OLD EXIT UP AHEAD<< \n Very badly ventilated \n Recommended oxygen level above 200";
		o_game.alarm[3] = 1;
		o_game.alarm[1] = room_speed * 10;
	}
}

#endregion

function attack() {
	attackcooldown = 20;
	if sign(vmove) = -1 {
		image_speed = 10;
		sprite_index = s_player_attack_back;
	} else if sign(vmove) = 1 {
		sprite_index = s_player_attack;
		image_speed = 10;
	} else {
		sprite_index = s_player_attack;
		image_speed = 10;
	}
	//Sound
	audio_play_sound(a_attack,2,0);
	if distance_to_object(o_enemyparent) <= range {
		//Do damage
		var _zom = instance_nearest(x,y,o_enemyparent);
		_zom.zomhealth -= 1;
		//knockback
		
		_zom.x += (_zom.x - o_player.x)*0.7;
		_zom.y += (_zom.y - o_player.y)*0.7;
		
		audio_play_sound(a_zombiehurt,2,0);
		//Create Blood
		var _temp = 0;
		var _xx = _zom.x //+ (o_enemyparent.sprite_width/2)
		var _yy = _zom.y //+ (o_enemyparent.sprite_height/2)
		repeat(8) {
			var _chip = instance_create_layer(_xx,_yy,"Instances",o_blood);
			_chip.direction = _temp;
			_chip.speed = 2;
			_chip.depth = _zom.depth-20;
			_temp += 45;
		}
	}
	if distance_to_object(o_exitplanks) <= range and o_exitplanks.plankhealth != 1 {
		o_exitplanks.plankhealth -= 1;
		audio_play_sound(a_wood,2,0);
	}
}

function death() {
	
	if health <= 0 {
		//Kill everything, this needs work
		instance_destroy();
		audio_stop_all();
		instance_deactivate_all(0);
		with(o_game) {
			instance_destroy();
		}
		room_goto(r_deathscreen);
	}
	
}