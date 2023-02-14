
save_box_x = camera_get_view_x(view_camera[0]) + 32;
save_box_y = camera_get_view_y(view_camera[0]) + 21;



function draw_save_files() {
	draw_set_font(save_font)
	// draw save overview
	var _save_y_offset = 0;
	for (var i=0; i<save_number; i++) {
		// display box
		draw_sprite_ext(box_spr, image_number, save_box_x, save_box_y + _save_y_offset, scale_x, scale_y, 0, c_white, 1)
	
		// display arrow
		if save_pos == i {
			draw_sprite_ext(SPR_BATTLE_MENU_ARROW, image_number, save_box_x - 9, save_box_y + _save_y_offset, 1, 1, 0, c_white, 1);
		}
		
		var load_data = load_data_arr[i]
		if load_data == noone {
			draw_centered_text(save_box_x, save_box_y, save_box_width, save_box_height, "empty")
		}  else {
			log("Load arr ", string(load_data))
		
			// TODO display team portrait, main char level, time played, place
		}
		
		_save_y_offset += dist_box + sprite_get_height(box_spr) * scale_y;
	}
}

function draw_main() {
		// draw save overview
		
	draw_set_font(main_font)
	var _save_y_offset = 0;
	for (var i=0; i<array_length(main_menu); i++) {
		// display box
		draw_sprite_ext(box_spr, image_number, save_box_x, save_box_y + _save_y_offset, scale_x, scale_y, 0, c_white, 1)
	
		// display arrow
		if save_pos == i {
			draw_sprite_ext(SPR_BATTLE_MENU_ARROW, image_number, save_box_x - 9, save_box_y + _save_y_offset, 1, 1, 0, c_white, 1);
		}
		//var _c = c_white;
		//draw_text_color(save_box_x, save_box_y + _save_y_offset,, _c, _c, _c, _c, 1);
		draw_centered_text(save_box_x, save_box_y + _save_y_offset, save_box_width, save_box_height, main_menu[i])
		log(main_menu[i])

		_save_y_offset += dist_box + sprite_get_height(box_spr) * scale_y;
	}
}

switch(mode) {
	case "MAIN": draw_main(); break;
	case "SAVE": draw_save_files(); break;
	case "LOAD": draw_save_files(); break;
}