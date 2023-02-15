if (instance_exists(OBJ_X_BATTLE_ANIMATION_ATTACK) == false) {
	if current_action_index == array_length(actions) {
		instance_destroy()
	} else {
		var _action = actions[current_action_index];
		debug("Processing animation for action ", string(_action));
		var _origin = _action.origin;
		var _action_name = _action.action;
		var _target = _action.target;
		var _dmg = compute_damage(_action)
		if _action.dmg != noone
			_dmg =_action.dmg;
		var _spr = retrieve_sprite_from_action(_action_name)
		var _audio = retrieve_audio_from_action(_action_name)
		
		if is_targetted_attack(_action_name) {
			if _target.HP <= 0 {
				log("Target is already KO, not animating");
			} else {
				apply_damage(_action)
				with instance_create_depth(0, 0, -999, OBJ_X_BATTLE_ANIMATION_ATTACK) {
					origin = _origin;
					action_name = _action_name;
					target = _target;
					dmg = _dmg;
					audio = _audio;
			
					if _spr != noone sprite_index = _spr;
					if audio != noone audio_play_sound(audio, 1, 0) // TODO move in creator somehow
				}
			}
		}
		current_action_index ++;
	} 
}

