
sprite = ds_map_find_value(global.spr_name_to_sprites, "SLIME_00")
current_room = global.start_room


// --------- movement animation --------- //
x_spd = 0;
y_spd = 0;
move_spd = 1;
face = DOWN;
stop_moving = true; // next time frame is index 0, set to true until arrow key is pressed..

// ------------ battle stats ------------ //
MAX_HP = 3;
ATK = 1;
DEF = 0;
HP = MAX_HP;

label = "Main";

XP = 0;
LVL = 0;

portrait = SPR_CHAR_PORTRAIT_SLIME_00_NEUTRAL