function play_battle(_battle_id, _caller = noone) {
	room_goto(ROOM_BATTLE)
	var _battle_data = event_get(_battle_id, EVENT_TYPE.BATTLE);
	with (instance_create_depth(x, y, -100, OBJ_X_BATTLE)) {
		enemy_obj = _battle_data.monsters;
		battle_id = _battle_id;
		caller = _caller;
		debug("Creating battle with caller ", caller);
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


}


/// draw a health bar given fighter, x, y, width and height of the bar
// @param _x is the height of the colored bar, warning sprite of the border can be higher than that, same for y
// @param _y is the vertical offset
// @param _width is the desired width of the bar, the border can be wider, same as height
// @param _height is the desired height of the bar
// @param [border] display the border or not
// @param [mode] str that is either HP or MP TODO move to enum
function draw_agent_bar(_agent, _x, _y, _width, _height, border = true, mode = "HP") {
	// -------- draw the colored bar ------ //
	var _bar_back_sprite = SPR_BATTLE_MENU_HEALTH_BAR_BACK;
	var _bar_sprite;
	var _bar_percentage;
	var _bar_sprite;
	if mode == "HP" {
		_bar_percentage = _agent.HP / _agent.MAX_HP;
		if 0.4 < _bar_percentage && _bar_percentage < 0.7 
			_bar_sprite = SPR_BATTLE_MENU_HEALTH_BAR_MEDIUM;
		else if 0.4 >= _bar_percentage 
			_bar_sprite = SPR_BATTLE_MENU_HEALTH_BAR_LOW;
		else
			_bar_sprite = SPR_BATTLE_MENU_HEALTH_BAR_HIGH;
	} else if mode == "MP" {
		_bar_percentage = _agent.MP / _agent.MAX_MP;
		_bar_sprite = SPR_BATTLE_MENU_MAGIC_BAR;
	} else {
		throw("Argument mode "+mode+" is not recognized.");
	}

	var _bar_scale_x = _width/sprite_get_width(_bar_sprite);
	var _bar_scale_y = _height/sprite_get_height(_bar_sprite);

	draw_sprite_simplified(_bar_back_sprite, _x, _y, _bar_scale_x, _bar_scale_y)
	draw_sprite_simplified(_bar_sprite, _x, _y, _bar_scale_x*_bar_percentage, _bar_scale_y)
	
	if border == false return;
	var _border_sprite = SPR_BATTLE_MENU_HEALTH_BAR_BORDER;
	var _bar_box_nine_slice = sprite_get_nineslice(_border_sprite);
	// actual width
	var _bar_border_sprite_width = sprite_get_width(_border_sprite);
	var _bar_border_sprite_height = sprite_get_height(_border_sprite);
	// target width
	var _bar_border_width = _width+_bar_box_nine_slice.right+_bar_box_nine_slice.left;
	var _bar_border_height = _height+_bar_box_nine_slice.top+_bar_box_nine_slice.bottom
	var _bar_border_scale_x = _bar_border_width/_bar_border_sprite_width;
	var _bar_border_scale_y = _bar_border_height/_bar_border_sprite_height;
	
	
	draw_sprite_simplified(_border_sprite, _x-_bar_box_nine_slice.right, _y-_bar_box_nine_slice.top, _bar_border_scale_x, _bar_border_scale_y)
	
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
	var _action_type = _action.type;
	var _target = _action.target;
	//log("Action is o:", _origin, " n:", _action_name, " t:", _target)
	//----  compute damage ----//
	switch(_action.type) {
		case ACTION_TYPE.ATTACK: handle_damage_action_type_attack(_action); break;
		case ACTION_TYPE.ITEM: handle_damage_action_type_item(_action); break;
		case ACTION_TYPE.MISC: debug("TODO"); break;
		default: throw("Action type not handled");
	}
}

function handle_damage_action_type_attack(_action) {
	if is_targetted_attack(_action) {
		var _dmg = -1*_action.origin.ATK / _action.target.DEF
		_action.dmg = _dmg;
	}
}

function handle_damage_action_type_item(_action) {
	var _item =  _action.item_stack.item;
	if is_targetted_attack(_action) {
		if _item.effect.attribute == ATTRIBUTE.HP {
			var _dmg = _item.effect.value;
			_action.dmg = _dmg;
		}
	}
}
function apply_damage(_action) {
	var _origin = _action.origin;
	var _action_type = _action.type;
	if !is_targetted_attack(_action) return;
	var _target = _action.target;
	if _origin.HP <= 0 // TODO remove security
		return;
	if _target.HP > 0 { 
		var _dmg = _action.dmg;
		_target.HP = max(_target.HP + _dmg, 0);
		_origin.HP = max(0,_origin.HP-1);
		_origin.MP = max(0,_origin.MP-1);
		log("Target ", object_get_name(_target.object_index), " HP turned to ", _target.HP);
	} else {
		 debug("TODO need to redirect attack on another monster");
	}
}


/// Retrieve animation sprite from action
function retrieve_sprite_from_action(_action_type) {
	switch(_action_type) {
		case ACTION_TYPE.ATTACK: return SPR_BATTLE_ANIMATION_ATTACK_SLASH;
		case ACTION_TYPE.ITEM: return SPR_BATTLE_ANIMATION_ATTACK_HOLY_01;
		case ACTION_TYPE.MISC: return noone;
		default : throw("Unknown attack name.");
	}
}

/// Retrieve animation sprite from action name
function retrieve_audio_from_action(_action_type) {
	switch(_action_type) {
		case ACTION_TYPE.ATTACK: return SOUND_EFFECT_BATTLE_SLASH;
		case ACTION_TYPE.ITEM: return SOUND_EFFECT_MENU_ITEM_HEAL;
		case ACTION_TYPE.MISC: return noone;
		default : throw("Unknown attack name.");
	}
}

/// Check if the action is a targetted attach or not (if index 2 has a target)
/// @param _action_name The label of the action
function is_targetted_attack(_action) {
	return _action.target != noone;
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
	var _nb_players = count_matches(_allies, { KO : false});
	var _index = find_first(_allies, { KO : false})
	var _start = _index
	var _loot_index = 0;
	var _tdb = text_data_builder_create();
	do {
		var _gained_XP = floor(_total_XP/_nb_players);
		var _str = _allies[_index].label+" gagne "+string(_gained_XP)+" points d'experience."
		
		text_data_builder_append(_tdb, _str, noone, noone)
		
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
		text_data_builder_append(_tdb, _str, SOUND_EFFECT_BATTLE_LEVEL_UP, noone)
	}
	// TODO import XP sheets
}



// battles file BATTLE_ID	TYPE	MONSTERS	EVENT_ID	EVENT_TYPE
function load_battle() {
	var _csv = load_csv(global.event_folder+"battle.csv")
	var _height = ds_grid_height(_csv);
	var _battle_map = ds_map_create()
	
	for (var i=1; i<_height; i++) {
		var _battle_id = _csv[# 0, i]
		var _monsters_names = string_split(_csv[#2, i], " ");
		var _monsters = array_create(0);
		for (var j=0; j<array_length(_monsters_names); j++) {
			array_push(_monsters, asset_get_index(_monsters_names[j]))
		}
		var _event_id = string_return_noone_if_empty(_csv[#3, i])
		var _event_type = string_return_noone_if_empty(_csv[#4, i])
		var _triggered_event = noone;
		if _event_id != noone {
			if _event_type == noone throw("Battle id "+_battle_id+" : following event can't have an empty type if id is specified.")
			_triggered_event = {
				event_id : _event_id,
				event_type : EVENT_TYPE_get(_event_type),
			}
		}
	
		var _battle_data = {
			battle_id : _battle_id,
			type : _csv[# 1, i],
			monsters : _monsters,
			triggered_event : _triggered_event
		}
		
		//log("Add battle data " + string(_battle_data))
		item_map_build(_battle_map, _battle_id, _battle_data)
	}
	ds_grid_destroy(_csv);
	return _battle_map;
	
}