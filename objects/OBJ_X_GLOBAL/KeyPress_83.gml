/// @desc Save game


if menu_opened() == true {
	log("Can't save game here");
	exit;
}

room_goto(ROOM_SAVE_SCREEN)
