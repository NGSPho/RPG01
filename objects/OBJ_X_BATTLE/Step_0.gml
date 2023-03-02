if !battle_over {
	if !setup_agents {
		place_agents(enemy_obj)
		setup_agents = true;
		var _battle_data = event_get(battle_id, EVENT_TYPE.BATTLE)
		triggered_event = _battle_data.triggered_event
		log("triggered event of battle ", battle_id, " is ", triggered_event)
	}


	if !has_team_lost(enemy) && !has_team_lost(global.team) {
	//if turn < 500 {
		// -------------- draw enemies---------------------//
		if !instance_exists(OBJ_X_BATTLE_ANIMATION) && !instance_exists(OBJ_X_BATTLE_MENU_ACTION) {
			log("Initializating turn ", turn);		
			create_battle_action_menu(global.team, enemy);
			turn++;
		}

	} else if !instance_exists(OBJ_X_BATTLE_ANIMATION) {
	
		log("Battle is over.")
		if has_team_lost(global.team) room_goto(ROOM_GAME_OVER)
		else process_victory(global.team, enemy)
		battle_over = true;
	}

} else {
	if !instance_exists(OBJ_X_TEXT_BOX) {
		
		// no text box
		log("No text box");
		// launch event after the battle
		if triggered_event != noone {
			play_event(triggered_event.event_id, triggered_event.event_type, caller);
		}
		instance_destroy();
		

	}
}

