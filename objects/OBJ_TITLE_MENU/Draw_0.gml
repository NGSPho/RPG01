// draw the options
draw_set_font(global.font_menu);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

var op_length = array_length(options[menu_level])

// dynamicly get width and height of menu
height = op_border*2 + string_height(options[0,0]) + (op_length-1)*op_space;
width = op_border*2 + get_max_width_from_string_array(options[menu_level])

// center menu
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - height/2;

//draw the menu background
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1)


for (var i=0; i < op_length; i++)
{
	var _c = c_white
	if pos == i { _c = c_yellow }
	draw_text_color(x + op_border, y + op_border + op_space * i, options[menu_level, i], _c, _c, _c, _c, 1);
}