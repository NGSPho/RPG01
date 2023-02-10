
function has_team_lost(_team) {
	//log("Checking if team has lost : ", _team);
	for (var i=0; i<array_length(_team); i++) {
		var _teammate = _team[i];
		if _teammate.HP > 0 return false 
	}
	return true	
}



function create_battle_action_menu(_ally_arr, _enemy_arr) {
	with(instance_create_depth(10,10,-100, OBJ_X_BATTLE_MENU_ACTION)) {
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
	var _origin = _action[0];
	var _action_name = _action[1];
	var _target = _action[2];
	//log("Action is o:", _origin, " n:", _action_name, " t:", _target)
	//----  compute damage ----//
	if is_targetted_attack(_action_name) {
		var _dmg = -1*_origin.ATK / _target.DEF
		_action[3] = _dmg
	}
}


function apply_damage(_action) {
	var _origin = _action[0];
	var _action_name = _action[1];
	if !is_targetted_attack(_action_name) return;
	var _target = _action[2];

	if _target.HP > 0 {
		var _dmg = _action[3]
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
	var _sb = string_builder_create();
	do {
		var _gained_XP = _total_XP/_nb_players
		var _str = _allies[_index].label+" gagne "+string(_gained_XP)+" points d'experience."
		
		string_builder_append(_sb, _str)
		
		_allies[_index].XP += _gained_XP
		//gains[_loot_index] = [_gained_XP];
		
		_index = find_next(_allies, _index, { KO : false}, 1, false)
	} until (_index == -1 || _index == _start )
	
	audio_play_sound(SOUND_EFFECT_BATTLE_VICTORY, 1, 0)
	//create_textbox(["You won !", "The team gained "+string(_total_XP)+" total so "+string(_total_XP/_nb_players)+" each."])
	create_textbox(_sb)
}


