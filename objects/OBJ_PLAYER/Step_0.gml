event_inherited()

right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

x_spd = (right_key - left_key) * move_spd;
y_spd = (down_key - up_key) * move_spd;


// pause
if instance_exists(OBJ_X_PAUSER)
{
	x_spd = 0;
	y_spd = 0;
} else {
	// menu
	if keyboard_check(vk_escape)
	{
		room_goto(ROOM_TITLE_SCREEN);
		visible = false;
	}
}

// set sprite

if y_spd == 0
{
	if x_spd > 0 { face = RIGHT };
	if x_spd < 0 { face = LEFT };
}
if x_spd == 0
{
	if y_spd > 0 { face = DOWN };
	if y_spd < 0 { face = UP };
}


// collisions

if place_meeting(x + x_spd, y, OBJ_X_OBSTACLE) == true  
{
	x_spd = 0
}
if place_meeting(x, y + y_spd, OBJ_X_OBSTACLE) == true  
{
	y_spd = 0
}

x += x_spd;
y += y_spd;

mask_index = sprite[DOWN]

// TODO some checks needed but not super clean
if x_spd > 0 && face == LEFT { face = RIGHT; }
if x_spd < 0 && face == RIGHT { face = LEFT; }
if y_spd > 0 && face == UP { face = DOWN; }
if y_spd < 0 && face == DOWN { face = UP; }


sprite_index = sprite[face];

// animate

// when a player stops moving in a direction, in mid air for instance
// the animation must be completed and must not go back to the initial frame
// abruptely
function reset_frame() // TODO move 
{
	//image_speed = 0 // manually upd image frames
	var ind = floor(image_index)
	if ind > 1
	{
		image_index = ind + 1
	} else {
		image_index = 0
	}
}

if x_spd == 00 && y_spd == 00 {
	if floor(image_index) == 0
	{
		stop_moving = true
	} else {
		if stop_moving == true {
			image_index = 0
		}
	}
} else {
	stop_moving = false
}


