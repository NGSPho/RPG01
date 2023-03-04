var exit_key = keyboard_check_pressed(vk_escape);
if exit_key == true instance_destroy();

var down = keyboard_check_pressed(vk_down);
var top = keyboard_check_pressed(vk_up);

pos_char = (array_length(global.team) + pos_char + down - top) % array_length(global.team);

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);