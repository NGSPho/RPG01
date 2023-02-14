// textbox param
textbox_width = 180;
textbox_height = 53;
textbox_x = 0;
textbox_y = 0;
border = 8;
line_sep = 12;
line_width = textbox_width - border * 2; // use for line break
txtb_img = 0;
txtb_img_spd = 6/60;

font = 0;

// the text
page = 0;

draw_char = 0;
text_spd = 1;
//options

option_pos = 0;

setup = false;
// sound
snd_delay = 4;
snd_count = snd_delay;
// effects
text_pause_timer = 0;
text_pause_time = 16;


draw_set_valign(fa_top);
draw_set_halign(fa_left);

function compute_x_offset_2(_text_data) {	
	// get x pos for the offset
		
	// no character center textb
	if _text_data.portrait == noone { 
		_text_data.text_x_offset = 48;
	} else {
		// character on the left
		_text_data.text_x_offset = 80;
		_text_data.portrait_x_offset = 14;
		// character on the right
		if  _text_data.side == "RIGHT" {
			_text_data.portrait_x_offset = 208;
			_text_data.text_x_offset = 16;
		} 
	}
}

function compute_line_breaks_2(_text_data, _line_width) {
	var _text = _text_data.text
	if _text_data.char != noone {
		log("Text data already computed");
		return;
	}
	_text_data.char = [0];
	_text_data.line_break_num = 0;
	_text_data.line_break_offset = 0;
	_text_data.line_break_pos = [0];
	
	var _last_free_space = 0;
	for (var c = 0; c < string_length(_text); c++) {
		var _char_pos = c + 1; // sring index starts with 1..
		 
		//store individual characters in char array
		var _char = string_char_at(_text, _char_pos);
			
		// get current width of the line
		var _txt_up_to_char = string_copy(_text, 1, _char_pos);
		var _current_txt_w = string_width(_txt_up_to_char) - string_width(_char)
			
		// get the last free space
		if _char = " " { _last_free_space = _char_pos + 1 };
			
		// get the line breaks
		if _current_txt_w - _text_data.line_break_offset > _line_width {
			_text_data.line_break_pos[_text_data.line_break_num] = _last_free_space
			_text_data.line_break_num ++;
			var _txt_up_to_last_space = string_copy(_text, 1, _last_free_space);
			var _last_free_space_string = string_char_at(_text, _last_free_space);
			_text_data.line_break_offset = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string)
		}
		
		_text_data.char[c] = _char;
	}
}

function compute_char_pos_2(_text_data, _textbox_x, _textbox_y, _border, _line_sep) {	// remove _text_x_offset
	
	if _text_data.char_x != noone {
		log("Char pos already computed");
		return;
	}
	_text_data.char_x = [0];
	_text_data.char_y = [0];
	//getting each char coordinates
	var _text = _text_data.text
	for (var c = 0 ; c < string_length(_text); c++) {
		var _char_pos = c + 1;
		var _txt_x = _textbox_x + _text_data.text_x_offset + _border;
		var _txt_y = _textbox_y + _border;
		// get current width of line
		var _txt_up_to_char = string_copy(_text, 1, _char_pos);
		var _current_txt_w = string_width(_txt_up_to_char) - string_width(_text_data.char[c]);
		var _txt_line = 0;
		//compensate for string breaks
		for (var lb = 0; lb < _text_data.line_break_num; lb++) {
			// if current looping char is after a line break
			if _char_pos >= _text_data.line_break_pos[lb] {
				var _str_copy = string_copy(_text, _text_data.line_break_pos[lb], _char_pos-_text_data.line_break_pos[lb]);
				_current_txt_w = string_width(_str_copy)
			// record the line this character should be on
			_txt_line = lb + 1 // + 1 since lb starts at 0
			}
		}
		// add to the x and y coord base on the new info
		_text_data.char_x[c] = _txt_x + _current_txt_w
		_text_data.char_y[c] = _txt_y + _txt_line*_line_sep;
	}
}



function text_handler(_text_data, _accept_key, _page_number) {
	if _accept_key {
		if draw_char == _text_data.text_length { // if typing is done
			if page < _page_number-1{
				page++;
				draw_char = 0;
			}
			else {
				instance_destroy()
			}
		} else { // if not done typing
			draw_char = _text_data.text_length;
		}
	}
}

function option_handler(_text_data, _accept_key) {
	if _accept_key {
		create_textbox_from_id_2(global.map_choice[? _text_data.text][option_pos].text_id)
		instance_destroy()
	}
	
}

function type_text(_text_data) {
	
	var _text_length = _text_data.text_length

	//typing the text
	if draw_char == 0 || text_pause_timer <= 0 {
		if draw_char < _text_length {
			draw_char += text_spd
			draw_char = clamp(draw_char, 0, _text_length);
			var _check_char = string_char_at(_text_data.text, draw_char);
			if _check_char == "." || _check_char == "!" || _check_char == "?" {
				text_pause_timer = text_pause_time;
			} else {
				// typing sound
				if snd_count < snd_delay {
					snd_count ++;
				} else {
					snd_count = 0;
					if _text_data.sound != noone && !audio_is_playing(_text_data.sound) {
						audio_play_sound(_text_data.sound, 10, false);
					}
				}
			}
		}
	} else {
		text_pause_timer--;
	}
	
	
	// --- draw the textbox --- //
	var _txtb_x = textbox_x + _text_data.text_x_offset;
	var _txtb_y = textbox_y;
	var _txtb_spr_w = sprite_get_width( _text_data.sprite)
	var _txtb_spr_h = sprite_get_height( _text_data.sprite)
	
	
	draw_sprite_ext(_text_data.sprite, txtb_img, _txtb_x,  _txtb_y, textbox_width/_txtb_spr_w, textbox_height/_txtb_spr_h, 0, c_white, 1)
	
	
	// ----draw the text --- //
	for (var c = 0; c < draw_char; c++) 
		draw_text(_text_data.char_x[c], _text_data.char_y[c], _text_data.char[c])

	// draw the speaker 
	if _text_data.portrait != noone {
		sprite_index = _text_data.portrait;
		var _speaker_x = textbox_x + _text_data.portrait_x_offset;
		var y_scale = 1;
		if _text_data.side == "LEFT" { 
			_speaker_x += sprite_width * global.scale_portrait 
			y_scale = -1;
		}
		
		
		// --- draw portrait ---- //
		draw_sprite_ext(_text_data.sprite, txtb_img, textbox_x + _text_data.portrait_x_offset, textbox_y, sprite_width/_txtb_spr_w * global.scale_portrait, sprite_height/_txtb_spr_h * global.scale_portrait, 0, c_white, 1);
		draw_sprite_ext(_text_data.portrait, txtb_img, _speaker_x, textbox_y, y_scale * global.scale_portrait, global.scale_portrait, 0, c_white, 1);
	}


}
	
function type_options(_text_data, _option_id) {
	var _options = global.map_choice[? _option_id]
	var _options_number = array_length(_options)
	var _txtb_x = textbox_x + _text_data.portrait_x_offset  + _text_data.text_x_offset;
	var _txtb_y = textbox_y;
	var _txtb_spr_w = sprite_get_width( _text_data.sprite)
	var _txtb_spr_h = sprite_get_height( _text_data.sprite)
	// options
		
	// option selection
	option_pos += keyboard_check_pressed(keyboard_check_pressed(vk_down)) - keyboard_check_pressed(keyboard_check_pressed(vk_up))
	option_pos = clamp(option_pos, 0, _options_number-1)
	
	// draw the options
	var _op_space = 12;
	var _op_bord = 8;
	for (var op = 0; op < _options_number ; op++) {
		var _option = _options[op]
		// the option box
		
		var _o_w = string_width(_option.choice_text) + _op_bord*2
		draw_sprite_ext(_text_data.sprite, txtb_img, _txtb_x + 16, _txtb_y - _op_space * _options_number + _op_space * op, _o_w/_txtb_spr_w, (_op_space-1)/_txtb_spr_h, 0, c_white, 1)
		
		// the arrow
		if option_pos == op 
			draw_sprite(SPR_TEXTBOX_ARROW, 0, _txtb_x, _txtb_y - _op_space * _options_number + _op_space * op );
			
		// the options text
		draw_text(_txtb_x + 16 + _op_bord, _txtb_y - _op_space * _options_number + _op_space * op + 2, _option.choice_text);
	}
	
}

function battle_handler(_battle_id) {
	
	create_battle_from_id(_battle_id)
	instance_destroy();
	
}
