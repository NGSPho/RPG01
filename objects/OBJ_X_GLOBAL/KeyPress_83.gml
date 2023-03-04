/// @desc Save game


if room_is_menu(room) {
	log("Can't save game here");
	exit;
}

if !instance_exists(OBJ_X_PAUSER)
	room_goto(ROOM_SAVE_SCREEN)
else
	log("Can't save rn");
