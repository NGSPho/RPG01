initialize_global_variables()

function pause_sound() {
	audio_pause_sound(OBJ_X_SOUNDTRACK.current_bgm) 
}

function resume_sound() {
	audio_resume_sound(OBJ_X_SOUNDTRACK.current_bgm)
}
sound_is_paused = false;


room_goto_next()
