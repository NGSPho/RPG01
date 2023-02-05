/*
[	Action,		Flee	]
[	Wait,				]
*/

enemy = [0];
ally = [0];


current_ally_turn_index = 0; // return the current index pointing to the ally whose turn it is to pick

// ----------action selection-------------- //
action_pos_x = 0;
action_pos_y = 0;
picked_actions = [0];

actions[0,0] = "Attack";
actions[0,1] = "Laugh";
actions[1,0] = "Wait";

// -----------------enemy selection--------------//
select_enemy_mode = false;
enemy_pos = 0;


/// switch to member selection mode
function start_member_selection() {
	select_enemy_mode = true;
}
function end_member_selection() {
	select_enemy_mode = false;
}