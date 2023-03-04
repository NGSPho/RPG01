

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

// ----------------- XP ---------------------- //
var _char_offset_x =_box_offset_x + _offset_x;
var _char_offset_y = _box_offset_y + _offset_y;
var _text = string(_ally.XP) + "/" + "???"; // TODO add trux value
draw_text_simplified(_char_offset_x, _char_offset_y, _text);
// ---------------- ATK ---------------------- //
_char_offset_y += string_height(_text) + 3;
_text = "ATK"
draw_text_simplified(_char_offset_x, _char_offset_y, _text);
var _value_text = string(_ally.ATK);
var _value_offset_x = _box_offset_x + _box_width - string_width(_value_text) - _offset_x;
draw_text_simplified(_value_offset_x, _char_offset_y, _value_text);
draw_text_simplified(_char_offset_x, _char_offset_y, _text);
// ---------------- ATK ---------------------- //
_char_offset_y += string_height(_text) + 3;
_text = "DEF"
draw_text_simplified(_char_offset_x, _char_offset_y, _text);
_value_text = string(_ally.DEF);
_value_offset_x = _box_offset_x + _box_width - string_width(_value_text) - _offset_x;
draw_text_simplified(_value_offset_x, _char_offset_y, _value_text);
