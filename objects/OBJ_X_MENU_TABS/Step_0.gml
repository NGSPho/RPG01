var previous = keyboard_check_pressed(ord("W"))
var next = keyboard_check_pressed(ord("X"))

var move = next - previous;
if move != 0 {
	tab_pos = (array_length(tabs) + tab_pos + move) mod array_length(tabs);
	audio_play_sound(SOUND_EFFECT_MENU_TAB_TOGGLE, 1, -1);
	open_menu();
	// TODO display the tab
}
