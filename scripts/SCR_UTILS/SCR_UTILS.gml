// Utilitary script

// TODO replace when functional arrays are released
// Get the longest string from a string array
// args : array, Optional integer
function get_max_width_from_string_array(tab)
{
	var max_width = 0;
	for (var i = 0 ; i < array_length(tab) ; i++)
	{
		var str_width = string_width(tab[i])
		max_width = max(max_width, str_width)
	}
	return max_width;
}



// print(variables or strings)
function log() 
{
	var output_string = "";
	var str = "";
	for (var i = 0; i < argument_count; i++) 
	{
	    str = argument[i];
	    if (!is_string(str)) str = string(str);
	    output_string += str + " ";
	}

	show_debug_message("LOG : " + output_string);
}

function debug() 
{
	var output_string = "";
	var str = "";
	for (var i = 0; i < argument_count; i++) 
	{
	    str = argument[i];
	    if (!is_string(str)) str = string(str);
	    output_string += str + " ";
	}

	show_debug_message("LOG : " + output_string);
}



function log_ds_map(ds_map) {
	var _key = ds_map_find_first(ds_map);
	var _str = "{ ";
	while !is_undefined(_key)  {
		_str += _key + " : " + string(ds_map_find_value(ds_map, _key)) + ", "
		_key = ds_map_find_next(ds_map, _key);
	}
	_str += " }";
	return _str;
}

// --------------------- Array utilitary functions ----------------------- //
/// Check if array contains requested item
///@param _arr the array on which to perform the search
///@item the item to look for
function array_contains(_arr, _item) {
	for (var i=0; i<array_length(_arr); i++) {
		if _arr[i] == _item return true;
	}
	return false;
}

/// Get the index of first object in array that matches filter, if none, return -1
/// @_fighter Array of fighter
/// @_index Starting index
/// @_filter Is of the same structure as fighter_selection_filter 
/// @_direction Is 1 or -1, gives the direction in the list
/// @_loop Do we want to keep looping or not
function find_next(_arr, _index, _filter, _direction, loop) { //TODO make filter and direction optional
	
	var _start_index = _index
	do {
		var _D = array_length(_arr)
		_index = (_index + _D + _direction) % _D
	} until (
		apply_filter(_arr[_index], _filter) || _start_index == _index)
	if _start_index == _index {
		if loop == true return _index else return -1
	} else {
		return _index;
	}
}

/// Get the index  first object in array that matches filter, if none, return -1
/// @param _fighters Array of fighter
/// @param _filter Is of the same structure as fighter_selection_filter 
function find_first(_arr, _filter) {
	var _result = find_next(_arr, -1, _filter, 1, false);
	return _result;
}

/// Count the number of item in an array that matches filter
///@param _figthers Array of fighters
///@_filter The filter to apply
function count_matches(_arr, _filter) {
	var _index = find_first(_arr, _filter)
	var _start = _index;
	if _index == -1 return 0;
	
	var _count = 1;
	do {
		_count++;
		item = find_next(_arr, _index, _filter, 1, false)
	} until (_index == -1 || _index == _start)
	return _count;
}

/// Check if obj matches all filter
/// @param _inst
/// @param _filter 
function apply_filter(_inst, _filter) {
	var result = true;
	if _filter.KO != noone
		result = result && _inst.HP <= 0 == _filter.KO;
	return result;
}
// ---------------------- String utils -------------------------- //
/// Create a string builder
function string_builder_create() {
	return [];
}

/// Append string to string builder
/// @param _s_b The string builder
/// @param _string The string to append
function string_builder_append(_s_b, _string) {
	_s_b[array_length(_s_b)] = _string
	return _s_b
}

/// return noone is input string is empty
function string_return_noone_if_empty(_str) {
	if _str != "" 
		return _str; 
	else 
		return noone;
}

function string_builder_to_string(_s_b) {
	TODO();
}

function string_remove_quotation_marks(_str) {
	if string_char_at(_str, 1) == "\"" && string_char_at(_str, string_length(_str)) == "\""
		return string_copy(_str, 2, string_length(_str)-2)
	return _str;
}


// --------- DRAW ------------- //
/// Type a text centered given a bounding box 
// @param _bb_x the x of the bounding box
// @param _bb_y the y of the bounding box
// @param _bb_width the width of the bounding box
// @param _bb_height the height of the bounding box
// @param _text the text to draw
function draw_centered_text(_bb_x, _bb_y, _bb_width, _bb_height, _text) {
	var _x = _bb_x + _bb_width/2 - string_width(_text)/2
	var _y = _bb_y + _bb_height/2 - string_height(_text)/2
	var _c = c_white;
	draw_text_color(_x, _y , _text, _c, _c, _c, _c, 1);
}


function TODO() {
	throw("Not implemented yet!");
}

function throw_and_log(_str) {
	log(_str);
	throw(_str);
}