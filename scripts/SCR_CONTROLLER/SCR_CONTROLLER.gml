

function initialize_global_variables() {
	log("Initializing global variables");
	global.start_room = ROOM_BEDROOM;
	
	global.font_menu = font_add_sprite(SPR_FONT_L, 32, true, 1);
	global.font_textb = font_add_sprite(SPR_FONT_S, 32, true, 1);
	global.font_battle = font_add_sprite(SPR_FONT_S, 32, true, 1);
	
	global.scale_portrait = 1;
	
	global.move_speed = 1;
	
	// map sprites names to sprites
	global.spr_name_to_sprites = ds_map_create();
	populate_sprite_map();
	log("Sprite map : ", log_ds_map(global.spr_name_to_sprites));
	
	// map of battle stats by character
	/*.battle_stats = ds_map_create()
	populate_battle_data()
	log("Battle map loaded");*/
	
	global.team = [OBJ_FIGHTER_PLAYER]
	log("GLOBAL TEAM :", global.team);
	
	// Instanciate playable characters
	
	for (var i=0; i<array_length(global.team); i++) {
		var _teammate = instance_create_depth(0, 0, 0, global.team[i])
		with(_teammate) { visible = false }
		log("Created teammate " + object_get_name(_teammate.object_index));
	}
		
	global.map_text = load_text()
	global.map_choice = load_option()
	global.map_battle = load_battle()
	global.map_join = load_join()
	
	
}

function load_team() {
	var _team = [OBJ_PLAYER]
	log("GLOBAL TEAM :", global.team);
	
	// Instanciate playable characters
	
	for (var i=0; i<array_length(global.team); i++) {
		var _teammate = instance_create_depth(0, 0, 0, global.team[i])
		with(_teammate) { visible = false }
		log("Created teammate " + object_get_name(_teammate.object_index));
	}
}


/// Map a sprite name to the associate sprite file name. 
/// Requirement : file name should be SPR_CHAR_BODY_XXX_DOWN with XXX being sprite name
function populate_sprite_map() {	
	function script_postfix(_str, _dir) { // input spr_name_RIGHT
		// Check if postfix matches with flie name
		var _postfix = string_copy(_str, string_length(_str) - string_length(_dir) + 1, string_length(_dir));
		if _dir != _postfix return noone;
		return string_copy(_str, 0, string_length(_str) - string_length(_dir) - 1);
	}
	
	log("Loading character sprites to map.");
	
	var max_sprite = 1000;
	var _prefix = "SPR_CHAR_BODY_";
	
	for (var spr=0; spr<max_sprite; spr++) {
		if !sprite_exists(spr) break;
		
		var _spr_name = sprite_get_name(spr);
		
		// parsing name
		if _prefix == string_copy(_spr_name, 0, string_length(_prefix)) {
			//log("Found sprite ", _spr_name);	
			var _directions = [ "RIGHT", "UP", "LEFT", "DOWN" ];
			var _file_name = noone;
		
			// extract sprite name from file name
			// remove SPR_CHAR_BODY_
			var _stripped_file_name = string_copy(_spr_name, string_length(_prefix) + 1, string_length(_spr_name) - string_length(_prefix) + 1)
	
			// test if the postfix is any direction
			// TODO if no direction found, should throw an error
			for (var dir=0; dir<4 ; dir++) {
				_file_name = script_postfix(_stripped_file_name, _directions[dir])
				if _file_name != noone {
					var _dir_sprite_arr = [0, 0, 0, 0]
					if ds_map_exists(global.spr_name_to_sprites, _file_name) { // if value already exists in map, we update it
						_dir_sprite_arr = ds_map_find_value(global.spr_name_to_sprites, _file_name);
						_dir_sprite_arr[dir] = spr;
				
					} else {
						_dir_sprite_arr[dir] = spr
						ds_map_add(global.spr_name_to_sprites, _file_name, _dir_sprite_arr)
					}
					break;
				}
			}
			
		}
	}
	
}
	
	
/// Populate battle data
// TODO should read from memory
function populate_battle_data() {
	var main_character = {
		MAX_HP: 10,
		ATK: 1,
		DEF: 1
	}
	ds_map_add(global.battle_stats, "main_character", main_character)
}



