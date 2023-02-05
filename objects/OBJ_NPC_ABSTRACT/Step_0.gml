event_inherited()
// depth : the lowest, the closest 
depth = -bbox_bottom;
if !instance_exists(OBJ_X_PAUSER) {
	image_speed = 1;
	// random behaviour
	move_count--;
	if move_count == 0 {
		move_count = move_frequency;
		//log("Moving PNJ ", id)
		face = random_dir;
		random_dir = floor(random_range(0, 4));
		//debug("Direction random : ",face);
		sprite_index = sprite[face]
		switch (face) {
			case RIGHT: x += img_speed; break;
			case UP: y -= img_speed; break;
			case LEFT: x -= img_speed; break;
			case DOWN: y += img_speed;  break;
		}
	}
} else {
	image_speed = 0;
}