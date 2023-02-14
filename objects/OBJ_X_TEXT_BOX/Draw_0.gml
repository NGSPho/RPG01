var _accept_key = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)
textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 160;


var _text_data_arr = global.map_text[? text_id];


// setup
if setup == false &&  _text_data_arr[0].already_computed == false {
	log("Setup text box");
	draw_set_font(font)
	for(var p = 0 ; p < array_length(_text_data_arr) ; p++ ) {
		var _txt_data = _text_data_arr[p]
		 _txt_data.text_length = string_length(_txt_data.text);	// TODO remove ? is it really useful	  store HOW MANY CHARS ARE ON EACH PAGE	
		compute_x_offset_2(_txt_data)
		compute_line_breaks_2(_txt_data, line_width)
		compute_char_pos_2(_txt_data, textbox_x, textbox_y, border, line_sep)
		
		_txt_data.already_computed = true;
	}
	setup = true 
}

txtb_img += txtb_img_spd

var _text_data = _text_data_arr[page];
var _previous_text_data = noone;
if page > 0 _previous_text_data = _text_data_arr[page-1];
var _text = _text_data.text


switch(_text_data.type) {
	case "TEXT": {
		type_text(_text_data); 
		text_handler(_text_data, _accept_key, array_length(_text_data_arr)); 
		break;
	}
	case "OPTION": {
		draw_char = _previous_text_data.text_length;
		_text_data.portrait_x_offset = _previous_text_data.portrait_x_offset
		type_text(_previous_text_data); 
		type_options(_text_data, _text); 
		option_handler(_text_data, _accept_key); 
		break;
	}
	case "BATTLE": {
		battle_handler(_text_data.text);
		break;
	}
	default: throw("Not implemented yet"); break;
}




