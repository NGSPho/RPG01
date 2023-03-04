initialize_global_variables()

function pause_sound() {
	audio_pause_sound(OBJ_X_SOUNDTRACK.current_bgm) 
}

function resume_sound() {
	audio_resume_sound(OBJ_X_SOUNDTRACK.current_bgm)
}

function menu_opened() {
	var _room_condition = room == ROOM_INIT 
		|| room == ROOM_BATTLE
		|| room == ROOM_GAME_OVER
		|| room == ROOM_TITLE_SCREEN 
		|| room == ROOM_SAVE_SCREEN 
	var _instance_condition = instance_exists(OBJ_X_PAUSER);
	debug("Room condition is ", _room_condition, " instance condition is ", _instance_condition);
	return _room_condition ||_instance_condition;
}
sound_is_paused = false;


room_goto_next()
