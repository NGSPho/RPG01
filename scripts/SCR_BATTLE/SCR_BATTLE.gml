function play_battle(_battle_id) {
	room_goto(ROOM_BATTLE)
	var _battle_data = event_get(_battle_id, EVENT_TYPE.BATTLE);
	with (instance_create_depth(x, y, -100, OBJ_X_BATTLE)) {
		enemy_obj = _battle_data.monsters
		battle_id = _battle_id
	}
}

/// Place agents in the viewport
function place_agents(_enemies_obj) {
	var _view_x = camera_get_view_x(view_camera[0]);
	var _view_y = camera_get_view_y(view_camera[0]);

	for (var i=0; i<array_length(_enemies_obj); i++) {
		var _x = _view_x + 50; // TODO center
		var _y = _view_y + 30;
		if i>0 {
			var _left_enemy = OBJ_X_BATTLE.enemy[i-1]
			_x = _left_enemy.x + _left_enemy.width;
		}
		log("Placing enemy", object_get_name(_enemies_obj[i]))
		var _enemy = instance_create_depth(_x, _y, 100, _enemies_obj[i])
		with(_enemy) {
			x = _x;
			y = _y;
			width = sprite_width
		}
		_enemy.x = _x;
		_enemy.y = _y;
		OBJ_X_BATTLE.enemy[i]= _enemy
		log("Create enemy : ", OBJ_X_BATTLE.enemy[i], "named ", object_get_name(OBJ_X_BATTLE.enemy[i].object_index), " at x ", _x , " y ", _y)	
	}

	for (var i=0; i<array_length(global.team); i++) {
		var _ally = global.team[i];
		_ally.visible = false;	
	}
}

function has_team_lost(_team) {
	//log("Checking if team has lost : ", _team);
	for (var i=0; i<array_length(_team); i++) {
		var _teammate = _team[i];
		if _teammate.HP > 0 return false 
	}
	return true	
}



function create_battle_action_menu(_ally_arr, _enemy_arr) {
	with(instance_create_depth(10,10,-16000, OBJ_X_BATTLE_MENU_ACTION)) {
		ally = _ally_arr;
		enemy = _enemy_arr;
	}
}

function create_battle_animation(_actions) {
	log("Starting battle animation")
	var battle_animation = instance_create_depth(0,0,-100, OBJ_X_BATTLE_ANIMATION)
	with(battle_animation) {
		actions = _actions
	}
}

/// Compute battle outcome, that is to say, status, damages, etc
function compute_damage(_action) {
	var _origin = _action.origin;
	var _action_name = _action.action;
	var _target = _action.target;
	//log("Action is o:", _origin, " n:", _action_name, " t:", _target)
	//----  compute damage ----//
	if is_targetted_attack(_action_name) {
		var _dmg = -1*_origin.ATK / _target.DEF
		_action.dmg = _dmg
	}
}


function apply_damage(_action) {
	var _origin = _action.origin;
	var _action_name = _action.action;
	if !is_targetted_attack(_action_name) return;
	var _target = _action.target;

	if _target.HP > 0 {
		var _dmg = _action.dmg
		_target.HP += _dmg
		log("Target ", object_get_name(_target.object_index), " HP turned to ", _target.HP);
	} 
}


/// Retrieve animation sprite from action
function retrieve_sprite_from_action(_action_name) {
	switch(_action_name) {
		case("Attack"): return SPR_BATTLE_ANIMATION_ATTACK_SLASH;
		case("Wait"): return noone;
		case("Laugh"): return noone;
		default : throw("Unknown attack name.");
	}
}

/// Retrieve animation sprite from action name
function retrieve_audio_from_action(_action_name) {
	switch(_action_name) {
		case("Attack"): return SOUND_EFFECT_BATTLE_SLASH;
		case("Wait"): return noone;
		case("Laugh"): return noone;
		default : throw("Unknown attack name.");
	}
}

/// Check if the action is a targetted attach or not (if index 2 has a target)
/// @param _action_name The label of the action
function is_targetted_attack(_action_name) {
	return array_contains(["Attack"], _action_name);
}
	
// ------------------------------ Victory menu ------------------------------------- //
/// Create the experience menu and apply the experience gain
///@param _ally The fighters that where in the fight
///@param _enemies The enemies that were defeated
function process_victory(_allies, _enemies) {
	distribute_XP(_allies, _enemies);
}

/// Distribue les points de compétences
///
function distribute_XP(_allies, _enemies) {
	var _total_XP = 0;
	for (var i=0; i<array_length(_enemies); i++) 
		_total_XP += _enemies[i].XP;
	// -- ditribute xp only to non KO allies -- //
	var _nb_players = count_matches(_allies, { KO : false})
	var _index = find_first(_allies, { KO : false})
	var _start = _index
	var _loot_index = 0;
	var _tdb = text_data_builder_create();
	do {
		var _gained_XP = _total_XP/_nb_players
		var _str = _allies[_index].label+" gagne "+string(_gained_XP)+" points d'experience."
		
		text_data_builder_append(_tdb, _str, noone)
		
		apply_XP(_allies[_index], _gained_XP, _tdb);
		//gains[_loot_index] = [_gained_XP];
		
		_index = find_next(_allies, _index, { KO : false}, 1, false)
	} until (_index == -1 || _index == _start )
	
	audio_play_sound(SOUND_EFFECT_BATTLE_VICTORY, 1, 0)
	create_textbox(_tdb);
}


function apply_XP(_ally, _XP, _tdb) {
	_ally.XP += _XP;
	var _XP_required_to_level_up = 6;
	if _ally.XP >= _XP_required_to_level_up {
		_ally.LVL ++;
		_ally.XP -= _XP_required_to_level_up;
		var _str = _ally.label + " levels up to level " + string(_ally.LVL);
		log(_str);
		text_data_builder_append(_tdb, _str, SOUND_EFFECT_BATTLE_LEVEL_UP)
	}
	// TODO import XP sheets
}