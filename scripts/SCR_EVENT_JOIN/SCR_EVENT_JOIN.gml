function play_join(_join_id) {
	var _join_data = event_get(_join_id, EVENT_TYPE.JOIN);
	if (is_undefined(_join_data)) {
		throw("Join event "+_join_id+" does not exist.");
	}
	
	debug("Processing join data ", _join_data);
	
	var _new_member = _join_data.new_member;
		
	if array_contains(global.team, _join_data.new_member) {
		throw (object_get_name(_new_member)+" is already in the team.");
	}
	if array_contains(global.team, _join_data.new_member) {
		throw (object_get_name(_new_member)+" already exists.");
	}
	
	// Create an instance
	array_push(global.team, _new_member);
	instance_create_depth(0, 0, 10000, _new_member)
	
	
	// Play the jingle
	audio_play_sound(_join_data.audio, 1, 0)
	
	// Create the textbox
	var _tdb = text_data_builder_create();
	var _str = (_new_member.label+" rejoint l'equipe !")
	text_data_builder_append(_tdb, _str, noone, noone)
	create_textbox(_tdb);
	
	
}

// battles file BATTLE_ID	TYPE	MONSTERS	EVENT_ID	EVENT_TYPE
function load_join() {
	var _csv = load_csv(global.event_folder+"join.csv")
	var _height = ds_grid_height(_csv);
	var _join_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _join_id = _csv[# 0, i]
		var _new_member_name = string_return_noone_if_empty(_csv[#1, i])
		if _new_member_name == noone 
			throw("No member name in join table.");
		else _new_member_name = "OBJ_FIGHTER_" + _new_member_name;
		var _member = asset_get_index(_new_member_name);
		log("load join member ", object_get_name(_member));
		
		var _audio_name = string_return_noone_if_empty(_csv[#2, i])
		if _audio_name == noone 
			_audio_name = "DEFAULT";
		_audio_name = "SOUND_EFFECT_NEW_PARTY_MEMBER_" + _audio_name;
		
		var _audio = asset_get_index(_audio_name)
		log("Audio : ", audio_get_name(_audio))
	
		var _join_data = {
			join_id : _join_id,
			new_member : _member,
			audio : _audio
		}
		
		log("Add join data " + string(_join_data))
		item_map_build(_join_map, _join_id, _join_data)
	}
	ds_grid_destroy(_csv);
	return _join_map;
	
}