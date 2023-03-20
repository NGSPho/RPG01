global.event_folder = "events/";
/// Load text files
// text file TEXT_ID	TYPE	TEXT	CHARACTER	EXPRESSION	SIDE	SOUND	CONSRAINT
function load_text() {
	var _file_name = string(global.event_folder)+"text.csv"
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
		_text_data.constraint = string_return_noone_if_empty(_csv[# 7, i])
		_text_data.effect = string_return_noone_if_empty(_csv[# 8, i])
		
		if _text_data.portrait == noone && _text_data.character != noone {
			if _text_data.expression == noone _text_data.expression = "NEUTRAL";
			if _text_data.side == noone _text_data.side = "LEFT";	
			var _spr_name = "SPR_CHAR_PORTRAIT_" + _text_data.character + "_" + _text_data.expression;
			_text_data.portrait = asset_get_index(_spr_name)
					
		}
		if _text_data.sound != noone  _text_data.sound = asset_get_index("SOUND_EFFECT_CHAR_"+_text_data.sound)
		if _text_data.constraint != noone {
			var _parse_result = parse_constraint_str(_text_data.constraint);
			_text_data.constraint = {
				attribute : _parse_result.constraint_attribute,
				operator : _parse_result.constraint_operator,
				value : _parse_result.constraint_value
			}
		}
		if _text_data.effect != noone {
			var _parse_result = parse_constraint_str(_text_data.effect);
			TODO();
		}
		if _text_data.constraint != noone {
			debug("Adding constraint ", _text_data.constraint, " to text id ", _text_data.text_id,":", _text_data.text);
		}
		//log("Add text data ", _text_data)
		item_list_map_build(_text_map, _text_id, _text_data);
	}
	
	ds_grid_destroy(_csv);
	return _text_map;
}


// choices file CHOICE_ID	CHOICE_SUB_ID	CHOICE_TEXT	TEXT_ID
function load_option() {
	var _csv = load_csv(global.event_folder+"option.csv")
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
		
		item_list_map_build(_choice_map, _choice_id, _choice_data);
	}
	ds_grid_destroy(_csv);
	return _choice_map;
	
}

/// get event by id and type
function event_get(event_id, event_type) {
	switch(event_type) {
		case EVENT_TYPE.TEXT: return global.map_text[? event_id]
		case EVENT_TYPE.OPTION: return global.map_choice[? event_id]
		case EVENT_TYPE.BATTLE: return global.map_battle[? event_id]
		case EVENT_TYPE.JOIN: return global.map_join[? event_id]
		default: TODO();
	}
	
}


function play_event(_event_id, _event_type, _caller = noone) {
	log("Play event ", _event_id, " type ", _event_type);
	switch(_event_type) {
		case EVENT_TYPE.TEXT: {
			play_text(_event_id, _caller);
			break;
		}
		case EVENT_TYPE.BATTLE: {
			play_battle(_event_id, _caller);
			break;
		}
		case EVENT_TYPE.JOIN: {
			play_join(_event_id);
			break;
		}
		default: TODO();
	}
}
