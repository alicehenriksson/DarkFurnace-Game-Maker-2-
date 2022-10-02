/// @description menu
//blink += 1;
//if blink >= room_speed * 0.2 {
//	if opacity == 1 {
//		opacity = 0;
//	} else {
//		opacity =1;
//	}
//	blink = 0;
//}

var _whiteish = $e8e8e8;
switch(room) {
	case r_startscreen:
		if !audio_is_playing(a_start) {
			audio_play_sound(a_start,1,1);
		}
		draw_set_font(f_main);
		draw_set_halign(fa_center);
		draw_text_transformed_color(320/2,176/3*1.8,"START",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		draw_text_transformed_color(320/2,176/3*1.8+15,"CONTROLS",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		draw_text_transformed_color(320/2,176/3*1.8+30,"EXIT",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		//menu function
		var _up = keyboard_check_pressed(ord("W"));
		var _down = keyboard_check_pressed(ord("S"));
		var _ent = keyboard_check_pressed(ord("E"));
		var _ent2 = keyboard_check_pressed(vk_enter);
		
		if _up {
			listsize -= 1;
			listsize = clamp(listsize,1,3);
			audio_play_sound(a_menuNav,1,0);
		} else if _down {
			listsize += 1;
			listsize = clamp(listsize,1,3);
			audio_play_sound(a_menuNav,1,0);
		}
		//Draw >< around selected
		if listsize == 1 { draw_text_transformed_color(320/2,176/3*1.8,">START<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1); }
		if listsize == 2 { draw_text_transformed_color(320/2,176/3*1.8+15,">CONTROLS<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1); }
		if listsize == 3 { draw_text_transformed_color(320/2,176/3*1.8+30,">EXIT<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1); }
		//Go to different rooms
		if listsize == 1 {
			if _ent or _ent2 {
				fadeToRoom(r_base, 120, c_black);
			}
		}
		if listsize == 2 {
			if _ent or _ent2 {
				room_goto(r_controls);
				audio_play_sound(a_menuNav,1,0);
			}
		}
		if listsize == 3 {
			if _ent or _ent2 {
				game_end();
			}
		}
	break;
	
	case r_controls:
		if !audio_is_playing(a_start) {
			audio_play_sound(a_start,1,1);
		}
		draw_set_font(f_main);
		draw_set_halign(fa_center);
		draw_text_transformed_color(320/2,176/3*1.8,">BACK<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		draw_text_transformed(320/2,176/3*1.8+15,
		"USE >WASD< TO MOVE AROUND\n"+
		"PRESS >E< TO INTERACT WITH ELEMENTS\n"+
		"PRESS >Q< TO GET INFO\n"+
		"PRESS >SPACE< TO ATTACK\n"+
		"PRESS >R< TO UPGRADE OXYGENPRESSURIZER\n"+
		"AVOID THE GAS ITS NOT FRIENDLY!",0.5,0.5,0);
		if keyboard_check_pressed(ord("E")) or keyboard_check_pressed(vk_enter) {
			room_goto(r_startscreen);
			audio_play_sound(a_menuNav,1,0);
		}
	break;
	case r_deathscreen: 
		if !audio_is_playing(a_death) {
			audio_play_sound(a_death,1,1);
		}
		var _ent2 = keyboard_check_pressed(vk_enter);
		var _ent = keyboard_check_pressed(ord("E"));
		var _up = keyboard_check_pressed(ord("W"));
		var _down = keyboard_check_pressed(ord("S"));
		if _up {
			listsize -= 1;
			listsize = clamp(listsize,1,2);
			audio_play_sound(a_menuNav,1,0);
		} else if _down {
			listsize += 1;
			listsize = clamp(listsize,1,2);
			audio_play_sound(a_menuNav,1,0);
		}
		draw_set_font(f_main);
		draw_set_halign(fa_center);
		draw_text_transformed_color(320/2,176/3*1.8,"RESTART",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		draw_text_transformed_color(320/2,176/3*1.8+15,"EXIT",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		if listsize == 1 { draw_text_transformed_color(320/2,176/3*1.8,">RESTART<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1); }
		if listsize == 2 { draw_text_transformed_color(320/2,176/3*1.8+15,">EXIT<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1); }
		if listsize == 1 {
			if _ent or _ent2 {
				game_restart();
			}
		}
		if listsize == 2 {
			if _ent or _ent2 {
				game_end();
			}
		}
	break;
	case r_endscreen: 
		if !audio_is_playing(a_end) {
			audio_play_sound(a_end,1,1);
		}
		draw_set_font(f_main);
		draw_set_halign(fa_center);
		draw_text_transformed_color(320/2,176/3*1.1+15,">EXIT<",1,1,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		draw_text_transformed_color(320/2,176/3*1.1+35,"THANKS FOR PLAYING!!! :)",0.5,0.5,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
		var _ent2 = keyboard_check_pressed(vk_enter);
		var _ent = keyboard_check_pressed(ord("E"));
		if _ent or _ent2 {
			game_end();
		}
	break;
}
