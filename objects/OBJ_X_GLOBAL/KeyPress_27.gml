
	
if room_is_menu(room) {
	log("Can't go to title screen from here");
	exit;
}
if !instance_exists(OBJ_X_PAUSER)
	room_goto(ROOM_TITLE_SCREEN)
else
	log("Can't exit rn");
