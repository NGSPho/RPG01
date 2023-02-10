

if !has_team_lost(enemy) && !has_team_lost(global.team) {
//if turn < 500 {
	// -------------- draw enemies---------------------//
	if !instance_exists(OBJ_X_BATTLE_ANIMATION) && !instance_exists(OBJ_X_BATTLE_MENU_ACTION) {
		log("Initializating turn ", turn);		
		create_battle_action_menu(global.team, enemy);
		turn++;
	}

} else if D_battle_over == false {
	D_battle_over = true;
	log("Battle is over.")
} 

if !instance_exists(OBJ_X_BATTLE_ANIMATION) && D_battle_over == true{
	if has_team_lost(global.team) room_goto(ROOM_GAME_OVER)
	else process_victory(global.team, enemy)
	// drop
	instance_destroy()
}

