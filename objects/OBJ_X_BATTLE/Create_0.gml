/// Place agents in the viewport

function place_agents(_enemies) {
	var _view_x = camera_get_view_x(view_camera[0]);
	var _view_y = camera_get_view_y(view_camera[0]);

	for (var i=0; i<array_length(_enemies); i++) {
		var _x = _view_x + 50; // TODO center
		var _y = _view_y + 30;
		if i>0 {
			var _left_enemy = enemy[i-1]
			_x = _left_enemy.x + _left_enemy.width;
		}
		var _enemy = instance_create_depth(_x, _y, -100, _enemies[i])
		with(_enemy) {
			x = _x;
			y = _y;
		}
		_enemy.x = _x;
		_enemy.y = _y;
		enemy[i]= _enemy
		log("Create enemy : ", enemy[i], "named ", object_get_name(enemy[i].object_index), " at x ", _x , " y ", _y)	
	}

	for (var i=0; i<array_length(global.team); i++) {
		var _ally = global.team[i];
		_ally.visible = false;	
	}
}

enemy[0] = 0;
turn = 0
// [ attacker, action, target ]
actions[0, 0] = 0;

D_battle_over = false

