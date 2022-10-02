event_inherited();


//Crafting system, more like shop but whatever

craftingOpen = false;
global.crafting = false;
delay = 0;

selected = 0;
selectedAnim = 0;

//Items
items = ds_list_create();

// 0 is for name, 1 is for icon, 2 is for description,
// 3 is for coal cost, 4 is for iron cost, 5 is for gear cost,
// 6 is for unique type(starts at 1), 7 is for bought status
ds_list_add(items,["Gas-mask",s_craft_gasmask,"This can be handy in a gassy situation",5,10,0,1,0]);
ds_list_add(items,["Hardhat",s_craft_hardhat,"This will protect my head from any bites...",0,15,0,2,0]);
ds_list_add(items,["Improved pick",s_craft_improvedpick,"With this i can mine iron!",20,0,0,3,0]);
ds_list_add(items,["Faster pick",s_craft_fastermining,"With this pick you can mine alot faster!",20,6,0,4,0]);
ds_list_add(items,["Bigger bag",s_craft_biggerbag,"Allows you to carry more items!",20,6,0,5,0]);

itemCount = ds_list_size(items);

//Gui
guiWidth = display_get_gui_width();
guiHeight = display_get_gui_height();

menuWidth = guiWidth * 0.3;
menuMargin = guiWidth * 0.1;

previewWidth = (guiWidth - (menuWidth+menuMargin));