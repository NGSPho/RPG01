

function handle_attack(_action) {
	
	compute_damage(_action);
	apply_damage(_action)
	with instance_create_depth(0, 0, -9999, OBJ_X_BATTLE_ANIMATION_ATTACK) {
		origin = _action.origin;
		target = _action.target;
		dmg = _action.dmg;
		audio = _action.audio;
			
		if _action.spr != noone sprite_index = _action.spr;
		if _action.audio != noone audio_play_sound(_action.audio, 1, 0) // TODO move in creator somehow
	}
}

function handle_item(_action) {	
	consume_item_stack(_action.item_stack, _action.target)
	with instance_create_depth(0, 0, -9999, OBJ_X_BATTLE_ANIMATION_ATTACK) {
		origin = _action.origin;
		target = _action.target;
		dmg = _action.dmg;
		audio = _action.audio;
		
		if _action.spr != noone sprite_index = _action.spr;
		if _action.audio != noone audio_play_sound(_action.audio, 1, 0) // TODO move in creator somehow
	}
}

function handle_misc(_action) {
	debug("Anim for misc");
}

if (instance_exists(OBJ_X_BATTLE_ANIMATION_ATTACK) == false) {
	if current_action_index == array_length(actions) {
		if timer <= 0
			instance_destroy()
		else
			timer--;
	} else {
		var _action = actions[current_action_index];
		_action.spr = retrieve_sprite_from_action(_action.type)
		_action.audio = retrieve_audio_from_action(_action.type)
		debug("Processing animation for action ", string(_action));
		
		if is_targetted_attack(_action) {
			if _action.target.HP <= 0 {
				log("Target is already KO, not animating");
			} else {
				switch (_action.type) {
					case ACTION_TYPE.ATTACK: handle_attack(_action); break;
					case ACTION_TYPE.ITEM: handle_item(_action); break;
					case ACTION_TYPE.MISC: handle_misc(); break;
					default: TODO();
				}
			}
		}
		current_action_index ++;
	} 
}
