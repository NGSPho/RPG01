/// @description Audio



// TODO not xworking
if sound_is_paused == false {
	sound_is_paused = true;
	debug("Pause sound ",  audio_get_name(OBJ_X_SOUNDTRACK.current_bgm));
	pause_sound()
} else {
	sound_is_paused = false;
	debug("Resume sound ", audio_get_name(OBJ_X_SOUNDTRACK.current_bgm));
	resume_sound()
}
