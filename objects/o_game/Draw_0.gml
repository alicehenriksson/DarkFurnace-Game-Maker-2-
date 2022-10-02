/// @description draw HUDsprite and gas creep effect

//gas creep in effect
if global.oxygenlevel - oxygencap <= 10 and global.oxygenlevel - oxygencap > 0 {
	depth = -2900;
	//0.2 is the alpha of toxicgas sprite, creep by 0.02 increments towards 0.20
	var _opacity = 0.20 - (0.02*(global.oxygenlevel-oxygencap));
	draw_sprite_ext(s_toxiccreep,0,0,0,1,1,0,c_white,_opacity);
}

//HUD
//depth = -3000;
//draw_sprite_ext(s_HUD,0,0,0,1,1,0,c_white,0.85);




//Oxygen low color flash - todo when lightning is added

//Grid show
if keyboard_check(vk_alt) {
	mp_grid_draw(global.mp_grid);
}