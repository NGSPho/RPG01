function scr_set_default_for_text() {
	line_break_pos[0, page_number] = 0;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
	
	txtb_spr[page_number] = SPR_TEXT_BOX // default
	speaker_sprite[page_number] = noone; // can be noone
	speaker_side[page_number] = 1;
	snd[page_number] = noone;
}

/// @param text
/// @param[character/sprite]
/// @param [side]
function scr_text(_text) {
	scr_set_default_for_text() // TODO why ??
	text[page_number] = _text;
	
	// get character info
	if argument_count > 1 {
		switch(argument[1]) {
			case "slime0": 
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_00_NEUTRAL;
				break;
			case "slime0 angry": 
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_00_ANGRY;
				break;
			case "slime0 joy": 
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_00_JOY;
				break;
			case "slime1":
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_01_NEUTRAL;
				snd[page_number] = SOUND_EFFECT_CHAR_BUBBLES;
				break;
			case "slime1 shy":
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_01_SHY;
				snd[page_number] = SOUND_EFFECT_CHAR_BUBBLES;
				break;
			case "slime1 cry":
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_SLIME_01_CRY;
				snd[page_number] = SOUND_EFFECT_CHAR_BUBBLES;
				break;
			case "denea":
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_DENEA_NEUTRAL;
				snd[page_number] = SOUND_EFFECT_CHAR_PURR;
				break;
				break;
			case "dancer":
				speaker_sprite[page_number] = SPR_CHAR_PORTRAIT_DANCER_NEUTRAL;
				snd[page_number] = SOUND_EFFECT_CHAR_LAUGH;
				break;
		}
	}
	
	if argument_count > 2 {
		speaker_side[page_number] = argument[2]
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
	with (instance_create_depth(0, 0, -100, OBJ_X_TEXT_BOX)) {
		scr_game_text(_text_id)
	}
}