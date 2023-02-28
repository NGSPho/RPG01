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
			shader_set_for_battle(_enemy);
			draw_sprite_ext(_enemy.sprite_index, _enemy.image_index, _enemy.x, _enemy.y, _scale_enemies, _scale_enemies, 0, c_white, 1)
			shader_reset();
		}
	}
} 

function shader_set_for_battle(_enemy) {
	
	if (ko_time == 0)
		ko_time = current_time;
		
	var _height = sprite_get_height(_enemy.sprite_index)
	var _width = sprite_get_width(_enemy.sprite_index)
	
	var _shader_index = SHADER_MULTI_PHASE;	
	shader_set(_shader_index);
	
	var _sampler_duration = shader_get_uniform(_shader_index, "duration");
	shader_set_uniform_f(_sampler_duration, 1300.)
	
	var _sampler_time = shader_get_uniform(_shader_index, "time");
	shader_set_uniform_f(_sampler_time, current_time)

	
	var _sampler_start_time = shader_get_uniform(_shader_index, "start_time");
	shader_set_uniform_f(_sampler_start_time, ko_time)

 
	var _sampler_width = shader_get_uniform(_shader_index, "width");
	shader_set_uniform_f(_sampler_width, _width)
	
	var _sampler_height = shader_get_uniform(_shader_index, "height");
	shader_set_uniform_f(_sampler_height, _height)
}