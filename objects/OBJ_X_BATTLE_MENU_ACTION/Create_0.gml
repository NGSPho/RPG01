/*
[	Action,		Flee	]
[	Wait,				]
*/


current_ally_turn_index = 0; // return the current index pointing to the ally whose turn it is to pick

// -------------- action selection --------------- //
action_pos_x = 0;
action_pos_y = 0;
// Data type is { origin, attack target dmg }
selected_actions = [0];

actions[0,0] = "Attack";
actions[0,1] = "Laugh";
actions[1,0] = "Wait";

// ----------------- enemy selection --------------//
select_target_mode = false;
enemy_pos = 0;


// ------------ Object functions ------------- /
/// Switch menu to target selection mode
/// @param _origin The ally, source of the action
/// @param _action The name of the action
/// @param _target_filter Filter on the target, ie, KO filter
function start_target_selection(_origin, _action, _fighter_selection_filter) {
	selected_actions[current_ally_turn_index][0] = _origin
	selected_actions[current_ally_turn_index][1] = _action;
	// Set the initial enemy cursor
	enemy_pos = find_first(OBJ_X_BATTLE.enemy, {KO : false})
	select_target_mode = true;
	
}

function end_target_selection(_ally, _action, _target) {
	select_target_mode = false;
	selected_actions[current_ally_turn_index][2] = _target;
	increment_ally_index();
	
}

function start_action(_ally, _action) {
	selected_actions[current_ally_turn_index][0] = _ally;
	selected_actions[current_ally_turn_index][1] = _action;
	selected_actions[current_ally_turn_index][2] = noone;
}

function end_action(_ally, _action) {	
	increment_ally_index();
}

function undo_target_selection() {
	select_target_mode = false;
	selected_actions[current_ally_turn_index] = 0;
}

function increment_ally_index() {
	current_ally_turn_index++;
}




// ------------ Struct definition ------------- //

 var fighter_selection_filter = {
	 // filter the KO fighters //
	KO : true,
}