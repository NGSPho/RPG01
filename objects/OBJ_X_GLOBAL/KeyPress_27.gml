
	
if menu_opened() == true {
	log("Can't go to title screen from here");
	exit;
}
room_goto(ROOM_TITLE_SCREEN)
