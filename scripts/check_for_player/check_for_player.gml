function check_for_player(){
	///@desc Check if the player is close enough to start chasing them
	
	var _dis = distance_to_object(o_player);
	//can we start chasing?
	if (_dis <= alert_dis or alert) and _dis > attack_dis {
		//should we calc our path?
		alert = true;
		//should we calc our path?
		if calc_path_timer-- <= 0 {
			//reset timer 
			calc_path_timer = calc_path_delay;
			//can we make a path to the player?
			var _found_player = mp_grid_path(global.mp_grid,path,x,y,o_player.x,o_player.y,1);
			
			//start path if we can reach the player
			if _found_player {
				path_start(path,move_spd,path_action_stop,false);
			}
			//Animations 90 degrees per direction, +- 45 from north south west east
			
			//Right, two arguments since you cant loop over 0
			if zomanim == 0 {
				if direction < 45 and direction >= 0 { sprite_index = s_zombieright; }
				if direction < 360 and direction >= 315 { sprite_index = s_zombieright;}
				//Down
				if direction < 315 and direction >= 225 { sprite_index = s_zombiefront; }
				//Left
				if direction < 225 and direction >= 135 { sprite_index = s_zombieleft; }
				//Up
				if direction < 135 and direction >= 45 { sprite_index = s_zombieback; }
			}
		}
	} else {
		//are we close enough to attack?
		if _dis <= attack_dis {
			path_end();
			//after 60frames * attack speed do attack
			if attack_cdwn >= room_speed * attack_spd {
				health -= 1;
				attack_cdwn = 0;
				audio_play_sound(a_hurt,2,0);
				//animations flip image for attack animation
				//if direction < 90 and direction >= 0 { facingside= 1; }
				//if direction < 360 and direction >= 270 { facingside= 1; }
				//if direction < 270 and direction >= 90 { facingside= -1; }
				////Up
				//if direction > 0 and direction < 180 { sprite_index = s_zombie_attack_back; }
				////Down
				//if direction > 180 and direction < 360 { sprite_index = s_zombie_attack; }
				zomanim = 4
			} else {
				attack_cdwn += 1;
			}
			
		}
	}
	if zomanim != 0 {
		zomanim -= 1;
	}
}