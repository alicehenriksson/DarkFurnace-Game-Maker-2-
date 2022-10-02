/// @description 
// Enter state
if (state == 0) {
	timer++;
	
	// Change room
	if (timer >= duration) {
		room_goto(targetRoom);
		
		// Set state
		state = 1;
	}
}
// Exit state
else if (state == 1) {
	timer--;
	
	// Destroy
	if (timer <= 0) {
		instance_destroy();
	}
}
	
// Set alpha
alpha = timer / duration;