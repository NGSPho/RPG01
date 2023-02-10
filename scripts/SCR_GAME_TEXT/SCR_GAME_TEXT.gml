/// Load text files
// text file TEXT_ID	TYPE	TEXT	CHARACTER	EXPRESSION	SIDE	SOUND
function load_text() {
	var _csv = load_csv("text/text.csv");
	var _height = ds_grid_height(_csv);
	
	var _text_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _text_id = _csv[# 0, i]
		//log("text ", _text)
		var _text_data = text_data_create()
		_text_data.text_id = _text_id
		_text_data.type = _csv[# 1, i]
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
			if _text_data.sound != noone  _text_data.sound = asset_get_index("SOUND_EFFECT_CHAR_"+_text_data.sound)
			
		}
		
		log("Add text data " + string(_text_data))
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
function load_choice() {
	var _csv = load_csv("text/choice.csv")
	var _height = ds_grid_height(_csv);
	var _choice_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _choice_id = _csv[# 0, i]
		//log("text ", _text)
		var _choice_data = {
			choice_id : _choice_id,
			choice_sub_id : _csv[# 1, i],
			choice_text : string_remove_quotation_marks(_csv[# 2, i]),
			text_id : _csv[# 3, i],
		}
		
		log("Add choice data " + string(_choice_data))
		
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