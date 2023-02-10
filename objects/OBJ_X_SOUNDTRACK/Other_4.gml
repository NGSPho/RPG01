var _room = room
var _bgm = room_to_bgm[_room]

if _bgm != current_bgm {
	log("Get bgm for ", room_get_name(room), " : ", audio_get_name(_bgm), ", ", _bgm);
	audio_stop_sound(current_bgm)
	audio_play_sound(_bgm, 1000, true);
	current_bgm = _bgm;
}