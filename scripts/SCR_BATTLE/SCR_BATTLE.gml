
function has_team_lost(_team) {
	//log("Checking if team has lost : ", _team);
	for (var i=0; i<array_length(_team); i++) {
		var _teammate = _team[i];
		if _teammate.HP == 0 return true 
	}
	return false	
}



function create_battle_action_menu(_ally_arr, _enemy_arr) {
	with(instance_create_depth(10,10,-100, OBJ_X_BATTLE_MENU_ACTION)) {
		ally = _ally_arr;
		enemy = _enemy_arr;
	}
}

function create_battle_animation() {
	log("Starting battle animation")
	var battle_animation = instance_create_depth(0,0,-100, OBJ_X_BATTLE_ANIMATION)
}