
var _view_x = camera_get_view_x(view_camera[0]);
var _view_y = camera_get_view_y(view_camera[0])
var _random_enemies = [ OBJ_MONSTER_SUCCUBUS, OBJ_MONSTER_EXECUTIONER]
var _new_enemy = [0];




for (var i=0; i<array_length(_random_enemies); i++) {
	log("Index ", i)
	var _x = _view_x + 50; // TODO center
	var _y = _view_y + 150;
	if i>0 {
		var _left_enemy = enemy[i-1]
		_x = _left_enemy.x + _left_enemy.width;
		log("Left enemy x : ", _left_enemy.x, "width : ",_left_enemy.width)
	}
	var _enemy = instance_create_depth(_x, _y, -100, _random_enemies[i])
	with(_enemy) {
		x = _x;
		y = _y;
	}
	_enemy.x = _x;
	_enemy.y = _y;
	enemy[i]= _enemy
	log("Create enemy : ", enemy[i], "named ", object_get_name(enemy[i].object_index), " at x ", _x , " y ", _y)	
}

var _ally = [ OBJ_ALLY_DENEA, OBJ_ALLY_DANCER ]
for (var i=0; i<array_length(_ally); i++) {
	var _new_ally = instance_create_depth(0, 0, -100, _ally[i])
	log("Create ally : ", object_get_name(_new_ally))
	ally[i] = _new_ally
}



log("Created ally : ", ally, " and enemy : ", enemy)