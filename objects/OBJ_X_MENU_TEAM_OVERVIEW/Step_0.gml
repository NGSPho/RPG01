var exit_key = keyboard_check_pressed(vk_escape);
if exit_key == true && check_focus() {
	instance_destroy(OBJ_X_MENU_TABS);
	instance_destroy(OBJ_X_MENU_TAB_ABSTRACT);
	audio_play_sound(SOUND_EFFECT_MENU_CANCEL, 1, -1);
	instance_destroy();
}


cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
// ---------------- check if arrows are already in use ------------------------------- //

var _down = keyboard_check_pressed(vk_down);
var _top = keyboard_check_pressed(vk_up);

var _move_char = _down - _top;
if _move_char != 0 {
	if has_focus(OBJ_X_MENU_TAB_ITEMS) == true {
		return;
	}
	audio_play_sound(SOUND_EFFECT_MENU_CURSOR, 1, -1)
	var _new_pos_char = (array_length(global.team) + pos_char + _move_char) % array_length(global.team);
	if _new_pos_char != pos_char { 
		pos_char = _new_pos_char;
		// ------------- reset sub menu -------------------- //
		//menu_reset(OBJ_X_MENU_TAB_ITEMS);
		//menu_reset(OBJ_X_MENU_TAB_SKILLS);
	
	}
}