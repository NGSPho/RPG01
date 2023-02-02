x_spd = 0;
y_spd = 0;
move_spd = 1;

sprite[0] = SPR_CHAR_SLIME_RIGHT;
sprite[1] = SPR_CHAR_SLIME_UP;
sprite[2] = SPR_CHAR_SLIME_LEFT;
sprite[3] = SPR_CHAR_SLIME_DOWN;

face = DOWN;

current_room = global.start_room
stop_moving = true; // nect time frame is index 0, set to true until key is pressed..