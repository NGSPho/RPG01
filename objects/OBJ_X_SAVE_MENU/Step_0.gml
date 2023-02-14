function move_cursor() {
	var _save_dir =  keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	save_pos = (save_pos + _save_dir + save_number) % save_number
	if save_pos != 0 audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, 0)
}


function step_main(_accept_key) {
	if _accept_key == true {
		switch(main_menu[save_pos]) {
			case "Exit": instance_destroy(); break;
			case "Save": mode = "SAVE"; break;
			case "Load": mode = "LOAD"; break;
		}
	}
}

function step_load(_accept_key, _return_key) {
	if _accept_key == true {
		if load_data_arr[save_pos] == noone {
			// play error sound
		} else {
			load_game()
		}
	
	} else if _return_key == true {
		mode = "MAIN";
		save_pos = 0;
	}
}


function step_save(_accept_key, _return_key) {	
	if _accept_key == true {
			save_game()
	} else if _return_key == true {
		mode = "MAIN";
		save_pos = 0;
	}
}



var _accept_key = keyboard_check_pressed(vk_enter)
var _return_key = keyboard_check_pressed(vk_escape)
move_cursor();

switch(mode) {
	case "MAIN": step_main(_accept_key); break;
	case "SAVE": step_save(_accept_key, _return_key); break;
	case "LOAD": step_load(_accept_key, _return_key); break;
}