
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

}

// array of json
load_data_arr = [noone, noone, noone];
save_pos = 0;
save_number = 3;

///////////////////////
box_spr = SPR_TEXT_BOX
font = global.font_textb
///////////////////////
save_box_x = camera_get_view_x(view_camera[0]) + 32;
save_box_y = camera_get_view_y(view_camera[0]) + 21;
scale_x = 9.72;
scale_y = 2.45;
dist_box = 7;

///////////////////


OBJ_NPC_ABSTRACT.visible = false;
OBJ_PLAYER.visible = false;
populate_menu();


//////////////////////////


