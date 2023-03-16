

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
