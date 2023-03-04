initialize_global_variables()

function pause_sound() {
	audio_pause_sound(OBJ_X_SOUNDTRACK.current_bgm) 
}

function resume_sound() {
	audio_resume_sound(OBJ_X_SOUNDTRACK.current_bgm)
}

function room_is_menu(_room) {
	return _room == ROOM_INIT 
		|| _room == ROOM_BATTLE
		|| _room == ROOM_GAME_OVER
		|| _room == ROOM_TITLE_SCREEN 
		|| _room == ROOM_SAVE_SCREEN ;
}
sound_is_paused = false;


room_goto_next()
