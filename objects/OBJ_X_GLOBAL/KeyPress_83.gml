/// @desc Save game


if room == ROOM_INIT 
|| room == ROOM_BATTLE
|| room == ROOM_GAME_OVER
|| room == ROOM_TITLE_SCREEN 
|| room == ROOM_SAVE_SCREEN {
	log("Can't save game here");
	exit;
}
room_goto(ROOM_SAVE_SCREEN)
