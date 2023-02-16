var _scale_enemies = 1; // TODO doesn't work
if !has_team_lost(enemy) || !has_team_lost(global.team) {
//if turn < 500 {
	// -------------- draw enemies---------------------//
	for (var i=0; i<array_length(enemy); i++) {
		var _enemy = enemy[i];
		if _enemy.KO = false {
			//("Display enemy ", object_get_name(_enemy.object_index))
			draw_sprite_ext(_enemy.sprite_index, _enemy.image_index, _enemy.x, _enemy.y, _scale_enemies, _scale_enemies, 0, c_white, 1)
		} else {
			//log("Enemy ", object_get_name(_enemy.object_index))
			// don't display koed enemy
			shader_set(SHADER_BATTLE_DEATH)
			draw_sprite_ext(_enemy.sprite_index, _enemy.image_index, _enemy.x, _enemy.y, _scale_enemies, _scale_enemies, 0, c_white, 1)
			shader_reset()
		}
	}
} 