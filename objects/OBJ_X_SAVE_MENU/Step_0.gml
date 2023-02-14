var _accept_key = keyboard_check_pressed(vk_enter)
var _save_dir =  keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
save_pos = (save_pos + _save_dir + save_number) % save_number
if save_pos != 0 audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 1, 0)

if _accept_key == true {
	if load_data_arr[save_pos] == noone {
	// play error sound
	} else {
		load_game()
	}
	
}

