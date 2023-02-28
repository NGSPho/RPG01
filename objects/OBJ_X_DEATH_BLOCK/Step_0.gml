
var _player_in_bbox = place_meeting(x, y, OBJ_PLAYER) 
if _player_in_bbox
	kill_player();
	
function kill_player()
{	
	room_goto(ROOM_GAME_OVER);
}