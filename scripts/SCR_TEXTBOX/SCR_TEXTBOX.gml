

/// @param text_id
function play_text(_text_id) {
	with (instance_create_depth(0, 0, -15000, OBJ_X_TEXT_BOX)) {
		font = global.font_textb
		text_id = _text_id
	}
}

/// Create a text box with input strings
/// @param text_arr An array of string
function create_textbox(_text_arr) {
	// add text to map
	var _text_id = "tmp"
	var _page_number = array_length(_text_arr)
	for (var d=0; d<_page_number; d++) {
		var _text_data = _text_arr[d]
		_text_data.text_id = _text_id
		_text_data.type = EVENT_TYPE.TEXT
	}
	
	ds_map_replace(global.map_text, _text_id, _text_arr);
	with (instance_create_depth(0, 0, -15000, OBJ_X_TEXT_BOX)) {
		font = global.font_textb
		text_id = _text_id
	}
}

function text_data_create() {
	return {
		text_id : noone,
		type : noone,
		text : noone,
		character : noone,
		expression : noone,
		side : noone,
		sound : noone,
		portrait : noone,
		sprite : SPR_TEXT_BOX,
			
		// will be filled later
		text_length : noone,
			
		char : noone,
		char_x : noone,
		char_y: noone,
				
		line_break_pos : noone,
		line_break_num : noone,
		line_break_offset : noone,
		
		portrait_x_offset : noone,
			
		/// has dynamic fields already been computed
		already_computed : false
	}
}



/// Create a text data builder
function text_data_builder_create() {
	return [];
}

/// Append data to string builder
/// @param _tdb The builder
/// @param _string The string to append
/// @param _snd
function text_data_builder_append(_tdb, _string, _snd) {
	var _text_data = text_data_create();
	_text_data.text = _string;
	_text_data.sound = _snd
	array_push(_tdb, _text_data)
	return _tdb
}