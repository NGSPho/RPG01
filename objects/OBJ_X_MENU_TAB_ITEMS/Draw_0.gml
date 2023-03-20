

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);

// ---------- display the box ---------------- //
var _box_offset_x = cam_x + 155;
var _box_offset_y = cam_y + 30;
var _box_width = 112;
var _box_height = 90;
draw_sprite_simplified_2(box_sprite, _box_offset_x, _box_offset_y, _box_width, _box_height);

var _ally = global.team[OBJ_X_MENU_TEAM_OVERVIEW.pos_char];

// distance from the sides of the box
var _offset_x = 10;
var _offset_y = 10;

var _place_holder_dimension = (min(_box_width, _box_height) - 2*_offset_x)/INVENTORY_SIZE;
var _place_holder_di
for (i=0; i<INVENTORY_SIZE; i++) {
	for (j=0; j<INVENTORY_SIZE; j++) {
		var _place_holder_x = _box_offset_x + _offset_x + i*_place_holder_dimension;
		var _place_holder_y = _box_offset_y + _offset_y + j*_place_holder_dimension;

		if i == pos_x && j == pos_y
			draw_sprite_simplified_2(SPR_X_MENU_ITEM_SELECTED_BACKGROUND, _place_holder_x, _place_holder_y, _place_holder_dimension, _place_holder_dimension)
		// --------------- draw the item -------------------- //
		var _stack = _ally.inventory[i][j];
		if _stack != noone {
			var _item =  _stack.item;
			draw_sprite_simplified_2(_item.sprite,_place_holder_x, _place_holder_y, _place_holder_dimension, _place_holder_dimension)
			draw_text_simplified(_place_holder_x+3, _place_holder_y+3, _stack.quantity)
		}
		if i == pos_x && j == pos_y {
			draw_sprite_simplified_2(SPR_X_MENU_ITEM_SELECTED, _place_holder_x, _place_holder_y, _place_holder_dimension, _place_holder_dimension)
		}
				
		// -------------- display item placeholder -------------- //
		draw_sprite_simplified_2(SPR_X_MENU_ITEM_PLACEHOLDER,_place_holder_x, _place_holder_y, _place_holder_dimension, _place_holder_dimension)
	
		
		
	}
}

// ---------------- grey if no focus ----------------- //
if !has_focus()
	draw_sprite_simplified_2(SPR_X_MENU_NO_FOCUS, _box_offset_x, _box_offset_y, _box_width, _box_height);

if mode = MENU_MODE.TARGET_SELECTION {
	var _line_height = 10;
	var _target_offset_x = 155 + cam_x;
	var _target_offset_y = 125 +  cam_y;
	var _target_border_distance = 10;
	var _teammates_number = array_length(global.team);
	
	var _target_labels = []; for (i=0; i<_teammates_number; i++) { array_push(_target_labels, global.team[i].label); }
	
	var _target_height =(_teammates_number)*_line_height + 2*_target_border_distance
	var _target_width = get_max_width_from_string_array(_target_labels) + 2*_target_border_distance
	
	draw_sprite_simplified_2(SPR_X_MENU, _target_offset_x, _target_offset_y, _target_width, _target_height)
	for (i=0; i<_teammates_number; i++) {
		var _text_x = _target_offset_x + _target_border_distance;
		var _text_y = _target_offset_y + _target_border_distance + i*_line_height
		var _target = global.team[i];
		draw_text(_text_x, _text_y, _target.label)
		if i == pos_target
			draw_sprite_simplified(SPR_BATTLE_MENU_ARROW, _text_x-10, _text_y, 1, 1);
	}
}