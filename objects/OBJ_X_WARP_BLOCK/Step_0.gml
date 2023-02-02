var player_in_bbox = place_meeting(x, y, OBJ_PLAYER) 

if instance_exists(OBJ_X_WARP) 
{
	// check if player spawns in or out the bbox
	was_player_outside = !player_in_bbox 
}
else if !player_in_bbox 
{ 
	was_player_outside = true 
}
else if was_player_outside == true
{
	// if player has been outside and collides with the block, warping is possible
	warp_player()
}



var function warp_player()
{
	var inst = instance_create_depth(0, 0, -1000, OBJ_X_WARP) // TODO get limit Integer
	inst.target_x = target_x; 
	inst.target_y = target_y;
	inst.target_room = target_room
	inst.target_face = target_face;
}