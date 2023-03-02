
function check_trigger()
{
	if instance_exists(OBJ_X_TEXT_BOX) == true { return false; }
	return position_meeting(mouse_x, mouse_y, id) && mouse_check_button_pressed(mb_left)
}

if check_trigger() == true
{
	// TODO fix it and save interaction count in a global array or smt
	interaction_count ++;
	debug("Increment interaction count to ", interaction_count);
	play_text(text_id, self.id);
}