var _scale_enemies = 1; // TODO doesn't work
if !has_team_lost(enemy) || !has_team_lost(global.team) {
//if turn < 500 {
	// -------------- draw enemies---------------------//
	
	for (var i=0; i<array_length(enemy); i++) {
		var _enemy = enemy[i];
		if _enemy.KO = false {
			shader_set_monster_attacked(_enemy);
			draw_sprite_simplified(_enemy.sprite_index, _enemy.x, _enemy.y, _scale_enemies, _scale_enemies, _enemy.image_index)
			shader_reset();
			//-------------- Draw the health bar -------------//
			var _health_bar_y =  _enemy.y + 115;
			var _health_bar_height = 3;
			var _health_bar_width = 30;
			// center health bar
			var _x = _enemy.x - _health_bar_width/2;
			draw_agent_bar(_enemy, _x, _health_bar_y, _health_bar_width, _health_bar_height);
		} else {
			shader_set_monster_kill(_enemy);
			draw_sprite_simplified(_enemy.sprite_index, _enemy.x, _enemy.y, _scale_enemies, _scale_enemies, _enemy.image_index)
			shader_reset();
		}
	}
} 
