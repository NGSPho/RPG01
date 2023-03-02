sprite = ds_map_find_value(global.spr_name_to_sprites, "SLIME_00")
current_room = global.start_room

// --------- movement animation --------- //
move_spd = global.move_speed;
face = DOWN;
stop_moving = true; // next time frame is index 0, set to true until arrow key is pressed..


portrait = SPR_CHAR_PORTRAIT_SLIME_00_NEUTRAL


/// smooth character animation when he stops moving
function animation_stop() {
	if floor(image_index) == 0 {
			stop_moving = true
	} else {
		if stop_moving == true {
			image_index = 0
		}
	}
}

function animation_resume() {
	stop_moving = false
}


/// Set sprite according to direction
function set_sprite_direction(_dir) {
	var _x_dir = lengthdir_x(1, _dir)
	var _y_dir = lengthdir_y(1, _dir)
	if _y_dir == 0 {
		if _x_dir > 0 { face = RIGHT };
		if _x_dir < 0 { face = LEFT };
	}
	if _x_dir == 0 {
		if _y_dir > 0 { face = DOWN };
		if _y_dir < 0 { face = UP };
	}
}