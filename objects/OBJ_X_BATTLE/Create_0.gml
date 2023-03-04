enemy_obj = array_create(0)
enemy = array_create(0)

turn = 0
// [ attacker, action, target ]
actions[0, 0] = 0;

battle_over = false;

battle_id = noone;
triggered_event = noone;


setup_agents = false;

ko_time = 0;

agents_hide();
// ---------------- shaders functions -------------------------- //
	
function shader_set_monster_kill(_enemy) {
	if (_enemy.ko_time == 0)
		_enemy.ko_time = current_time;
		
	var _height = sprite_get_height(_enemy.sprite_index)
	var _width = sprite_get_width(_enemy.sprite_index)
	
	var _shader_index = SHADER_MULTI_PHASE;	
	shader_set(_shader_index);
	
	var _sampler_duration = shader_get_uniform(_shader_index, "duration");
	shader_set_uniform_f(_sampler_duration, 900.)
	
	var _sampler_time = shader_get_uniform(_shader_index, "time");
	shader_set_uniform_f(_sampler_time, current_time)

	
	var _sampler_start_time = shader_get_uniform(_shader_index, "start_time");
	shader_set_uniform_f(_sampler_start_time, _enemy.ko_time)

 
	var _sampler_width = shader_get_uniform(_shader_index, "width");
	shader_set_uniform_f(_sampler_width, _width)
	
	var _sampler_height = shader_get_uniform(_shader_index, "height");
	shader_set_uniform_f(_sampler_height, _height)
}

function shader_set_monster_attacked(_enemy) {
	if _enemy.is_attacked == false {
		return;
	}
	
	if (_enemy.attacked_time == 0) {
		_enemy.attacked_time = current_time;
	}
	
	
	var _attack_duration = 1000.; // in ms, anim + additional freeze time;
	var _anim_duration = 200.; // in ms
	var _execution_time = current_time - _enemy.attacked_time;
	
	if  _execution_time > _attack_duration {
		// if anim si done, reset enemy attacked fields
		_enemy.is_attacked = false;
		_enemy.attacked_time = 0;
		return;
	}
	
	// Freeze enemy for a while
	_enemy.image_index = (_enemy.image_index-1)*_enemy.speed;
	
	if (_execution_time <= _anim_duration) {
		var _height = sprite_get_height(_enemy.sprite_index)
		var _width = sprite_get_width(_enemy.sprite_index)
	
		var _shader_index = SHADER_DAMAGE;	
		shader_set(_shader_index);
	
		var _sampler_duration = shader_get_uniform(_shader_index, "duration");
		shader_set_uniform_f(_sampler_duration, _anim_duration)
	
		var _sampler_time = shader_get_uniform(_shader_index, "time");
		shader_set_uniform_f(_sampler_time, current_time)

	
		var _sampler_start_time = shader_get_uniform(_shader_index, "start_time");
		shader_set_uniform_f(_sampler_start_time, _enemy.attacked_time)

 
		var _sampler_width = shader_get_uniform(_shader_index, "width");
		shader_set_uniform_f(_sampler_width, _width)
	
		var _sampler_height = shader_get_uniform(_shader_index, "height");
		shader_set_uniform_f(_sampler_height, _height)
	}
}