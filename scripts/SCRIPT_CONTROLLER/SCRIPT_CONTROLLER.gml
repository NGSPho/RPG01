// script that runs at the start of the fame
gml_pragma("global","initialize_global_variables()")


function initialize_global_variables() {
	print_log("Initializing global variables");
	global.rooms = 
	[
		"ROOM_BEDROOM",
		"ROOM_TITLE_SCREEN",
		"ROOM_FOREST",
		"ROOM_LIVING_ROOM"
	];
	global.start_room = ROOM_BEDROOM;
	global.current_bgm = 0;
}