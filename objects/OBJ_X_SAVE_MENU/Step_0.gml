

var _accept_key = keyboard_check_pressed(vk_enter)
var _return_key = keyboard_check_pressed(vk_escape)
var _delete_key = keyboard_check_pressed(ord("D"))
move_cursor();

switch(mode) {
	case "MAIN": step_main(_accept_key); break;
	case "SAVE": step_save(_accept_key, _return_key, _delete_key); break;
	case "LOAD": step_load(_accept_key, _return_key); break;
}