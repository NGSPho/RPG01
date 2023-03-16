
cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
var _box_offset_x = cam_x + 16;
var _box_offset_y = cam_y + 14;
var _box_width = 250/array_length(tabs);
var _box_height = 15;

for (i=0; i<array_length(tabs); i++) {
	// -----------------------  highlight the current tab ------------------- //
	var _sprite = box_sprite_off;
	if i == tab_pos
		_sprite = box_sprite;

	var _dynamic_offset_x = _box_offset_x + i * _box_width;
	draw_sprite_simplified_2(_sprite, _dynamic_offset_x, _box_offset_y, _box_width, _box_height);
	draw_centered_text(_dynamic_offset_x, _box_offset_y, _box_width, _box_height, menu_tabs_label(tabs[i]))
}