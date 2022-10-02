/// @description
//are we chasing the player?
alert = false;
//distance we can start chasing the player
alert_dis = 90;
//set distance we stop from the player
attack_dis = 4;
//attack speed
attack_cdwn = 40;	//start cooldown at "0"
attack_spd = 0.5;
//speed we chase
move_spd = 0.8;
//create path resource
path = path_add();
//set delay for calculation path
calc_path_delay = 10;
//set a timer for when we calc a path
calc_path_timer = irandom(20);
//zombie health
zomhealth = 4;
//animation cooldown
zomanim = 0;
facingside = 1;
