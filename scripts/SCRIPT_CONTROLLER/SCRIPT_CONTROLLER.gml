

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
	global.font_menu = font_add_sprite(SPR_FONT_L, 32, true, 1);
	global.font_textb = font_add_sprite(SPR_FONT_S, 32, true, 1);
	global.scale_portrait = 3;
}