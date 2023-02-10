/// @desc Load Game
with (OBJ_PLAYER) instance_destroy();

if (file_exists("savedgame.save") == true) {
	var _buffer = buffer_load("savedgame.save");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _load_data = json_parse(_string);
	
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
} else {
	debug("No save file found")
}	