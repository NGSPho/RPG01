/*
[	Action,		Flee	]
[	Item,		Wait				]
*/


current_ally_turn_index = 0; // return the current index pointing to the ally whose turn it is to pick

// -------------- action selection --------------- //
action_pos_x = 0;
action_pos_y = 0;
// Data type is { origin, attack target dmg }
selected_actions = [0];

actions[0,0] = "Attack";
actions[0,1] = "Laugh";
actions[1,0] = "Item";
actions[1,1] = "Wait";

// ----------------- enemy/item selection --------------//
enemy_pos = 0;
item_pos = 0;
item_display_pos = 0; // the index of the first item displayed
item_display_max = 3; // the max number of items displayed in item selection menu
ally_pos = 0;
selected_item_stack = noone;


mode = ACTION_MENU_MODE.ACTION_SELECTION;

enum ACTION_MENU_MODE {
	ACTION_SELECTION,
	ATTACK_TARGET_SELECTION,
	ITEM_SELECTION,
	ITEM_TARGET_SELECTION
}
enum ACTION_TYPE {
	ATTACK,
	ITEM,
	MISC
}
// ------------ Object functions ------------- /
/// Switch menu to target selection mode
/// @param _origin The ally, source of the action
/// @param _target_filter Filter on the target, ie, KO filter
function start_attack_target_selection(_origin, _fighter_selection_filter) {
	selected_actions[current_ally_turn_index] = init_action()
	selected_actions[current_ally_turn_index].origin = _origin
	selected_actions[current_ally_turn_index].type = ACTION_TYPE.ATTACK;
	// Set the initial enemy cursor
	enemy_pos = find_first(OBJ_X_BATTLE.enemy, {KO : false})
	mode = ACTION_MENU_MODE.ATTACK_TARGET_SELECTION;
	
}

function end_target_selection(_target) {
	mode = ACTION_MENU_MODE.ACTION_SELECTION;
	selected_actions[current_ally_turn_index].target = _target;
	increment_ally_index();
	
}

function start_item_selection(_origin) {
	selected_actions[current_ally_turn_index] = init_action()
	selected_actions[current_ally_turn_index].origin = _origin;
	selected_actions[current_ally_turn_index].type =  ACTION_TYPE.ITEM;
	mode = ACTION_MENU_MODE.ITEM_SELECTION;
}

function start_item_target_selection(_stack_item) {
	// Set the initial enemy cursor
	enemy_pos = find_first(OBJ_X_BATTLE.enemy, {KO : false})
	selected_actions[current_ally_turn_index].item_stack =  _stack_item;
	mode = ACTION_MENU_MODE.ITEM_TARGET_SELECTION;
}

function full_action(_ally, _action) {
	selected_actions[current_ally_turn_index] = init_action()
	selected_actions[current_ally_turn_index].origin = _ally;
	selected_actions[current_ally_turn_index].type =  ACTION_TYPE.MISC;
	selected_actions[current_ally_turn_index].target = noone;
	selected_actions[current_ally_turn_index].dmg = noone;
	increment_ally_index();
}

function undo_target_selection() {
	mode = ACTION_MENU_MODE.ACTION_SELECTION;
	selected_actions[current_ally_turn_index] = init_action();
}

function undo_item_selection() {
	mode = ACTION_MENU_MODE.ACTION_SELECTION;
	selected_actions[current_ally_turn_index]= init_action();
}

function increment_ally_index() {
	current_ally_turn_index++;
}


// clean items with quantity 0, todo move
for (i=0; i<array_length(global.team); i++) {
	var _sorted_inventory = global.team[i].battle_inventory; //TODO sort inventory
	global.team[i].battle_inventory = array_filter(_sorted_inventory, function(_item){return _item.quantity>0});		
}


// ------------ Struct definition ------------- //

 var fighter_selection_filter = {
	 // filter the KO fighters //
	KO : true,
}