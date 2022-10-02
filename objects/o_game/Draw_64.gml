/// @description Draw relative to camera 1920x1080
depth = -10000;
//So many magic numbers, changing resolution will break this ui <--- fix before final push resultion scale is 6
var _guiw = display_get_gui_width();
var _guih = display_get_gui_height();
//Set display font
draw_set_font(f_main);
//Draw hud BG
var _blend = $555555;
if !global.crafting {
	draw_sprite_ext(s_HUD,0,0,0-36,6,6,0,_blend,0.8);
}
//Draw Health bar
draw_sprite_ext(healthbar,health,10,30,6,6,0,c_white,1);

//Set "white color"
var _whiteish = $e8e8e8;

//Oxyxen icon states
var _0 = oxygencap + 5;		//Blink
var _1 = oxygencap + 10;	//Red
var _2 = oxygencap + 20;	//Yellow
//Oxygen Blink
if global.oxygenlevel <= _0 {
	blink += 1;
	if blink = room_speed * 0.5 {
		if opacity == 1 {
			opacity = 0;
		} else {
			opacity = 1;
		}
		blink = 0;
	}
} else {
	opacity = 1;
}

//Draw UI

//Oxygen icon switch color
if global.oxygenlevel < _1 {
	iconlvl = 2 
} else if global.oxygenlevel < _2 { 
	iconlvl = 1 
} else { 
	iconlvl = 0
}
//Draw oxygen icon
draw_sprite_ext(s_oxygenicon,iconlvl,10,110-12,6,6,0,c_white,opacity);
draw_text_transformed_color(110,110,string(global.oxygenlevel),5,5,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
//This switches iron and coal places in your inventory
var _switch = 0;
if global.coal == 0 and global.iron > 0 {
	_switch = -70;
}
if global.iron == 0 {
	_switch = 0;
}
//Move the gear
var _switch2 = 0;
if global.coal > 0 or global.iron > 0 {
	_switch2 = -70;
}
if global.coal > 0 and global.iron > 0 {
	_switch2 = 0;
} 
if global.coal == 0 and global.iron == 0{
	_switch2 = -140;
}
//coal icon
if global.coal > 0 {
	draw_sprite_ext(s_coalicon,0,10,180-12-_switch,6,6,0,c_white,1);
	draw_text_transformed_color(110,180-_switch,string(global.coal),5,5,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
}
//iron icon
if global.iron > 0 {
	draw_sprite_ext(s_ironicon,0,10,250-12+_switch,6,6,0,c_white,1);
	draw_text_transformed_color(110,250+_switch,string(global.iron),5,5,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
}
//gear icon
if global.gears > 0 {
	draw_sprite_ext(s_gearicon,0,10,320-12+_switch2,6,6,0,c_white,1);
	draw_text_transformed_color(110,320+_switch2,string(global.gears),5,5,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
}

//Draw text notification
draw_set_halign(fa_center);
draw_text_transformed_color(960,400,string(global.typewriter_out),4,4,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
draw_text_transformed_color(960,400,string(global.textalert),6,6,0,_whiteish,_whiteish,_whiteish,_whiteish,1);
draw_set_halign(fa_left);
//Draw upgrades
if global.gasmask == true { draw_sprite_ext(s_craft_gasmask,0,_guiw-80,80,6,6,0,c_white,1); }
if global.hardhat == true { draw_sprite_ext(s_craft_hardhat,0,_guiw-190,80,6,6,0,c_white,1); }
if global.improvedpick == true { draw_sprite_ext(s_craft_improvedpick,0,_guiw-300,80,6,6,0,c_white,1); }
if global.biggerbag == true { draw_sprite_ext(s_craft_biggerbag,0,_guiw-410,80,6,6,0,c_white,1); }
if global.fastermining == true { draw_sprite_ext(s_craft_fastermining,0,_guiw-520,80,6,6,0,c_white,1); }

