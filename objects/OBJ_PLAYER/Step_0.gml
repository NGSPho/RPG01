event_inherited()

var _pixel_per_second = 100;
var _time_passed = delta_time / 1000000
var _pixel_in_this_frame = _pixel_per_second * _time_passed
var _x_dir = keyboard_check(vk_right) -  keyboard_check(vk_left);
var _y_dir = keyboard_check(vk_down) -  keyboard_check(vk_up);
var _x_spd = 0;
var _y_spd = 0;

var _dir = point_direction(0, 0, _x_dir, _y_dir)

if !instance_exists(OBJ_X_PAUSER) && (_x_dir != 0 || _y_dir != 0) {
	set_sprite_direction(_dir);
	
	var _moved_successfully = false;
	// ------- check collisions ------- //
	for (var i = 0; i <= 80; i += 10) {
		for (var n = -1; n <= 1; n += 2) {
			var _modified_dir = (n*i) + _dir;
			var _x_target = x + lengthdir_x(_pixel_in_this_frame, _modified_dir) * move_spd;
			var _y_target = y + lengthdir_y(_pixel_in_this_frame, _modified_dir) * move_spd;
			
			if place_free(_x_target, _y_target){
				x = _x_target;
				y = _y_target;
				_moved_successfully = true;
				break;
			}
		}
		
		if _moved_successfully == true break;
	}


	sprite_index = sprite[face];
	mask_index = sprite[DOWN]

	// animate
	animation_resume();
} else {
	animation_stop();
}



