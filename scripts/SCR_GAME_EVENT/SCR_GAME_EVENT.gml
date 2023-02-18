global.csv_folder = "events/";
/// Load text files
// text file TEXT_ID	TYPE	TEXT	CHARACTER	EXPRESSION	SIDE	SOUND
function load_text() {
	var _file_name = string(global.csv_folder)+"text.csv"
	log("csv file is ", _file_name);
	var _csv = load_csv(_file_name);
	var _height = ds_grid_height(_csv);
	
	var _text_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _text_id =  string_return_noone_if_empty(_csv[# 0, i])
		if _text_id == noone continue;
		var _text_data = text_data_create()
		_text_data.text_id = _text_id
		_text_data.type = EVENT_TYPE_get(_csv[# 1, i])
		_text_data.text = string_remove_quotation_marks(_csv[# 2, i])
		_text_data.character = string_return_noone_if_empty(_csv[# 3, i])
		_text_data.expression = string_return_noone_if_empty(_csv[# 4, i])
		_text_data.side = string_return_noone_if_empty(_csv[# 5, i])
		_text_data.sound = string_return_noone_if_empty(_csv[# 6, i])
		
		if _text_data.portrait == noone && _text_data.character != noone {
			if _text_data.expression == noone _text_data.expression = "NEUTRAL";
			if _text_data.side == noone _text_data.side = "LEFT";	
			var _spr_name = "SPR_CHAR_PORTRAIT_" + _text_data.character + "_" + _text_data.expression;
			_text_data.portrait = asset_get_index(_spr_name)
					
		}
		if _text_data.sound != noone  _text_data.sound = asset_get_index("SOUND_EFFECT_CHAR_"+_text_data.sound)
		
		//log("Add text data " + string(_text_data))
		if !ds_map_exists(_text_map, _text_id) 
			ds_map_add(_text_map, _text_id, [_text_data])
		else {
			var _data_arr = _text_map[? _text_id]
			array_push(_data_arr, _text_data)
		}
	}
	
	ds_grid_destroy(_csv);
	return _text_map;
}


// choices file CHOICE_ID	CHOICE_SUB_ID	CHOICE_TEXT	TEXT_ID
function load_option() {
	var _csv = load_csv(global.csv_folder+"option.csv")
	var _height = ds_grid_height(_csv);
	var _choice_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _choice_id = _csv[# 0, i]
		var _choice_data = {
			choice_id : _choice_id,
			choice_sub_id : _csv[# 1, i],
			choice_text : string_remove_quotation_marks(_csv[# 2, i]),
			text_id : _csv[# 3, i],
		}
		
		//log("Add choice data " + string(_choice_data))
		
		if !ds_map_exists(_choice_map, _choice_id) 
			ds_map_add(_choice_map, _choice_id, [_choice_data])
		else {
			var _data_arr = _choice_map[? _choice_id]
			array_push(_data_arr, _choice_data)
		}
	}
	ds_grid_destroy(_csv);
	return _choice_map;
	
}

// battles file BATTLE_ID	TYPE	MONSTERS	EVENT_ID	EVENT_TYPE
function load_battle() {
	var _csv = load_csv(global.csv_folder+"battle.csv")
	var _height = ds_grid_height(_csv);
	var _battle_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _battle_id = _csv[# 0, i]
		var _monsters_names = string_split(_csv[#2, i], " ");
		var _monsters = array_create(0);
		for (var j=0; j<array_length(_monsters_names); j++) {
			array_push(_monsters, asset_get_index(_monsters_names[j]))
		}
		var _event_id = string_return_noone_if_empty(_csv[#3, i])
		var _event_type = string_return_noone_if_empty(_csv[#4, i])
		var _triggered_event = noone;
		if _event_id != noone {
			if _event_type == noone throw("Battle id "+_battle_id+" : following event can't have an empty type if id is specified.")
			_triggered_event = {
				event_id : _event_id,
				event_type : EVENT_TYPE_get(_event_type),
			}
		}
	
		var _battle_data = {
			battle_id : _battle_id,
			type : _csv[# 1, i],
			monsters : _monsters,
			triggered_event : _triggered_event
		}
		
		//log("Add battle data " + string(_battle_data))
		
		if !ds_map_exists(_battle_map, _battle_id) 
			ds_map_add(_battle_map, _battle_id, _battle_data)
		else {
			throw("Duplicate battle id in csv file");
		}
	}
	ds_grid_destroy(_csv);
	return _battle_map;
	
}

// battles file BATTLE_ID	TYPE	MONSTERS	EVENT_ID	EVENT_TYPE
function load_join() {
	var _csv = load_csv(global.csv_folder+"join.csv")
	var _height = ds_grid_height(_csv);
	var _join_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _join_id = _csv[# 0, i]
		var _new_member_name = string_return_noone_if_empty(_csv[#1, i])
		if _new_member_name == noone 
			throw("No member name in join table.");
		else _new_member_name = "OBJ_NPC_" + _new_member_name;
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
			new_member : _new_member_name,
			audio : _audio
		}
		
		log("Add join data " + string(_join_data))
		
		if !ds_map_exists(_join_map, _join_id) 
			ds_map_add(_join_map, _join_id, _join_data)
		else {
			throw("Duplicate battle id in csv file");
		}
	}
	ds_grid_destroy(_csv);
	return _join_map;
	
}

/// get event by id and type
function event_get(event_id, event_type) {
	switch(event_type) {
		case EVENT_TYPE.TEXT: return global.map_text[? event_id]
		case EVENT_TYPE.OPTION: return global.map_choice[? event_id]
		case EVENT_TYPE.BATTLE: return global.map_battle[? event_id]
		default: TODO();
	}
	
}


function play_event(_event_id, _event_type) {
	log("Play event ", _event_id, " type ", _event_type);
	switch(_event_type) {
		case EVENT_TYPE.TEXT: {
			play_text(_event_id);
			break;
		}
		case EVENT_TYPE.BATTLE: {
			play_battle(_event_id);
			break;
		}
		default: TODO();
	}
}