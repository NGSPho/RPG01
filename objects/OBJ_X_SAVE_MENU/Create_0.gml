// ----------------- Create --------------------------- //
function populate_menu() {
	if (file_exists("savedgame.save") == true) {
		var _buffer = buffer_load("savedgame.save");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		load_data_arr[0] = json_parse(_string);
	} else {
		debug("No save file found")
	}	
}

function load_game() {
	var _load_data = load_data_arr[save_pos]
	with (OBJ_PLAYER) instance_destroy();
	
	while (array_length(_load_data) > 0) {
		
		var _load_entity = array_pop(_load_data);
		debug("Loaded save file ", string(_load_entity))
		room_goto(_load_entity.current_room)
		with(instance_create_layer(0, 0, layer, asset_get_index(_load_entity.obj))) {
			x = _load_entity.x
			y = _load_entity.y
			face = _load_entity.face
			current_room = _load_entity.current_room
		}
		debug("Loading OK")
	}

	instance_destroy()
}
	
// -------------------------- Step ----------------------- //

function move_cursor() {
	var _save_dir =  keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	save_pos = (save_pos + _save_dir + save_number) % save_number
	if _save_dir != 0 audio_play_sound(SOUND_EFFECT_BATTLE_CURSOR, 0, 0)
}


function step_main(_accept_key) {
	if _accept_key == true {
		switch(main_menu[save_pos]) {
			case "Exit": instance_destroy(); break;
			case "Save": mode = "SAVE"; break;
			case "Load": mode = "LOAD"; break;
		}
	}
}

function step_load(_accept_key, _return_key) {
	if _accept_key == true {
		if load_data_arr[save_pos] == noone {
			// play error sound
		} else {
			load_game()
		}
	
	} else if _return_key == true {
		mode = "MAIN";
		save_pos = 0;
	} else if _delete_key == true {
		load_data_arr[save_pos] = noone;
	}
}

function step_save(_accept_key, _return_key, _delete_key) {	
	if _accept_key == true {
			save_game()
	} else if _return_key == true {
		mode = "MAIN";
		save_pos = 0;
	} else if _delete_key == true {
		load_data_arr[save_pos] = noone;
	}
}

// -------------------------- Draw ----------------------- //



function save_game() {
	// Create save array
	var _save_data = array_create(0)

	// For every persistent ibject, create a struct
	with(OBJ_PLAYER) {
		var _save_entity = {
			obj: object_get_name(object_index),
			x : x,
			y : y,
			face : face,
			current_room: current_room
		}
		array_push(_save_data, _save_entity)
	}
	
	load_data_arr[save_pos] = _save_data

	var _string = json_stringify(_save_data)
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "savedgame.save")

	debug("Game saved! " + _string)
}

// array of json
load_data_arr = [noone, noone, noone];
save_pos = 0;
save_number = 3;
mode = "MAIN"; // can be "MAIN", "LOAD", "SAVE";
main_menu = ["Load", "Save", "Exit"];

///////////////////////
box_spr = SPR_TEXT_BOX
main_font = global.font_menu
save_font = global.font_textb
///////////////////////
scale_x = 9.72;
scale_y = 2.45;
save_box_width = sprite_get_width(box_spr) * scale_x;
save_box_height = sprite_get_height(box_spr) * scale_y;
dist_box = 7;

///////////////////


OBJ_NPC_ABSTRACT.visible = false;
OBJ_PLAYER.visible = false;
populate_menu();


//////////////////////////


