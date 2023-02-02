depth = -9999

accept_key = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)
textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 433;

// setup
if setup == false {
	setup = true;
	draw_set_font(global.font_textb);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	print_log("Page number : ", page_number)
	for(var p = 0 ; p < page_number ; p++ ) {
		// store HOW MANY CHARS ARE ON EACH PAGE
		text_length[p] = string_length(text[p]);
		// get x pos for the offset
		
			// character on the left
			text_x_offset[p] = 240;
			portrait_x_offset[p] = 48;
			// character on the right
			if speaker_side[p] == 1 {
				portrait_x_offset[p] = 672;
			}
			// no character center textb
			if speaker_sprite[p] == noone { 
				text_x_offset[p] = 144;
			}
			
		// settings indifividual characters and finding where the lines of text should break
		for (var c = 0; c < text_length[p]; c++) {
			var _char_pos = c + 1; // sring index starts with 1..
			
			//store individual characters in char array
			char[c, p] = string_char_at(text[p], _char_pos);
			
			// get current width of the line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p])
			
			// get the last free space
			if char[c, p] = " " { last_free_space = _char_pos + 1 };
			
			// get the line breaks
			if _current_txt_w - line_break_offset[p] > line_width {
				line_break_pos[line_break_num[p], p] = last_free_space
				line_break_num[p]++;
				var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space);
				var _last_free_space_string = string_char_at(text[p], last_free_space);
				line_break_offset[p] = string_width(_txt_up_to_last_space - string_width(_last_free_space_string))
			}
		}
		//getting each char coordinates
		for (var c = 0 ; c < text_length[p]; c++) {
			var _char_pos = c + 1;
			var _txt_x = textbox_x + text_x_offset[p] + border;
			var _txt_y = textbox_y + border;
			// get current width of line
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
			var _txt_line = 0;
			 //compensate for string breaks
			 for (var lb = 0; lb < line_break_num[p]; lb++) {
				 // if current looping char is after a line break
				 if char_pos >= line_break_pos[lb, p] {
					 var _str_copy = string_copy(text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb,p]);
					 _current_txt_w = string_width(_str_copy)
					// record the line this character should be on
					_txt_line = lb + 1 // + 1 since lb starts at 0
				 }
			 }
			 // add to the x and y coord base on the new info
			 char_x[c, p] = _txt_x + _current_txt_w
			 char_y[c, p] = _txt_y + _txt_line*line_sep;
			
		}	
	}
	setup = true // TODO remove ?
}


// typing the text
if draw_char < text_length[page] {
	draw_char += text_spd
	draw_char = clamp(draw_char, 0, text_length[page]);
}


// flip through pages
if accept_key
{
	// if typing is done
	if draw_char == text_length[page]
	{
		
		if page < page_number-1 // next page
		{
			page++;
			draw_char = 0;
		}
		else // destroy the textbox
		{
			if option_number > 0 {
				create_textbox(option_link_id[option_pos])
			}
			instance_destroy()
		}
	} 
	else // if not done typing
	{
		draw_char = text_length[page];
	}
}

// draw the textbox

var _txtb_x = textbox_x + text_x_offset[page];
var _txtb_y = textbox_y;
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr[page])
txtb_spr_h = sprite_get_height(txtb_spr[page])

// draw the speaker 
if speaker_sprite[page] != noone {
		print_log("page = ", page)
		print_log("speakers sprites = ", speaker_sprite)
		sprite_index = speaker_sprite[page];
		print_log("Sprite index : ", sprite_index, " offsets _x portrait = ", portrait_x_offset)
		var _speaker_x = textbox_x + portrait_x_offset[page];
		print_log("textbox_x : ", textbox_x)
		print_log("Speaker x : ", _speaker_x, " Speaker side : ", speaker_side[page])
		if speaker_side[page] == -1 { _speaker_x += sprite_width * global.scale_portrait }
		
		// draw the speaker
		print_log(" speaker_x : ", _speaker_x, "sprite width  ", sprite_width)
		draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w * global.scale_portrait, sprite_height/txtb_spr_h * global.scale_portrait, 0, c_white, 1);
		draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, speaker_side[page] * global.scale_portrait, global.scale_portrait, 0, c_white, 1);
}

draw_sprite_ext(txtb_spr[page], -1, _txtb_x,  _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1)



// options
if draw_char == text_length[page] && page == page_number - 1 {
	// option selection
	option_pos += keyboard_check_pressed(keyboard_check_pressed(vk_down)) - keyboard_check_pressed(keyboard_check_pressed(vk_up))
	option_pos = clamp(option_pos, 0, option_number-1)
	
	// draw the options
	var _op_space = 12;
	var _op_bord = 8;
	for (var op = 0; op < option_number ; op++) {
		// the option box
		
		var _o_w = string_width(option[op]) + _op_bord*2
		draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x + 16, _txtb_y - _op_space * option_number + _op_space * op, _o_w/txtb_spr_w, (_op_space-1)/txtb_spr_h, 0, c_white, 1)
		
		// the arrow
		if option_pos == op
			{
				draw_sprite(SPR_TEXTBOX_ARROW, 0, _txtb_x, _txtb_y - _op_space * option_number + _op_space * op );
			}
		// the options text
		draw_text(_txtb_x + 16 + _op_bord, _txtb_y - _op_space * option_number + _op_space * op + 2, option[op]);
	}
}

// draw the tewt
for (var c = 0; c < draw_char; c++) {
	// the text
	draw_text(char_x[c, page], char_y[c,page], char[c, page])
}