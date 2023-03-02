var _accept_key = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)
textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 160;


// setup
if setup == false && array_length(text_data_array) == 0 {
	log("Setup text box");
	draw_set_font(font)
	
	// -- apply constraints to filter out the pages -- //
	var _unfiltered_text_data_array = event_get(text_id, EVENT_TYPE.TEXT);
	for(var p = 0 ; p < array_length(_unfiltered_text_data_array) ; p++ ) {
		var _text_data = _unfiltered_text_data_array[p];

		if _text_data.constraint == noone || constraint_apply(_text_data.constraint) == true {

			//if caller != noone debug("Int count", caller.interaction_count);
			//debug(_text_data.text + " is ok");
			array_push(text_data_array,_text_data);
		} 
	}
	
	if (_unfiltered_text_data_array[0].already_computed == false) {
		for(var p = 0 ; p < array_length(text_data_array) ; p++ ) {
			var _txt_data = text_data_array[p]
			 _txt_data.text_length = string_length(_txt_data.text);	// TODO remove ? is it really useful	  store HOW MANY CHARS ARE ON EACH PAGE	
			compute_x_offset_2(_txt_data)
			compute_line_breaks_2(_txt_data, line_width)
			compute_char_pos_2(_txt_data, textbox_x, textbox_y, border, line_sep)
		
			_txt_data.already_computed = true;
		}
	} 
	setup = true 
	
}

// Don't open the text box if there is no page
if array_length(text_data_array) == 0 {
	instance_destroy();
	return;
}

txtb_img += txtb_img_spd
var _text_data = text_data_array[page];
var _previous_text_data = noone;
if page > 0 _previous_text_data = text_data_array[page-1];
var _text = _text_data.text

switch(_text_data.type) {
	case EVENT_TYPE.TEXT: {
		type_text(_text_data); 
		text_handler(_text_data, _accept_key, array_length(text_data_array)); 
		break;
	}
	case EVENT_TYPE.OPTION: {
		draw_char = _previous_text_data.text_length;
		_text_data.portrait_x_offset = _previous_text_data.portrait_x_offset
		type_text(_previous_text_data); 
		type_options(_text_data, _text); 
		option_handler(_text_data, _accept_key); 
		break;
	}
	case EVENT_TYPE.BATTLE: {
		battle_handler(_text_data.text);
		break;
	}
	default: TODO();
}




