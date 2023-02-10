if instance_exists(OBJ_X_BATTLE_ANIMATION) return;

var _battle_spr = SPR_BATTLE_BATTLE_MENU
var _battle_menu_spr_width = sprite_get_width(_battle_spr)
var _battle_menu_spr_height = sprite_get_height(_battle_spr)

// -------------display ally information board-----------//
var _ally_menu_x = camera_get_view_x(view_camera[0]) + 32
var _ally_menu_y = camera_get_view_y(view_camera[0]);
var _ally_menu_width = 213;
var _ally_menu_height = 53;

var _scale_x =  _ally_menu_width/_battle_menu_spr_width
var _scale_y = _ally_menu_height/_battle_menu_spr_height


draw_sprite_ext(_battle_spr, 0, _ally_menu_x, _ally_menu_y, _scale_x, _scale_y, 0, c_white, 1)

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(global.font_battle);

// ------------------------- display character info ----------------------------//
// HP / MAX_HP
for (var i=0; i<array_length(global.team); i++) {
	var _ally = global.team[i]
	var _text_x = _ally_menu_x + i * _ally_menu_width / 4 + 10; // divide by 4, ie the max number of allies (ref DQ8)
	var _text_y = 3;
	draw_text(_text_x, _text_y, _ally.label)
	draw_text(_text_x, _text_y + 10, "HP : " + string(_ally.HP) + "/" + string(_ally.MAX_HP))
	//-------- draw the portrait -------//
	var _target_portrait_size = 25;
	var _portrait_scale_x = _target_portrait_size/sprite_get_width(_ally.portrait);
	var _portrait_scale_y = _target_portrait_size/sprite_get_height(_ally.portrait);
	draw_sprite_ext(_ally.portrait, 0, _text_x, _text_y + 20, _portrait_scale_x, _portrait_scale_y, 0, c_white, 1)
}
	
	
// -------------------------draw action menu ---------------------------//
// Actions = Attack ( later shield, skills, talk )
// actions is a 2D array
// display ally information board
var _action_menu_x = camera_get_view_x(view_camera[0]);
var _action_menu_y = camera_get_view_y(view_camera[0]) + 160;
var _action_menu_width = 150;
var _action_menu_height = 53;
var _max_action_width = 50;
var _max_action_height = 20;


_scale_x =  _action_menu_width/_battle_menu_spr_width
_scale_y = _action_menu_height/_battle_menu_spr_height
draw_sprite_ext(_battle_spr, 0, _action_menu_x, _action_menu_y, _scale_x, _scale_y, 0, c_white, 1)

//------- Display ally name -------//
draw_text(_action_menu_x + 10, _action_menu_y + 5, global.team[current_ally_turn_index].label)
draw_text(_action_menu_x + 10, _action_menu_y + 8, "______________________")

//------- Display actions ---------//


//log("Current action is : ", actions[action_pos_y, action_pos_x])
for (var _pos_y=0; _pos_y<array_length(actions); _pos_y++;) {
	for (var _pos_x=0; _pos_x<array_length(actions[_pos_y]); _pos_x++;) {
		var _action = actions[_pos_y, _pos_x]
		var _text_x = _action_menu_x + _pos_x * _max_action_width + 20;
		var _text_y = _action_menu_y + _pos_y * _max_action_height + 20;
		draw_text(_text_x, _text_y, _action)
		
		// draw the action arrow
		if _pos_x == action_pos_x && _pos_y == action_pos_y {
			var _spr = SPR_BATTLE_MENU_ARROW
			var _arrow_spr_height = sprite_get_height(_spr)
			var _arrow_spr_width = sprite_get_width(_spr)
			draw_sprite_ext(_spr, 0, _text_x - 10, _text_y - 1, 0.5, 0.5, 0, c_white, 1) // TODO add anim on arrow
		}
	}
}

// -------------------- Display enemy selecion ----------------------------- //
if select_target_mode == true {
	var _enemy_box_x = camera_get_view_x(view_camera[0]) + 160;
	var _enemy_box_y = camera_get_view_y(view_camera[0]) + 160;
	var _enemy_box_w = 120;
	var _enemy_box_h = 20;
	var _enemy_scale_x = _enemy_box_w/_battle_menu_spr_width
	var _enemy_scale_y = _enemy_box_h/_battle_menu_spr_height	
	// -- draw the box -- //
	draw_sprite_ext(_battle_spr, 0, _enemy_box_x, _enemy_box_y, _enemy_scale_x, _enemy_scale_y, 0, c_white, 1)
	// -- draw the name -- //
	draw_text(_enemy_box_x+3, _enemy_box_y+3, enemy[enemy_pos].label)
	// -- draw the arrow -- //
	var _arrow_spr = SPR_BATTLE_ENEMY_ARROW;
	var _enemy_x = enemy[enemy_pos].x;
	draw_sprite_ext(_arrow_spr, 0, _enemy_x + 10, 150, 1, 1, 180, c_white, 1)

}

