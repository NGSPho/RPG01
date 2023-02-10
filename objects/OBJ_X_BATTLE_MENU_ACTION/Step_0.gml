var _x_dir = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
var _y_dir = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
var _accept_key = keyboard_check_pressed(vk_enter)
var _undo_key = keyboard_check_pressed(vk_escape)

if (select_target_mode == true) {
	
	if _x_dir != 0 {
		enemy_pos = find_next(OBJ_X_BATTLE.enemy, enemy_pos, {KO : false}, _x_dir, true)
		// --- play cursor sounds --- //
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
	}
	if _accept_key == true {
		// --- play accept sounds --- //
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
		end_target_selection(selected_actions[current_ally_turn_index][0], selected_actions[current_ally_turn_index][1], enemy[enemy_pos])
	}
	if _undo_key == true {
		undo_target_selection()
	}
	
	
} else {
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
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
	}
	if _accept_key == true {
		// --- play accept sounds --- //
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
		var _action = actions[action_pos_y, action_pos_x];
		var _ally = ally[current_ally_turn_index]
		
		// Switching mode
		switch(_action) {
			case ("Attack") : start_target_selection(_ally, _action, { KO: false }); break;
			case ("Wait") : start_action(_ally, _action); end_action(_ally, _action); break;
			case ("Laugh") : start_action(_ally, _action); end_action(_ally, _action); break;
			default : throw ("Unknown battle action"); break;
		}

	}
	
}
// ------ when turn is complete, process the actions ------ //
if (current_ally_turn_index == array_length(ally)) { 
	current_ally_turn_index = 0;
	// -- compute damage and populate selected_actions -- //
	create_battle_animation(selected_actions)//selected_actions)
	instance_destroy()
}