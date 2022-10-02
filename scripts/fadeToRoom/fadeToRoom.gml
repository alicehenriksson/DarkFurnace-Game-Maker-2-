/// @arg room
/// @arg duration
/// @arg color
function fadeToRoom() {

	// Args
	var _room = argument[0];
	var _dur = argument[1];
	var _color = argument[2];

	// Create
	var _inst = instance_create_depth(0, 0, 0, oFade);

	// Set properties
	with (_inst) {
		targetRoom = _room;
		duration = _dur;
		color = _color;
	}


}
