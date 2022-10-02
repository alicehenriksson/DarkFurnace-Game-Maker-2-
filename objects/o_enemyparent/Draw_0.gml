/// @description

draw_sprite_ext(sprite_index, image_index, x, y, facingside, 1, 0, c_white, 1);
if keyboard_check(ord("P")) {
	draw_path(path,x,y,0);
}
draw_self();