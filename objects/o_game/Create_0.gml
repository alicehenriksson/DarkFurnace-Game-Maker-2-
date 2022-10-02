/// @description Game variables

//Oxygen
global.oxygenlevel = 35;						//Start level for oxygen
global.prelvl = 0;								//Oxygenpressurizer level
global.oxygencaps = [100,120,150,180,200,220];	//Pressurizer caps
alarm[0] = room_speed * 15;						//every 20 sec tic oxygen down by 1
//Toxic
oxygencap = 0;									//This changes dependent of the room you are in
toxictimer = 0; //timer variable				//Used for a timer
gas = false;									//Used for a flipflop
//oxygen critical alert flipflop
criticalalert = false;							//Used for critical alert flip flop
//blink function for oxygen
blink = 0;										//Make oxygen icon blink
opacity = 1;									//By changing the opacity here
iconlvl = 0;									//Change oxygen icon dependent of oxygen level
//Node Regen variables 
nodevar();										//Setup node variables for global recharge --> node_regen script
//Items
global.coal = 0;								//Coal in inventory
global.iron = 0;								//Iron in inventory
global.gears = 0;								//Gears in inventory
//Upgrades
global.gasmask = false;							//Do you have gasmask upgrade?
global.hardhat = false;							//--||--
global.improvedpick = false;					//--||--
global.fastermining = false;					//--||--
global.biggerbag = false;						//--||--
//TextPopUp --> reset_text script
global.text = "";								//Normal Text
global.textalert = "";							//Alert Text
global.inputcooldown = false;					//Cooldown to avoid spam
global.typewriter_out = "";						//Typewriter effect
global.tw = 1;									//Typewriter start position
global.texthold = false;						//Stops text from dissapearing
//enemyai
global.mp_grid = 0;								//Set up path grid
//medkit
global.medcharge = 0;							//Starting charge for medkit
alarm[2] = room_speed * 15;						//Seconds for recharge
//crafting
global.crafting = false;
//Hardhat healthbar
healthbar = s_healthbar;
healthbarswitch = 0;