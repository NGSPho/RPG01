

/// @param text_id
function create_textbox_from_id_2(_text_id) {
	with (instance_create_depth(0, 0, -15000, OBJ_X_TEXT_BOX)) {
		font = global.font_textb
		text_id = _text_id
	}
}

/// Create a text box with input strings
/// @param text_arr An array of string
function create_textbox(_text_arr) {
	// add text to map
	var _text_id = "battle"
	var _page_number = array_length(_text_arr)
	var _text_data_arr = [];
	for (var d=0; d<_page_number; d++) {
		var _text_data = text_data_create()
		_text_data.text_id = _text_id
		_text_data.text = _text_arr[d]
		_text_data.type = "TEXT"
		array_push(_text_data_arr, _text_data);
	}
	ds_map_add(global.map_text, _text_id, _text_data_arr);
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
			
		/// has dynamic fields already been computed
		already_computed : false
	}
}