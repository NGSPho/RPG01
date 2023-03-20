

menu_sprite = SPR_TEXT_BOX;
cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
box_sprite = SPR_X_MENU;

pos_char = 0;
pos_x = 0;
pos_y = 0;

font = global.font_textb;
draw_set_font(font);


/// display characters info on the side bar
function display_characters() {
	// ---------- display the box ---------------- //
	var _box_offset_x = cam_x + 16;
	var _box_offset_y = cam_y + 30;
	var _box_width = 137;
	var _box_height = 160;
	draw_sprite_simplified_2(box_sprite, _box_offset_x, _box_offset_y, _box_width, _box_height);
	
	var _offset_x = _box_offset_x + 5;
	var _offset_y = _box_offset_y + 10;
	// ------------ display characters data ------------------------ //
	for (var i=0;i<global.MAX_TEAM_MEMBER;i++) {
		var _character_section_height = 30; 
		var _character_section_offset_y = _offset_y + i * _character_section_height;
		
		if i >= array_length(global.team) {
			// TODO display placeholder only
			continue;
		}	
		
		var _ally = global.team[i]
		
		// ------------------- draw the portrait ----------------- //
		var _portrait_dimensions = _character_section_height-6;
		var _portrait_offset_x = 5;
		draw_sprite_simplified_2(_ally.sprite_index, _offset_x+_portrait_offset_x, _character_section_offset_y+2, _portrait_dimensions, _portrait_dimensions)
		
		
		// ----------------- Write teammate data ----------------------------- //
		var _ally_data_x =_offset_x+_portrait_offset_x+_portrait_dimensions+5;
		var _ally_data_label_y =  _character_section_offset_y+1;
		draw_text_simplified(_ally_data_x, _ally_data_label_y, _ally.label);
		// ------------------- Draw HP and MP ------------------- //
		var _value_offset_x = _ally_data_x + 20;
		var _bar_x =  _ally_data_x+60;
		var _bar_width = 30;
		var _bar_height = 3;
		// ------------------- draw HP -------------------------- //
		var _ally_data_hp_y = _ally_data_label_y + string_height(_ally.label)+1;
		var _hp_str = "HP";
		draw_text_simplified(_ally_data_x, _ally_data_hp_y, _hp_str);
		var _hp_value = string(_ally.HP)+"/"+string(_ally.MAX_HP);
		draw_text_simplified(_value_offset_x, _ally_data_hp_y, _hp_value);
		var _bar_y = _ally_data_hp_y+string_height(_hp_str+_hp_value)-_bar_height*2;
		draw_agent_bar(_ally, _bar_x, _bar_y, _bar_width, _bar_height, false);
		// --------------------- Draw MP ------------------------ //
		var _ally_data_mp_y =_ally_data_hp_y + string_height(_hp_str+_hp_value)+1;
		var _mp_str = "MP";
		draw_text_simplified(_ally_data_x, _ally_data_mp_y, _mp_str);
		var _mp_value = string(_ally.MP)+"/"+string(_ally.MAX_MP);
		draw_text_simplified(_value_offset_x, _ally_data_mp_y, _mp_value);
		_bar_y = _ally_data_mp_y+string_height(_mp_str+_mp_value)-_bar_height*2;
		draw_agent_bar(_ally, _bar_x, _bar_y, _bar_width, _bar_height, false, "MP");
		
		// ------------- draw the separation line -------------- //
		var _separator_y = _character_section_offset_y + _character_section_height - 2;
		draw_line_width_colour(_offset_x, _separator_y, _offset_x+_box_width - 10, _separator_y, 2, c_white, c_white);
		
		// -------------- draw character cursor ---------------- //
		if i == pos_char {
			var _arrow_offset_y = _character_section_offset_y + _character_section_height/2;
			var _arrow_offset_x = _box_offset_x + _box_width;
			draw_sprite_simplified_2(SPR_BATTLE_MENU_OVERVIEW_ARROW, _arrow_offset_x-1,_arrow_offset_y, 10, 10)
		

		}
	}
}

function menu_reset(_menu_object) {
	if instance_exists(_menu_object) with(_menu_object) menu_reset();
		
}

function check_focus() {
	var result = !has_focus(OBJ_X_MENU_TAB_ITEMS);
	return result;
}

function has_focus(_menu_object) {
	if !instance_exists(_menu_object) return false;
	with(_menu_object) return has_focus();
}