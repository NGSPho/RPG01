	
if !window_has_focus() && !is_undefined(OBJ_X_SOUNDTRACK.current_bgm) { audio_pause_sound(OBJ_X_SOUNDTRACK.current_bgm) }
else { audio_resume_sound(OBJ_X_SOUNDTRACK.current_bgm) } 

