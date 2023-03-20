function handle_no_focus() {
	var _select = keyboard_check_pressed(vk_enter);
	if _select == 1 {
		mode = MENU_MODE.ITEM_SELECTION;
		audio_play_sound(SOUND_EFFECT_MENU_CONFIRM, 1, -1);
	}
}

function handle_character_selection() {
	mode = MENU_MODE.NO_FOCUS;
}


function cancel_item_selection() {
	var _esc = keyboard_check_pressed(vk_escape);

	if _esc == 1 {
		audio_play_sound(SOUND_EFFECT_MENU_CANCEL, 1, -1);
		mode = MENU_MODE.CHARACTER_SELECTION;
		selected_item = noone;
	}
}

function handle_item_selection() {
	cancel_item_selection()
	
	var _down = keyboard_check_pressed(vk_down);
	var _top = keyboard_check_pressed(vk_up);
	var _left = keyboard_check_pressed(vk_left);
	var _right = keyboard_check_pressed(vk_right);
	var _select = keyboard_check_pressed(vk_enter);
	var _move_x = _right - _left;
	var _move_y = _down - _top;
	
	if _move_x != 0 || _move_y != 0 {
		pos_x = (INVENTORY_SIZE + pos_x + _move_x) % INVENTORY_SIZE;
		pos_y = (INVENTORY_SIZE + pos_y  + _move_y) % INVENTORY_SIZE;
		audio_play_sound(SOUND_EFFECT_MENU_CURSOR, 1, -1);
	}
	
	if _select == 1 {
		var _ally = global.team[OBJ_X_MENU_TEAM_OVERVIEW.pos_char];
		var _stack = _ally.inventory[pos_x][pos_y];
		if _stack != noone {
			start_target_selection(_stack);
			audio_play_sound(SOUND_EFFECT_MENU_CONFIRM, 1, -1);
		} else {
			debug("Selection empty, TODO change sound");
			audio_play_sound(SOUND_EFFECT_MENU_ITEM_UNUSABLE, 1, -1);
		}
	}
}

function cancel_target_selection() {
	var _esc = keyboard_check_pressed(vk_escape);

	if _esc == 1 {
		audio_play_sound(SOUND_EFFECT_MENU_CANCEL, 1, -1);
		mode = MENU_MODE.ITEM_SELECTION;
		selected_target = noone;
		pos_target = 0;
	}
}

function handle_target_selection() {
	cancel_target_selection()
	
	var _down = keyboard_check_pressed(vk_down);
	var _top = keyboard_check_pressed(vk_up);
	var _select = keyboard_check_pressed(vk_enter);
	var _move_y = _down - _top;
	
	var teammates_number = array_length(global.team);
	if _move_y != 0 {
		pos_target = (teammates_number + pos_target  + _move_y) % teammates_number;
		audio_play_sound(SOUND_EFFECT_MENU_CURSOR, 1, -1)
	}
	
	if _select == 1 {
		end_target_selection(global.team[pos_target], selected_item_stack);
		
	}
}


switch(mode) {
	case MENU_MODE.NO_FOCUS: handle_no_focus(); break
	case MENU_MODE.CHARACTER_SELECTION: handle_character_selection(); break
	case MENU_MODE.ITEM_SELECTION: handle_item_selection(); break;
	case MENU_MODE.TARGET_SELECTION: handle_target_selection(); break;
}