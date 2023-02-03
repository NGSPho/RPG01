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


// get the ith instance of input class or else return null
function instance_get_or_null(obj, i, name)
{
	instance_nb = instance_number(obj)
	log(instance_nb, " instances of ", name, " found.")
	if instance_nb > i
	{
		return instance_find(OBJ_SOUNDTRACK_ABSTRACT, i)
	}
	else 
	{
		return 0;
	}
}