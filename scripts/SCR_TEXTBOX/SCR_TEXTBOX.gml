function scr_set_default_for_text() {
	line_break_pos[0, page_number] = 0;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
	
	txtb_spr[page_number] = SPR_TEXT_BOX // default
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = -1;
}

/// @param text
/// @param[character]
function scr_text(_text ) {
	scr_set_default_for_text() // TODO why ??
	text[page_number] = _text;
	
	// get character info
	if argument_count > 1 {
		switch(argument[1]) {
			case "player": 
				speaker_sprite[page_number] = OBJ_PLAYER.sprite_index
				txtb_spr[page_number] = SPR_TEXT_BOX;
				break;
			case "slime 1":
				speaker_sprite[page_number] = SPR_CHAR_SLIME_01_PORTRAIT_NEUTRAL
				txtb_spr[page_number] = SPR_TEXT_BOX;
				txtb_spr[page_number] = SPR_TEXT_BOX;
				break;
			case "denea":
				speaker_sprite[page_number] = SPR_CHAR_DENEA_PORTRAIT_NEUTRAL
				txtb_spr[page_number] = SPR_TEXT_BOX;
				break;
		}
	}
	
	
	
	
	
	
	page_number++;
	
}


/// @param option
/// @param link_id
function scr_option(_option, _link_id) {
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	option_number++;
}

/// @param text_id
function create_textbox(_text_id) {
	with (instance_create_depth(0, 0, -9999, OBJ_X_TEXT_BOX)) {
		scr_game_text(_text_id)
	}
}