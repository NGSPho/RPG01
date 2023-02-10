


function resume() 
{

	if !instance_exists(OBJ_PLAYER) { room_goto(global.start_room); return }
	OBJ_PLAYER.visible = true
	room_goto(OBJ_PLAYER.current_room); 
}


// get inputs
up_key = keyboard_check_pressed(vk_up)
down_key = keyboard_check_pressed(vk_down)
accept_key = keyboard_check_pressed(vk_enter)

// stopre nb of options in current menu
op_length = array_length(options[menu_level])

// move through options
pos = abs(pos + down_key - up_key) mod op_length;


// setting options
if accept_key 
{
	switch(menu_level)
	{
		case 0:
		{
			switch(pos) 
			{
				// Resume game
				case 0: resume() ; break;
				// settings
				case 1: menu_level = 1; pos = 0; break;
				// quit
				case 2: game_end(); break;
				default: break;
			}
			break;
		}
		case 1:
		{
			switch(pos)
			{	
				case 3: menu_level = 0; pos = 0; break;
				default: break;
			}
			break;
		}
	}
}


