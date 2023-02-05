

var _x_dir = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
var _y_dir = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)

if (_y_dir != 0 ||_x_dir != 00) {
	var _actions_num = array_length(actions)
	if _y_dir != 0 {
		var _D =  array_length(actions)
		action_pos_y = (action_pos_y + _D + _y_dir) % _D
	} else {
		if _x_dir != 0 {
			var _D = array_length(actions[action_pos_y])
			action_pos_x = (action_pos_x + _D + _x_dir) % _D
		}
	}
}
if keyboard_check_pressed(vk_enter) {
	var _action = actions[action_pos_y, action_pos_x];
	var _ally = ally[current_ally_turn_index]
	picked_actions[current_ally_turn_index] = _action
	log("Selecting action ", _action, " for player ", _ally.label)
		
	// Switching mode
	switch(_action) {
		case ("Action") : start_member_selection();
		case ("Wait") : break;
		case ("Laugh") : break;
	}

	current_ally_turn_index++;
}
if (current_ally_turn_index == array_length(ally)) { // turn is over, all actions have been validated so play animation
	current_ally_turn_index = 0;
	create_battle_animation()
	instance_destroy()
}