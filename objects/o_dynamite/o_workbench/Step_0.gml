/// @description 
event_inherited();
//Open Shop is done in player processes script
if delay != 0 {
	delay -= 1;
}
//Close shop 
if craftingOpen and keyboard_check_pressed(vk_escape) {
	craftingOpen = false;
	global.crafting = false;
}
//Shop is open
if craftingOpen {
	reset_text();
	selectedAnim = lerp(selectedAnim,selected,0.1);
	//Down
	if keyboard_check_pressed(ord("S")) {
		if selected != itemCount-1 {
			selected += 1;
		}
	}
	//Up
	if keyboard_check_pressed(ord("W")) {
		selected -= 1;
		selected = clamp(selected,0,itemCount);
	}
	
	//Buy
	var _arr = items[|selected];
	var _coal = _arr[3];
	var _iron = _arr[4];
	//var _gears = _arr[5];
	var _type = _arr[6];
	var _bought = _arr[7];
	
	//and global.gears >= _gears
	if keyboard_check_pressed(ord("E")) and global.coal >= _coal and global.iron >= _iron and _bought == 0 {
		//Add to inventory
		if _type == 1 {global.gasmask = true;}
		if _type == 2 {global.hardhat = true;}
		if _type == 3 {global.improvedpick = true;}
		if _type == 4 {global.fastermining = true;}
		if _type == 5 {global.biggerbag = true;}
		audio_play_sound(a_chestopen,2,0);
		global.coal -= _coal;
		global.iron -= _iron;
		//global.gears -= _gears;
		//Close crafting after buy
		craftingOpen = false;
		global.crafting = false;
		delay = 20;
	}
}

//Ugliest code so far but it works okayy :) 
//change last value from 0 to 1 to block user from buying also change sprite and desc
if global.gasmask == true {ds_list_replace(items,0,["Gas Mask",s_craft_gasmaskbought,"",0,0,0,1,1])}
if global.hardhat == true {ds_list_replace(items,1,["Hardhat",s_craft_hardhatbought,"",0,0,0,2,1])}
if global.improvedpick == true {ds_list_replace(items,2,["Improved pick",s_craft_improvedpickbought,"",0,0,0,3,1])}
if global.fastermining == true {ds_list_replace(items,3,["Faster pick",s_craft_fasterminingbought,"",0,0,0,4,1])}
if global.biggerbag == true {ds_list_replace(items,4,["Bigger bag",s_craft_biggerbagbought,"",0,0,0,5,1])}
