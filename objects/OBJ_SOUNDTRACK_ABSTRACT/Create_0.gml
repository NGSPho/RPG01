var previous_bgm_inst = instance_get_or_null(OBJ_SOUNDTRACK_ABSTRACT, 1, "soundtrack")
if previous_bgm_inst != 0 // if sound already playing, we play a new one if it's different
{
	if audio != global.current_bgm
	{
		audio_stop_sound(global.current_bgm)
		audio_play_sound(audio, 1000, true);
		
	}
	instance_destroy(previous_bgm_inst.id)
} else {
	audio_play_sound(audio, 1000, true);
}
global.current_bgm = audio
global.current_bgm_id = audio.id

// TODO Save in global script room to sound map	