
function handle_mode_target_selection() {	
	var _x_dir = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
	var _accept_key = keyboard_check_pressed(vk_enter)
	var _undo_key = keyboard_check_pressed(vk_escape)
	if _x_dir != 0 {
	enemy_pos = find_next(OBJ_X_BATTLE.enemy, enemy_pos, {KO : false}, _x_dir, true)
		// --- play cursor sounds --- //
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
	}
	if _accept_key == true {
		// --- play accept sounds --- //
		audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, -1)
		end_target_selection(enemy[enemy_pos])
	}
	if _undo_key == true {
		undo_target_selection()
	}
}

function handle_mode_action_selection() {
	var _x_dir = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
	var _y_dir = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	var _accept_key = keyboard_check_pressed(vk_enter)
	var _undo_key = keyboard_check_pressed(vk_escape)
	// handle cursor
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
			case ("Attack") : start_attack_target_selection(_ally, { KO: false }); break;
			case ("Wait") : full_action(_ally, _action); ; break;
			case ("Laugh") : full_action(_ally, _action); break;
			case ("Item") : start_item_selection(_ally); break;
			default : throw ("Unknown battle action"); break;
		}

	}
}
function init_action() {
	return {
		action : noone,
		type : noone,
		origin : noone,
		target : noone,
		dmg : noone
	}
}

function handle_mode_item_selection() {
	var _y_dir = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	var _accept_key = keyboard_check_pressed(vk_enter);
	
	var _undo_key = keyboard_check_pressed(vk_escape)
	var _sorted_inventory = global.team[current_ally_turn_index].battle_inventory; //TODO sort inventory
	var _item_stack = _sorted_inventory[item_pos];
	if _accept_key == 1 {
		start_item_target_selection(_item_stack);
		return;
	}
	var _new_item_pos = (array_length(_sorted_inventory) + item_pos + _y_dir) mod array_length(_sorted_inventory);
	if _new_item_pos != item_pos {
		if _new_item_pos > item_pos {
			if _new_item_pos >= item_display_pos + item_display_max {
				item_display_pos++;
			}
		} 
		if _new_item_pos < item_pos {
			if _new_item_pos == 0
				item_display_pos = 0;
			else if _new_item_pos < item_display_pos - item_display_max {
				item_display_pos--;
			}
		}
		item_pos = _new_item_pos;
	}
	if _undo_key == true {
		undo_item_selection()
	}
}

switch(mode) {
	case(ACTION_MENU_MODE.ACTION_SELECTION): handle_mode_action_selection(); break;
	case(ACTION_MENU_MODE.ATTACK_TARGET_SELECTION): handle_mode_target_selection(); break;
	case(ACTION_MENU_MODE.ITEM_SELECTION): handle_mode_item_selection(); break;
	case(ACTION_MENU_MODE.ITEM_TARGET_SELECTION): handle_mode_target_selection(); break;
	default : throw ("Unknown battle mode"); break;
} 

// ------ when turn is complete, process the actions ------ //
if (current_ally_turn_index == array_length(global.team)) { 
	current_ally_turn_index = 0;
	// -- compute damage and populate selected_actions -- //
	create_battle_animation(selected_actions)//selected_actions)
	instance_destroy()
}