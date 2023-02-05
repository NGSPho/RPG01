var _scale_enemies = 1; // TODO doesn't work

if !has_team_lost(enemy) {
//if turn < 500 {
	// -------------- draw enemies---------------------//
	for (var i=0; i<array_length(enemy); i++) {
		draw_sprite_ext(enemy[i].sprite_index, enemy[i].image_index, enemy[i].x, enemy[i].y, enemy[i].sprite_width/enemy[i].width * _scale_enemies, enemy[i].sprite_height/enemy[i].width * _scale_enemies, 0, c_white, 1)
	}
	
	if !instance_exists(OBJ_X_BATTLE_ANIMATION) && !instance_exists(OBJ_X_BATTLE_MENU_ACTION) {
		log("Initializating turn ", turn);		
		create_battle_action_menu(ally, enemy);
		turn++;
		
	
	}
	

} else {
	D_battle_over = true;
	log("Battle is over.")
	//instance_destroy()
}



