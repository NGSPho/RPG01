draw_set_font(font)


function draw_save_files() {
	// draw save overview
	var _save_y_offset = 0;
	for (var i=0; i<save_number; i++) {
		// display box
		draw_sprite_ext(box_spr, image_number, save_box_x, save_box_y + _save_y_offset, scale_x, scale_y, 0, c_white, 1)
	
		// display arrow
		if save_pos == i {
			draw_sprite_ext(SPR_BATTLE_MENU_ARROW, image_number, save_box_x - 9, save_box_y + _save_y_offset, 1, 1, 0, c_white, 1);
		}
		var _c = c_white;
		var load_data = load_data_arr[i]
		if load_data == noone {
			draw_text_color(save_box_x, save_box_y + _save_y_offset, "empty", _c, _c, _c, _c, 1);
		}  else {
			log("Load arr ", string(load_data))
		
			// TODO display team portrait, main char level, time played, place
		}
		
		_save_y_offset += dist_box + sprite_get_height(box_spr) * scale_y;
	}
}

function draw_main() {
		// draw save overview
	var _save_y_offset = 0;
	for (var i=0; i<array_length(main_menu); i++) {
		// display box
		draw_sprite_ext(box_spr, image_number, save_box_x, save_box_y + _save_y_offset, scale_x, scale_y, 0, c_white, 1)
	
		// display arrow
		if save_pos == i {
			draw_sprite_ext(SPR_BATTLE_MENU_ARROW, image_number, save_box_x - 9, save_box_y + _save_y_offset, 1, 1, 0, c_white, 1);
		}
		var _c = c_white;
		draw_text_color(save_box_x, save_box_y + _save_y_offset, main_menu[i], _c, _c, _c, _c, 1);


		_save_y_offset += dist_box + sprite_get_height(box_spr) * scale_y;
	}
}

switch(mode) {
	case "MAIN": draw_main(); break;
	case "SAVE": draw_save_files(); break;
	case "LOAD": draw_save_files(); break;
}