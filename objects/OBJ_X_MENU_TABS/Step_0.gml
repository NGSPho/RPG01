var exit_key = keyboard_check_pressed(vk_escape);
if exit_key == true instance_destroy();

var previous = keyboard_check_pressed(ord("A"))
var next = keyboard_check_pressed(ord("Z"))

var move = next - previous;
if move != 0 {
	tab_pos = (array_length(tabs) + tab_pos + move) mod array_length(tabs);
	open_menu();
	// TODO display the tab
}
