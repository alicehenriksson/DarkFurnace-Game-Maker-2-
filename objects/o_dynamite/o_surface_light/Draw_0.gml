if (surface_exists(surface)) {
	
	var _cw = camera_get_view_width(view_camera[0]);
	var _ch = camera_get_view_height(view_camera[0]);
	var _cx = camera_get_view_x(view_camera[0]);
	var _cy = camera_get_view_y(view_camera[0]);
	
	surface_set_target(surface);
	draw_set_color(c_black);	//Color to draw rectangle on screen
	draw_set_alpha(0.7);		//Transparency
	draw_rectangle(0,0,_cw,_ch,0);
	
	
	
	//Set light sources:
	with(o_torchparent) {	//White torch
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,1+random(0.1),1+random(0.1),0,c_white,0.7);
		gpu_set_blendmode(bm_normal);
		
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,1+random(0.1),1+random(0.1),0,c_yellow,0.3);
	}
	with(o_hiddenlight) {	//Hidden room light
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,6,5,0,c_white,0.4);
		gpu_set_blendmode(bm_normal);
		
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,6,5,0,c_yellow,0.1);
	}
	with(o_basedoorlight) {	//Hidden basedoor light
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,1.2,2,0,c_white,1);
		gpu_set_blendmode(bm_normal);
		
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy,1.2,2,0,c_yellow,0.1);
	}
	//with(o_player) {		//Player
	//	gpu_set_blendmode(bm_subtract);
	//	draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy+5,0.7,0.7,0,c_white,1);
	//	gpu_set_blendmode(bm_normal);
	//	gpu_set_blendmode(bm_add);
	//	draw_sprite_ext(s_lightsphere,0,x-_cx,y-_cy+5,0.7,0.7,0,c_yellow,0.3);
	//}
	
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	surface_reset_target();
	draw_surface(surface,_cx,_cy);

}

if !(surface_exists(surface)) {
	var _cw = camera_get_view_width(view_camera[0]);
	var _ch = camera_get_view_height(view_camera[0]);
	
	surface = surface_create(_cw,_ch);
	
	surface_set_target(surface);
	draw_set_color(c_black);	//Color to draw rectangle on screen
	draw_set_alpha(0.6);		//Transparency
	draw_rectangle(0,0,_cw,_ch,0);
	
	surface_reset_target();
}