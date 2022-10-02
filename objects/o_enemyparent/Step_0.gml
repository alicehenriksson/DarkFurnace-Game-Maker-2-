/// @description 
depth = -y;
check_for_player();

if zomhealth <= 0 {
	instance_destroy();
	instance_create_layer(x,y,"Instances",o_gear);
}
