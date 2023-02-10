/// @desc Save game

if room == ROOM_INIT 
|| room == ROOM_BATTLE
|| room == ROOM_GAME_OVER
|| room == ROOM_TITLE_SCREEN {
	log("Can't save game here");
	exit;
}

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


var _string = json_stringify(_save_data)
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, "savedgame.save")

debug("Game saved! " + _string)