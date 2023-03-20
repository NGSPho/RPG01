enum MENU_MODE {
	NO_FOCUS,
	CHARACTER_SELECTION,
	ITEM_SELECTION,
	TARGET_SELECTION,
	ACTION_VALIDATED
}

mode = MENU_MODE.ITEM_SELECTION;
box_sprite = SPR_X_MENU;

pos_x = 0;
pos_y = 0;

pos_target = 0;
selected_target = noone;
selected_item_stack = noone;




function menu_reset() {
	pos_x = 0;
	pos_y = 0;
}

function has_focus() {
	var _res = mode != MENU_MODE.NO_FOCUS;
	return _res;
}

function start_target_selection(_stack) {
	debug("Selecting target for item ", _stack.item.label);
	selected_item_stack = _stack;
	pos_target = 0;
	mode = MENU_MODE.TARGET_SELECTION;
}

function end_target_selection(_target, _stack) {
	debug("Picking target ",_target.label," for item ", _stack.item.label);
	consume_item_stack(_stack, _target);
	// remove item from inventory once quantity is 0
	var _ally = global.team[OBJ_X_MENU_TEAM_OVERVIEW.pos_char];
	if _stack.quantity == 0 {
		_ally.inventory[pos_x][ pos_y] = noone;
		mode = MENU_MODE.ITEM_SELECTION;
	} else {
		mode = MENU_MODE.TARGET_SELECTION;
	}
}