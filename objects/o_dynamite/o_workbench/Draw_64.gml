/// @description 
if !craftingOpen exit;
draw_sprite_ext(s_Craftingmenu,0,0,0-36,6,6,0,c_white,0.85);
draw_set_color(c_white);
//Draw menu items
for (var i=0; i<itemCount; i++){
	//Get item
	var _arr = items[|i];
	var _item = _arr[0];
	
	//Draw position
	var _x = menuMargin + menuWidth/2;
	var _y = (guiHeight/2) + (i-selectedAnim)*64;
	
	//Draw scale
	var _s = 4;
	if (i==selected) _s = 4.5;
	
	//Selected item name 
	if (i==selected) _item = "> " + _item + " <";
	
	//Draw
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(_x,_y,_item,_s,_s,0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
}

//Get selected item's data
var _arr = items[|selected];
var _icon = _arr[1];
var _desc = _arr[2];
var _coal = _arr[3];
var _iron = _arr[4];
//var _gears = _arr[5];
var _bought = _arr[7];

//Draw position
var _x = (menuMargin + menuWidth) + previewWidth/2;
var _y = (guiHeight/2);

if (sprite_exists(_icon)) {
	//Draw scale 
	var _s = 15;
	
	//Draw
	draw_sprite_ext(_icon,0,_x,_y-24,_s,_s,0,-1,1);
}

draw_set_color($e8e8e8);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
//Draw description
if _bought != 1 {
	draw_text_transformed(_x,_y+140,_desc,3.5,3.5,0);
}
draw_set_halign(fa_left);
//Draw price
var _pricex = _x - 200;
var _pricey = _y + 230;
if _bought != 1 {
	//draw_text_transformed(_x,_y+300,"I need: "+string(_coal)+" coal, "+string(_iron)+" iron and "+string(_gears)+" gears to craft this...",3,3,0);
	draw_sprite_ext(s_coalicon,0,_pricex,_pricey-48,6,6,0,c_white,1);
	draw_text_transformed(_pricex+100,_pricey,string(_coal),6,6,0);
	
	draw_sprite_ext(s_ironicon,0,_pricex+200,_pricey-48,6,6,0,c_white,1);
	draw_text_transformed(_pricex+300,_pricey,string(_iron),6,6,0);
	
	//draw_sprite_ext(s_gearicon,0,_pricex+400,_pricey-48,6,6,0,c_white,1);
	//draw_text_transformed(_pricex+500,_pricey,string(_gears),6,6,0);
}
//Draw buy button
//draw_text(guiWidth-4,guiHeight-4,"Press E to buy");
draw_set_valign(fa_top);
draw_set_halign(fa_left);

